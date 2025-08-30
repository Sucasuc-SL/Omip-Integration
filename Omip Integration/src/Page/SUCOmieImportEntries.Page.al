namespace Sucasuc.Omie.Auditing;
page 50259 "SUC Omie Import Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Omie Import Entries";
    SourceTableView = sorting("Entry No.") order(descending);
    Caption = 'Omie Import Entries';
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Omie File Name"; Rec."Omie File Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the File Name field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Download Omie File")
            {
                ApplicationArea = All;
                Caption = 'Download Omie File';
                Image = Download;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Download the Omie File';
                trigger OnAction()
                begin
                    Rec.DownloadOmieFile();
                end;
            }
        }
    }
}