namespace Sucasuc.Omip.Contracts;

page 50224 "SUC Fam. Contract Modalities"
{
    ApplicationArea = All;
    Caption = 'Families Contract Modalities';
    PageType = List;
    SourceTable = "SUC Fam. Contract Modalities";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
            }
        }
    }
}
