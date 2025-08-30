namespace Sucasuc.Omip.Masters;
page 50257 "SUC Omip Consum. Distributor"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Omip Consum. Distributor";
    Caption = 'Omip Consumption Established by Distributor';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rate No. field.';
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
            }
        }
    }
}