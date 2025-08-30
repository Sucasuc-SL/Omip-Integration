namespace Sucasuc.Omip.Ledger;
page 50230 "SUC Omip Energy Entry Preview"
{
    UsageCategory = None;
    Caption = 'Omip Energy Entry';
    PageType = ListPart;
    SourceTable = "SUC Omip Energy Entry Preview";
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
                field("Times Text"; Rec."Times Text")
                {
                    ToolTip = 'Specifies the value of the Times Text field.';
                }
                field("Omip price"; Rec."Omip price")
                {
                    ToolTip = 'Specifies the value of the Omip price field.';
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