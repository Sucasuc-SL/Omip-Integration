namespace Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC Omip Commisions (ID 50160).
/// </summary>
page 50160 "SUC Omip Commisions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip Commisions";
    Caption = 'Omip Commisions', Comment = 'ESP="Omip Comisiones"';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Distribution; Rec.Distribution)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Distribution field.', Comment = 'ESP="Reparto"';
                }
                field(Percent; Rec.Percent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Percent field.', Comment = 'ESP="Porcentaje"';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.', Comment = 'ESP="Importe"';
                }
            }
        }
    }
}