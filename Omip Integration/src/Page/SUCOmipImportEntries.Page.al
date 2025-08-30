namespace Sucasuc.Omip.Auditing;
using Sucasuc.Omip.Utilities;
using System.Utilities;
using System.Text;
page 50200 "SUC Omip Import Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Omip Import Entries";
    SourceTableView = sorting("Entry No.") order(descending);
    Caption = 'Omip Import Entries';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Omip File Name"; Rec."Omip File Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File Name field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Download Omip File")
            {
                ApplicationArea = All;
                Caption = 'Download Omip File';
                Image = Download;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Download the Omip File';
                trigger OnAction()
                begin
                    Rec.DownloadOmipFile();
                end;
            }
            action("Assign Omip File")
            {
                ApplicationArea = All;
                Caption = 'Assign Omip File';
                Image = SelectItemSubstitution;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Assign the Omip File';
                trigger OnAction()
                var
                    ConfirmLbl: Label 'Do you want to assign the associated prices?';
                    FileNoDataLbl: Label 'Imported file without data';
                begin
                    if Rec."Omip File".HasValue then begin
                        if Confirm(ConfirmLbl) then
                            ProcessSingleFile(Rec);
                    end else
                        Error(FileNoDataLbl);
                end;
            }
            action("Process Selected Files")
            {
                ApplicationArea = All;
                Caption = 'Process Selected Files to History';
                Image = PostBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Process all selected files and save price data to history';
                trigger OnAction()
                var
                    SUCOmipImportEntries: Record "SUC Omip Import Entries";
                    TempMostRecentEntries: Record "SUC Omip Import Entries" temporary;
                    ProcessedCount: Integer;
                    SkippedCount: Integer;
                    TotalSelected: Integer;
                    TotalToProcess: Integer;
                    CurrentFileNo: Integer;
                    SingleFileConfirmLbl: Label 'Do you want to process the selected file and save its data to price history?';
                    MultipleFileConfirmLbl: Label 'You have selected %1 files from different months. The most recent file from each month will be processed (%2 files total). Do you want to continue?';
                    NoSelectionLbl: Label 'Please select one or more files to process.';
                    CompletedLbl: Label 'Processing completed. Files processed: %1, Files skipped (no data): %2';
                    ProcessingLbl: Label 'Processing file #1####### of #2####### : #3#######';
                    Dialog: Dialog;
                begin
                    CurrPage.SetSelectionFilter(SUCOmipImportEntries);
                    if not SUCOmipImportEntries.FindSet() then begin
                        Message(NoSelectionLbl);
                        exit;
                    end;

                    TotalSelected := SUCOmipImportEntries.Count();

                    if TotalSelected = 1 then begin
                        // Single file selected, process directly
                        if not Confirm(SingleFileConfirmLbl) then
                            exit;

                        Dialog.Open(ProcessingLbl);
                        Dialog.Update(1, 1);
                        Dialog.Update(2, 1);
                        Dialog.Update(3, SUCOmipImportEntries."Omip File Name");

                        if ProcessSingleFileWithErrorHandling(SUCOmipImportEntries) then
                            ProcessedCount := 1
                        else
                            SkippedCount := 1;
                    end else begin
                        // Multiple files selected, find most recent per month
                        FindMostRecentEntriesByMonth(SUCOmipImportEntries, TempMostRecentEntries);
                        TotalToProcess := TempMostRecentEntries.Count();

                        if not Confirm(StrSubstNo(MultipleFileConfirmLbl, TotalSelected, TotalToProcess)) then
                            exit;

                        Dialog.Open(ProcessingLbl);
                        CurrentFileNo := 0;

                        if TempMostRecentEntries.FindSet() then
                            repeat
                                CurrentFileNo += 1;
                                Dialog.Update(1, CurrentFileNo);
                                Dialog.Update(2, TotalToProcess);
                                Dialog.Update(3, TempMostRecentEntries."Omip File Name");

                                if ProcessSingleFileWithErrorHandling(TempMostRecentEntries) then
                                    ProcessedCount += 1
                                else
                                    SkippedCount += 1;
                            until TempMostRecentEntries.Next() = 0;
                    end;

                    Dialog.Close();
                    Message(StrSubstNo(CompletedLbl, ProcessedCount, SkippedCount));
                end;
            }
        }
    }

    local procedure ProcessSingleFile(ImportEntry: Record "SUC Omip Import Entries")
    var
        ProcessPriceDate: Date;
    begin
        ProcessPriceDate := ExtractAndImportFileData(ImportEntry);
        if ProcessPriceDate <> 0D then begin
            ProcessPriceDate := AdjustProcessDate(ProcessPriceDate);
            ExecutePriceCalculation(ProcessPriceDate);
        end;
    end;

    local procedure ProcessSingleFileWithErrorHandling(ImportEntry: Record "SUC Omip Import Entries"): Boolean
    var
        ProcessPriceDate: Date;
    begin
        ImportEntry.CalcFields("Omip File");
        if not ImportEntry."Omip File".HasValue then
            exit(false);

        ProcessPriceDate := ExtractAndImportFileData(ImportEntry);
        if ProcessPriceDate = 0D then
            exit(false);

        ProcessPriceDate := AdjustProcessDate(ProcessPriceDate);
        ExecutePriceCalculation(ProcessPriceDate);
        exit(true);
    end;

    local procedure ExtractAndImportFileData(ImportEntry: Record "SUC Omip Import Entries"): Date
    var
        SUCOmipImportFromExcel: Codeunit "SUC Omip Import From Excel";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
        InStream1: InStream;
        OutStream: OutStream;
        OmipFileDoc: Text;
        FileName: Text;
    begin
        ImportEntry.CalcFields("Omip File");
        FileName := ImportEntry."Omip File Name";
        ImportEntry."Omip File".CreateInStream(InStream, TextEncoding::UTF8);

        Clear(OmipFileDoc);
        while not (InStream.EOS) do
            InStream.Read(OmipFileDoc);

        if OmipFileDoc = '' then
            exit(0D);

        Clear(TempBlob);
        TempBlob.CreateOutStream(OutStream);
        Base64Convert.FromBase64(OmipFileDoc, OutStream);
        TempBlob.CreateInStream(InStream1);

        exit(SUCOmipImportFromExcel.ExcelProcessImport(FileName, InStream1));
    end;

    local procedure AdjustProcessDate(ProcessPriceDate: Date): Date
    begin
        if ProcessPriceDate = CalcDate('<CM>', ProcessPriceDate) then
            ProcessPriceDate := CalcDate('<+1D>', ProcessPriceDate);

        exit(CalcDate('<-CM+2M>', ProcessPriceDate));
    end;

    local procedure ExecutePriceCalculation(ProcessPriceDate: Date)
    var
        SUCOmipManagement: Codeunit "SUC Omip Management";
    begin
        SUCOmipManagement.ProcessNewPricesOmipBatch(ProcessPriceDate);
    end;

    local procedure FindMostRecentEntriesByMonth(var SUCOmipImportEntriesIn: Record "SUC Omip Import Entries"; var TempMostRecentEntries: Record "SUC Omip Import Entries" temporary)
    var
        SUCOmipImportEntry: Record "SUC Omip Import Entries";
        MostRecentEntryForMonth: Record "SUC Omip Import Entries";
        AllUniqueMonths: List of [Text];
        ProcessedDates: List of [Date];
        MonthKey: Text[50];
        Year: Integer;
        Month: Integer;
        MostRecentDate: DateTime;
        EntryDate: Date;
        i: Integer;
    begin
        TempMostRecentEntries.DeleteAll();

        // First pass: collect all unique month/year combinations from selected entries

        if SUCOmipImportEntriesIn.FindSet() then
            repeat
                Year := Date2DMY(DT2Date(SUCOmipImportEntriesIn."Posting Date"), 3);
                Month := Date2DMY(DT2Date(SUCOmipImportEntriesIn."Posting Date"), 2);
                MonthKey := Format(Year) + '-' + Format(Month);

                if not AllUniqueMonths.Contains(MonthKey) then
                    AllUniqueMonths.Add(MonthKey);
            until SUCOmipImportEntriesIn.Next() = 0;

        // Second pass: for each unique month, find the most recent entry
        for i := 1 to AllUniqueMonths.Count() do begin
            MonthKey := CopyStr(AllUniqueMonths.Get(i), 1, 50);
            Evaluate(Year, CopyStr(MonthKey, 1, StrPos(MonthKey, '-') - 1));
            Evaluate(Month, CopyStr(MonthKey, StrPos(MonthKey, '-') + 1));

            MostRecentDate := 0DT;
            Clear(MostRecentEntryForMonth);

            // Find the most recent entry for this specific month among all selected entries
            SUCOmipImportEntry.Reset();
            SUCOmipImportEntry.Copy(SUCOmipImportEntriesIn, false); // Copy without filters
            CurrPage.SetSelectionFilter(SUCOmipImportEntry); // Apply the same selection filter
            if SUCOmipImportEntry.FindSet() then
                repeat
                    if (Date2DMY(DT2Date(SUCOmipImportEntry."Posting Date"), 3) = Year) and
                       (Date2DMY(DT2Date(SUCOmipImportEntry."Posting Date"), 2) = Month) then
                        if SUCOmipImportEntry."Posting Date" > MostRecentDate then begin
                            MostRecentDate := SUCOmipImportEntry."Posting Date";
                            MostRecentEntryForMonth := SUCOmipImportEntry;
                        end;
                until SUCOmipImportEntry.Next() = 0;

            // Add the most recent entry for this month to results only if date not already processed
            if MostRecentDate <> 0DT then begin
                EntryDate := DT2Date(MostRecentDate);
                if not ProcessedDates.Contains(EntryDate) then begin
                    ProcessedDates.Add(EntryDate);
                    TempMostRecentEntries.Init();
                    TempMostRecentEntries.TransferFields(MostRecentEntryForMonth);
                    TempMostRecentEntries.Insert();
                end;
            end;
        end;
    end;
}