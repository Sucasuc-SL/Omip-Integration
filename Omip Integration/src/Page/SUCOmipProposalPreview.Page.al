namespace Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Documents;
page 50229 "SUC Omip Proposal Preview"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "SUC Omip Proposal Preview";
    Caption = 'Omip Proposals Preview';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Proposal No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preview Proposal No. field.';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Marketer No."; Rec."Marketer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketer field.';
                }
                field("Marketer Name"; Rec."Marketer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketer Name field.';
                }
                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rate No. field.';
                }
                field(Times; Rec.Times)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.', Comment = 'ESP="Tiempo"';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Energy Origen"; Rec."Energy Origen")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Energy Origen field.';
                }
                field("Agent No."; Rec."Agent No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent No. field.';
                }
                field("FEE Group Id."; Rec."FEE Group Id.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the FEE Group Id. field.';
                }
                field(CUPS; Rec.CUPS)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CUPS field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.';
                    Editable = false;
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Start Date field.';
                }
            }
            part("SUC Omip FEE Power Document"; "SUC Omip FEE Power Document")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const("Proposal Preview"), "Document No." = field("No."), "Marketer No." = field("Marketer No.");
            }
            part("SUC Omip FEE Energy Document"; "SUC Omip FEE Energy Document")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const("Proposal Preview"), "Document No." = field("No."), "Marketer No." = field("Marketer No.");
            }
            part("SUC Omip Power Entry Preview"; "SUC Omip Power Entry Preview")
            {
                ApplicationArea = All;
                SubPageLink = "Proposal No." = field("No.");
            }
            part("SUC Omip Energy Entry Preview"; "SUC Omip Energy Entry Preview")
            {
                ApplicationArea = All;
                SubPageLink = "Proposal No." = field("No."), Enabled = const(true);
            }
            part("SUC Omip Contracted Power"; "SUC Omip Contracted Power")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const("Proposal Preview"), "Document No." = field("No.");
            }
            part("SUC Omip Consumption Declared"; "SUC Omip Consumption Declared")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const("Proposal Preview"), "Document No." = field("No.");
            }
        }
    }
    actions
    {

        area(Processing)
        {
            action(Preview)
            {
                ApplicationArea = All;
                Caption = 'Preview';
                ToolTip = 'Preview the record.';
                Image = PreviewChecks;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.SetDocumentPricesWithCalculation();
                end;
            }
            action("Delete all")
            {
                ApplicationArea = All;
                Caption = 'Delete';
                ToolTip = 'Deletes the record.';
                Image = Delete;
                trigger OnAction()
                var
                    SUCOmipProposalPreview: Record "SUC Omip Proposal Preview";
                begin
                    SUCOmipProposalPreview.DeleteAll(true);
                end;
            }
            action("Create New Proposal")
            {
                ApplicationArea = All;
                Caption = 'Create New Proposal';
                ToolTip = 'Creates a new proposal using the current record.';
                Image = New;
                trigger OnAction()
                begin
                    CreateProposal();
                    CurrPage.Close();
                end;
            }
        }
        area(Reporting)
        {

        }
    }
    trigger OnClosePage()
    begin
        if Rec."No." <> '' then
            Rec.Delete(true)
    end;

    local procedure CreateProposal()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        NewDocNo: Code[20];
    begin
        Rec.TestField("Marketer No.");
        Rec.TestField("Rate No.");
        Rec.TestField(Type);
        Rec.TestField(Times);
        Rec.TestField("Energy Origen");
        NewDocNo := SUCOmipManagement.GenerateProposal3(Rec."Marketer No.", Rec."Rate No.", Rec.Type, Rec.Times, Rec."Energy Origen", false, '', Rec."Agent No.", Rec."FEE Group Id.");
        SUCOmipProposals.Get(NewDocNo);
        Page.Run(Page::"SUC Omip Proposals Card", SUCOmipProposals);
    end;
}