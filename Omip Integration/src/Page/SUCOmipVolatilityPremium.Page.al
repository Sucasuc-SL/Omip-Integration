namespace Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC Omip Volatility Premium (ID 50156).
/// </summary>
page 50156 "SUC Omip Volatility Premium"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Omip Volatility Premium";
    Caption = 'Omip Volatility Premium', Comment = 'ESP="Omip Prima Volatilidad"';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Times; Rec.Times)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.', Comment = 'ESP="Tiempo"';
                }
                field("Amount/MWh"; Rec."Amount/MWh")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount / MWh field.', Comment = 'ESP="Importe / MWh"';
                }
            }
        }
    }
}