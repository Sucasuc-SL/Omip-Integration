namespace Sucasuc.Omip.Ledger;
using System.IO;
using Sucasuc.Omip.Masters;
using Microsoft.Utilities;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Utilities;
/// <summary>
/// Table SUC Omip Rates Entry (ID 50182).
/// </summary>
table 50182 "SUC Omip Rates Entry 2"
{
    Caption = 'Omip Rates Entry';
    DataClassification = CustomerContent;
    DrillDownPageId = "SUC Omip Rates Entry 2";
    LookupPageId = "SUC Omip Rates Entry 2";

    fields
    {
        field(1; "Marketer No."; Code[20])
        {
            Caption = 'Marketer No.';
            TableRelation = "SUC Omip Marketers"."No.";
        }
        field(2; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
        }
        field(3; "Hired Potency"; Enum "SUC Omip Hired Potency")
        {
            Caption = 'Hired Potency';
        }
        field(4; "Omip Times"; Enum "SUC Omip Times")
        {
            Caption = 'Times';
        }
        field(5; Omip; Decimal)
        {
            Caption = 'Omip';
            DecimalPlaces = 0 : 6;
        }
        field(6; Apuntament; Decimal)
        {
            Caption = 'Apunt.';
            DecimalPlaces = 0 : 6;
        }
        field(7; SSCC; Decimal)
        {
            Caption = 'SSCC';
            DecimalPlaces = 0 : 6;
        }
        field(8; "OS/OM"; Decimal)
        {
            Caption = 'OS/OM';
            DecimalPlaces = 0 : 6;
        }
        field(9; "Price Capacity"; Decimal)
        {
            Caption = 'P. Capac.';
            DecimalPlaces = 0 : 6;
        }
        field(10; "Social Bonus"; Decimal)
        {
            Caption = 'Bono Social';
            DecimalPlaces = 0 : 6;
        }
        field(11; Losses; Decimal)
        {
            Caption = 'Perdidas';
            DecimalPlaces = 0 : 6;
        }
        field(12; Detours; Decimal)
        {
            Caption = 'Desvios';
            DecimalPlaces = 0 : 6;
        }
        field(13; AFNEE; Decimal)
        {
            Caption = 'AFNEE';
            DecimalPlaces = 0 : 6;
        }
        field(14; EGREEN; Decimal)
        {
            Caption = 'EGREEN';
            DecimalPlaces = 0 : 6;
        }
        field(15; "Operating Expenses"; Decimal)
        {
            Caption = 'G. Oper.';
            DecimalPlaces = 0 : 6;
        }
        field(16; IM; Decimal)
        {
            Caption = 'IM';
            DecimalPlaces = 0 : 6;
        }
        field(17; ATR; Decimal)
        {
            Caption = 'ATR';
            DecimalPlaces = 0 : 6;
        }
        field(18; Final; Decimal)
        {
            Caption = 'Final';
            DecimalPlaces = 0 : 6;
        }
        field(19; "Final + ATR"; Decimal)
        {
            Caption = 'Final + ATR';
            DecimalPlaces = 0 : 6;
        }
        field(20; "Total Final"; Decimal)
        {
            Caption = 'Total Final';
            DecimalPlaces = 0 : 6;
        }
        field(21; "Rates Entry Premium Open Pos."; Decimal)
        {
            Caption = 'Rates Entry Premium Open Position';
            DecimalPlaces = 0 : 6;
        }
    }

    keys
    {
        key(Key1; "Marketer No.", "Rate No.", "Hired Potency", "Omip Times")
        {
            Clustered = true;
        }
    }

    /// <summary>
    /// ProcessExcel.
    /// </summary>
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
                SUCOmipRatesEntry.DeleteAll();
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
    end;

    local procedure InsertData()
    var
        SUCOmipManagement: Codeunit "SUC Omip Management";
        SUCOmipRateEntryTypes: Enum "SUC Omip Rate Entry Types";
        EnergyOrigen: Enum "SUC Omip Energy Origen";
        MarketerNo: Code[20];
        RateNo: Code[20];
        i: Integer;
        PriceBase: Decimal;
    begin
        Clear(RateNo);

        SUCOmipRatesEntry.Init();
        for i := 1 to 5 do
            for RowNo := 3 to MaxRowNo do begin
                MarketerNo := CopyStr(GetValueAtCell(RowNo, 1), 1, 20);
                SUCOmipRatesEntry."Marketer No." := MarketerNo;
                RateNo := CopyStr(GetValueAtCell(RowNo, 2), 1, MaxStrLen(SUCOmipRatesEntry."Rate No."));
                SUCOmipRatesEntry."Rate No." := RateNo;
                Evaluate(SUCOmipRatesEntry."Hired Potency", GetValueAtCell(RowNo, 3));
                Evaluate(SUCOmipRatesEntry."Omip Times", Format(Enum::"SUC Omip Times".FromInteger(i)));
                Evaluate(SUCOmipRatesEntry."Rates Entry Premium Open Pos.", GetValueAtCell(RowNo, 4));

                PriceBase := SUCOmipManagement.SUCGetPriceBase(SUCOmipRateEntryTypes::"Type 1", i);
                SUCOmipRatesEntry.Validate(Omip, PriceBase);

                Evaluate(SUCOmipRatesEntry.Apuntament, GetValueAtCell(RowNo, 6));
                Evaluate(SUCOmipRatesEntry.SSCC, GetValueAtCell(RowNo, 7));
                Evaluate(SUCOmipRatesEntry."OS/OM", GetValueAtCell(RowNo, 8));
                Evaluate(SUCOmipRatesEntry."Price Capacity", GetValueAtCell(RowNo, 9));
                Evaluate(SUCOmipRatesEntry."Social Bonus", GetValueAtCell(RowNo, 10));
                Evaluate(SUCOmipRatesEntry.Losses, GetValueAtCell(RowNo, 11));
                Evaluate(SUCOmipRatesEntry.Detours, GetValueAtCell(RowNo, 12));
                Evaluate(SUCOmipRatesEntry.AFNEE, GetValueAtCell(RowNo, 13));
                Evaluate(SUCOmipRatesEntry.EGREEN, GetValueAtCell(RowNo, 14));
                Evaluate(SUCOmipRatesEntry."Operating Expenses", GetValueAtCell(RowNo, 15));
                Evaluate(SUCOmipRatesEntry.IM, GetValueAtCell(RowNo, 16));
                Evaluate(SUCOmipRatesEntry.ATR, GetValueAtCell(RowNo, 17));
                SUCOmipRatesEntry.Insert();

                SUCOmipManagement.CalculateRatesEntry2(MarketerNo, i, PriceBase, EnergyOrigen::" ");
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

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        TempNameValueBufferOut: Record "Name/Value Buffer" temporary;
        SUCOmipRatesEntry: Record "SUC Omip Rates Entry 2";
        ExcelInStream: InStream;
        MaxRowNo: Integer;
        RowNo: Integer;
        ExcelImportSucessLbl: Label 'Excel import sucess', Comment = 'ESP="Importación excel completado"';
        ImportLbl: Label 'Import Excel';
        FileName: Text;
        SheetName: Text;
}