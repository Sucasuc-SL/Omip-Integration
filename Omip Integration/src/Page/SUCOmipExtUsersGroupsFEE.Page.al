namespace Sucasuc.Omip.User;
using Sucasuc.Omip.Masters;
page 50253 "SUC Omip Ext. Users Groups FEE"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip Ext. Users Groups FEE";
    Caption = 'External Users Groups FEE';
    InsertAllowed = false;

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
    actions
    {
        area(Processing)
        {
            action("View FEE Potency")
            {
                ApplicationArea = All;
                Caption = 'View FEE Potency';
                Image = View;
                RunObject = page "SUC Omip FEE Power Agent";
                RunPageLink = "Agent No." = field("User Name"), "FEE Group Id." = field("Group Id.");
            }
            action("View FEE Energy")
            {
                ApplicationArea = All;
                Caption = 'View FEE Energy';
                Image = View;
                RunObject = page "SUC Omip FEE Energy Agent";
                RunPageLink = "Agent No." = field("User Name"), "FEE Group Id." = field("Group Id.");
            }
        }
    }
}