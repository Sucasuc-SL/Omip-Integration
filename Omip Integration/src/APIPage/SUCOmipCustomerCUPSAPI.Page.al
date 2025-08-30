namespace Sucasuc.Omip.API;

using Sucasuc.Omip.Masters;
/// <summary>
/// page SUC Omip Customer CUPS API (ID 50175).
/// </summary>
page 50175 "SUC Omip Customer CUPS API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipCUPSCustomers';
    EntityName = 'sucOmipCUPSCustomer';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Customer CUPS";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(customerNo; Rec."Customer No.") { }
                field(cups; Rec.CUPS) { }
                field(sucSupplyPointCountry; Rec."SUC Supply Point Country") { }
                field(sucSupplyPointPostCode; Rec."SUC Supply Point Post Code") { }
                field(sucSupplyPointCity; Rec."SUC Supply Point City") { }
                field(sucSupplyPointCounty; Rec."SUC Supply Point County") { }
                field(sucSupplyPointAddress; Rec."SUC Supply Point Address") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}