namespace Sucasuc.Energy.Ledger;
using Sucasuc.Omip.Masters;
using Microsoft.Utilities;
using System.IO;
using Sucasuc.Omip.Contracts;
table 50193 "SUC Control Prices Energy"
{
    DataClassification = CustomerContent;
    Caption = 'Control Prices Energy';
    DrillDownPageId = "SUC Control Prices Energy";
    LookupPageId = "SUC Control Prices Energy";

    fields
    {
        field(1; "Id."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Id.';
        }
        field(2; "Marketer No."; Code[20])
        {
            Caption = 'Marketer No.';
            TableRelation = "SUC Omip Marketers"."No.";
        }
        field(3; "Energy Type"; Enum "SUC Energy Type")
        {
            Caption = 'Energy Type';
        }
        field(4; "Id Rate WS"; Integer)
        {
            Caption = 'Id Rate WS';
        }
        field(5; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
        }
        field(6; "Potency Upper"; Decimal)
        {
            Caption = 'Potency Upper';
        }
        field(7; "Potency Lower"; Decimal)
        {
            Caption = 'Potency Lower';
        }
        field(8; "Rate Type Contract"; Enum "SUC Rate Type Contract")
        {
            Caption = 'Rate Type';
        }
        field(9; "GOs Visible"; Boolean)
        {
            Caption = 'GOs Visible';
        }
        field(10; Modality; Text[100])
        {
            Caption = 'Modality';
            TableRelation = "SUC Contract Modalities".Name where("Marketer No." = field("Marketer No."), "Energy Type" = field("Energy Type"));
        }
        field(11; Discount; Decimal)
        {
            Caption = 'Discount';
        }
        field(12; P1; Decimal)
        {
            Caption = 'P1';
            DecimalPlaces = 0 : 6;
        }
        field(13; P2; Decimal)
        {
            Caption = 'P2';
            DecimalPlaces = 0 : 6;
        }
        field(14; P3; Decimal)
        {
            Caption = 'P3';
            DecimalPlaces = 0 : 6;
        }
        field(15; P4; Decimal)
        {
            Caption = 'P4';
            DecimalPlaces = 0 : 6;
        }
        field(16; P5; Decimal)
        {
            Caption = 'P5';
            DecimalPlaces = 0 : 6;
        }
        field(17; P6; Decimal)
        {
            Caption = 'P6';
            DecimalPlaces = 0 : 6;
        }
        field(18; E1; Decimal)
        {
            Caption = 'E1';
            DecimalPlaces = 0 : 6;
        }
        field(19; E2; Decimal)
        {
            Caption = 'E2';
            DecimalPlaces = 0 : 6;
        }
        field(20; E3; Decimal)
        {
            Caption = 'E3';
            DecimalPlaces = 0 : 6;
        }
        field(21; E4; Decimal)
        {
            Caption = 'E4';
            DecimalPlaces = 0 : 6;
        }
        field(22; E5; Decimal)
        {
            Caption = 'E5';
            DecimalPlaces = 0 : 6;
        }
        field(23; E6; Decimal)
        {
            Caption = 'E6';
            DecimalPlaces = 0 : 6;
        }
        field(24; Maintenance; Decimal)
        {
            Caption = 'Maintenance';
        }
        field(25; SGE; Decimal)
        {
            Caption = 'SGE';
        }
        field(26; SGEV; Decimal)
        {
            Caption = 'SGEV';
        }
        field(27; Remuneration; Decimal)
        {
            Caption = 'Remuneration';
        }
        field(28; Contracting; Boolean)
        {
            Caption = 'Contracting';
        }
        field(29; Comparison; Boolean)
        {
            Caption = 'Comparison';
        }
        field(30; Web; Boolean)
        {
            Caption = 'Web';
        }
        field(31; "Contracting Status"; Text[20])
        {
            Caption = 'Contracting Status';
        }
        field(32; "Comparison Status"; Text[20])
        {
            Caption = 'Comparison Status';
        }
        field(33; "Price Source"; Text[30])
        {
            Caption = 'Price Source';
        }
        field(34; "Price Type"; Text[20])
        {
            Caption = 'Price Type';
        }
        field(36; "Modality Family"; Text[30])
        {
            Caption = 'Modality Family';
        }
        field(37; Annex; Text[50])
        {
            Caption = 'Annex';
        }
        field(38; "Custom Annex"; Text[50])
        {
            Caption = 'Custom Annex';
        }
        field(39; "Future Activation Modality"; Date)
        {
            Caption = 'Future Activation Modality';
        }
        field(40; "Contract Reference Code"; Text[30])
        {
            Caption = 'Contract Reference Code';
        }
        field(41; "Customer Type"; Text[20])
        {
            Caption = 'Customer Type';
        }
        field(42; "Special Price For"; Text[20])
        {
            Caption = 'Special Price For';
        }
        field(43; Province; Text[20])
        {
            Caption = 'Province';
        }
        field(44; "Visible Operating Costs"; Text[10])
        {
            Caption = 'Visible Operating Costs';
        }
        field(45; "Management Time Scale"; Text[5])
        {
            Caption = 'Management Time Scale';
        }
        field(46; "Measurement Equip. Mngt. Costs"; Decimal)
        {
            Caption = 'Measurement Equipment Management Costs';
        }
        field(47; "Maintenance Management Costs"; Decimal)
        {
            Caption = 'Maintenance Management Costs';
        }
        field(48; "Capacity Costs"; Decimal)
        {
            Caption = 'Capacity Costs';
        }
        field(49; "Company Remuneration Costs"; Text[250])
        {
            Caption = 'Company Remuneration Costs';
        }
        field(50; "Base Company Rem. Costs"; Decimal)
        {
            Caption = 'Base Company Remuneration Costs';
        }
        field(51; "Financial Costs"; Decimal)
        {
            Caption = 'Financial Costs';
        }
        field(52; "SGE Costs"; Decimal)
        {
            Caption = 'SGE Costs';
        }
        field(53; "SGEV Costs"; Decimal)
        {
            Caption = 'SGEV Costs';
        }
        field(54; "Contracted KW"; Decimal)
        {
            Caption = 'Contracted KW';
        }
        field(55; "General Discount"; Decimal)
        {
            Caption = 'General Discount';
        }
        field(56; "Power Bonus"; Boolean)
        {
            Caption = 'Power Bonus';
        }
        field(57; "Power Surcharge"; Boolean)
        {
            Caption = 'Power Surcharge';
        }
        field(58; "Power From"; Decimal)
        {
            Caption = 'Power From';
        }
        field(59; "Power To"; Decimal)
        {
            Caption = 'Power To';
        }
        field(60; "Power Time Scale"; Text[5])
        {
            Caption = 'Power Time Scale';
        }
        field(61; "First Year Power Discount"; Decimal)
        {
            Caption = 'First Year Power Discount';
        }
        field(62; "Energy From"; Decimal)
        {
            Caption = 'Energy From';
        }
        field(63; "Energy To"; Decimal)
        {
            Caption = 'Energy To';
        }
        field(64; "Energy Scale"; Text[5])
        {
            Caption = 'Energy Scale';
        }
        field(65; "First Year Energy Discount"; Decimal)
        {
            Caption = 'First Year Energy Discount';
        }
        field(66; "Processing Date"; Date)
        {
            Caption = 'Processing Date';
            Editable = false;
        }
        field(67; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = CustomerContent;
        }
        field(68; Version; Code[10])
        {
            Caption = 'Version';
            DataClassification = CustomerContent;
        }
        field(69; "Full Modality Name"; Text[100])
        {
            Caption = 'Full Modality Name';
            DataClassification = CustomerContent;
        }
        field(70; "Imported File Name"; Text[250])
        {
            Caption = 'Imported File Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Id.", Modality, Version, "Rate No.")
        {
            Clustered = true;
        }
        key(Key2; "Rate No.") { }
        key(Key3; "Marketer No.", "Energy Type", Modality, Version, "Rate No.") { }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Marketer No.", "Energy Type", "Rate No.", "Rate Type Contract", "Full Modality Name", Modality, Version) { }
    }

    trigger OnDelete()
    begin
        DeleteRelatedRecords();
    end;

    procedure ProcessExcel()
    begin
        if UploadIntoStream(ImportLbl, '', '', FileName, ExcelInStream) then
            ProcessFile();
    end;

    local procedure ProcessFile()
    begin
        TempExcelBuffer.GetSheetsNameListFromStream(ExcelInStream, TempNameValueBufferOut);
        if TempNameValueBufferOut.FindSet() then
            repeat
                Clear(SheetName);
                SheetName := TempNameValueBufferOut.Value;
                TempExcelBuffer.OpenBookStream(ExcelInStream, SheetName);
                TempExcelBuffer.ReadSheet();
                AnalyzeData();
                InsertData();
            until TempNameValueBufferOut.Next() = 0;
    end;

    local procedure AnalyzeData()
    begin
        RowNo := 0;
        MaxRowNo := 0;

        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then
            MaxRowNo := TempExcelBuffer."Row No.";

        // Validate Excel structure before processing
        ValidateExcelStructure();
    end;

    local procedure ValidateExcelStructure()
    var
        ExpectedHeaders: array[127] of Text[50];
        ActualHeader: Text;
        ColNo: Integer;
        Month: Integer;
        Period: Integer;
        ErrorMessage: Text;
        HasErrors: Boolean;
    begin
        // Define expected headers in correct order (WEB column included)
        ExpectedHeaders[1] := 'CONTRATACION';
        ExpectedHeaders[2] := 'COMPARATIVA';
        ExpectedHeaders[3] := 'WEB';
        ExpectedHeaders[4] := 'ESTADO_CONTRATACION';
        ExpectedHeaders[5] := 'ESTADO_COMPARATIVA';
        ExpectedHeaders[6] := 'FUENTE_PRECIOS';
        ExpectedHeaders[7] := 'COMERCIALIZADORA';
        ExpectedHeaders[8] := 'TIPO_ENERGIA';
        ExpectedHeaders[9] := 'TIPO_PRECIO';
        ExpectedHeaders[10] := 'TARIFA';
        ExpectedHeaders[11] := 'FAMILIA_MODALIDAD';
        ExpectedHeaders[12] := 'MODALIDAD';
        ExpectedHeaders[13] := 'ANEXO';
        ExpectedHeaders[14] := 'ANEXO_PERSONALIZADO';
        ExpectedHeaders[15] := 'MODALIDAD_ACTIVACION_FUTURA';
        ExpectedHeaders[16] := 'CODIGO_REFERENCIA_CONTRATO';
        ExpectedHeaders[17] := 'ID_TARIFA_WS';
        ExpectedHeaders[18] := 'TIPO_CLIENTE_WS';
        ExpectedHeaders[19] := 'TIPO_CLIENTE';
        ExpectedHeaders[20] := 'PRECIO_ESPECIAL_PARA';
        ExpectedHeaders[21] := 'PROVINCIA';
        ExpectedHeaders[22] := 'GASTOS_OPERATIVOS_VISIBLES';
        ExpectedHeaders[23] := 'ESCALA_TIEMPO_GESTIONES';
        ExpectedHeaders[24] := 'COSTES_GESTION_EQUIPOS_MEDIDA';
        ExpectedHeaders[25] := 'COSTES_GESTION_MANTENIMIENTO';
        ExpectedHeaders[26] := 'COSTES_CAPACIDAD';
        ExpectedHeaders[27] := 'COSTES_REMUNERACION_COMPANIA';
        ExpectedHeaders[28] := 'COSTES_REMUNERACION_COMPANIA_BASE';
        ExpectedHeaders[29] := 'COSTES_FINANCIEROS';
        ExpectedHeaders[30] := 'COSTES_SGE';
        ExpectedHeaders[31] := 'COSTES_SGEV';
        ExpectedHeaders[32] := 'KW_CONTRATADOS';
        ExpectedHeaders[33] := 'DESCUENTO_GENERAL';
        ExpectedHeaders[34] := 'BONIFICACION_POTENCIA';
        ExpectedHeaders[35] := 'RECARGO_POTENCIA';
        ExpectedHeaders[36] := 'POTENCIA_DESDE';
        ExpectedHeaders[37] := 'POTENCIA_HASTA';
        ExpectedHeaders[38] := 'ESCALA_TIEMPO_POTENCIA';
        ExpectedHeaders[39] := 'DESCUENTO_PRIMER_ANIO_POTENCIA';
        ExpectedHeaders[40] := 'P1';
        ExpectedHeaders[41] := 'P2';
        ExpectedHeaders[42] := 'P3';
        ExpectedHeaders[43] := 'P4';
        ExpectedHeaders[44] := 'P5';
        ExpectedHeaders[45] := 'P6';
        ExpectedHeaders[46] := 'ENERGIA_DESDE';
        ExpectedHeaders[47] := 'ENERGIA_HASTA';
        ExpectedHeaders[48] := 'ESCALA_ENERGIA';
        ExpectedHeaders[49] := 'DESCUENTO_PRIMER_ANIO_ENERGIA';
        ExpectedHeaders[50] := 'E1';
        ExpectedHeaders[51] := 'E2';
        ExpectedHeaders[52] := 'E3';
        ExpectedHeaders[53] := 'E4';
        ExpectedHeaders[54] := 'E5';
        ExpectedHeaders[55] := 'E6';

        // Historical index fields (P1-P6, Month 12 to Month 1 for each period)
        ColNo := 56;
        for Period := 1 to 6 do
            for Month := 12 downto 1 do begin
                ExpectedHeaders[ColNo] := 'INDEX_P' + Format(Period) + '_MES_' + Format(Month);
                ColNo += 1;
            end;

        // Validate each column header
        HasErrors := false;
        ErrorMessage := HeaderValidationErrorLbl;

        for ColNo := 1 to 127 do begin
            ActualHeader := UpperCase(GetValueAtCell(1, ColNo));
            if ActualHeader <> UpperCase(ExpectedHeaders[ColNo]) then begin
                HasErrors := true;
                ErrorMessage += 'Column ' + Format(ColNo) + ': Expected "' + ExpectedHeaders[ColNo] +
                              '", Found "' + ActualHeader + '"\';
            end;
        end;

        if HasErrors then
            Error(ErrorMessage);
    end;

    local procedure InsertData()
    var
        ExistingRecord: Record "SUC Control Prices Energy";
        ModalityVersionControl: Record "SUC Modality Version Control";
        LineNo: Integer;
        EnergyType: Text;
        ContractingValue: Text;
        ComparisonValue: Text;
        FutureActivationValue: Text;
        MarketerValue: Text;
        ModalityValue: Text;
        RateNoValue: Text[20];
        BaseModalityName: Text[100];
        VersionCode: Code[10];
        VersionNumber: Integer;
        QuarterCode: Code[10];
        TempDecimal: Decimal;
        RecordExists: Boolean;
        NextId: Integer;
    begin
        // Get the next available ID
        ExistingRecord.Reset();
        if ExistingRecord.FindLast() then
            NextId := ExistingRecord."Id." + 1
        else
            NextId := 1;

        LineNo := 1;
        for RowNo := 2 to MaxRowNo do begin

            // Get key values first to check for existing record
            Clear(MarketerValue);
            MarketerValue := GetValueAtCell(RowNo, 7);  // COMERCIALIZADORA now in column 7
            ModalityValue := CopyStr(GetValueAtCell(RowNo, 12), 1, 100); // MODALIDAD now in column 12
            RateNoValue := CopyStr(GetValueAtCell(RowNo, 10), 1, 20); // TARIFA now in column 10

            // Extract version information from the full modality name
            if ModalityVersionControl.ExtractVersionInfo(CopyStr(ModalityValue, 1, 100), BaseModalityName, VersionCode, VersionNumber, QuarterCode) then begin
                // Version found - use base modality name and version code for record identification
                BaseModalityName := BaseModalityName;
                VersionCode := VersionCode;
            end else begin
                // No version found - use full name as base and empty version
                BaseModalityName := CopyStr(ModalityValue, 1, 100);
                VersionCode := '';
            end;

            // Check if record already exists using base modality name + version + rate no.
            RecordExists := false;
            ExistingRecord.Reset();
            ExistingRecord.SetRange("Marketer No.", ValidateAndNormalizeMarketer(MarketerValue));
            ExistingRecord.SetRange(Modality, BaseModalityName);
            ExistingRecord.SetRange(Version, VersionCode);
            ExistingRecord.SetRange("Rate No.", RateNoValue); // Include Rate No. in uniqueness check
            if ExistingRecord.FindFirst() then begin
                SUCControlPricesEnergy := ExistingRecord;
                RecordExists := true;
            end else begin
                SUCControlPricesEnergy.Init();
                SUCControlPricesEnergy."Id." := NextId;
                NextId += 1;
            end;

            // Mapping according to new column order
            Clear(ContractingValue);
            ContractingValue := GetValueAtCell(RowNo, 1);
            case ContractingValue of
                'SI':
                    SUCControlPricesEnergy.Contracting := true;
                'NO':
                    SUCControlPricesEnergy.Contracting := false;
                else
                    SUCControlPricesEnergy.Contracting := false;
            end;

            Clear(ComparisonValue);
            ComparisonValue := GetValueAtCell(RowNo, 2);
            case ComparisonValue of
                'SI':
                    SUCControlPricesEnergy.Comparison := true;
                'NO':
                    SUCControlPricesEnergy.Comparison := false;
                else
                    SUCControlPricesEnergy.Comparison := false;
            end;

            // WEB (column 3) - New field mapping
            Clear(ComparisonValue);
            ComparisonValue := GetValueAtCell(RowNo, 3);
            case ComparisonValue of
                'SI':
                    SUCControlPricesEnergy.Web := true;
                'NO':
                    SUCControlPricesEnergy.Web := false;
                else
                    SUCControlPricesEnergy.Web := false;
            end;

            SUCControlPricesEnergy."Contracting Status" := CopyStr(GetValueAtCell(RowNo, 4), 1, 20);                  // ESTADO_CONTRATACION
            SUCControlPricesEnergy."Comparison Status" := CopyStr(GetValueAtCell(RowNo, 5), 1, 20);                   // ESTADO_COMPARATIVA
            SUCControlPricesEnergy."Price Source" := CopyStr(GetValueAtCell(RowNo, 6), 1, 30);                        // FUENTE_PRECIOS

            // COMERCIALIZADORA (column 7) - Validate if marketer exists
            Clear(MarketerValue);
            MarketerValue := GetValueAtCell(RowNo, 7);
            SUCControlPricesEnergy."Marketer No." := ValidateAndNormalizeMarketer(MarketerValue);

            // TIPO_ENERGIA (column 8)
            Clear(EnergyType);
            EnergyType := GetValueAtCell(RowNo, 8);
            case EnergyType of
                'ELECTRICIDAD':
                    SUCControlPricesEnergy."Energy Type" := SUCControlPricesEnergy."Energy Type"::Electricity;
                'GAS':
                    SUCControlPricesEnergy."Energy Type" := SUCControlPricesEnergy."Energy Type"::Gas;
            end;

            SUCControlPricesEnergy."Price Type" := CopyStr(GetValueAtCell(RowNo, 9), 1, 20);                          // TIPO_PRECIO
            SUCControlPricesEnergy."Rate No." := RateNoValue;                                                          // TARIFA
            SUCControlPricesEnergy."Modality Family" := CopyStr(GetValueAtCell(RowNo, 11), 1, 30);                    // FAMILIA_MODALIDAD
            SUCControlPricesEnergy."Full Modality Name" := CopyStr(GetValueAtCell(RowNo, 12), 1, 100);                // MODALIDAD (full name as imported)
            SUCControlPricesEnergy.Modality := BaseModalityName;                                                       // MODALIDAD (base name without version)
            SUCControlPricesEnergy.Version := VersionCode;                                                             // VERSION (extracted or default V1)
            SUCControlPricesEnergy."Imported File Name" := CopyStr(FileName, 1, MaxStrLen(SUCControlPricesEnergy."Imported File Name")); // Set the imported file name

            SUCControlPricesEnergy.Annex := CopyStr(GetValueAtCell(RowNo, 13), 1, 50);                                // ANEXO
            SUCControlPricesEnergy."Custom Annex" := CopyStr(GetValueAtCell(RowNo, 14), 1, 50);                       // ANEXO_PERSONALIZADO

            // MODALIDAD_ACTIVACION_FUTURA (column 15) - Handle date format
            Clear(FutureActivationValue);
            FutureActivationValue := GetValueAtCell(RowNo, 15);
            if (FutureActivationValue <> '0000-00-00') and (FutureActivationValue <> '') then
                if Evaluate(SUCControlPricesEnergy."Future Activation Modality", FutureActivationValue) then;

            SUCControlPricesEnergy."Contract Reference Code" := CopyStr(GetValueAtCell(RowNo, 16), 1, 30);            // CODIGO_REFERENCIA_CONTRATO

            ProcessModalityVersions(SUCControlPricesEnergy);
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 17), TempDecimal) then
                SUCControlPricesEnergy."Id Rate WS" := TempDecimal;                                   // ID_TARIFA_WS
            // Column 18: TIPO_CLIENTE_WS (no corresponding field in table)
            SUCControlPricesEnergy."Customer Type" := CopyStr(GetValueAtCell(RowNo, 19), 1, 20);                     // TIPO_CLIENTE
            SUCControlPricesEnergy."Special Price For" := CopyStr(GetValueAtCell(RowNo, 20), 1, 20);                 // PRECIO_ESPECIAL_PARA
            SUCControlPricesEnergy.Province := CopyStr(GetValueAtCell(RowNo, 21), 1, 20);                            // PROVINCIA
            SUCControlPricesEnergy."Visible Operating Costs" := CopyStr(GetValueAtCell(RowNo, 22), 1, 10);           // GASTOS_OPERATIVOS_VISIBLES
            SUCControlPricesEnergy."Management Time Scale" := CopyStr(GetValueAtCell(RowNo, 23), 1, 5);              // ESCALA_TIEMPO_GESTIONES

            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 24), TempDecimal) then
                SUCControlPricesEnergy."Measurement Equip. Mngt. Costs" := TempDecimal;              // COSTES_GESTION_EQUIPOS_MEDIDA
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 25), TempDecimal) then
                SUCControlPricesEnergy."Maintenance Management Costs" := TempDecimal;                // COSTES_GESTION_MANTENIMIENTO
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 26), TempDecimal) then
                SUCControlPricesEnergy."Capacity Costs" := TempDecimal;                              // COSTES_CAPACIDAD
            SUCControlPricesEnergy."Company Remuneration Costs" := CopyStr(GetValueAtCell(RowNo, 27), 1, 250);       // COSTES_REMUNERACION_COMPANIA
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 28), TempDecimal) then
                SUCControlPricesEnergy."Base Company Rem. Costs" := TempDecimal;                     // COSTES_REMUNERACION_COMPANIA_BASE
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 29), TempDecimal) then
                SUCControlPricesEnergy."Financial Costs" := TempDecimal;                             // COSTES_FINANCIEROS
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 30), TempDecimal) then
                SUCControlPricesEnergy."SGE Costs" := TempDecimal;                                   // COSTES_SGE
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 31), TempDecimal) then
                SUCControlPricesEnergy."SGEV Costs" := TempDecimal;                                  // COSTES_SGEV
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 32), TempDecimal) then
                SUCControlPricesEnergy."Contracted KW" := TempDecimal;                               // KW_CONTRATADOS
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 33), TempDecimal) then
                SUCControlPricesEnergy."General Discount" := TempDecimal;                            // DESCUENTO_GENERAL

            // BONIFICACION_POTENCIA (column 34) - Boolean field
            Clear(ContractingValue);
            ContractingValue := GetValueAtCell(RowNo, 34);
            case ContractingValue of
                'SI':
                    SUCControlPricesEnergy."Power Bonus" := true;
                'NO':
                    SUCControlPricesEnergy."Power Bonus" := false;
                else
                    SUCControlPricesEnergy."Power Bonus" := false;
            end;

            // RECARGO_POTENCIA (column 35) - Boolean field
            Clear(ComparisonValue);
            ComparisonValue := GetValueAtCell(RowNo, 35);
            case ComparisonValue of
                'SI':
                    SUCControlPricesEnergy."Power Surcharge" := true;
                'NO':
                    SUCControlPricesEnergy."Power Surcharge" := false;
                else
                    SUCControlPricesEnergy."Power Surcharge" := false;
            end;

            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 36), TempDecimal) then
                SUCControlPricesEnergy."Power From" := TempDecimal;                                  // POTENCIA_DESDE
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 37), TempDecimal) then
                SUCControlPricesEnergy."Power To" := TempDecimal;                                    // POTENCIA_HASTA

            SUCControlPricesEnergy."Power Time Scale" := CopyStr(GetValueAtCell(RowNo, 38), 1, 5);   // ESCALA_TIEMPO_POTENCIA

            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 39), TempDecimal) then
                SUCControlPricesEnergy."First Year Power Discount" := TempDecimal;                   // DESCUENTO_PRIMER_ANIO_POTENCIA
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 40), TempDecimal) then
                SUCControlPricesEnergy.P1 := TempDecimal;                                            // P1
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 41), TempDecimal) then
                SUCControlPricesEnergy.P2 := TempDecimal;                                            // P2
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 42), TempDecimal) then
                SUCControlPricesEnergy.P3 := TempDecimal;                                            // P3
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 43), TempDecimal) then
                SUCControlPricesEnergy.P4 := TempDecimal;                                            // P4
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 44), TempDecimal) then
                SUCControlPricesEnergy.P5 := TempDecimal;                                            // P5
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 45), TempDecimal) then
                SUCControlPricesEnergy.P6 := TempDecimal;                                            // P6
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 46), TempDecimal) then
                SUCControlPricesEnergy."Energy From" := TempDecimal;                                 // ENERGIA_DESDE
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 47), TempDecimal) then
                SUCControlPricesEnergy."Energy To" := TempDecimal;                                   // ENERGIA_HASTA

            SUCControlPricesEnergy."Energy Scale" := CopyStr(GetValueAtCell(RowNo, 48), 1, 5);                      // ESCALA_ENERGIA

            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 49), TempDecimal) then
                SUCControlPricesEnergy."First Year Energy Discount" := TempDecimal;                 // DESCUENTO_PRIMER_ANIO_ENERGIA
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 50), TempDecimal) then
                SUCControlPricesEnergy.E1 := TempDecimal;                                            // E1
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 51), TempDecimal) then
                SUCControlPricesEnergy.E2 := TempDecimal;                                            // E2
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 52), TempDecimal) then
                SUCControlPricesEnergy.E3 := TempDecimal;                                            // E3
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 53), TempDecimal) then
                SUCControlPricesEnergy.E4 := TempDecimal;                                            // E4
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 54), TempDecimal) then
                SUCControlPricesEnergy.E5 := TempDecimal;                                            // E5
            if EvaluateDecimalWithProperFormatting(GetValueAtCell(RowNo, 55), TempDecimal) then
                SUCControlPricesEnergy.E6 := TempDecimal;                                            // E6

            // Set processing date and active status
            SUCControlPricesEnergy."Processing Date" := Today;
            SUCControlPricesEnergy.Active := true;  // New records are active by default

            // Process historical index data for new table structure
            ProcessHistoricalIndexData(SUCControlPricesEnergy, RowNo);

            // Insert or modify record based on whether it exists
            if RecordExists then
                SUCControlPricesEnergy.Modify()
            else
                SUCControlPricesEnergy.Insert();

            LineNo := LineNo + 1;
        end;

        Message(ExcelImportSucessLbl);
    end;

    local procedure GetValueAtCell(_RowNo: Integer; _ColNo: Integer): Text
    begin
        TempExcelBuffer.Reset();
        if TempExcelBuffer.Get(_RowNo, _ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    local procedure ValidateAndNormalizeMarketer(MarketerValue: Text): Code[20]
    var
        MarketerRecord: Record "SUC Omip Marketers";
        NormalizedMarketer: Code[20];
    begin
        // Handle empty values
        if MarketerValue = '' then
            exit('');

        // Normalize known marketer variations
        case MarketerValue of
            'NAB', 'NABALIA':
                NormalizedMarketer := 'NAB';
            'AVANZA', 'AVA':
                NormalizedMarketer := 'AVA';
            else
                NormalizedMarketer := CopyStr(MarketerValue, 1, 20);
        end;

        // Validate if the normalized marketer exists
        MarketerRecord.Reset();
        if MarketerRecord.Get(NormalizedMarketer) then
            exit(NormalizedMarketer)
        else
            exit('');
    end;

    local procedure ProcessHistoricalIndexData(var ControlPricesRecord: Record "SUC Control Prices Energy"; ExcelRowNo: Integer)
    var
        HistoricalPrices: Record "SUC Historical Prices";
        TempDecimal: Decimal;
        ColIndex: Integer;
        MonthsBack: Integer;
        Period: Integer;
        ProcessingDate: Date;
        HistoricalDate: Date;
        HistoricalMonth: Integer;
        HistoricalYear: Integer;
        PeriodCode: Code[2];
        ExcelColumnDescription: Text[50];
        CellValue: Text;
    begin
        // Get processing date (today when file is processed)
        ProcessingDate := Today;

        // Clear existing historical data for this control prices ID
        HistoricalPrices.DeleteHistoricalData(ControlPricesRecord."Id.");

        // Process data from columns 55-126 (P1-P6, Month 12 to Month 1 for each period)
        // P1 = Period 1, P2 = Period 2, etc.
        // Month 12 = 12 months back, Month 11 = 11 months back, etc.
        ColIndex := 55;
        for Period := 1 to 6 do
            for MonthsBack := 12 downto 1 do begin
                CellValue := GetValueAtCell(ExcelRowNo, ColIndex);
                if EvaluateDecimalWithProperFormatting(CellValue, TempDecimal) then
                    if TempDecimal <> 0 then begin // Only insert non-zero values
                        // Calculate the historical date (MonthsBack months before processing date)
                        HistoricalDate := CalcDate('<-' + Format(MonthsBack) + 'M>', ProcessingDate);
                        HistoricalMonth := Date2DMY(HistoricalDate, 2); // Extract month
                        HistoricalYear := Date2DMY(HistoricalDate, 3);  // Extract year

                        PeriodCode := 'P' + Format(Period);
                        ExcelColumnDescription := 'INDEX_P' + Format(Period) + '_MES_' + Format(MonthsBack);

                        HistoricalPrices.InsertHistoricalPrice(
                            ControlPricesRecord."Id.",
                            ControlPricesRecord."Marketer No.",
                            ControlPricesRecord.Modality,
                            HistoricalMonth,
                            PeriodCode,
                            TempDecimal,
                            HistoricalYear,
                            ExcelColumnDescription,
                            ControlPricesRecord.Version,
                            ControlPricesRecord."Rate No."
                        );
                    end;
                ColIndex += 1;
            end;
    end;

    local procedure EvaluateDecimalWithProperFormatting(ValueText: Text; var DecimalValue: Decimal): Boolean
    var
        CleanedValue: Text;
        TempDecimal: Decimal;
        RegionalDecimalSeparator: Text[1];
        HasComma: Boolean;
        HasPeriod: Boolean;
        CommaPos: Integer;
        PeriodPos: Integer;
    begin
        if ValueText = '' then
            exit(false);

        // Get regional decimal separator
        RegionalDecimalSeparator := Format(1.1) [2];

        // Clean the value: remove spaces
        CleanedValue := DelChr(ValueText, '=', ' ');

        // Detect separators
        HasComma := StrPos(CleanedValue, ',') > 0;
        HasPeriod := StrPos(CleanedValue, '.') > 0;

        // Handle Excel format conversion to regional format
        if HasComma and HasPeriod then begin
            // Both present - determine which is decimal
            CommaPos := StrPos(CleanedValue, ',');
            PeriodPos := StrPos(CleanedValue, '.');
            if PeriodPos > CommaPos then begin
                // Period comes after comma - period is decimal (Excel format)
                CleanedValue := DelChr(CleanedValue, '=', ','); // Remove thousand separators
                if RegionalDecimalSeparator = ',' then
                    CleanedValue := ConvertStr(CleanedValue, '.', ',');
            end else begin
                // Comma comes after period - comma is decimal
                CleanedValue := DelChr(CleanedValue, '=', '.'); // Remove thousand separators  
                if RegionalDecimalSeparator = '.' then
                    CleanedValue := ConvertStr(CleanedValue, ',', '.');
            end;
        end;

        if HasPeriod and not HasComma then
            // Only period - convert from Excel format to regional if needed
            if RegionalDecimalSeparator = ',' then
                CleanedValue := ConvertStr(CleanedValue, '.', ',');

        if HasComma and not HasPeriod then
            // Only comma - convert to period for regional if needed
            if RegionalDecimalSeparator = '.' then
                CleanedValue := ConvertStr(CleanedValue, ',', '.');

        // Try to evaluate with the cleaned value
        if Evaluate(TempDecimal, CleanedValue) then begin
            DecimalValue := TempDecimal;
            exit(true);
        end;

        // Fallback: try original value
        exit(Evaluate(DecimalValue, ValueText));
    end;

    local procedure ValidateAndCreateModalityFamily(ModalityFamilyText: Text[30])
    var
        FamContractModalities: Record "SUC Fam. Contract Modalities";
        FamilyCode: Code[20];
    begin
        // Exit if modality family is empty
        if ModalityFamilyText = '' then
            exit;

        // Convert to Code[20] format
        FamilyCode := CopyStr(ModalityFamilyText, 1, 20);

        // Check if family already exists
        FamContractModalities.Reset();
        if not FamContractModalities.Get(FamilyCode) then begin
            // Family doesn't exist, create it
            FamContractModalities.Init();
            FamContractModalities.Code := FamilyCode;
            FamContractModalities.Description := CopyStr(ModalityFamilyText, 1, 100);
            FamContractModalities.Insert(true);
        end;
    end;

    local procedure ProcessModalityVersions(var ControlPricesRecord: Record "SUC Control Prices Energy")
    var
        ModalityVersionControl: Record "SUC Modality Version Control";
        ContractModalities: Record "SUC Contract Modalities";
        VersionControlRecord: Record "SUC Modality Version Control";
        BaseModalityName: Text[100];
        VersionCode: Code[10];
        VersionNumber: Integer;
        QuarterCode: Code[10];
        FullModalityName: Text[100];
    begin
        if ControlPricesRecord."Full Modality Name" = '' then
            exit;

        // Use the Full Modality Name (complete name as imported from Excel)
        FullModalityName := ControlPricesRecord."Full Modality Name";

        // Validate and create family if it doesn't exist
        ValidateAndCreateModalityFamily(ControlPricesRecord."Modality Family");

        // Step 1.1: Extract version from the FULL modality name
        if ModalityVersionControl.ExtractVersionInfo(FullModalityName, BaseModalityName, VersionCode, VersionNumber, QuarterCode) then begin
            // Version found in the modality name

            // Update the Modality field to use the base name (without version)
            ControlPricesRecord.Modality := BaseModalityName;

            // Step 1.2: Check if base modality (without version) exists in contract modalities
            ContractModalities.Reset();
            ContractModalities.SetRange("Marketer No.", ControlPricesRecord."Marketer No.");
            ContractModalities.SetRange("Energy Type", ControlPricesRecord."Energy Type");
            ContractModalities.SetRange(Name, BaseModalityName);

            if ContractModalities.IsEmpty() then begin
                // Step 1.4: Base modality doesn't exist, create it
                ContractModalities.Init();
                ContractModalities."Marketer No." := ControlPricesRecord."Marketer No.";
                ContractModalities."Energy Type" := ControlPricesRecord."Energy Type";
                ContractModalities.Name := BaseModalityName;
                ContractModalities."Custom Name" := BaseModalityName;
                ContractModalities."Family Code" := CopyStr(ControlPricesRecord."Modality Family", 1, 20);
                ContractModalities."Reference Contract Code" := ControlPricesRecord."Contract Reference Code";
                ContractModalities.Insert(true);
            end else
                // Modality exists, check if Family Code or Reference Contract Code need to be updated
                if ContractModalities.FindFirst() then begin
                    // Check if Family Code is empty and new value is not empty
                    if (ContractModalities."Family Code" = '') and (ControlPricesRecord."Modality Family" <> '') then
                        ContractModalities."Family Code" := CopyStr(ControlPricesRecord."Modality Family", 1, 20);

                    // Check if Reference Contract Code is empty and new value is not empty
                    if (ContractModalities."Reference Contract Code" = '') and (ControlPricesRecord."Contract Reference Code" <> '') then
                        ContractModalities."Reference Contract Code" := ControlPricesRecord."Contract Reference Code";

                    ContractModalities.Modify();
                end;

            // Step 1.3 & 1.5: Create version control record using FULL modality name
            VersionControlRecord := ModalityVersionControl.CreateOrUpdateVersion(
                ControlPricesRecord."Marketer No.",
                ControlPricesRecord."Energy Type",
                ControlPricesRecord."Rate No.",
                FullModalityName,
                ControlPricesRecord."Imported File Name");

            // Step 1.5: New version is active, so mark control prices record as active
            ControlPricesRecord.Active := VersionControlRecord."Is Active";

        end else begin
            // No version found, treat as base modality without creating version
            BaseModalityName := FullModalityName;

            // Update the Modality field to use the base name (same as full name in this case)
            ControlPricesRecord.Modality := BaseModalityName;

            // Check if modality exists in contract modalities
            ContractModalities.Reset();
            ContractModalities.SetRange("Marketer No.", ControlPricesRecord."Marketer No.");
            ContractModalities.SetRange("Energy Type", ControlPricesRecord."Energy Type");
            ContractModalities.SetRange(Name, BaseModalityName);

            if ContractModalities.IsEmpty() then begin
                // Create new contract modality
                ContractModalities.Init();
                ContractModalities."Marketer No." := ControlPricesRecord."Marketer No.";
                ContractModalities."Energy Type" := ControlPricesRecord."Energy Type";
                ContractModalities.Name := BaseModalityName;
                ContractModalities."Custom Name" := BaseModalityName;
                ContractModalities."Family Code" := CopyStr(ControlPricesRecord."Modality Family", 1, 20);
                ContractModalities."Reference Contract Code" := ControlPricesRecord."Contract Reference Code";
                ContractModalities.Insert(true);
            end else
                // Modality exists, check if Family Code or Reference Contract Code need to be updated
                if ContractModalities.FindFirst() then begin
                    // Check if Family Code is empty and new value is not empty
                    if (ContractModalities."Family Code" = '') and (ControlPricesRecord."Modality Family" <> '') then
                        ContractModalities."Family Code" := CopyStr(ControlPricesRecord."Modality Family", 1, 20);

                    // Check if Reference Contract Code is empty and new value is not empty
                    if (ContractModalities."Reference Contract Code" = '') and (ControlPricesRecord."Contract Reference Code" <> '') then
                        ContractModalities."Reference Contract Code" := ControlPricesRecord."Contract Reference Code";

                    ContractModalities.Modify();
                end;

            // Create version control record with the full modality name as is (no version found)
            VersionControlRecord := ModalityVersionControl.CreateOrUpdateVersion(
                ControlPricesRecord."Marketer No.",
                ControlPricesRecord."Energy Type",
                ControlPricesRecord."Rate No.",
                FullModalityName,
                ControlPricesRecord."Imported File Name");

            // Mark control prices record as active
            ControlPricesRecord.Active := VersionControlRecord."Is Active";
        end;
    end;

    /// <summary>
    /// Deletes all related records when a control prices record is deleted
    /// </summary>
    local procedure DeleteRelatedRecords()
    begin
        // Delete related historical prices records
        DeleteHistoricalPricesRecords(); //TODO

        // Handle modality version control deletion
        DeleteModalityVersionControl();
    end;

    /// <summary>
    /// Deletes historical prices records related to this control prices record
    /// </summary>
    local procedure DeleteHistoricalPricesRecords()
    var
        HistoricalPrices: Record "SUC Historical Prices";
    begin
        HistoricalPrices.Reset();
        HistoricalPrices.SetRange("Control Prices Id.", "Id.");
        HistoricalPrices.SetRange(Modality, Modality);
        HistoricalPrices.SetRange(Version, Version);
        HistoricalPrices.SetRange("Rate No.", "Rate No.");

        // Delete all matching records
        HistoricalPrices.DeleteAll(true);
    end;

    /// <summary>
    /// Deletes modality version control record if no other control prices records use the same version
    /// </summary>
    local procedure DeleteModalityVersionControl()
    var
        ModalityVersionControl: Record "SUC Modality Version Control";
        RelatedControlPrices: Record "SUC Control Prices Energy";
        HasOtherRecordsWithSameVersion: Boolean;
    begin
        if (Modality = '') or (Version = '') then
            exit;

        // Check if there are other control prices records using the same base modality, version AND rate no.
        RelatedControlPrices.Reset();
        RelatedControlPrices.SetRange("Marketer No.", "Marketer No.");
        RelatedControlPrices.SetRange("Energy Type", "Energy Type");
        RelatedControlPrices.SetRange(Modality, Modality); // This is now base modality name
        RelatedControlPrices.SetRange(Version, Version);
        RelatedControlPrices.SetRange("Rate No.", "Rate No."); // Include Rate No. to check for same rate
        RelatedControlPrices.SetFilter("Id.", '<>%1', "Id."); // Exclude current record being deleted

        HasOtherRecordsWithSameVersion := not RelatedControlPrices.IsEmpty();

        // Only delete version control if no other records use this exact combination
        if not HasOtherRecordsWithSameVersion then begin
            // Find and delete the corresponding version control record
            ModalityVersionControl.Reset();
            ModalityVersionControl.SetRange("Marketer No.", "Marketer No.");
            ModalityVersionControl.SetRange("Energy Type", "Energy Type");
            ModalityVersionControl.SetRange("Rate No.", "Rate No."); // Include Rate No. in the search
            ModalityVersionControl.SetRange("Base Modality Name", Modality); // Use base modality name
            ModalityVersionControl.SetRange("Version Code", Version);

            if ModalityVersionControl.FindFirst() then begin
                ModalityVersionControl.Delete(true);

                // Check if we should also delete the base contract modality
                DeleteContractModalityIfNecessary(ModalityVersionControl);
            end;
        end;
    end;

    /// <summary>
    /// Deletes contract modality if no other versions exist for the same base modality
    /// </summary>
    local procedure DeleteContractModalityIfNecessary(VersionControl: Record "SUC Modality Version Control")
    var
        ContractModalities: Record "SUC Contract Modalities";
        ModalityVersionControl: Record "SUC Modality Version Control";
        HasOtherVersions: Boolean;
    begin
        // Check if there are other versions for the same base modality
        ModalityVersionControl.Reset();
        ModalityVersionControl.SetRange("Marketer No.", VersionControl."Marketer No.");
        ModalityVersionControl.SetRange("Energy Type", VersionControl."Energy Type");
        ModalityVersionControl.SetRange("Base Modality Name", VersionControl."Base Modality Name");

        HasOtherVersions := not ModalityVersionControl.IsEmpty();

        if not HasOtherVersions then begin
            // No other versions exist, safe to delete the contract modality
            ContractModalities.Reset();
            ContractModalities.SetRange("Marketer No.", VersionControl."Marketer No.");
            ContractModalities.SetRange("Energy Type", VersionControl."Energy Type");
            ContractModalities.SetRange(Name, VersionControl."Base Modality Name");

            if ContractModalities.FindFirst() then
                ContractModalities.Delete(true);
        end;
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TempNameValueBufferOut: Record "Name/Value Buffer" temporary;
        SUCControlPricesEnergy: Record "SUC Control Prices Energy";
        ExcelInStream: InStream;
        MaxRowNo: Integer;
        RowNo: Integer;
        ExcelImportSucessLbl: Label 'Excel import sucess';
        ImportLbl: Label 'Import excel';
        HeaderValidationErrorLbl: Label 'Excel header validation failed. Please check the following errors:\';
        FileName: Text;
        SheetName: Text;
}