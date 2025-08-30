namespace Sucasuc.Omip.Masters;
table 50190 "SUC Omip E-Send Doc. Setup"
{
    DataClassification = CustomerContent;
    Caption = 'E-Send Doc. Setup';

    fields
    {
        field(1; "Marketer No."; Code[20])
        {
            Caption = 'Marketer';
            TableRelation = "SUC Omip Marketers"."No.";
            trigger OnValidate()
            begin
                CalcFields("Marketer Name");
            end;
        }
        field(2; "Marketer Name"; Text[250])
        {
            Caption = 'Marketer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Marketers".Name where("No." = field("Marketer No.")));
        }
        field(3; "URL E-Send"; Text[250])
        {
            Caption = 'URL E-Send';
        }
        field(4; "Channel Code"; Code[5])
        {
            Caption = 'Channel Code';
        }
        field(5; "Operator Code"; Text[20])
        {
            Caption = 'Operator Code';
        }
    }

    keys
    {
        key(Key1; "Marketer No.")
        {
            Clustered = true;
        }
    }
}