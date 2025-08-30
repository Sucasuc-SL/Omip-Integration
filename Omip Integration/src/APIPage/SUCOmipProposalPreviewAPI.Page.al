namespace Sucasuc.Omip.API;

using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Ledger;
page 50232 "SUC Omip Proposal Preview API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipProposalPreviewLists';
    EntityName = 'sucOmipProposalPreviewList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Proposal Preview";
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
                field(rateNo; Rec."Rate No.") { }
                field(times; Rec.Times) { }
                field(tipe; Rec.Type) { }
                field(energyOrigen; Rec."Energy Origen") { }
                field(contractStartDate; Rec."Contract Start Date") { }
                field(dateCreated; Rec."Date Created") { }
                field(marketerNo; Rec."Marketer No.") { }
                field(marketerName; Rec."Marketer Name") { }
                field(customerNo; Rec."Customer No.") { }
                field(customerName; Rec."Customer Name") { }
                field(customerCUPS; Rec."Customer CUPS") { }
                field(feeGroupId; Rec."FEE Group Id.") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
                part(sucOmipFEEPowerDocument; "SUC Omip FEE Power Doc. API")
                {
                    EntitySetName = 'sucOmipFEEPowerDocLists';
                    EntityName = 'sucOmipFEEPowerDocList';
                    SubPageLink = "Document Type" = const("Proposal Preview"), "Document No." = field("No.");
                }
                part(sucOmipFEEEnergyDocument; "SUC Omip FEE Energy Doc. API")
                {
                    EntitySetName = 'sucOmipFEEEnergyDocLists';
                    EntityName = 'sucOmipFEEEnergyDocList';
                    SubPageLink = "Document Type" = const("Proposal Preview"), "Document No." = field("No.");
                }
                part(sucomipPowerEntrys; "SUC Omip Power Entry Prev. API")
                {
                    EntitySetName = 'sucOmipPowerEntryPreview';
                    EntityName = 'sucOmipPowerEntryPreview';
                    SubPageLink = "Proposal Id" = field(SystemId);
                }
                part(sucomipEnergyEntrys; "SUC Omip Energy Entry Prev API")
                {
                    EntitySetName = 'sucOmipEnergyEntryPreview';
                    EntityName = 'sucOmipEnergyEntryPreview';
                    SubPageLink = "Proposal Id" = field(SystemId);
                }
                part(sucomipContractedPower; "SUC Omip Contracted Power API")
                {
                    EntitySetName = 'sucOmipContractedPowerLists';
                    EntityName = 'sucOmipContractedPowerList';
                    SubPageLink = "Document Type" = const("Proposal Preview"), "Document No." = field("No.");
                }
                part(sucomipConsumptionDeclared; "SUC Omip Consump. Declared API")
                {
                    EntitySetName = 'sucOmipConsumptionDeclaredLists';
                    EntityName = 'sucOmipConsumptionDeclaredList';
                    SubPageLink = "Document Type" = const("Proposal Preview"), "Document No." = field("No.");
                }
            }
        }
    }
}