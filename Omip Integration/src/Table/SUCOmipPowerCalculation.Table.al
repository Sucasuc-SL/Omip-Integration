namespace Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Masters;
/// <summary>
/// Table SUC Omip Power Calculation (ID 50117).
/// </summary>
table 50167 "SUC Omip Power Calculation"
{
    Caption = 'Omip Power Calculation';
    DataClassification = CustomerContent;
    ObsoleteState = Removed;
    ObsoleteReason = 'Table change by Omip "SUC Omip Power Calculation 2"';
    ObsoleteTag = '24.36';

    fields
    {
        field(1; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
        }
        field(2; P1; Decimal)
        {
            Caption = 'P1';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:4><Standard Format,0>%';
        }
        field(3; P2; Decimal)
        {
            Caption = 'P2';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:4><Standard Format,0>%';
        }
        field(4; P3; Decimal)
        {
            Caption = 'P3';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:4><Standard Format,0>%';
        }
        field(5; P4; Decimal)
        {
            Caption = 'P4';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:4><Standard Format,0>%';
        }
        field(6; P5; Decimal)
        {
            Caption = 'P5';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:4><Standard Format,0>%';
        }
        field(7; P6; Decimal)
        {
            Caption = 'P6';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:4><standard format,0>%';
        }
    }

    keys
    {
        key(PK; "Rate No.")
        {
            Clustered = true;
        }
    }
}