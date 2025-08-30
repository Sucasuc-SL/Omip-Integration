namespace Sucasuc.Omip.Masters;
/// <summary>
/// Table SUC Omip Regulated Price Power (ID 50118).
/// </summary>
table 50168 "SUC Omip Regulated Price Power"
{
    Caption = 'Omip Regulated Price Power';
    DataClassification = CustomerContent;
    ObsoleteState = Removed;
    ObsoleteReason = 'Table change by Omip "SUC Omip Reg. Price Power 2"';
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
            DecimalPlaces = 0 : 6;
        }
        field(3; P2; Decimal)
        {
            Caption = 'P2';
            DecimalPlaces = 0 : 6;
        }
        field(4; P3; Decimal)
        {
            Caption = 'P3';
            DecimalPlaces = 0 : 6;
        }
        field(5; P4; Decimal)
        {
            Caption = 'P4';
            DecimalPlaces = 0 : 6;
        }
        field(6; P5; Decimal)
        {
            Caption = 'P5';
            DecimalPlaces = 0 : 6;
        }
        field(7; P6; Decimal)
        {
            Caption = 'P6';
            DecimalPlaces = 0 : 6;
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