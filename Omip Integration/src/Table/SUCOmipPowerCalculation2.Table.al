namespace Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Masters;
/// <summary>
/// Table SUC Omip Power Calculation (ID 50185).
/// </summary>
table 50185 "SUC Omip Power Calculation 2"
{
    Caption = 'Omip Power Calculation';
    DataClassification = CustomerContent;
    LookupPageId = "SUC Omip Power Calculation 2";
    DrillDownPageId = "SUC Omip Power Calculation 2";

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
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:4><Standard Format,0>%';
        }
        field(4; P2; Decimal)
        {
            Caption = 'P2';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:4><Standard Format,0>%';
        }
        field(5; P3; Decimal)
        {
            Caption = 'P3';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:4><Standard Format,0>%';
        }
        field(6; P4; Decimal)
        {
            Caption = 'P4';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:4><Standard Format,0>%';
        }
        field(7; P5; Decimal)
        {
            Caption = 'P5';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:4><Standard Format,0>%';
        }
        field(8; P6; Decimal)
        {
            Caption = 'P6';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:4><standard format,0>%';
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