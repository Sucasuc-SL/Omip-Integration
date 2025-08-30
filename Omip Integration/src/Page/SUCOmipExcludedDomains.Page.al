namespace Sucasuc.Omip.Setup;
/// <summary>
/// Page SUC Omip Excluded Domains (ID 50177).
/// </summary>
page 50177 "SUC Omip Excluded Domains"
{
    ApplicationArea = All;
    Caption = 'Omip Excluded Domains';
    PageType = List;
    SourceTable = "SUC Omip Excluded Domains";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Domains; Rec.Domains)
                {
                    ToolTip = 'Specifies the value of the Domains field.';
                }
                field("Domains Email"; Rec."Domains Email")
                {
                    ToolTip = 'Specifies the value of the Domains Emails field.';
                }
            }
        }
    }
}