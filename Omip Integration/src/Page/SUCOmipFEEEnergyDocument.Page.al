namespace Sucasuc.Omip.Documents;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Utilities;
page 50239 "SUC Omip FEE Energy Document"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip FEE Energy Document";
    Caption = 'FEE Energy Document';
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
                field("Total Period"; Rec."Total Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Period field.';
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
                end;
            }
        }
    }
}