namespace Sucasuc.Omip.Proposals;
page 50215 "SUC Omip Proposal Multicups"
{
    UsageCategory = None;
    Caption = 'Multicups';
    PageType = ListPart;
    SourceTable = "SUC Omip Proposal Multicups";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Customer CUPS"; Rec."Customer CUPS")
                {
                    ApplicationArea = All;
                    ToolTip = 'CUPS of the Customer';
                }
                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Rate No.';
                }
                field("SUC Supply Point Address"; Rec."SUC Supply Point Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Address of the Supply Point';
                    Editable = false;
                }
                field("SUC Supply Point Country"; Rec."SUC Supply Point Country")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country of the Supply Point';
                    Editable = false;
                }
                field("SUC Supply Point Postal Code"; Rec."SUC Supply Point Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Postal Code of the Supply Point';
                    Editable = false;
                }
                field("SUC Supply Point City"; Rec."SUC Supply Point City")
                {
                    ApplicationArea = All;
                    ToolTip = 'City of the Supply Point';
                    Editable = false;
                }
                field("SUC Supply Point County"; Rec."SUC Supply Point County")
                {
                    ApplicationArea = All;
                    ToolTip = 'County of the Supply Point';
                    Editable = false;
                }
                field(P1; Rec.P1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P1 field.';
                }
                field(P2; Rec.P2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P2 field.';
                }
                field(P3; Rec.P3)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P3 field.';
                }
                field(P4; Rec.P4)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P4 field.';
                }
                field(P5; Rec.P5)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P5 field.';
                }
                field(P6; Rec.P6)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P6 field.';
                }
                field("Activation Date"; Rec."Activation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Activation Date';
                }
            }
        }
    }
}