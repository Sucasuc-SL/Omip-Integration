namespace Sucasuc.Omip.User;
page 50235 "SUC Omip External Users Log"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Omip External Users Log";
    Editable = false;
    Caption = 'External Users Log';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}