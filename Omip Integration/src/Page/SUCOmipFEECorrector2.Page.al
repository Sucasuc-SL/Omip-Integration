namespace Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC Omip Volatility Premium (ID 50212).
/// </summary>
page 50212 "SUC Omip FEE Corrector 2"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Omip FEE Corrector 2";
    Caption = 'Omip FEE Corrector', Comment = 'ESP="Omip FEE Corrector"';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Marketer No."; Rec."Marketer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketer No. field.';
                }
                field(Times; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("12M"; Rec."12M")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 12M field.';
                }
                field("24M"; Rec."24M")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 24M field.';
                }
                field("36M"; Rec."36M")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 36M field.';
                }
                field("48M"; Rec."48M")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 48M field.';
                }
                field("60M"; Rec."60M")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the 60M field.';
                }
            }
        }
    }
}