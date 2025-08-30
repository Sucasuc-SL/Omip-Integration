namespace Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Auditing;
using Sucasuc.Omip.BTP;
using Sucasuc.Omip.Utilities;
/// <summary>
/// Page SUC Omip Proposals (ID 50168).
/// </summary>
page 50168 "SUC Omip Proposals"
{
    ApplicationArea = All;
    Caption = 'Omip Proposals';
    PageType = List;
    SourceTable = "SUC Omip Proposals";
    SourceTableView = sorting("No.") order(descending);
    UsageCategory = Lists;
    CardPageId = "SUC Omip Proposals Card";
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Proposal No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proposal No. field.';
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Type field.';
                }
                field("Marketer No."; Rec."Marketer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketer field.';
                }
                field(Multicups; Rec.Multicups)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Multicups field.';
                }
                field("Date Proposal"; Rec."Date Proposal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Proposal field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Times; Rec.Times)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Customer CUPS"; Rec."Customer CUPS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CUPS field.';
                }
                field("Acceptance Method"; Rec."Acceptance Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acceptance Method field.';
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract No. field.';
                }
                field("Agent No."; Rec."Agent No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent No. field.';
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Name field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("New Proposal")
            {
                ApplicationArea = All;
                Caption = 'New Proposal';
                Image = PostedOrder;
                ToolTip = 'Executes the New Proposal action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.GetDataOmipRatesEntry();
                end;
            }
            action("SUC Omip Send Acceptance")
            {
                Image = SendConfirmation;
                Caption = 'Send Acceptance';
                ToolTip = 'Executes the Send Acceptance action.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.SendProposal(Rec);
                end;
            }
            action("SUC Convert to Contract")
            {
                Image = TransferToLines;
                Caption = 'Convert to Contract';
                ToolTip = 'Executes the Convert to Contract action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.GenerateContract(Rec);
                end;
            }
            action("SUC Cancel BTP")
            {
                ApplicationArea = All;
                Caption = 'Cancel BTP';
                Image = Cancel;
                ToolTip = 'Executes the Cancel BTP action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    SUCOmipDocumentType: Enum "SUC Omip Document Type";
                begin
                    SUCOmipManagement.CancelOperation(SUCOmipDocumentType::Proposal, Rec."No.");
                end;
            }
            action("SUC Tracking BTP")
            {
                ApplicationArea = All;
                Caption = 'Tracking BTP';
                Image = Track;
                RunObject = page "SUC Omip Tracking BTP";
                RunPageLink = "Document Type" = const(Proposal), "Document No." = field("No.");
                RunPageView = sorting("Document Type", "Document No.", "Line No.") order(descending);
                ToolTip = 'Executes the Tracking BTP action.';
            }
            action("SUC Send to Purchases")
            {
                Image = SendConfirmation;
                Caption = 'Send to Purchases';
                ToolTip = 'Executes the to Purchases action.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    SUCOmipDocumentType: Enum "SUC Omip Document Type";
                    ConfirmLbl: Label 'Do you want to send the proposal to Purchases?';
                begin
                    if Confirm(ConfirmLbl) then
                        SUCOmipManagement.SendEmailToPurchases(Rec."No.", SUCOmipDocumentType::Proposal);
                end;
            }
            action("SUC Duplicate Proposal")
            {
                Image = CheckDuplicates;
                Caption = 'Duplicate Proposal';
                ToolTip = 'Executes the Duplicate Proposal action.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    ConfirmLbl: Label 'Do you want to duplicate the offer? Prices will be calculated based on current prices.';
                begin
                    if Confirm(ConfirmLbl) then
                        SUCOmipManagement.DuplicateProposal(Rec);
                end;
            }
            action("SUC Update Proposal Id.")
            {
                Image = UpdateShipment;
                Caption = 'Update Proposal Id.';
                ToolTip = 'Executes the Update Proposal Id. action.';
                ApplicationArea = All;
                trigger OnAction()
                var
                    SUCOmipProposalMulticups: Record "SUC Omip Proposal Multicups";
                    SUCOmipProposals: Record "SUC Omip Proposals";
                begin
                    SUCOmipProposalMulticups.Reset();
                    if SUCOmipProposalMulticups.FindSet() then
                        repeat
                            SUCOmipProposals.Get(SUCOmipProposalMulticups."Proposal No.");
                            SUCOmipProposalMulticups.Validate("Proposal Id", SUCOmipProposals.SystemId);
                            SUCOmipProposalMulticups.Modify();
                        until SUCOmipProposalMulticups.Next() = 0;
                end;
            }
            action("Preview Proposal")
            {
                Image = ViewPostedOrder;
                Caption = 'Preview Proposal Prices';
                ToolTip = 'Executes the Preview Proposal action.';
                RunObject = page "SUC Omip Proposal Preview";
                RunPageMode = Create;
            }
        }
        area(Reporting)
        {
            action("SUC Print Proposal")
            {
                Image = Print;
                Caption = 'Print';
                ToolTip = 'Executes the Print action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.PrintProposal(Rec);
                end;
            }
        }

        area(Navigation)
        {
            action("SUC Comment Line")
            {
                ApplicationArea = All;
                Caption = 'Comments';
                Image = Comment;
                RunObject = page "SUC Omip Comment Line";
                RunPageLink = "No." = field("No."), "Document Type" = const(Proposal);
                ToolTip = 'Executes the Comments action.';
            }
            action("SUC Change Log Entry")
            {
                Image = Log;
                Caption = 'Change Log Entry';
                ToolTip = 'Executes the Change Log Entry action.';
                RunObject = page "SUC Omip Change Log Entries";
                RunPageLink = "Primary Key field 1 Value" = field("No.");
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("No.");
        Rec.Ascending := false;
    end;
}