namespace Sucasuc.Omip.Masters;
page 50267 "SUC Omip Customer CUPS List"
{
    ApplicationArea = All;
    Caption = 'Omip Customer CUPS';
    PageType = List;
    SourceTable = "SUC Omip Customer CUPS";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Customer Number associated with the CUPS.';
                }
                field(CUPS; Rec.CUPS)
                {
                    ToolTip = 'Specifies the value of the CUPS field.';
                }
                field("SUC Supply Point Address"; Rec."SUC Supply Point Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Address of the Supply Point';
                }
                field("SUC Supply Point Country"; Rec."SUC Supply Point Country")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country of the Supply Point';
                }
                field("SUC Supply Point Postal Code"; Rec."SUC Supply Point Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Postal Code of the Supply Point';
                }
                field("SUC Supply Point City"; Rec."SUC Supply Point City")
                {
                    ApplicationArea = All;
                    ToolTip = 'City of the Supply Point';
                }
                field("SUC Supply Point County"; Rec."SUC Supply Point County")
                {
                    ApplicationArea = All;
                    ToolTip = 'County of the Supply Point';
                }
            }
        }
    }
}
