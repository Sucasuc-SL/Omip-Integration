namespace Sucasuc.Omip.Setup;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Masters;
table 50201 "SUC Omip Times"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Times';

    fields
    {
        field(1; "Marketer No."; Code[20])
        {
            Caption = 'Marketer No.';
            TableRelation = "SUC Omip Marketers"."No.";
        }
        field(2; "SUC Time"; Enum "SUC Omip Times")
        {
            Caption = 'Time';
        }
        field(3; "Rates Entry GdOs"; Decimal)
        {
            Caption = 'Rates Entry GdOs';
            DecimalPlaces = 0 : 6;
        }
    }

    keys
    {
        key(Key1; "Marketer No.", "SUC Time")
        {
            Clustered = true;
        }
    }
}