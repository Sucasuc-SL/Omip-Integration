namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Masters;

query 50151 "SUC Omip Rates Entry Setup API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipRatesEntrySetupLists';
    EntityName = 'sucOmipRatesEntrySetupList';
    QueryType = API;
    DataAccessIntent = ReadOnly;

    elements
    {
        dataitem(SUC_Omip_Rates_Entry_Setup; "SUC Omip Rates Entry Setup")
        {
            column(marketerNo; "Marketer No.") { }
            column(marketerName; "Marketer Name") { }
            column(minFEEPotency; "Min. FEE Potency") { }
            column(maxFEEPotency; "Max. FEE Potency") { }
            column(minFEEEnergy; "Min. FEE Energy") { }
            column(maxFEEEnergy; "Max. FEE Energy") { }
            column(systemId; SystemId) { }
            column(systemCreatedAt; SystemCreatedAt) { }
            column(systemModifiedAt; SystemModifiedAt) { }
        }
    }
}