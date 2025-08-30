namespace Sucasuc.Omip.Masters;
page 50219 "SUC Omip E-Send Doc. Setup"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip E-Send Doc. Setup";
    Caption = 'E-Send Doc. Setup';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Marketer No."; Rec."Marketer No.")
                {
                    ApplicationArea = All;
                }
                field("Marketer Name"; Rec."Marketer Name")
                {
                    ApplicationArea = All;
                }
                field("URL E-Send"; Rec."URL E-Send")
                {
                    ApplicationArea = All;
                }
                field("Channel Code"; Rec."Channel Code")
                {
                    ApplicationArea = All;
                }
                field("Operator Code"; Rec."Operator Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}