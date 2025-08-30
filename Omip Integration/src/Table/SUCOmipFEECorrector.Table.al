namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
/// <summary>
/// Table SUC Omip FEE Corrector (ID 50107).
/// </summary>
table 50157 "SUC Omip FEE Corrector"
{
    DataClassification = CustomerContent;
    Caption = 'Omip FEE Corrector', Comment = 'ESP="Omip FEE Corrector"';
    DrillDownPageId = "SUC Omip FEE Corrector";
    LookupPageId = "SUC Omip FEE Corrector";
    ObsoleteState = Removed;
    ObsoleteReason = 'Table change by Omip "SUC Omip FEE Corrector 2"';
    ObsoleteTag = '24.36';

    fields
    {
        field(1; Type; Enum "SUC Omip Rate Entry Types")
        {
            Caption = 'Type';
        }
        field(2; "12M"; Decimal)
        {
            Caption = '12M';
        }
        field(3; "24M"; Decimal)
        {
            Caption = '24M';
        }
        field(4; "36M"; Decimal)
        {
            Caption = '36M';
        }
        field(5; "48M"; Decimal)
        {
            Caption = '48M';
        }
        field(6; "60M"; Decimal)
        {
            Caption = '60M';
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