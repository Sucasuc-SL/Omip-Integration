namespace Sucasuc.Omip.Contracts;
table 50194 "SUC Fam. Contract Modalities"
{
    DataClassification = CustomerContent;
    Caption = 'Families Contract Modalities';
    DrillDownPageId = "SUC Fam. Contract Modalities";
    LookupPageId = "SUC Fam. Contract Modalities";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
}