namespace Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
using Microsoft.Utilities;
using System.IO;
table 50209 "SUC Omip Rates Entry Update"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Rates Entry Update';

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
        field(3; "Omip Times"; Enum "SUC Omip Times")
        {
            Caption = 'Times';
        }
        field(4; SSCC; Decimal)
        {
            Caption = 'SSCC';
            DecimalPlaces = 0 : 6;
        }
        field(5; Detours; Decimal)
        {
            Caption = 'Desvios';
            DecimalPlaces = 0 : 6;
        }
        field(6; AFNEE; Decimal)
        {
            Caption = 'AFNEE';
            DecimalPlaces = 0 : 6;
        }
    }

    keys
    {
        key(Key1; "Marketer No.", "Rate No.", "Omip Times")
        {
            Clustered = true;
        }
    }
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
                SUCOmipRatesEntryUpdate.DeleteAll();
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
        Times: Enum "SUC Omip Times";
        TimesText: Text;
        MarketerNo: Code[20];
        RateNo: Code[20];
    begin
        for RowNo := 2 to MaxRowNo do begin
            MarketerNo := CopyStr(GetValueAtCell(RowNo, 1), 1, MaxStrLen(SUCOmipRatesEntryUpdate."Marketer No."));
            RateNo := CopyStr(GetValueAtCell(RowNo, 2), 1, MaxStrLen(SUCOmipRatesEntryUpdate."Rate No."));
            TimesText := GetValueAtCell(RowNo, 3);

            case TimesText of
                '12M':
                    Times := Times::"12M";
                '24M':
                    Times := Times::"24M";
                '36M':
                    Times := Times::"36M";
                '48M':
                    Times := Times::"48M";
                '60M':
                    Times := Times::"60M";
                else
                    Times := Times::" ";
            end;

            if not SUCOmipRatesEntryUpdate.Get(MarketerNo, RateNo, Times) then begin
                SUCOmipRatesEntryUpdate.Init();
                SUCOmipRatesEntryUpdate.Validate("Marketer No.", MarketerNo);
                SUCOmipRatesEntryUpdate.Validate("Rate No.", RateNo);
                SUCOmipRatesEntryUpdate.Validate("Omip Times", Times);
                SUCOmipRatesEntryUpdate.Insert()
            end;
            Evaluate(SUCOmipRatesEntryUpdate.SSCC, GetValueAtCell(RowNo, 4));
            Evaluate(SUCOmipRatesEntryUpdate.Detours, GetValueAtCell(RowNo, 5));
            Evaluate(SUCOmipRatesEntryUpdate.AFNEE, GetValueAtCell(RowNo, 6));
            SUCOmipRatesEntryUpdate.Modify();
        end;
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
        SUCOmipRatesEntryUpdate: Record "SUC Omip Rates Entry Update";
        ExcelInStream: InStream;
        MaxRowNo: Integer;
        RowNo: Integer;
        ImportLbl: Label 'Import Excel';
        FileName: Text;
        SheetName: Text;
}