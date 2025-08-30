namespace Sucasuc.Omip.Setup;
page 50236 "SUC Omip Times"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Omip Times";
    Caption = 'Omip Times';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Marketer No."; Rec."Marketer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketer No. field.';
                }
                field("SUC Time"; Rec."SUC Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.';
                }
                field("Rates Entry GdOs"; Rec."Rates Entry GdOs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rates Entry GdOs field.';
                }
            }
        }
    }
}