namespace Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Contracts;
page 50263 "SUC Commissions Entry"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Commissions Entry";
    Caption = 'Commissions Entry';
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = sorting("Hierarchical Level") order(descending);

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Hierarchical Level"; Rec."Hierarchical Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hierarchical level of the commission entry.';
                }
                field("Agent No."; Rec."Agent No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the agent number.';
                }
                field("Commercial Figures Type"; Rec."Commercial Figures Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of commercial figures.';
                }
                field("Commercial Figure"; Rec."Commercial Figure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the commercial figure.';
                }
                field(Distribution; Rec."Percent Commision Own Sale")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the distribution.';
                }
                field("Commision Own Sale"; Rec."Commision Own Sale")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the commission amount for own sales.';
                }
                field("Superior Officer"; Rec."Superior Officer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the superior officer.';
                }
                field("Distribution Superior Officer"; Rec."Percent Hierarchy Distribution")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the distribution superior officer.';
                }
                field("Power Commission Amount"; Rec."Power Commission Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the power commission amount.';
                }
                field("Energy Commission Amount"; Rec."Energy Commission Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the energy commission amount.';
                }
                field("Total Commission Amount"; Rec."Total Commission Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total commission amount.';
                }
                field("Percent. Distribution Applied"; Rec."Percent Commision Drag")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the percentage of distribution applied.';
                }
                field("Distribution Commission Amount"; Rec."Commission Drag Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the distribution commission amount.';
                }
                field("Superseded by Contract"; Rec."Superseded by Contract")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates if this proposal commission has been superseded by a contract.';
                    Editable = false;
                }
                field("Source Proposal No."; Rec."Source Proposal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source proposal number for contract commissions.';
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update Prices")
            {
                ApplicationArea = All;
                Caption = 'Update Commissions';
                ToolTip = 'Update Commissions.';
                Image = PriceAdjustment;
                trigger OnAction()
                var
                    SUCOmipProposals: Record "SUC Omip Proposals";
                    SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
                    SUCOmipProposalPreview: Record "SUC Omip Proposal Preview";
                    SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    case Rec."Document Type" of
                        Rec."Document Type"::Proposal:
                            begin
                                SUCOmipProposals.Get(Rec."Document No.");
                                SUCOmipProposals.SetDocumentPricesWithCalculation();
                            end;
                        Rec."Document Type"::Contract:
                            begin
                                SUCOmipEnergyContracts.Get(Rec."Document No.");
                                SUCOmipEnergyContracts.SetDocumentPricesWithCalculation();
                            end;
                        Rec."Document Type"::"Proposal Preview":
                            begin
                                SUCOmipProposalPreview.Get(Rec."Document No.");
                                SUCOmipProposalPreview.SetDocumentPricesWithCalculation();
                            end;
                    end;
                    SUCOmipFEEPowerDocument.Reset();
                    SUCOmipFEEPowerDocument.SetRange("Document Type", Rec."Document Type");
                    SUCOmipFEEPowerDocument.SetRange("Document No.", Rec."Document No.");
                    if SUCOmipFEEPowerDocument.FindSet() then
                        repeat
                            SUCOmipManagement.UpdateCommisionsAfterModifyFEEs(SUCOmipFEEPowerDocument."Document Type", CopyStr(SUCOmipFEEPowerDocument."Document No.", 1, 20), SUCOmipFEEPowerDocument."Rate No.")
                        until SUCOmipFEEPowerDocument.Next() = 0;
                end;
            }
        }
    }
}