namespace Sucasuc.Omip.Ledger;

page 50280 "SUC Commissions Entry List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Commissions Entry";
    Caption = 'Commissions Entry List';
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    SourceTableView = sorting("Document Type", "Document No.", "Agent No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of document for the commission entry.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number for the commission entry.';
                }
                field("Agent No."; Rec."Agent No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the agent number.';
                }
                field("Hierarchical Level"; Rec."Hierarchical Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hierarchical level of the commission entry.';
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
                }
                field("Source Proposal No."; Rec."Source Proposal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source proposal number for contract commissions.';
                }
            }
        }
    }
}
