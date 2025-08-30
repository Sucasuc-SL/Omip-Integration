namespace Sucasuc.Omip.Prosegur;
page 50266 "SUC Prosegur Type Alarm"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Prosegur Type Alarm";
    Caption = 'Prosegur Type Alarm';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No. Type Use"; Rec."No. Type Use")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Type Use field.';
                }
                field("No. Type Alarm"; Rec."No. Type Alarm")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Type Alarm field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}