namespace Sucasuc.Omip.API;

using Sucasuc.Omip.Masters;
/// <summary>
/// page SUC Omip Rates API (ID 50192).
/// </summary>
page 50192 "SUC Omip Rates API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipRateLists';
    EntityName = 'sucOmipRateList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Rates";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(ratesCode; Rec.Code) { }
                field(description; Rec.Description) { }
                field(marketingType; Rec."Marketing Type") { }
                field(id; Rec.ID) { }
                field(greenEnergy; Rec."Green Energy") { }
                field(voltageNo; Rec."Voltage No.") { }
                field(omipIndexed; Rec."OMIP Indexed") { }
                field(omipIndexed5; Rec."OMIP Indexed 5") { }
                field(availableonAgentsportal; Rec."Available on Agents portal") { }
                field(availabletoRenew; Rec."Available to Renew") { }
                field(commissionPlanNo; Rec."Commission Plan No.") { }
                field(validfrom; Rec."Valid from") { }
                field(validUntil; Rec."Valid Until") { }
                field(year; Rec.Year) { }
                field(energyManagement; Rec."Energy Management") { }
                field(feekWh; Rec."Rate kWh") { }
                field(conditionsText; Rec."Conditions Text") { }
                field(conditionsTariff; Rec."Conditions Tariff") { }
                field(conditionsTariff2; Rec."Conditions Tariff 2") { }
                field(noPotency; Rec."No. Potency") { }
                field(noConsumption; Rec."No. Consumption") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}