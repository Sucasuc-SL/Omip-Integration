namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
table 50181 "SUC Omip Rates Times"
{
    Caption = 'Omip Rates Times';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code Rate"; Code[20])
        {
            Caption = 'Code Rate';
        }
        field(2; Time; Enum "SUC Omip Times")
        {
            Caption = 'Time';
        }
    }

    keys
    {
        key(Key1; "Code Rate", Time)
        {
            Clustered = true;
        }
    }
}