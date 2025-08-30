namespace Sucasuc.Omip.Setup;
page 50206 "SUC Omip Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Omip Types";
    Caption = 'Omip Types';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Start Date Contract"; Rec."Start Date Contract")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start Date Contract field.';
                }
            }
        }
    }
}