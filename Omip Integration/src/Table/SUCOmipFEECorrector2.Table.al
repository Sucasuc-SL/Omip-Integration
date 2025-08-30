namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
/// <summary>
/// Table SUC Omip FEE Corrector (ID 50184).
/// </summary>
table 50184 "SUC Omip FEE Corrector 2"
{
    DataClassification = CustomerContent;
    Caption = 'Omip FEE Corrector', Comment = 'ESP="Omip FEE Corrector"';
    DrillDownPageId = "SUC Omip FEE Corrector 2";
    LookupPageId = "SUC Omip FEE Corrector 2";

    fields
    {
        field(1; "Marketer No."; Code[20])
        {
            Caption = 'Marketer No.';
            TableRelation = "SUC Omip Marketers"."No.";
        }
        field(2; Type; Enum "SUC Omip Rate Entry Types")
        {
            Caption = 'Type';
        }
        field(3; "12M"; Decimal)
        {
            Caption = '12M';
        }
        field(4; "24M"; Decimal)
        {
            Caption = '24M';
        }
        field(5; "36M"; Decimal)
        {
            Caption = '36M';
        }
        field(6; "48M"; Decimal)
        {
            Caption = '48M';
        }
        field(7; "60M"; Decimal)
        {
            Caption = '60M';
        }
    }

    keys
    {
        key(Key1; "Marketer No.", Type)
        {
            Clustered = true;
        }
    }
}