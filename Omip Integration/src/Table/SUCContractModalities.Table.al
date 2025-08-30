namespace Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Masters;
using Sucasuc.Energy.Ledger;
using System.Reflection;
using System.IO;
table 50195 "SUC Contract Modalities"
{
    DataClassification = CustomerContent;
    Caption = 'Contract Modalities';
    DrillDownPageId = "SUC Contract Modalities";
    LookupPageId = "SUC Contract Modalities";

    fields
    {
        field(1; "Marketer No."; Code[20])
        {
            Caption = 'Marketer';
            TableRelation = "SUC Omip Marketers"."No.";
        }
        field(2; "Energy Type"; Enum "SUC Energy Type")
        {
            Caption = 'Energy Type';
            DataClassification = CustomerContent;
        }
        field(3; "Family Code"; Code[20])
        {
            Caption = 'Family Code';
            TableRelation = "SUC Fam. Contract Modalities"."Code";
        }
        field(4; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(5; "Custom Name"; Text[100])
        {
            Caption = 'Custom Name';
        }
        field(6; "Reference Contract Code"; Text[50])
        {
            Caption = 'Reference Contract Code';
        }
        field(7; Observations; Text[250])
        {
            Caption = 'Observations';
        }
        field(8; Tittle; Text[250])
        {
            Caption = 'Tittle';
        }
        field(9; "Tittle Complement 1"; Text[100])
        {
            Caption = 'Tittle Complement 1';
        }
        field(10; "Tittle Complement 2"; Text[100])
        {
            Caption = 'Tittle Complement 2';
        }
        field(11; "Tittle Complement 3"; Text[100])
        {
            Caption = 'Tittle Complement 3';
        }
        field(12; "Body Applicable Conditions"; Blob)
        {
            Caption = 'Body Applicable Conditions';
        }
        field(13; "Body Complement 1"; Text[100])
        {
            Caption = 'Body Complement 1';
        }
        field(14; "Body Complement 2"; Text[100])
        {
            Caption = 'Body Complement 2';
        }
        field(15; "Body Complement 3"; Text[100])
        {
            Caption = 'Body Complement 3';
        }
        field(16; "Body Complement 4"; Text[100])
        {
            Caption = 'Body Complement 4';
        }
        field(17; "Body Complement 5"; Text[100])
        {
            Caption = 'Body Complement 5';
        }
        field(18; "Body Complement 6"; Text[100])
        {
            Caption = 'Body Complement 6';
        }
        field(20; "No. Contract App. Cond. Tittle"; Code[20])
        {
            Caption = 'No. Contract App. Conditions Tittle';
            TableRelation = "SUC Contract App. Cond. Tittle"."No.";
        }
        field(19; "No. Contract App. Cond. Body"; Code[20])
        {
            Caption = 'No. Contract App. Conditions Body';
            TableRelation = "SUC Contract App. Cond. Body"."Entry No.";
        }
    }

    keys
    {
        key(Key1; "Marketer No.", "Energy Type", Name)
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    begin
        DeleteAssociatedModalityVersions();
        DeleteAssociatedControlPricesRecords();
        DeleteAssociatedConditionImportLog();
    end;

    /// <summary>
    /// Deletes all modality versions associated with this contract modality
    /// </summary>
    local procedure DeleteAssociatedModalityVersions()
    var
        ModalityVersionControl: Record "SUC Modality Version Control";
    begin
        ModalityVersionControl.Reset();
        ModalityVersionControl.SetRange("Marketer No.", "Marketer No.");
        ModalityVersionControl.SetRange("Energy Type", "Energy Type");
        ModalityVersionControl.SetRange("Base Modality Name", Name);

        if not ModalityVersionControl.IsEmpty() then
            ModalityVersionControl.DeleteAll(true);
    end;

    /// <summary>
    /// Deletes all control prices records associated with this contract modality
    /// </summary>
    local procedure DeleteAssociatedControlPricesRecords()
    var
        ControlPricesEnergy: Record "SUC Control Prices Energy";
    begin
        ControlPricesEnergy.Reset();
        ControlPricesEnergy.SetRange("Marketer No.", "Marketer No.");
        ControlPricesEnergy.SetRange("Energy Type", "Energy Type");
        ControlPricesEnergy.SetRange(Modality, Name);

        if not ControlPricesEnergy.IsEmpty() then
            ControlPricesEnergy.DeleteAll(true);
    end;

    /// <summary>
    /// Deletes all condition import log records associated with this contract modality
    /// </summary>
    local procedure DeleteAssociatedConditionImportLog()
    var
        ConditionImportLog: Record "SUC Condition Import Log";
    begin
        ConditionImportLog.Reset();
        ConditionImportLog.SetRange("Modality Name", Name);

        if not ConditionImportLog.IsEmpty() then
            ConditionImportLog.DeleteAll(true);
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
    /// Imports modalities from Excel file
    /// </summary>
    procedure ImportModalitiesFromExcel()
    begin
        if UploadIntoStream(SelectFileMsg, '', 'Excel Files (*.xlsx)|*.xlsx', FileName, ExcelInStream) then
            ProcessModalitiesFile();
    end;

    local procedure ProcessModalitiesFile()
    begin
        TempExcelBuffer.OpenBookStream(ExcelInStream, '');
        TempExcelBuffer.ReadSheet();
        AnalyzeModalitiesData();
        InsertModalitiesData();
    end;

    local procedure AnalyzeModalitiesData()
    begin
        MaxRowNo := 0;
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then
            MaxRowNo := TempExcelBuffer."Row No.";
    end;

    local procedure InsertModalitiesData()
    var
        RowNo: Integer;
        SuccessCount: Integer;
        ErrorCount: Integer;
        ErrorText: Text;
        ImportResultMsg: Label 'Import completed.\\Success: %1 records\\Errors: %2 records%3';
        ErrorHeaderMsg: Label '\\\\ERRORS:\\';
    begin
        // Validate Excel structure
        if not ValidateExcelHeaders() then
            exit;

        // Process each row (starting from row 2, skip headers)
        for RowNo := 2 to MaxRowNo do
            if ProcessExcelRow(RowNo, ErrorText) then
                SuccessCount += 1
            else
                ErrorCount += 1;

        // Show results
        if ErrorCount > 0 then
            Message(ImportResultMsg, SuccessCount, ErrorCount, ErrorHeaderMsg + '\\' + ErrorText)
        else
            Message(ImportResultMsg, SuccessCount, ErrorCount, '');
    end;

    local procedure ValidateExcelHeaders(): Boolean
    var
        ExpectedHeaders: array[7] of Text[50];
        ActualHeader: Text;
        ColumnNo: Integer;
        ErrorMessage: Text;
        HasErrors: Boolean;
        InvalidStructureMsg: Label 'Invalid Excel structure. Expected headers:\\COMERCIALIZADORA, TIPO ENERGIA, FAMILIA, NOMBRE, NOMBRE PERSONALIZADO, CODIGO REFERENCIA CONTRATO, OBSERVACIONES';
        MissingHeaderMsg: Label 'Missing required header at column %1: Expected "%2", Found "%3"';
    begin
        // Define expected headers in exact order
        ExpectedHeaders[1] := 'COMERCIALIZADORA';
        ExpectedHeaders[2] := 'TIPO ENERGIA';
        ExpectedHeaders[3] := 'FAMILIA';
        ExpectedHeaders[4] := 'NOMBRE';
        ExpectedHeaders[5] := 'NOMBRE PERSONALIZADO';
        ExpectedHeaders[6] := 'CODIGO REFERENCIA CONTRATO';
        ExpectedHeaders[7] := 'OBSERVACIONES';

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
            Message(ErrorMessage + '\\' + InvalidStructureMsg);
            exit(false);
        end;

        exit(true);
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin
        TempExcelBuffer.Reset();
        if TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    local procedure ProcessExcelRow(RowNo: Integer; var ErrorText: Text): Boolean
    var
        FamContractModalities: Record "SUC Fam. Contract Modalities";
        OmipMarketers: Record "SUC Omip Marketers";
        ContractModalities: Record "SUC Contract Modalities";
        ModalityVersionControl: Record "SUC Modality Version Control";
        MarketerNo: Code[20];
        EnergyTypeText: Text;
        FamilyCode: Code[20];
        ModalityName: Text[100];
        CustomName: Text[100];
        ReferenceContractCode: Text[50];
        Comments: Text[250];
        EnergyType: Enum "SUC Energy Type";
        BaseModalityName: Text[100];
        VersionCode: Code[10];
        VersionNumber: Integer;
        QuarterCode: Code[10];
        ErrorMarketerEmptyMsg: Label 'Row %1: Marketer is mandatory.';
        ErrorNameEmptyMsg: Label 'Row %1: Name is mandatory.';
        ErrorMarketerNotFoundMsg: Label 'Row %1: Marketer "%2" not found.';
        ErrorEnergyTypeMsg: Label 'Row %1: Invalid Energy Type "%2".';
        ErrorCreatingModalityMsg: Label 'Row %1: Error creating modality "%2": %3';
    begin
        // Extract data from row using fixed column positions (like SUC Control Prices Energy)
        MarketerNo := CopyStr(GetValueAtCell(RowNo, 1), 1, 20);                  // Column 1: COMERCIALIZADORA
        EnergyTypeText := GetValueAtCell(RowNo, 2);                                        // Column 2: TIPO ENERGIA
        FamilyCode := CopyStr(GetValueAtCell(RowNo, 3), 1, 20);                          // Column 3: FAMILIA
        ModalityName := CopyStr(GetValueAtCell(RowNo, 4), 1, 100);                          // Column 4: NOMBRE
        CustomName := CopyStr(GetValueAtCell(RowNo, 5), 1, 100);             // Column 5: NOMBRE PERSONALIZADO
        ReferenceContractCode := CopyStr(GetValueAtCell(RowNo, 6), 1, 50);         // Column 6: CODIGO REFERENCIA CONTRATO
        Comments := CopyStr(GetValueAtCell(RowNo, 7), 1, 250);                   // Column 7: OBSERVACIONES

        // Validate mandatory fields
        if MarketerNo = '' then begin
            ErrorText += StrSubstNo(ErrorMarketerEmptyMsg, RowNo) + '\\';
            exit(false);
        end;

        if ModalityName = '' then begin
            ErrorText += StrSubstNo(ErrorNameEmptyMsg, RowNo) + '\\';
            exit(false);
        end;

        // Validate marketer exists
        if not OmipMarketers.Get(MarketerNo) then begin
            ErrorText += StrSubstNo(ErrorMarketerNotFoundMsg, RowNo, MarketerNo) + '\\';
            exit(false);
        end;

        // Validate and convert energy type
        case UpperCase(EnergyTypeText) of
            'ELECTRICIDAD', 'ELECTRICITY':
                EnergyType := EnergyType::Electricity;
            'GAS':
                EnergyType := EnergyType::Gas;
            else begin
                ErrorText += StrSubstNo(ErrorEnergyTypeMsg, RowNo, EnergyTypeText) + '\\';
                exit(false);
            end;
        end;

        // Create family if it doesn't exist
        if FamilyCode <> '' then
            if not FamContractModalities.Get(FamilyCode) then begin
                FamContractModalities.Init();
                FamContractModalities.Code := FamilyCode;
                FamContractModalities.Description := FamilyCode;
                FamContractModalities.Insert();
            end;

        // Extract version info using SUC Modality Version Control function
        ModalityVersionControl.ExtractVersionInfo(ModalityName, BaseModalityName, VersionCode, VersionNumber, QuarterCode);
        if BaseModalityName = '' then
            BaseModalityName := ModalityName;

        // Create or update contract modality
        ContractModalities.Reset();
        ContractModalities.SetRange("Marketer No.", MarketerNo);
        ContractModalities.SetRange("Energy Type", EnergyType);
        ContractModalities.SetRange(Name, BaseModalityName);

        if not ContractModalities.FindFirst() then begin
            ContractModalities.Init();
            ContractModalities."Marketer No." := MarketerNo;
            ContractModalities."Energy Type" := EnergyType;
            ContractModalities."Family Code" := FamilyCode;
            ContractModalities.Name := BaseModalityName;
            ContractModalities."Custom Name" := CustomName;
            ContractModalities."Reference Contract Code" := ReferenceContractCode;
            ContractModalities.Observations := Comments;

            if not ContractModalities.Insert() then begin
                ErrorText += StrSubstNo(ErrorCreatingModalityMsg, RowNo, BaseModalityName, GetLastErrorText()) + '\\';
                exit(false);
            end;
        end else begin
            // Update existing record
            if CustomName <> '' then
                ContractModalities."Custom Name" := CustomName;
            if ReferenceContractCode <> '' then
                ContractModalities."Reference Contract Code" := ReferenceContractCode;
            if Comments <> '' then
                ContractModalities.Observations := Comments;
            if FamilyCode <> '' then
                ContractModalities."Family Code" := FamilyCode;
            ContractModalities.Modify();
        end;

        // Create version control record if version was found
        if VersionCode <> '' then
            ModalityVersionControl.CreateOrUpdateVersion(MarketerNo, EnergyType, '', ModalityName, CopyStr(FileName, 1, 250));

        exit(true);
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ExcelInStream: InStream;
        MaxRowNo: Integer;
        FileName: Text;
        SelectFileMsg: Label 'Select Excel file to import';
}