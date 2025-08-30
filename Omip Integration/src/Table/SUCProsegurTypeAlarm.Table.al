namespace Sucasuc.Omip.Prosegur;
table 50217 "SUC Prosegur Type Alarm"
{
    DataClassification = CustomerContent;
    Caption = 'Prosegur Type Alarm';
    LookupPageId = "SUC Prosegur Type Alarm";
    DrillDownPageId = "SUC Prosegur Type Alarm";

    fields
    {
        field(1; "No. Type Use"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            TableRelation = "SUC Prosegur Type Uses"."No.";
        }
        field(2; "No. Type Alarm"; Code[20])
        {
            Caption = 'Type Alarm';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No. Type Use", "No. Type Alarm")
        {
            Clustered = true;
        }
    }
}