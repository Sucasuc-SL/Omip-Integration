namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Contracts;
page 50202 "SUC Omip Consumption Declared"
{
    Caption = 'Omip Consumption Declared';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip Consumption Declared";
    InsertAllowed = false;
    // DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(CUPS; Rec.CUPS)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(P1; Rec.P1)
                {
                    ApplicationArea = All;
                }
                field(P2; Rec.P2)
                {
                    ApplicationArea = All;
                }
                field(P3; Rec.P3)
                {
                    ApplicationArea = All;
                }
                field(P4; Rec.P4)
                {
                    ApplicationArea = All;
                }
                field(P5; Rec.P5)
                {
                    ApplicationArea = All;
                }
                field(P6; Rec.P6)
                {
                    ApplicationArea = All;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("P1 %"; Rec."P1 %")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("P2 %"; Rec."P2 %")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("P3 %"; Rec."P3 %")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("P4 %"; Rec."P4 %")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("P5 %"; Rec."P5 %")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("P6 %"; Rec."P6 %")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Real FEE P1"; Rec."Real FEE P1")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Real FEE P2"; Rec."Real FEE P2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Real FEE P3"; Rec."Real FEE P3")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Real FEE P4"; Rec."Real FEE P4")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Real FEE P5"; Rec."Real FEE P5")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Real FEE P6"; Rec."Real FEE P6")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Real FEE Total"; Rec."Real FEE Total")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Commission P1"; Rec."Commission P1")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Commission P2"; Rec."Commission P2")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Commission P3"; Rec."Commission P3")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Commission P4"; Rec."Commission P4")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Commission P5"; Rec."Commission P5")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Commission P6"; Rec."Commission P6")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Total Commission"; Rec."Total Commission")
                {
                    ApplicationArea = All;
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