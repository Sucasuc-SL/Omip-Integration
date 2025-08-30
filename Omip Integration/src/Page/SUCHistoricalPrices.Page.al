namespace Sucasuc.Energy.Ledger;

page 50274 "SUC Historical Prices"
{
    ApplicationArea = All;
    Caption = 'Historical Prices';
    PageType = List;
    SourceTable = "SUC Historical Prices";
    UsageCategory = None;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = sorting("Control Prices Id.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Control Prices ID"; Rec."Control Prices Id.")
                {
                    ToolTip = 'Specifies the Control Prices ID.';
                    Editable = false;
                }
                field("Marketer No."; Rec."Marketer No.")
                {
                    ToolTip = 'Specifies the Marketer No.';
                }
                field(Modality; Rec.Modality)
                {
                    ToolTip = 'Specifies the Modality.';
                }
                field(Version; Rec.Version)
                {
                    ToolTip = 'Specifies the Version of the historical prices.';
                }
                field("Rate No."; Rec."Rate No.")
                {
                    ToolTip = 'Specifies the Rate No. associated with the historical prices.';
                }
                field("Year"; Rec."Year")
                {
                    ToolTip = 'Specifies the Year.';
                }
                field("Month"; Rec."Month")
                {
                    ToolTip = 'Specifies the Month.';
                }
                field("Period"; Rec."Period")
                {
                    ToolTip = 'Specifies the Period (P1-P6).';
                }
                field("Index Value"; Rec."Index Value")
                {
                    ToolTip = 'Specifies the Index Value.';
                }
                field("Excel Column Description"; Rec."Excel Column Description")
                {
                    ToolTip = 'Specifies the Excel column description for easy identification.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ToolTip = 'Specifies when the record was created.';
                }
            }
        }
    }
}
