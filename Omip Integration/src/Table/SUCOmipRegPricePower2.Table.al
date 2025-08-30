namespace Sucasuc.Omip.Masters;
/// <summary>
/// Table SUC Omip Regulated Price Power (ID 50186).
/// </summary>
table 50186 "SUC Omip Reg. Price Power 2"
{
    Caption = 'Omip Regulated Price Power';
    DataClassification = CustomerContent;
    LookupPageId = "SUC Omip Reg. Price Power 2";
    DrillDownPageId = "SUC Omip Reg. Price Power 2";

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
        field(3; P1; Decimal)
        {
            Caption = 'P1';
            DecimalPlaces = 0 : 6;
        }
        field(4; P2; Decimal)
        {
            Caption = 'P2';
            DecimalPlaces = 0 : 6;
        }
        field(5; P3; Decimal)
        {
            Caption = 'P3';
            DecimalPlaces = 0 : 6;
        }
        field(6; P4; Decimal)
        {
            Caption = 'P4';
            DecimalPlaces = 0 : 6;
        }
        field(7; P5; Decimal)
        {
            Caption = 'P5';
            DecimalPlaces = 0 : 6;
        }
        field(8; P6; Decimal)
        {
            Caption = 'P6';
            DecimalPlaces = 0 : 6;
        }
    }

    keys
    {
        key(PK; "Marketer No.", "Rate No.")
        {
            Clustered = true;
        }
    }
}