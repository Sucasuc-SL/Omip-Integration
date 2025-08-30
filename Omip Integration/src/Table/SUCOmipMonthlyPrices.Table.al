namespace Sucasuc.Omip.Masters;
/// <summary>
/// Table SUC Omip Price (ID 50114).
/// </summary>
table 50164 "SUC Omip Monthly Prices"
{
    Caption = 'Omip Monthly Prices';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Start Date Month"; Date)
        {
            Caption = 'Start Date Month';
        }
        field(3; Year; Integer)
        {
            Caption = 'Year';
        }
        field(4; Month; Integer)
        {
            Caption = 'Month';
        }
        field(5; "Ref. Trim"; Code[2])
        {
            Caption = 'Ref. Trim';
        }
        field(6; "Ref. Month"; Text[15])
        {
            Caption = 'Ref. Month';
        }
        field(7; "Type Month"; Text[10])
        {
            Caption = 'Type Month';
        }
        field(8; "Range Prices"; Decimal)
        {
            Caption = 'Range Prices';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}