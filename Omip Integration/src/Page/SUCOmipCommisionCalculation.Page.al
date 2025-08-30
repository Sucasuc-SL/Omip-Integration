namespace Sucasuc.Omip.Utilities;
/// <summary>
/// Page SUC Omip Commision Calculation (ID 50159).
/// </summary>
page 50159 "SUC Omip Commision Calculation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip Commision Calculation";
    Caption = 'Omip Commision Calculation', Comment = 'ESP="Omip Calculo Comisiones"';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.', Comment = 'ESP="Tiempo"';
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