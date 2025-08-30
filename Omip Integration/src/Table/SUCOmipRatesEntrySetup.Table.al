namespace Sucasuc.Omip.Masters;
using System.Reflection;

table 50189 "SUC Omip Rates Entry Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Rates Entry Setup';
    DrillDownPageId = "SUC Omip Rates Entry Setup";
    LookupPageId = "SUC Omip Rates Entry Setup";

    fields
    {
        field(1; "Marketer No."; Code[20])
        {
            Caption = 'Marketer';
            TableRelation = "SUC Omip Marketers"."No.";
            trigger OnValidate()
            begin
                CalcFields("Marketer Name");
            end;
        }
        field(2; "Marketer Name"; Text[250])
        {
            Caption = 'Marketer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Marketers".Name where("No." = field("Marketer No.")));
        }
        field(3; "Rates Entry GdOs"; Decimal)
        {
            Caption = 'Rates Entry GdOs';
            DecimalPlaces = 0 : 6;
            ObsoleteState = Pending;
            ObsoleteReason = 'Table change by Omip "SUC Omip Times"';
            ObsoleteTag = '25.02';
        }
        field(4; "Min. FEE Potency"; Decimal)
        {
            Caption = 'Min. FEE Potency';
        }
        field(5; "Max. FEE Potency"; Decimal)
        {
            Caption = 'Max. FEE Potency';
        }
        field(6; "Min. FEE Energy"; Decimal)
        {
            Caption = 'Min. FEE Energy';
        }
        field(7; "Max. FEE Energy"; Decimal)
        {
            Caption = 'Max. FEE Energy';
        }
        field(8; "Tittle Applicable Conditions"; Text[250])
        {
            Caption = 'Tittle Applicable Conditions';
        }
        field(9; "Body App. Conditions 12M"; Blob)
        {
            Caption = 'Body Applicable Conditions 12M';
        }
        field(10; "Body App. Conditions +12M"; Blob)
        {
            Caption = 'Body Applicable Conditions +12M';
        }
        field(11; "Body App. Conditions 12MC"; Blob)
        {
            Caption = 'Body Applicable Conditions 12MC';
        }
        field(12; "Body App. Conditions +12MC"; Blob)
        {
            Caption = 'Body Applicable Conditions +12MC';
        }
    }

    keys
    {
        key(Key1; "Marketer No.")
        {
            Clustered = true;
        }
    }
    procedure SetDataBlob(FieldNo: Integer; NewData: Text)
    var
        OutStream: OutStream;
    begin
        case FieldNo of
            FieldNo("Body App. Conditions 12M"):
                begin
                    Clear("Body App. Conditions 12M");
                    "Body App. Conditions 12M".CreateOutStream(OutStream, TextEncoding::UTF8);
                    OutStream.WriteText(NewData);
                    Modify();
                end;
            FieldNo("Body App. Conditions +12M"):
                begin
                    Clear("Body App. Conditions +12M");
                    "Body App. Conditions +12M".CreateOutStream(OutStream, TextEncoding::UTF8);
                    OutStream.WriteText(NewData);
                    Modify();
                end;
            FieldNo("Body App. Conditions 12MC"):
                begin
                    Clear("Body App. Conditions 12MC");
                    "Body App. Conditions 12MC".CreateOutStream(OutStream, TextEncoding::UTF8);
                    OutStream.WriteText(NewData);
                    Modify();
                end;
            FieldNo("Body App. Conditions +12MC"):
                begin
                    Clear("Body App. Conditions +12MC");
                    "Body App. Conditions +12MC".CreateOutStream(OutStream, TextEncoding::UTF8);
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
            FieldNo("Body App. Conditions 12M"):
                begin
                    CalcFields("Body App. Conditions 12M");
                    "Body App. Conditions 12M".CreateInStream(InStream, TextEncoding::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Body App. Conditions 12M")));
                end;
            FieldNo("Body App. Conditions +12M"):
                begin
                    CalcFields("Body App. Conditions +12M");
                    "Body App. Conditions +12M".CreateInStream(InStream, TextEncoding::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Body App. Conditions +12M")));
                end;
            FieldNo("Body App. Conditions 12MC"):
                begin
                    CalcFields("Body App. Conditions 12MC");
                    "Body App. Conditions 12MC".CreateInStream(InStream, TextEncoding::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Body App. Conditions 12MC")));
                end;
            FieldNo("Body App. Conditions +12MC"):
                begin
                    CalcFields("Body App. Conditions +12MC");
                    "Body App. Conditions +12MC".CreateInStream(InStream, TextEncoding::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Body App. Conditions +12MC")));
                end;
        end;
    end;
}