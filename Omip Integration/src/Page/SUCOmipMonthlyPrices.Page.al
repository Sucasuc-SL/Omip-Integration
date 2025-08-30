namespace Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC Omip Price (ID 50167).
/// </summary>
page 50167 "SUC Omip Monthly Prices"
{
    ApplicationArea = All;
    Caption = 'Omip Monthly Prices';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "SUC Omip Monthly Prices";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Start Date Month"; Rec."Start Date Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date Month field.';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year field.';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Month field.';
                }
                field("Ref. Trim"; Rec."Ref. Trim")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ref. Trim field.';
                }
                field("Ref. Month"; Rec."Ref. Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ref. Month field.';
                }
                field("Type Month"; Rec."Type Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type Month field.';
                }
                field("Range Prices"; Rec."Range Prices")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Range Prices field.';
                }
            }
        }
    }
}