namespace Sucasuc.Omip.BTP;
using Sucasuc.Omip.Auditing;
page 50193 "SUC Omip Tracking BTP"
{
    PageType = List;
    UsageCategory = None;
    SourceTable = "SUC Omip Tracking BTP";
    Caption = 'Tracking';
    InsertAllowed = false;
    ModifyAllowed = false;
    //DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Execution Date"; Rec."Execution Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Execution Date field.';
                }
                field("Response Status"; Rec."Response Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Response Status field.';
                }
                field("Response Description"; Rec."Response Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Response Description field.';
                }
                field("Acceptance Method"; Rec."Acceptance Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acceptance Method field.';
                }
                field("Acceptance Send"; Rec."Acceptance Send")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acceptance Send field.';
                }
                field("Type Tracking"; Rec."Action Tracking")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type Tracking field.';
                }
                field("BTP ncal"; Rec."BTP ncal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BTP ncal field.';
                }
                field("BTP nop"; Rec."BTP nop")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BTP nop field.';
                }
                field("BTP status"; Rec."BTP status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BTP status field.';
                }
                field("BTP description"; Rec."BTP description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BTP description field.';
                }
                field("BTP date"; Rec."BTP date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BTP date field.';
                }
                field("Duplicate Document"; Rec."Duplicate Document")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duplicate Document field.';
                }
                field("Duplicate Document No."; Rec."Duplicate Document No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duplicate Document No. field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Download Request")
            {
                ApplicationArea = All;
                Caption = 'Download Request';
                Image = Download;
                ToolTip = 'Executes the Download Request action.';
                trigger OnAction()
                begin
                    Rec.DownloadRequest();
                end;
            }
            action("Download Support Document")
            {
                ApplicationArea = All;
                Caption = 'Download Support Document';
                Image = Download;
                ToolTip = 'Executes the Download Support Document action.';
                trigger OnAction()
                begin
                    Rec.DownloadDocBTP();
                end;
            }
        }
    }
}