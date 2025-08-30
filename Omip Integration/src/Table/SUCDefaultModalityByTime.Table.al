namespace Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Documents;
table 50196 "SUC Default Modality By Time"
{
    DataClassification = CustomerContent;
    Caption = 'Default Modality By Time';

    fields
    {
        field(1; "Time"; Enum "SUC Omip Times")
        {
            Caption = 'Time';
        }
        field(2; "Default Contract Modality"; Text[100])
        {
            Caption = 'Default Contract Modality';
        }
    }

    keys
    {
        key(Key1; Time)
        {
            Clustered = true;
        }
    }
}