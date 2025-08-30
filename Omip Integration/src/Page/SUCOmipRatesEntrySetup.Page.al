namespace Sucasuc.Omip.Masters;
page 50218 "SUC Omip Rates Entry Setup"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip Rates Entry Setup";
    Caption = 'Rates Entry Setup';
    CardPageId = "SUC Omip Rates Entry Setup Crd";


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
                field("Min. FEE Potency"; Rec."Min. FEE Potency")
                {
                    ApplicationArea = All;
                }
                field("Max. FEE Potency"; Rec."Max. FEE Potency")
                {
                    ApplicationArea = All;
                }
                field("Min. FEE Energy"; Rec."Min. FEE Energy")
                {
                    ApplicationArea = All;
                }
                field("Max. FEE Energy"; Rec."Max. FEE Energy")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}