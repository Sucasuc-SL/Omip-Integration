namespace Sucasuc.Omip.Masters;
table 50215 "SUC Commercial Figures Type"
{
    DataClassification = CustomerContent;
    Caption = 'Commercial Figures Types';
    LookupPageId = "SUC Commercial Figures Type";
    DrillDownPageId = "SUC Commercial Figures Type";

    fields
    {
        field(1; "Id."; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Id.")
        {
            Clustered = true;
        }
    }
}