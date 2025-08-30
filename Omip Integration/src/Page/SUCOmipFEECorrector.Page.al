namespace Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC Omip Volatility Premium (ID 50157).
/// </summary>
page 50157 "SUC Omip FEE Corrector"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    // SourceTable = "SUC Omip FEE Corrector";
    Caption = 'Omip FEE Corrector', Comment = 'ESP="Omip FEE Corrector"';
    ObsoleteState = Pending;
    ObsoleteReason = 'Page change by Omip "SUC Omip FEE Corrector 2"';
    ObsoleteTag = '24.36';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Times; '')
                {
                    ApplicationArea = All;
                    Caption = 'Times';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field("12M"; '')
                {
                    ApplicationArea = All;
                    Caption = '12M';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field("24M"; '')
                {
                    ApplicationArea = All;
                    Caption = '24M';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field("36M"; '')
                {
                    ApplicationArea = All;
                    Caption = '36M';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field("48M"; '')
                {
                    ApplicationArea = All;
                    Caption = '48M';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field("60M"; '')
                {
                    ApplicationArea = All;
                    Caption = '60M';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
            }
        }
    }
}