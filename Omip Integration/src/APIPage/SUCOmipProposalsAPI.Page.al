namespace Sucasuc.Omip.API;

using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Ledger;
/// <summary>
/// page SUC Omip Proposals API (ID 50190).
/// </summary>
page 50190 "SUC Omip Proposals API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipProposalsLists';
    EntityName = 'sucOmipProposalsList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Proposals";
    ODataKeyFields = SystemId;
    ChangeTrackingAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(proposalNo; Rec."No.") { }
                field(dateProposal; Rec."Date Proposal") { }
                field(contractStartDate; Rec."Contract Start Date") { }
                field(agentNo; Rec."Agent No.") { }
                field(agentName; Rec."Agent Name") { }
                field(customerNo; Rec."Customer No.") { }
                field(customerName; Rec."Customer Name") { }
                field(status; Rec.Status) { }
                field(rateNo; Rec."Rate No.") { }
                field(times; Rec.Times) { }
                field(tipe; Rec.Type) { }
                field(rateCategory; Rec."Rate Category") { }
                field(customerCUPS; Rec."Customer CUPS") { }
                field(customerPhoneNo; Rec."Customer Phone No.") { }
                field(customerVATRegistrationNo; Rec."Customer VAT Registration No.") { }
                field(marketerNo; Rec."Marketer No.") { }
                field(marketerName; Rec."Marketer Name") { }
                field(acceptanceMethod; Rec."Acceptance Method") { }
                field(acceptanceSend; Rec."Acceptance Send") { }
                field(contractNo; Rec."Contract No.") { }
                field(fileName; Rec."File Name") { }
                field(receiveInvoiceElectronically; Rec."Receive invoice electronically") { }
                field(sendingCommunications; Rec."Sending Communications") { }
                field(multicups; Rec.Multicups) { }
                field(oldFEEPotency; Rec."FEE Potency") { }
                field(oldFEEEnergy; Rec."FEE Energy") { }
                field(feeGroupId; Rec."FEE Group Id.") { }
                part(sucomipProposalMulticups; "SUC Omip Prop. Multicups API")
                {
                    EntitySetName = 'sucOmipProposalMulticups';
                    EntityName = 'sucOmipProposalMulticups';
                    SubPageLink = "Proposal Id" = field(SystemId);
                }
                part(sucOmipFEEPowerDocument; "SUC Omip FEE Power Doc. API")
                {
                    EntitySetName = 'sucOmipFEEPowerDocLists';
                    EntityName = 'sucOmipFEEPowerDocList';
                    SubPageLink = "Document Type" = const("Proposal"), "Document No." = field("No.");
                }
                part(sucOmipFEEEnergyDocument; "SUC Omip FEE Energy Doc. API")
                {
                    EntitySetName = 'sucOmipFEEEnergyDocLists';
                    EntityName = 'sucOmipFEEEnergyDocList';
                    SubPageLink = "Document Type" = const("Proposal"), "Document No." = field("No.");
                }
                part(sucomipPowerEntrys; "SUC Omip Power Entry API")
                {
                    EntitySetName = 'sucOmipPowerEntry';
                    EntityName = 'sucOmipPowerEntry';
                    SubPageLink = "Proposal Id" = field(SystemId);
                }
                part(sucomipEnergyEntrys; "SUC Omip Energy Entry API")
                {
                    EntitySetName = 'sucOmipEnergyEntry';
                    EntityName = 'sucOmipEnergyEntry';
                    SubPageLink = "Proposal Id" = field(SystemId);
                }
                part(sucomipContractedPower; "SUC Omip Contracted Power API")
                {
                    EntitySetName = 'sucOmipContractedPowerLists';
                    EntityName = 'sucOmipContractedPowerList';
                    SubPageLink = "Document Type" = const("Proposal"), "Document No." = field("No.");
                }
                part(sucomipConsumptionDeclared; "SUC Omip Consump. Declared API")
                {
                    EntitySetName = 'sucOmipConsumptionDeclaredLists';
                    EntityName = 'sucOmipConsumptionDeclaredList';
                    SubPageLink = "Document Type" = const("Proposal"), "Document No." = field("No.");
                }

                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}