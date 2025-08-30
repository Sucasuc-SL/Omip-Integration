namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Setup;
/// <summary>
/// Table SUC Omip Rate Category (ID 50113).
/// </summary>
table 50163 "SUC Omip Rate Category"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Rate Category';
    DrillDownPageId = "SUC Omip Rate Category";
    LookupPageId = "SUC Omip Rate Category";

    fields
    {
        field(1; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
        }
        field(2; "FEE Potency"; Decimal)
        {
            Caption = 'FEE Potency';
        }
        field(3; "FEE Energy"; Decimal)
        {
            Caption = 'FEE Energy';
        }
    }

    keys
    {
        key(Key1; "Category Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Category Code", "FEE Potency", "FEE Energy")
        {
        }
    }
}