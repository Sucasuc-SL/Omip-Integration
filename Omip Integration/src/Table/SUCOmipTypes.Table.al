namespace Sucasuc.Omip.Setup;
using Sucasuc.Omip.Documents;
table 50180 "SUC Omip Types"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Types';

    fields
    {
        field(1; Type; Enum "SUC Omip Rate Entry Types")
        {
            Caption = 'Type';
        }
        field(2; "Start Date Contract"; DateFormula)
        {
            Caption = 'Start Date Contract';
        }
    }

    keys
    {
        key(Key1; Type)
        {
            Clustered = true;
        }
    }
}