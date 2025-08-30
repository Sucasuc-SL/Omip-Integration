namespace Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Setup;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.User;
using System.IO;
using Microsoft.Utilities;
/// <summary>
/// OnRun.
/// </summary>
codeunit 50150 "SUC Omip Import From Excel"
{
    Permissions =
        tabledata "Name/Value Buffer" = R,
        tabledata "SUC Omip Setup" = R;
    /// <summary>
    /// ProcessExcel.
    /// </summary>


    procedure ExcelProcessImport(FromFile: Text; InStream: InStream): Date
    begin
        ReadExcelSheet(FromFile, InStream);
        exit(ImportExcelData());
    end;

    procedure ExcelUsersProcessImport(FromFile: Text; InStream: InStream)
    begin
        ReadExcelSheet(FromFile, InStream);
        ImportExcelDataUsers();
    end;

    local procedure ReadExcelSheet(FromFile: Text; InStream: InStream)
    var
        FileManagement: Codeunit "File Management";
    begin
        if FromFile <> '' then begin
            FileName := FileManagement.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(InStream);
        end else
            Error('Excel file found');

        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempSUCOmipEntry.DeleteAll();
        TempExcelBuffer.OpenBookStream(InStream, SheetName);
        TempExcelBuffer.ReadSheet();
    end;

    local procedure ImportExcelData(): Date
    begin
        AnalyzeData();
        exit(InsertData());
    end;

    local procedure ImportExcelDataUsers()
    begin
        AnalyzeDataUserExt();
        InsertDataUserExt();
    end;

    local procedure AnalyzeData()
    begin
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindFirst() then
            repeat
                if TempExcelBuffer."Row No." > 10 then begin
                    if (TempExcelBuffer."Column No." = 1) then
                        InitNewLine();
                    InsertField(TempExcelBuffer."Column No.", TempExcelBuffer."Cell Value as Text");
                end;
            until TempExcelBuffer.Next() = 0;
    end;

    local procedure AnalyzeDataUserExt()
    begin
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindSet() then
            repeat
                if TempExcelBuffer."Row No." > 1 then begin
                    if (TempExcelBuffer."Column No." = 1) then
                        InitNewLineUsersExt(TempExcelBuffer."Cell Value as Text");
                    InsertFieldUserExt(TempExcelBuffer."Column No.", TempExcelBuffer."Cell Value as Text");
                end;
            until TempExcelBuffer.Next() = 0;
    end;

    local procedure InsertField(FieldNo: Integer; TextNoFormat: Text)
    begin
        case FieldNo of
            1:
                ProcessDateField(TextNoFormat);
            2:
                ProcessInstrumentField(TextNoFormat);
            11:
                ProcessPriceField(TextNoFormat);
        end;
        TempSUCOmipEntry.Modify();
    end;

    local procedure ProcessDateField(TextNoFormat: Text)
    var
        ParsedDate: Date;
    begin
        if TryParseDate(TextNoFormat, ParsedDate) then
            TempSUCOmipEntry.Date := ParsedDate
        else
            TempSUCOmipEntry.Validate("Date NoFormat", TextNoFormat);
    end;

    local procedure TryParseDate(DateText: Text; var ResultDate: Date): Boolean
    var
        DateParts: List of [Text];
        DateFormats: List of [Text];
        CurrentFormat: Text;
        FormattedDate: Text;
    begin
        // Try direct evaluation first
        if Evaluate(ResultDate, DateText) then
            exit(true);

        // If contains '/', split and try different combinations
        if StrPos(DateText, '/') = 0 then
            exit(false);

        DateParts := SplitDateString(DateText, '/');
        if DateParts.Count() <> 3 then
            exit(false);

        // Try different date format combinations
        DateFormats.Add('%1-%2-%3'); // First-Second-Third
        DateFormats.Add('%2-%1-%3'); // Second-First-Third
        DateFormats.Add('%3-%2-%1'); // Third-Second-First
        DateFormats.Add('%3-%1-%2'); // Third-First-Second
        DateFormats.Add('%2-%3-%1'); // Second-Third-First
        DateFormats.Add('%1-%3-%2'); // First-Third-Second

        foreach CurrentFormat in DateFormats do begin
            FormattedDate := StrSubstNo(CurrentFormat, DateParts.Get(1), DateParts.Get(2), DateParts.Get(3));
            if Evaluate(ResultDate, FormattedDate) then
                exit(true);
        end;

        exit(false);
    end;

    local procedure SplitDateString(DateString: Text; Separator: Text[1]): List of [Text]
    var
        DateParts: List of [Text];
        CurrentPart: Text;
        SeparatorPos: Integer;
        RemainingText: Text;
    begin
        RemainingText := DateString;

        // Get first part
        SeparatorPos := StrPos(RemainingText, Separator);
        if SeparatorPos > 0 then begin
            CurrentPart := CopyStr(RemainingText, 1, SeparatorPos - 1);
            DateParts.Add(CurrentPart);
            RemainingText := CopyStr(RemainingText, SeparatorPos + 1);

            // Get second part
            SeparatorPos := StrPos(RemainingText, Separator);
            if SeparatorPos > 0 then begin
                CurrentPart := CopyStr(RemainingText, 1, SeparatorPos - 1);
                DateParts.Add(CurrentPart);
                // Get third part (remaining text)
                CurrentPart := CopyStr(RemainingText, SeparatorPos + 1);
                DateParts.Add(CurrentPart);
            end;
        end;

        exit(DateParts);
    end;

    local procedure ProcessInstrumentField(TextNoFormat: Text)
    begin
        TempSUCOmipEntry.Instrument := CopyStr(TextNoFormat, 1, MaxStrLen(TempSUCOmipEntry.Instrument));

        case true of
            StrPos(TempSUCOmipEntry.Instrument, 'FTB M ') <> 0:
                ProcessMonthInstrument();
            StrPos(TempSUCOmipEntry.Instrument, 'FTB Q') <> 0:
                ProcessQuarterInstrument();
            StrPos(TempSUCOmipEntry.Instrument, 'FTB YR') <> 0:
                ProcessYearInstrument();
        end;
    end;

    local procedure ProcessMonthInstrument()
    var
        TempValue: Code[50];
        TempYear: Integer;
        AbcLbl: Label 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz- ';
        TempYearText: Text;
    begin
        TempSUCOmipEntry.Validate("Date Type", TempSUCOmipEntry."Date Type"::Month);
        TempValue := CopyStr(TempSUCOmipEntry.Instrument, 6, StrLen(TempSUCOmipEntry.Instrument));
        TempYearText := DelChr(TempValue, '=', AbcLbl);
        Evaluate(TempYear, TempYearText);
        TempSUCOmipEntry.Validate(Year, TempYear);
        TempValue := CopyStr(DelChr(TempValue, '=', Format(TempYear)), 1, 50);
        TempValue := CopyStr(DelChr(TempValue, '=', '-'), 1, 50);
        TempSUCOmipEntry.Validate(Value, GetMonthInt(TempValue));
    end;

    local procedure ProcessQuarterInstrument()
    var
        TempValue: Code[50];
        TempYear: Integer;
        AbcLbl: Label 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz- ';
        TempYearText: Text;
    begin
        TempSUCOmipEntry.Validate("Date Type", TempSUCOmipEntry."Date Type"::Quarter);
        TempValue := CopyStr(TempSUCOmipEntry.Instrument, 6, StrLen(TempSUCOmipEntry.Instrument));
        TempYearText := DelChr(CopyStr(TempValue, 2, StrLen(TempValue)), '=', AbcLbl);
        Evaluate(TempYear, TempYearText);
        TempSUCOmipEntry.Validate(Year, TempYear);
        TempValue := CopyStr(TempValue, 1, StrPos(TempValue, '-'));
        TempValue := CopyStr(DelChr(TempValue, '=', '-'), 1, 50);
        TempSUCOmipEntry.Validate(Value, TempValue);
    end;

    local procedure ProcessYearInstrument()
    var
        TempValue: Code[50];
        TempYear: Integer;
        AbcLbl: Label 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz- ';
        TempYearText: Text;
    begin
        TempSUCOmipEntry.Validate("Date Type", TempSUCOmipEntry."Date Type"::Year);
        TempValue := CopyStr(TempSUCOmipEntry.Instrument, 7, StrLen(TempSUCOmipEntry.Instrument));
        TempYearText := DelChr(TempValue, '=', AbcLbl);
        Evaluate(TempYear, TempYearText);
        TempSUCOmipEntry.Validate(Year, TempYear);
    end;

    local procedure ProcessPriceField(TextNoFormat: Text)
    begin
        Evaluate(TempSUCOmipEntry.Price, TextNoFormat);
    end;

    local procedure InsertFieldUserExt(FieldNo: Integer; TextNoFormat: Text)
    var
    begin
        case FieldNo of
            2:
                TempSUCOmipExternalUsers.Validate("Full Name", TextNoFormat);
            3:
                TempSUCOmipExternalUsers.SetPassword(TextNoFormat);
        end;
        TempSUCOmipExternalUsers.Modify();
    end;

    local procedure InitNewLine()
    begin
        TempSUCOmipEntry.Init();
        TempSUCOmipEntry."Entry No." := NextEntryNo;
        TempSUCOmipEntry."File Name" := CopyStr(FileName, 1, 250);
        TempSUCOmipEntry.Insert();
        NextEntryNo := NextEntryNo + 1;
    end;

    local procedure InitNewLineUsersExt(UserName: Text[250])
    begin
        if not TempSUCOmipExternalUsers.Get(UserName) then begin
            TempSUCOmipExternalUsers.Init();
            TempSUCOmipExternalUsers.Validate("User Security ID", CreateGuid());
            TempSUCOmipExternalUsers.Validate("User Name", CopyStr(UserName, 1, 100));
            TempSUCOmipExternalUsers.Validate("Contact Email", UserName);
            TempSUCOmipExternalUsers.Insert();
        end;
    end;

    local procedure InsertData(): Date
    var
        SUCOmipEntry: Record "SUC Omip Entry";
        ProcessPriceDate: Date;
    begin
        ClearExistingData(SUCOmipEntry);
        ProcessPriceDate := ProcessTempEntries(SUCOmipEntry);
        exit(ProcessPriceDate);
    end;

    local procedure ClearExistingData(var SUCOmipEntry: Record "SUC Omip Entry")
    begin
        SUCOmipEntry.DeleteAll();
    end;

    local procedure ProcessTempEntries(var SUCOmipEntry: Record "SUC Omip Entry"): Date
    var
        ProcessPriceDate: Date;
    begin
        TempSUCOmipEntry.Reset();
        if TempSUCOmipEntry.FindSet() then
            repeat
                ProcessPriceDate := ProcessSingleEntry(SUCOmipEntry, ProcessPriceDate);
            until TempSUCOmipEntry.Next() = 0;

        exit(ProcessPriceDate);
    end;

    local procedure ProcessSingleEntry(var SUCOmipEntry: Record "SUC Omip Entry"; CurrentProcessDate: Date): Date
    begin
        if TryUpdateExistingEntry(SUCOmipEntry) then
            exit(CurrentProcessDate);

        if IsValidInstrumentForInsertion() then
            exit(InsertNewEntry(SUCOmipEntry));

        exit(CurrentProcessDate);
    end;

    local procedure TryUpdateExistingEntry(var SUCOmipEntry: Record "SUC Omip Entry"): Boolean
    begin
        SUCOmipEntry.Reset();
        SUCOmipEntry.SetRange(Date, TempSUCOmipEntry.Date);
        SUCOmipEntry.SetRange(Instrument, TempSUCOmipEntry.Instrument);

        if SUCOmipEntry.FindLast() then begin
            UpdateEntryPrice(SUCOmipEntry);
            exit(true);
        end;

        exit(false);
    end;

    local procedure UpdateEntryPrice(var SUCOmipEntry: Record "SUC Omip Entry")
    begin
        SUCOmipEntry.Validate(Price, TempSUCOmipEntry.Price);
        SUCOmipEntry.Modify();
    end;

    local procedure IsValidInstrumentForInsertion(): Boolean
    begin
        exit(IsMonthInstrument() or IsQuarterInstrument() or IsYearInstrument());
    end;

    local procedure IsMonthInstrument(): Boolean
    begin
        exit(StrPos(TempSUCOmipEntry.Instrument, 'FTB M') <> 0);
    end;

    local procedure IsQuarterInstrument(): Boolean
    begin
        exit((StrPos(TempSUCOmipEntry.Instrument, 'FTB Q1') <> 0) or
             (StrPos(TempSUCOmipEntry.Instrument, 'FTB Q2') <> 0) or
             (StrPos(TempSUCOmipEntry.Instrument, 'FTB Q3') <> 0) or
             (StrPos(TempSUCOmipEntry.Instrument, 'FTB Q4') <> 0));
    end;

    local procedure IsYearInstrument(): Boolean
    begin
        exit(StrPos(TempSUCOmipEntry.Instrument, 'FTB YR') <> 0);
    end;

    local procedure InsertNewEntry(var SUCOmipEntry: Record "SUC Omip Entry"): Date
    begin
        SUCOmipEntry.Init();
        SUCOmipEntry.TransferFields(TempSUCOmipEntry);
        SUCOmipEntry.Insert();
        exit(SUCOmipEntry.Date);
    end;

    local procedure InsertDataUserExt()
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
    begin
        TempSUCOmipExternalUsers.Reset();
        if TempSUCOmipExternalUsers.FindSet() then
            repeat
                if not SUCOmipExternalUsers.Get(TempSUCOmipExternalUsers."User Name") then begin
                    SUCOmipExternalUsers.Init();
                    SUCOmipExternalUsers.TransferFields(TempSUCOmipExternalUsers);
                    SUCOmipExternalUsers.Insert();
                    SUCOmipExternalUsers.SetPassword(TempSUCOmipExternalUsers.GetPassword());
                end;
            until TempSUCOmipExternalUsers.Next() = 0;
    end;

    local procedure GetMonthInt(TempValueIn: Code[50]): Text[50]
    begin
        // Using case statement with consistent formatting and clear mapping
        case UpperCase(TempValueIn) of
            'JAN':
                exit('1');
            'FEB':
                exit('2');
            'MAR':
                exit('3');
            'APR':
                exit('4');
            'MAY':
                exit('5');
            'JUN':
                exit('6');
            'JUL':
                exit('7');
            'AUG':
                exit('8');
            'SEP':
                exit('9');
            'OCT':
                exit('10');
            'NOV':
                exit('11');
            'DEC':
                exit('12');
            else
                exit(''); // Return empty string for invalid month
        end;
    end;


    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TempSUCOmipEntry: Record "SUC Omip Entry" temporary;
        TempSUCOmipExternalUsers: Record "SUC Omip External Users" temporary;
        NextEntryNo: Integer;
        FileName: Text;
        SheetName: Text;

}