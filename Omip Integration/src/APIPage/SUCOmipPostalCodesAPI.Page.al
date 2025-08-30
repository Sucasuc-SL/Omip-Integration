namespace Sucasuc.Omip.API;

using Microsoft.Foundation.Address;
/// <summary>
/// page SUC Postal Codes API (ID 50185).
/// </summary>
page 50185 "SUC Omip Postal Codes API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipPostalCodesLists';
    EntityName = 'sucOmipPostalCodesList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "Post Code";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field("code"; Rec."Code") { }
                field(city; Rec.City) { }
                field(countryRegionCode; Rec."Country/Region Code") { }
                field(county; Rec.County) { }
                field(timeZone; Rec."Time Zone") { }
                field(countyCode; Rec."County Code") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}