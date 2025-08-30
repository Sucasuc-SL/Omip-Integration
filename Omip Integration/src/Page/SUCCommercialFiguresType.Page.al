namespace Sucasuc.Omip.Masters;
page 50261 "SUC Commercial Figures Type"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Commercial Figures Type";
    Caption = 'Commercial Figures Types';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Id."; Rec."Id.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the commercial figures type.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the commercial figures type.';
                }
            }
        }
    }
}