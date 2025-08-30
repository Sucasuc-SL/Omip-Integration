namespace Sucasuc.Omip.Contracts;
table 50206 "SUC Commercials Plenitude"
{
    DataClassification = CustomerContent;
    Caption = 'Commercials Plenitude';
    LookupPageId = "SUC Commercials Plenitude";
    DrillDownPageId = "SUC Commercials Plenitude";

    fields
    {
        field(1; "Id."; Code[10])
        {
            Caption = 'Id.';
        }
        field(2; User; Text[50])
        {
            Caption = 'User';
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