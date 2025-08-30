namespace Sucasuc.Omip.Ledger;
/// <summary>
/// Table SUC Omip Entry (ID 50101).
/// </summary>
table 50151 "SUC Omip Entry"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Entries';
    DrillDownPageId = "SUC Omip Entries";
    LookupPageId = "SUC Omip Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(3; Instrument; Text[50])
        {
            Caption = 'Instrument';
        }
        field(4; Price; Decimal)
        {
            Caption = 'Price';
        }
        field(5; "File Name"; Text[250])
        {
            Caption = 'File Name';
        }
        field(6; "Date Type"; Enum "SUC Omip Entry Date Type")
        {
            Caption = 'Date Type';
            Editable = false;
        }
        field(7; Value; Text[50])
        {
            Caption = 'Value';
            Editable = false;
        }
        field(8; Year; Integer)
        {
            Caption = 'Year';
            Editable = false;
        }
        field(9; "Date NoFormat"; Text[10])
        {
            Caption = 'Date No Format';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}