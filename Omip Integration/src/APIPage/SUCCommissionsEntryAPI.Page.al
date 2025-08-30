namespace Sucasuc.Omip.API;

using Sucasuc.Omip.Ledger;
page 50277 "SUC Commissions Entry API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucCommissionsEntryLists';
    EntityName = 'sucCommissionsEntryList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Commissions Entry";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(documentType; Rec."Document Type") { }
                field(documentNo; Rec."Document No.") { }
                field(agentNo; Rec."Agent No.") { }
                field(commercialFiguresType; Rec."Commercial Figures Type") { }
                field(commercialFigure; Rec."Commercial Figure") { }
                field(percentCommisionOwnSale; Rec."Percent Commision Own Sale") { }
                field(superiorOfficer; Rec."Superior Officer") { }
                field(percentHierarchyDistribution; Rec."Percent Hierarchy Distribution") { }
                field(powerCommissionAmount; Rec."Power Commission Amount") { }
                field(energyCommissionAmount; Rec."Energy Commission Amount") { }
                field(totalCommissionAmount; Rec."Total Commission Amount") { }
                field(percentCommisionDrag; Rec."Percent Commision Drag") { }
                field(commissionDragAmount; Rec."Commission Drag Amount") { }
                field(firstAgentCalculation; Rec."First Agent Calculation") { }
                field(hierarchicalLevel; Rec."Hierarchical Level") { }
                field(commisionOwnSale; Rec."Commision Own Sale") { }
                field(supersededByContract; Rec."Superseded by Contract") { }
                field(sourceProposalNo; Rec."Source Proposal No.") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}
