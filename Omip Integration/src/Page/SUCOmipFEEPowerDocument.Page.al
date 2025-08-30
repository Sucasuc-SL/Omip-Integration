namespace Sucasuc.Omip.Documents;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Contracts;
page 50240 "SUC Omip FEE Power Document"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip FEE Power Document";
    Caption = 'FEE Power Document';
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rate No. field.';
                    Editable = false;
                }
                field(P1; Rec.P1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P1 field.';
                }
                field(P2; Rec.P2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P2 field.';
                }
                field(P3; Rec.P3)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P3 field.';
                }
                field(P4; Rec.P4)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P4 field.';
                }
                field(P5; Rec.P5)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P5 field.';
                }
                field(P6; Rec.P6)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P6 field.';
                }
                field("P1 %"; Rec."P1 %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P1 % field.';
                }
                field("P2 %"; Rec."P2 %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P2 % field.';
                }
                field("P3 %"; Rec."P3 %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P3 % field.';
                }
                field("P4 %"; Rec."P4 %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P4 % field.';
                }
                field("P5 %"; Rec."P5 %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P5 % field.';
                }
                field("P6 %"; Rec."P6 %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P6 % field.';
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
                Caption = 'Update Prices';
                ToolTip = 'Update Prices.';
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
                    //* Commisions
                    SUCOmipFEEPowerDocument.Reset();
                    SUCOmipFEEPowerDocument.SetRange("Document Type", Rec."Document Type");
                    SUCOmipFEEPowerDocument.SetRange("Document No.", Rec."Document No.");
                    if SUCOmipFEEPowerDocument.FindSet() then
                        repeat
                            SUCOmipManagement.UpdateCommisionsAfterModifyFEEs(SUCOmipFEEPowerDocument."Document Type", CopyStr(SUCOmipFEEPowerDocument."Document No.", 1, 20), SUCOmipFEEPowerDocument."Rate No.")
                        until SUCOmipFEEPowerDocument.Next() = 0;
                    //* End Commisions
                end;
            }
        }
    }
}