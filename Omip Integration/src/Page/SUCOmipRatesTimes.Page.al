namespace Sucasuc.Omip.Masters;
page 50208 "SUC Omip Rates Times"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "SUC Omip Rates Times";
    Caption = 'Omip Rates Times';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Code Rate"; Rec."Code Rate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code Rate field.';
                }
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.';
                }
            }
        }
    }
}