namespace Sucasuc.Omip.Masters;
page 50252 "SUC Omip FEE Groups"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Omip FEE Groups";
    Caption = 'Omip FEE Groups';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Group Id."; Rec."Group Id.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group Id. field.';
                }
                field("Group Name"; Rec."Group Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group Name field.';
                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default field.';
                }
            }
        }
    }
}