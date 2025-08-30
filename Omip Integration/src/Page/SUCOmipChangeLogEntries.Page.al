namespace Sucasuc.Omip.Auditing;
/// <summary>
/// Page SUC Omip Change Log Entries (ID 50179).
/// </summary>
page 50179 "SUC Omip Change Log Entries"
{
    Caption = 'Omip Change Log Entries';
    PageType = List;
    SourceTable = "SUC Omip Change Log Entries";
    SourceTableView = sorting("Entry No.") order(descending);
    UsageCategory = None;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Date and Time"; Rec."Date and Time")
                {
                    ToolTip = 'Specifies the value of the Date and Time field.';
                }
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                }
                field("Table Caption"; Rec."Table Caption")
                {
                    ToolTip = 'Specifies the value of the Table Caption field.';
                }
                field("Primary Key field 1 Value"; Rec."Primary Key field 1 Value")
                {
                    ToolTip = 'Specifies the value of the Primary Key field 1 Value field.';
                }
                field("Primary Key field 2 Value"; Rec."Primary Key field 2 Value")
                {
                    ToolTip = 'Specifies the value of the Primary Key field 2 Value field.';
                }
                field("Primary Key field 3 Value"; Rec."Primary Key field 3 Value")
                {
                    ToolTip = 'Specifies the value of the Primary Key field 3 Value field.';
                }
                field("field Caption"; Rec."field Caption")
                {
                    ToolTip = 'Specifies the value of the Table Caption field.';
                }
                field("Type of Change"; Rec."Type of Change")
                {
                    ToolTip = 'Specifies the value of the Type of Change field.';
                }
                field("Old Value"; Rec."Old Value")
                {
                    ToolTip = 'Specifies the value of the Old Value field.';
                }
                field("New Value"; Rec."New Value")
                {
                    ToolTip = 'Specifies the value of the New Value field.';
                }
            }
        }
    }
}
