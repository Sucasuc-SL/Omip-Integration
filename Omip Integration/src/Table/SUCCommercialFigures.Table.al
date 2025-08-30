namespace Sucasuc.Omip.Masters;
table 50214 "SUC Commercial Figures"
{
    DataClassification = CustomerContent;
    Caption = 'Commercial Figures';
    LookupPageId = "SUC Commercial Figures";
    DrillDownPageId = "SUC Commercial Figures";

    fields
    {
        field(1; Type; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Type';
            TableRelation = "SUC Commercial Figures Type"."Id.";
        }
        field(2; "Id."; Code[20])
        {
            Caption = 'Code';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; Distribution; Decimal)
        {
            Caption = 'Distribution';
        }
        field(5; "Hierarchical Level"; Integer)
        {
            Caption = 'Hierarchical Level';
        }
        field(6; "Distribution by Figure"; Boolean)
        {
            Caption = 'Distribution by Figure';
        }
    }

    keys
    {
        key(Key1; Type, "Id.")
        {
            Clustered = true;
        }
    }
}