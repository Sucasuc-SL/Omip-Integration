namespace Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC Omip Regulated Price Power (ID 50170).
/// </summary>
page 50170 "SUC Omip Regulated Price Power"
{
    ApplicationArea = All;
    Caption = 'Omip Regulated Price Power';
    PageType = List;
    // SourceTable = "SUC Omip Regulated Price Power";
    UsageCategory = None;
    ObsoleteState = Pending;
    ObsoleteReason = 'Page change by Omip "SUC Omip Regulated Price Power 2"';
    ObsoleteTag = '24.36';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Rate No."; '')
                {
                    ApplicationArea = All;
                    Caption = 'Rate No.';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
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
            }
        }
    }
}