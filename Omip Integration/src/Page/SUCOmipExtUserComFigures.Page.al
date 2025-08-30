namespace Sucasuc.Omip.User;

/// <summary>
/// Page SUC Omip User Supervision Types
/// </summary>
page 50283 "SUC Omip Ext User Com. Figures"
{
    ApplicationArea = All;
    Caption = 'User Commercial Figures';
    PageType = ListPart;
    SourceTable = "SUC Omip Ext User Com. Figures";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Commercial Figures Type"; Rec."Commercial Figures Type")
                {
                    ToolTip = 'Specifies the commercial figures type.';
                    ApplicationArea = All;
                }
                field("Commercial Figure"; Rec."Commercial Figure")
                {
                    ToolTip = 'Specifies the commercial figure.';
                    ApplicationArea = All;
                }
                field("Superior Officer"; Rec."Superior Officer")
                {
                    ToolTip = 'Specifies the superior officer for this commercial figure type.';
                    ApplicationArea = All;
                }
                field("Hierarchical Level"; Rec."Hierarchical Level")
                {
                    ToolTip = 'Specifies the hierarchical level.';
                    ApplicationArea = All;
                }
                field("Percent Commission"; Rec."Percent Commission")
                {
                    ToolTip = 'Specifies the commission percentage.';
                    ApplicationArea = All;
                }
                field("Percent. Commission Drag"; Rec."Percent. Commission Drag")
                {
                    ToolTip = 'Specifies the commission drag percentage.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
