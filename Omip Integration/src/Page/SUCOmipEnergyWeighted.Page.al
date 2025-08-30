namespace Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC Omip Energy Weighted (ID 50165).
/// </summary>
page 50165 "SUC Omip Energy Weighted"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    // SourceTable = "SUC Omip Energy Weighted";
    Caption = 'Omip Energy Weighted';
    ObsoleteState = Pending;
    ObsoleteReason = 'Page change by Omip "SUC Omip Energy Weighted 2"';
    ObsoleteTag = '24.36';
    layout
    {
        area(Content)
        {
            group(Lists)
            {
                field("Rate Code"; '')
                {
                    ApplicationArea = All;
                    Caption = 'Rate Code';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field(Times; '')
                {
                    ApplicationArea = All;
                    Caption = 'Times';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.', Comment = 'ESP="Tiempo"';
                }
                field(P1; '')
                {
                    ApplicationArea = All;
                    Caption = 'P1';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field(P2; '')
                {
                    ApplicationArea = All;
                    Caption = 'P2';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field(P3; '')
                {
                    ApplicationArea = All;
                    Caption = 'P3';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field(P4; '')
                {
                    ApplicationArea = All;
                    Caption = 'P4';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field(P5; '')
                {
                    ApplicationArea = All;
                    Caption = 'P5';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field(P6; '')
                {
                    ApplicationArea = All;
                    Caption = 'P6';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field(FEE; '')
                {
                    ApplicationArea = All;
                    Caption = 'FEE';
                    Editable = false;
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field("FEE P1"; '')
                {
                    ApplicationArea = All;
                    Caption = 'FEE P1';
                    Editable = false;
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field("FEE P2"; '')
                {
                    ApplicationArea = All;
                    Caption = 'FEE P2';
                    Editable = false;
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field("FEE P3"; '')
                {
                    ApplicationArea = All;
                    Caption = 'FEE P3';
                    Editable = false;
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field("FEE P4"; '')
                {
                    ApplicationArea = All;
                    Caption = 'FEE P4';
                    Editable = false;
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field("FEE P5"; '')
                {
                    ApplicationArea = All;
                    Caption = 'FEE P5';
                    Editable = false;
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
                field("FEE P6"; '')
                {
                    ApplicationArea = All;
                    Caption = 'FEE P6';
                    Editable = false;
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                }
            }
        }
    }
}