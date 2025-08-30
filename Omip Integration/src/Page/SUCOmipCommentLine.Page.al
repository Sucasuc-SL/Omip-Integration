namespace Sucasuc.Omip.Documents;
page 50172 "SUC Omip Comment Line"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "SUC Omip Comment Line";
    Caption = 'Comment line';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comment field.';
                }
            }
        }
    }
}