namespace Sucasuc.Omip.Contracts;
using Sucasuc.Omip.BTP;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Utilities;
/// <summary>
/// Page SUC Omip Energy Contracts List (ID 50180).
/// </summary>
page 50180 "SUC Omip Energy Contracts List"
{
    ApplicationArea = All;
    Caption = 'Omip Contracts';
    PageType = List;
    SourceTable = "SUC Omip Energy Contracts";
    CardPageId = "SUC Omip Energy Contracts";
    UsageCategory = Lists;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("Marketer No."; Rec."Marketer No.")
                {
                    ToolTip = 'Specifies the value of the Marketer No. field.';
                }
                field("Product Type"; Rec."Product Type")
                {
                    ToolTip = 'Specifies the value of the Product Type field.';
                }
                field(Multicups; Rec.Multicups)
                {
                    ToolTip = 'Specifies the value of the Multicups field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Times; Rec.Times)
                {
                    ToolTip = 'Specifies the value of the Times field.';
                }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Customer CUPS"; Rec."Customer CUPS")
                {
                    ToolTip = 'Specifies the value of the Customer CUPS field.';
                }
                field("Acceptance Method"; Rec."Acceptance Method")
                {
                    ToolTip = 'Specifies the value of the Acceptance Method field.';
                }
                field("Proposal No."; Rec."Proposal No.")
                {
                    ToolTip = 'Specifies the value of the Proposal No field.';
                }
                field("Agent No."; Rec."Agent No.")
                {
                    ToolTip = 'Specifies the value of the Agent No field.';
                }
                field("Agent Name"; Rec."Agent Name Contract")
                {
                    ToolTip = 'Specifies the value of the Agent Name field.';
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Code field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("New Contract")
            {
                ApplicationArea = All;
                Caption = 'New Contract';
                Image = PostedOrder;
                ToolTip = 'Executes the New Contract action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.GetDataOmipRatesEntryContract();
                end;
            }
            action("SUC Omip Send Acceptance")
            {
                Image = SendConfirmation;
                Caption = 'Omip Send Acceptance';
                ToolTip = 'Executes the Omip Send Acceptance action.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.SendContract(Rec, true);
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
                    SUCOmipManagement.CancelOperation(SUCOmipDocumentType::Contract, Rec."No.");
                end;
            }
            action("SUC Tracking BTP")
            {
                ApplicationArea = All;
                Caption = 'Tracking BTP';
                Image = Track;
                RunObject = page "SUC Omip Tracking BTP";
                RunPageLink = "Document Type" = const(Contract), "Document No." = field("No.");
                RunPageView = sorting("Document Type", "Document No.", "Line No.") order(descending);
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
                    ConfirmLbl: Label 'Do you want to send the contract to Purchases?';
                begin
                    if Confirm(ConfirmLbl) then
                        SUCOmipManagement.SendEmailToPurchases(Rec."No.", SUCOmipDocumentType::Contract);
                end;
            }
            action("SUC Update Order TED & Resolution")
            {
                Visible = false;
                Image = UpdateDescription;
                Caption = 'Update Order TED & Resolution';
                ToolTip = 'Executes the Update Order TED & Resolution action.';
                trigger OnAction()
                var
                    SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
                    SUCOmipEnergyContracts2: Record "SUC Omip Energy Contracts";
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    RecordRef: RecordRef;
                    NoRows: Integer;
                begin
                    CurrPage.SetSelectionFilter(SUCOmipEnergyContracts);
                    SUCOmipEnergyContracts.Next();
                    NoRows := SUCOmipEnergyContracts.Count;

                    if NoRows = 1 then
                        SUCOmipManagement.UpdateOrderTEDResolution(Rec)
                    else begin
                        RecordRef.GetTable(SUCOmipEnergyContracts);
                        RecordRef.SetTable(SUCOmipEnergyContracts2);
                        if SUCOmipEnergyContracts2.FindSet() then
                            repeat
                                SUCOmipManagement.UpdateOrderTEDResolution(SUCOmipEnergyContracts2);
                            until SUCOmipEnergyContracts2.Next() = 0;
                    end;
                end;
            }
            action("SUC Update Data Proposals")
            {
                Image = UpdateDescription;
                Caption = 'Update Data Proposals';
                ToolTip = 'Executes the Update Data Proposals action.';
                trigger OnAction()
                var
                    SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
                    SUCOmipEnergyContracts2: Record "SUC Omip Energy Contracts";
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    RecordRef: RecordRef;
                    NoRows: Integer;
                begin
                    CurrPage.SetSelectionFilter(SUCOmipEnergyContracts);
                    SUCOmipEnergyContracts.Next();
                    NoRows := SUCOmipEnergyContracts.Count;

                    if NoRows = 1 then
                        SUCOmipManagement.UpdateDataFromProposal(Rec)
                    else begin
                        RecordRef.GetTable(SUCOmipEnergyContracts);
                        RecordRef.SetTable(SUCOmipEnergyContracts2);
                        if SUCOmipEnergyContracts2.FindSet() then
                            repeat
                                SUCOmipManagement.UpdateDataFromProposal(SUCOmipEnergyContracts2);
                            until SUCOmipEnergyContracts2.Next() = 0;
                    end;
                end;
            }
            action("SUC Update Applicable Conditions")
            {
                Image = UpdateDescription;
                Caption = 'Update Applicable Conditions';
                ToolTip = 'Executes the Update Applicable Conditions action.';

                trigger OnAction()
                var
                    SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
                    SUCOmipEnergyContracts2: Record "SUC Omip Energy Contracts";
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    RecordRef: RecordRef;
                    NoRows: Integer;
                begin
                    CurrPage.SetSelectionFilter(SUCOmipEnergyContracts);
                    SUCOmipEnergyContracts.Next();
                    NoRows := SUCOmipEnergyContracts.Count;

                    if NoRows = 1 then
                        SUCOmipManagement.SetContractApplicableConditions(Rec)
                    else begin
                        RecordRef.GetTable(SUCOmipEnergyContracts);
                        RecordRef.SetTable(SUCOmipEnergyContracts2);
                        if SUCOmipEnergyContracts2.FindSet() then
                            repeat
                                SUCOmipManagement.SetContractApplicableConditions(SUCOmipEnergyContracts2);
                            until SUCOmipEnergyContracts2.Next() = 0;
                    end;
                end;
            }
        }
        area(Reporting)
        {
            action("SUC Print Contract")
            {
                Image = Print;
                Caption = 'Print';
                ToolTip = 'Executes the Print action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.PrintContract(Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("No.");
        Rec.Ascending := false;
    end;
}