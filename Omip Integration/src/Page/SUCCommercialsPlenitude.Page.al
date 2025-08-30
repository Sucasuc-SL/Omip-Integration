namespace Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Utilities;
page 50247 "SUC Commercials Plenitude"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Commercials Plenitude";
    Caption = 'Commercials Plenitude';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Id."; Rec."Id.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Id. field.';
                }
                field(User; Rec.User)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Get Commercials")
            {
                Caption = 'Get Commercials';
                ApplicationArea = All;
                ToolTip = 'Get Commercials';
                Image = GetEntries;
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.GetCommercialsPlenitude();
                end;
            }
        }
    }
}