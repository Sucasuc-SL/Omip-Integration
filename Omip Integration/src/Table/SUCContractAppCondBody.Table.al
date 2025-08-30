namespace Sucasuc.Omip.Contracts;
using System.Reflection;
using System.IO;
using Microsoft.Utilities;
table 50219 "SUC Contract App. Cond. Body"
{
    DataClassification = CustomerContent;
    Caption = 'Contract Applicable Conditions Body';
    DrillDownPageId = "SUC Contract App. Cond. Body";
    LookupPageId = "SUC Contract App. Cond. Body";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Body Applicable Conditions"; Blob)
        {
            Caption = 'Body Applicable Conditions';
        }
        field(3; "Body Complement 1"; Text[100])
        {
            Caption = 'Body Complement 1';
        }
        field(4; "Body Complement 2"; Text[100])
        {
            Caption = 'Body Complement 2';
        }
        field(5; "Body Complement 3"; Text[100])
        {
            Caption = 'Body Complement 3';
        }
        field(6; "Body Complement 4"; Text[100])
        {
            Caption = 'Body Complement 4';
        }
        field(7; "Body Complement 5"; Text[100])
        {
            Caption = 'Body Complement 5';
        }
        field(8; "Body Complement 6"; Text[100])
        {
            Caption = 'Body Complement 6';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "Entry No." = 0 then
            "Entry No." := GetNextEntryNo();
    end;

    trigger OnDelete()
    begin
        DeleteAssociatedConditionImportLog();
        DisassociateModalitiesAndClearComplements();
    end;

    /// <summary>
    /// Gets the next available Entry No. by finding the maximum + 1
    /// </summary>
    local procedure GetNextEntryNo(): Integer
    var
        ContractAppCondBody: Record "SUC Contract App. Cond. Body";
    begin
        ContractAppCondBody.Reset();
        if ContractAppCondBody.FindLast() then
            exit(ContractAppCondBody."Entry No." + 1)
        else
            exit(1);
    end;

    /// <summary>
    /// Deletes all condition import log records associated with this condition
    /// </summary>
    local procedure DeleteAssociatedConditionImportLog()
    var
        ConditionImportLog: Record "SUC Condition Import Log";
    begin
        ConditionImportLog.Reset();
        ConditionImportLog.SetRange("Condition Code", Format("Entry No."));

        if not ConditionImportLog.IsEmpty() then
            ConditionImportLog.DeleteAll(true);
    end;

    /// <summary>
    /// Disassociates all modalities that have this condition assigned and clears their Body Complement fields
    /// </summary>
    local procedure DisassociateModalitiesAndClearComplements()
    var
        ContractModalities: Record "SUC Contract Modalities";
    begin
        ContractModalities.Reset();
        ContractModalities.SetRange("No. Contract App. Cond. Body", Format("Entry No."));

        if ContractModalities.FindSet() then
            repeat
                // Clear the condition association
                ContractModalities."No. Contract App. Cond. Body" := '';

                // Clear all Body Complement fields
                ContractModalities."Body Complement 1" := '';
                ContractModalities."Body Complement 2" := '';
                ContractModalities."Body Complement 3" := '';
                ContractModalities."Body Complement 4" := '';
                ContractModalities."Body Complement 5" := '';
                ContractModalities."Body Complement 6" := '';

                ContractModalities.Modify();
            until ContractModalities.Next() = 0;
    end;

    procedure SetDataBlob(FieldNo: Integer; NewData: Text)
    var
        OutStream: OutStream;
    begin
        case FieldNo of
            FieldNo("Body Applicable Conditions"):
                begin
                    Clear("Body Applicable Conditions");
                    "Body Applicable Conditions".CreateOutStream(OutStream, TextEncoding::UTF8);
                    OutStream.WriteText(NewData);
                    Modify();
                end;
        end;
    end;

    procedure GetDataValueBlob(FieldNo: Integer): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        case FieldNo of
            FieldNo("Body Applicable Conditions"):
                begin
                    CalcFields("Body Applicable Conditions");
                    "Body Applicable Conditions".CreateInStream(InStream, TextEncoding::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Body Applicable Conditions")));
                end;
        end;
    end;

    /// <summary>
    /// Imports contract applicable conditions body from Excel file
    /// </summary>
    procedure ImportConditionsFromExcel()
    begin
        if UploadIntoStream(SelectFileMsg, '', 'Excel Files (*.xlsx)|*.xlsx', FileName, ExcelInStream) then
            ProcessConditionsFile();
    end;

    local procedure ProcessConditionsFile()
    var
        HasTextosSheet: Boolean;
        HasValoresSheet: Boolean;
        InvalidStructureMsg: Label 'Excel file must contain exactly two sheets: "TEXTOS" and "VALORES"';
    begin
        // Validate that the Excel has exactly two sheets: TEXTOS and VALORES
        TempExcelBuffer.GetSheetsNameListFromStream(ExcelInStream, TempNameValueBufferOut);

        HasTextosSheet := false;
        HasValoresSheet := false;

        if TempNameValueBufferOut.FindSet() then
            repeat
                case UpperCase(TempNameValueBufferOut.Value) of
                    'TEXTOS':
                        HasTextosSheet := true;
                    'VALORES':
                        HasValoresSheet := true;
                end;
            until TempNameValueBufferOut.Next() = 0;

        if not (HasTextosSheet and HasValoresSheet) then
            Error(InvalidStructureMsg);

        // Process TEXTOS sheet first
        TempExcelBuffer.OpenBookStream(ExcelInStream, 'TEXTOS');
        TempExcelBuffer.ReadSheet();
        AnalyzeConditionsData();
        InsertConditionsData();

        // Process VALORES sheet second
        TempExcelBuffer.OpenBookStream(ExcelInStream, 'VALORES');
        TempExcelBuffer.ReadSheet();
        AnalyzeValoresData();
        InsertValoresData();
    end;

    local procedure AnalyzeConditionsData()
    begin
        MaxRowNo := 0;
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then
            MaxRowNo := TempExcelBuffer."Row No.";
    end;

    local procedure AnalyzeValoresData()
    begin
        MaxRowNo := 0;
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then
            MaxRowNo := TempExcelBuffer."Row No.";
    end;

    local procedure InsertConditionsData()
    var
        ImportLogPage: Page "SUC Condition Import Log";
        RowNo: Integer;
    begin
        // Clear previous log entries from today
        ClearTodayImportLog();

        // Validate Excel structure
        if not ValidateExcelHeaders() then
            exit;

        // Process each row (starting from row 2, skip headers)
        for RowNo := 2 to MaxRowNo do
            ProcessExcelRow(RowNo);

        ImportLogPage.Run();
    end;

    local procedure InsertValoresData()
    var
        RowNo: Integer;
        ErrorText: Text;
    begin
        // Validate Excel structure for VALORES sheet
        if not ValidateValoresHeaders() then
            exit;

        // Process each row (starting from row 2, skip headers)
        for RowNo := 2 to MaxRowNo do
            ProcessValoresRow(RowNo, ErrorText);
    end;

    local procedure ClearTodayImportLog()
    var
        ConditionImportLog: Record "SUC Condition Import Log";
        TodayStart: DateTime;
        TodayEnd: DateTime;
    begin
        TodayStart := CreateDateTime(Today(), 0T);
        TodayEnd := CreateDateTime(Today(), 235959T);

        ConditionImportLog.Reset();
        ConditionImportLog.SetRange("Import Date", TodayStart, TodayEnd);
        ConditionImportLog.DeleteAll();
    end;

    local procedure ValidateExcelHeaders(): Boolean
    var
        ExpectedHeaders: array[2] of Text[50];
        ActualHeader: Text;
        ColumnNo: Integer;
        ErrorMessage: Text;
        HasErrors: Boolean;
        InvalidStructureMsg: Label 'Invalid Excel structure. Expected headers:\\NOM, CONECO';
        MissingHeaderMsg: Label 'Missing required header at column %1: Expected "%2", Found "%3"';
    begin
        // Define expected headers in exact order
        ExpectedHeaders[1] := 'NOM';
        ExpectedHeaders[2] := 'CONECO';

        // Validate each column header
        HasErrors := false;
        ErrorMessage := '';

        for ColumnNo := 1 to 2 do begin
            ActualHeader := UpperCase(GetValueAtCell(1, ColumnNo));
            if ActualHeader <> UpperCase(ExpectedHeaders[ColumnNo]) then begin
                HasErrors := true;
                if ErrorMessage <> '' then
                    ErrorMessage += '\\';
                ErrorMessage += StrSubstNo(MissingHeaderMsg, ColumnNo, ExpectedHeaders[ColumnNo], ActualHeader);
            end;
        end;

        if HasErrors then begin
            ErrorMessage := ErrorMessage + '\\' + InvalidStructureMsg;
            Error(ErrorMessage);
        end;

        exit(true);
    end;

    local procedure ValidateValoresHeaders(): Boolean
    var
        ExpectedHeaders: array[7] of Text[50];
        ActualHeader: Text;
        ColumnNo: Integer;
        ErrorMessage: Text;
        HasErrors: Boolean;
        InvalidStructureMsg: Label 'Invalid VALORES sheet structure. Expected headers:\\MODALIDAD, %1, %2, %3, %4, %5, %6';
        MissingHeaderMsg: Label 'Missing required header at column %1: Expected "%2", Found "%3"';
    begin
        // Define expected headers for VALORES sheet
        ExpectedHeaders[1] := 'MODALIDAD';
        ExpectedHeaders[2] := '%1';
        ExpectedHeaders[3] := '%2';
        ExpectedHeaders[4] := '%3';
        ExpectedHeaders[5] := '%4';
        ExpectedHeaders[6] := '%5';
        ExpectedHeaders[7] := '%6';

        // Validate each column header
        HasErrors := false;
        ErrorMessage := '';

        for ColumnNo := 1 to 7 do begin
            ActualHeader := UpperCase(GetValueAtCell(1, ColumnNo));
            if ActualHeader <> UpperCase(ExpectedHeaders[ColumnNo]) then begin
                HasErrors := true;
                if ErrorMessage <> '' then
                    ErrorMessage += '\\';
                ErrorMessage += StrSubstNo(MissingHeaderMsg, ColumnNo, ExpectedHeaders[ColumnNo], ActualHeader);
            end;
        end;

        if HasErrors then begin
            ErrorMessage := ErrorMessage + '\\' + InvalidStructureMsg;
            Error(ErrorMessage);
        end;

        exit(true);
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColumnNo: Integer): Text
    var
        CellValue: Text;
    begin
        TempExcelBuffer.Reset();
        if TempExcelBuffer.Get(RowNo, ColumnNo) then begin
            CellValue := TempExcelBuffer."Cell Value as Text";

            if TempExcelBuffer."SUC Extended Cell Value Text" <> '' then begin
                CellValue := TempExcelBuffer."SUC Extended Cell Value Text";
                // If there's additional content in the second field, append it
                if TempExcelBuffer."SUC Extended Cell Value Text 1" <> '' then
                    CellValue += TempExcelBuffer."SUC Extended Cell Value Text 1";
            end;

            exit(CellValue);
        end else
            exit('');
    end;

    local procedure ProcessExcelRow(RowNo: Integer): Boolean
    var
        ModalitiesText: Text;
        ConditionText: Text;
        ConditionCode: Integer;
        ModalityName: Text[100];
        ModalitiesList: List of [Text];
        ModalityItem: Text;
        HasErrors: Boolean;
    begin
        // Extract data from row using fixed column positions
        ModalitiesText := GetValueAtCell(RowNo, 1);  // Column 1: NOM (modalidades)
        ConditionText := GetValueAtCell(RowNo, 2);   // Column 2: CONECO (texto condición)

        // Validate mandatory fields
        if ConditionText = '' then begin
            LogImportEntry(RowNo, '', 0, "SUC Import Status"::Error, 'Condition text is mandatory', '', 'TEXTOS');
            exit(false);
        end;

        // Create condition record
        ConditionCode := CreateConditionRecord(ConditionText);
        if ConditionCode = 0 then begin
            LogImportEntry(RowNo, '', 0, "SUC Import Status"::Error, 'Error creating condition: ' + GetLastErrorText(), '', 'TEXTOS');
            exit(false);
        end;

        // Process modalities list if provided
        if ModalitiesText <> '' then begin
            Clear(ModalitiesList);
            ParseModalitiesList(ModalitiesText, ModalitiesList);
            foreach ModalityItem in ModalitiesList do begin
                ModalityName := CopyStr(ModalityItem.Trim(), 1, 100);
                if ModalityName <> '' then
                    if not AssignConditionToModality(ModalityName, ConditionCode, RowNo) then
                        HasErrors := true;
            end;
        end;

        exit(not HasErrors);
    end;

    local procedure CreateConditionRecord(ConditionText: Text): Integer
    var
        ContractAppCondBody: Record "SUC Contract App. Cond. Body";
        ExistingCondBody: Record "SUC Contract App. Cond. Body";
        ExistingText: Text;
    begin
        // First, check if a condition with the same text already exists
        ExistingCondBody.Reset();
        if ExistingCondBody.FindSet() then
            repeat
                ExistingText := ExistingCondBody.GetDataValueBlob(ExistingCondBody.FieldNo("Body Applicable Conditions"));
                if ExistingText = ConditionText then
                    exit(ExistingCondBody."Entry No.");
            until ExistingCondBody.Next() = 0;

        // Create new record (manual Entry No. assignment via OnInsert trigger)
        ContractAppCondBody.Init();
        ContractAppCondBody.Insert(true);
        ContractAppCondBody.SetDataBlob(ContractAppCondBody.FieldNo("Body Applicable Conditions"), ConditionText);
        exit(ContractAppCondBody."Entry No.");
    end;

    local procedure ParseModalitiesList(ModalitiesText: Text; var ModalitiesList: List of [Text])
    var
        CleanText: Text;
        i: Integer;
        ModalityName: Text;
        InsideQuotes: Boolean;
        StartPos: Integer;
        TextLength: Integer;
    begin
        // Remove outer brackets
        CleanText := ModalitiesText.Replace('[', '').Replace(']', '').Trim();
        TextLength := StrLen(CleanText);

        i := 1;
        InsideQuotes := false;
        StartPos := 0;

        while i <= TextLength do begin
            if CleanText[i] = '''' then
                if not InsideQuotes then begin
                    // Opening quote - start capturing
                    InsideQuotes := true;
                    StartPos := i + 1;
                end else begin
                    // Closing quote - extract modality name
                    if StartPos > 0 then begin
                        ModalityName := CopyStr(CleanText, StartPos, i - StartPos);
                        if ModalityName <> '' then
                            ModalitiesList.Add(ModalityName);
                    end;
                    InsideQuotes := false;
                    StartPos := 0;
                end;
            i += 1;
        end;
    end;

    local procedure AssignConditionToModality(ModalityName: Text[100]; ConditionCode: Integer; RowNo: Integer): Boolean
    var
        ContractModalities: Record "SUC Contract Modalities";
        ModalityVersionControl: Record "SUC Modality Version Control";
        ContractAppCondBody: Record "SUC Contract App. Cond. Body";
        BaseModalityName: Text[100];
        VersionCode: Code[10];
        VersionNumber: Integer;
        QuarterCode: Code[10];
        ConditionTextPreview: Text[100];
        FoundCount: Integer;
        AssignedToModalitiesMsg: Label 'Assigned to %1 modalities';
    begin
        // Get condition text preview
        if ContractAppCondBody.Get(ConditionCode) then
            ConditionTextPreview := CopyStr(ContractAppCondBody.GetDataValueBlob(ContractAppCondBody.FieldNo("Body Applicable Conditions")), 1, 100);

        // Extract base modality name (remove version and quarter if present)
        ModalityVersionControl.ExtractVersionInfo(ModalityName, BaseModalityName, VersionCode, VersionNumber, QuarterCode);
        if BaseModalityName = '' then
            BaseModalityName := ModalityName;

        // Find modality by base name (search in all marketers and energy types)
        ContractModalities.Reset();
        ContractModalities.SetRange(Name, BaseModalityName);
        if ContractModalities.FindSet() then begin
            repeat
                ContractModalities."No. Contract App. Cond. Body" := Format(ConditionCode);
                if ContractModalities.Modify() then
                    FoundCount += 1
                else
                    LogImportEntry(RowNo, BaseModalityName, ConditionCode, "SUC Import Status"::Error,
                        'Error assigning condition: ' + GetLastErrorText(), ConditionTextPreview, 'TEXTOS');
            until ContractModalities.Next() = 0;

            if FoundCount > 0 then begin
                LogImportEntry(RowNo, BaseModalityName, ConditionCode, "SUC Import Status"::Success,
                    StrSubstNo(AssignedToModalitiesMsg, FoundCount), ConditionTextPreview, 'TEXTOS');
                exit(true);
            end;
        end else begin
            LogImportEntry(RowNo, BaseModalityName, ConditionCode, "SUC Import Status"::Error,
                'Modality not found', ConditionTextPreview, 'TEXTOS');
            exit(false);
        end;

        exit(false);
    end;

    local procedure LogImportEntry(RowNo: Integer; ModalityName: Text[100]; ConditionCode: Integer; Status: Enum "SUC Import Status"; ErrorMessage: Text[250]; ConditionTextPreview: Text[100]; Source: Text[20])
    var
        ConditionImportLog: Record "SUC Condition Import Log";
    begin
        ConditionImportLog.Init();
        ConditionImportLog."Import Date" := CurrentDateTime();
        ConditionImportLog."Row No." := RowNo;
        ConditionImportLog."Modality Name" := ModalityName;
        ConditionImportLog."Condition Code" := Format(ConditionCode);
        ConditionImportLog."Status" := Status;
        ConditionImportLog."Error Message" := ErrorMessage;
        ConditionImportLog."Condition Text Preview" := ConditionTextPreview;
        ConditionImportLog."Source" := Source;
        ConditionImportLog.Insert(true);
    end;

    local procedure ProcessValoresRow(RowNo: Integer; var ErrorText: Text): Boolean
    var
        ContractModalities: Record "SUC Contract Modalities";
        ModalityVersionControl: Record "SUC Modality Version Control";
        ModalityName: Text;
        BodyComp1, BodyComp2, BodyComp3, BodyComp4, BodyComp5, BodyComp6 : Text;
        BaseModalityName: Text[100];
        VersionCode: Code[10];
        VersionNumber: Integer;
        QuarterCode: Code[10];
        ModalityNameText: Text[100];
        ErrorMsg: Label 'Modality not found';
        UpdatedMsg: Label 'Updated %1 modalities with Body Complement values';
        FoundCount: Integer;
    begin
        // Get MODALIDAD from first column
        ModalityName := GetValueAtCell(RowNo, 1);

        if ModalityName = '' then
            exit(false);

        // Convert to proper length
        ModalityNameText := CopyStr(ModalityName, 1, 100);

        // Extract base modality name (remove version and quarter if present)
        ModalityVersionControl.ExtractVersionInfo(ModalityNameText, BaseModalityName, VersionCode, VersionNumber, QuarterCode);
        if BaseModalityName = '' then
            BaseModalityName := ModalityNameText;

        // Get values from columns 2-7 (%1 to %6)
        BodyComp1 := GetValueAtCell(RowNo, 2);
        BodyComp2 := GetValueAtCell(RowNo, 3);
        BodyComp3 := GetValueAtCell(RowNo, 4);
        BodyComp4 := GetValueAtCell(RowNo, 5);
        BodyComp5 := GetValueAtCell(RowNo, 6);
        BodyComp6 := GetValueAtCell(RowNo, 7);

        // Find and update all modalities with this base name
        ContractModalities.Reset();
        ContractModalities.SetRange(Name, BaseModalityName);
        if ContractModalities.FindSet() then
            repeat
                // Update Body Complement fields in Contract Modalities
                ContractModalities."Body Complement 1" := CopyStr(BodyComp1, 1, MaxStrLen(ContractModalities."Body Complement 1"));
                ContractModalities."Body Complement 2" := CopyStr(BodyComp2, 1, MaxStrLen(ContractModalities."Body Complement 2"));
                ContractModalities."Body Complement 3" := CopyStr(BodyComp3, 1, MaxStrLen(ContractModalities."Body Complement 3"));
                ContractModalities."Body Complement 4" := CopyStr(BodyComp4, 1, MaxStrLen(ContractModalities."Body Complement 4"));
                ContractModalities."Body Complement 5" := CopyStr(BodyComp5, 1, MaxStrLen(ContractModalities."Body Complement 5"));
                ContractModalities."Body Complement 6" := CopyStr(BodyComp6, 1, MaxStrLen(ContractModalities."Body Complement 6"));
                ContractModalities.Modify();
                FoundCount += 1;
            until ContractModalities.Next() = 0;

        if FoundCount = 0 then begin
            // Log that modality was not found
            LogImportEntry(RowNo, BaseModalityName, 0, "SUC Import Status"::Error,
                ErrorMsg, '', 'VALORES');
            ErrorText += ErrorMsg + '\\';
            exit(false);
        end;

        // Log successful update
        LogImportEntry(RowNo, BaseModalityName, 0, "SUC Import Status"::Success,
            StrSubstNo(UpdatedMsg, FoundCount), '', 'VALORES');

        exit(true);
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TempNameValueBufferOut: Record "Name/Value Buffer" temporary;
        ExcelInStream: InStream;
        MaxRowNo: Integer;
        FileName: Text;
        SelectFileMsg: Label 'Select Excel file to import';
}