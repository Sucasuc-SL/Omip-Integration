namespace Sucasuc.Omip.Prosegur;
table 50218 "SUC Prosegur Type Uses"
{
    DataClassification = CustomerContent;
    Caption = 'Prosegur Type Of Uses';
    LookupPageId = "SUC Prosegur Type Uses";
    DrillDownPageId = "SUC Prosegur Type Uses";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description) { }
    }
}