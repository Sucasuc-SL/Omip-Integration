namespace Sucasuc.Omip.Masters;
page 50220 "SUC Omip Power Entry Sub Cont."
{
    UsageCategory = None;
    Caption = 'Omip Power Entry';
    PageType = ListPart;
    SourceTable = "SUC Omip Power Entry Contract";
    Editable = false;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Rate No."; Rec."Rate No.")
                {
                    ToolTip = 'Specifies the value of the Rate No. field.';
                }
                field(P1; Rec.P1)
                {
                    ToolTip = 'Specifies the value of the P1 field.';
                }
                field(P2; Rec.P2)
                {
                    ToolTip = 'Specifies the value of the P2 field.';
                }
                field(P3; Rec.P3)
                {
                    ToolTip = 'Specifies the value of the P3 field.';
                }
                field(P4; Rec.P4)
                {
                    ToolTip = 'Specifies the value of the P4 field.';
                }
                field(P5; Rec.P5)
                {
                    ToolTip = 'Specifies the value of the P5 field.';
                }
                field(P6; Rec.P6)
                {
                    ToolTip = 'Specifies the value of the P6 field.';
                }
            }
        }
    }
}