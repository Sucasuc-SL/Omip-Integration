namespace Sucasuc.Omip.Contracts;
page 50226 "SUC Default Modality By Time"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Default Modality By Time";
    Caption = 'Default Modality By Time';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Time; Rec.Time)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.';
                }
                field("Default Contract Modality"; Rec."Default Contract Modality")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Contract Modality field.';
                }
            }
        }
    }
}