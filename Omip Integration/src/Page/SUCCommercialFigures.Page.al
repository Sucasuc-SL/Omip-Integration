namespace Sucasuc.Omip.Masters;
page 50262 "SUC Commercial Figures"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Commercial Figures";
    Caption = 'Commercial Figures';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of commercial figure.';
                }
                field("Id."; Rec."Id.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the commercial figure.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the commercial figure.';
                }
                field(Distribution; Rec.Distribution)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the distribution method for the commercial figure.';
                }
                field("Hierarchical Level"; Rec."Hierarchical Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hierarchical level of the commercial figure.';
                }
                field("Distribution by Figure"; Rec."Distribution by Figure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates whether the distribution is done by figure.';
                }
            }
        }
    }
}