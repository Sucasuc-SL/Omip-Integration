namespace Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC Omip Rate Category (ID 50166).
/// </summary>
page 50166 "SUC Omip Rate Category"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Omip Rate Category";
    Caption = 'Omip Rate Category';

    layout
    {
        area(Content)
        {
            repeater(Categories)
            {
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Code field.';
                }
                field("FEE Potency"; Rec."FEE Potency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FEE Potency field.';
                    Visible = false;
                }
                field("FEE Energy"; Rec."FEE Energy")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FEE Energy field.';
                    Visible = false;
                }
            }
        }
    }
}