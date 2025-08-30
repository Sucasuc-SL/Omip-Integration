namespace Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC Marketers (ID 50183).
/// </summary>
page 50183 "SUC Omip Marketers"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Omip Marketers";
    Caption = 'Marketers';

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Proposals Report Id."; Rec.Marketer)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proposals Report Id. field.';
                }

            }
        }
    }
}