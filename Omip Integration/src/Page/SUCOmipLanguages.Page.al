namespace Sucasuc.Omip.Masters;
page 50248 "SUC Omip Languages"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip Languages";
    Caption = 'Omip Languages';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country Code field.';
                }
                field("Country Name"; Rec."Country Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country Name field.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Language Code field.';
                }
                field("Language Name"; Rec."Language Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Language Name field.';
                }
                field("Id. Plenitude"; Rec."Id. Plenitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Id. Plenitude field.';
                }
            }
        }
    }
}