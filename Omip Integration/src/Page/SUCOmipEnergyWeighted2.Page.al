namespace Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC Omip Energy Weighted (ID 50211).
/// </summary>
page 50211 "SUC Omip Energy Weighted 2"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Omip Energy Weighted 2";
    Caption = 'Omip Energy Weighted';
    layout
    {
        area(Content)
        {
            repeater(Lists)
            {
                field("Marketer No."; Rec."Marketer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketer No. field.';
                }
                field("Rate Code"; Rec."Rate Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rate Code field.';
                }
                field(Times; Rec.Times)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.', Comment = 'ESP="Tiempo"';
                }
                // field(P1; Rec.P1)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the P1 field.';
                // }
                // field(P2; Rec.P2)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the P2 field.';
                // }
                // field(P3; Rec.P3)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the P3 field.';
                // }
                // field(P4; Rec.P4)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the P4 field.';
                // }
                // field(P5; Rec.P5)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the P5 field.';
                // }
                // field(P6; Rec.P6)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the P6 field.';
                // }
                field(FEE; Rec.FEE)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the FEE field.';
                }
                field("FEE P1"; Rec."FEE P1")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the FEE P1 field.';
                }
                field("FEE P2"; Rec."FEE P2")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the FEE P2 field.';
                }
                field("FEE P3"; Rec."FEE P3")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the FEE P3 field.';
                }
                field("FEE P4"; Rec."FEE P4")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the FEE P4 field.';
                }
                field("FEE P5"; Rec."FEE P5")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the FEE P5 field.';
                }
                field("FEE P6"; Rec."FEE P6")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the value of the FEE P6 field.';
                }
            }
        }
    }
}