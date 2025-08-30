namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Setup;

query 50150 "SUC Omip Setup API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipSetupLists';
    EntityName = 'sucOmipSetupList';
    QueryType = API;
    DataAccessIntent = ReadOnly;

    elements
    {
        dataitem(SUC_Omip_Setup; "SUC Omip Setup")
        {
            column(emailProposalConfirmation; "Email Proposal Confirmation") { }
            column(timeValidityProposals; "Time Validity Proposals") { }
            column(timeValidityContracts; "Time Validity Contracts") { }
            column(systemId; SystemId) { }
            column(systemCreatedAt; SystemCreatedAt) { }
            column(systemModifiedAt; SystemModifiedAt) { }
        }
    }
}