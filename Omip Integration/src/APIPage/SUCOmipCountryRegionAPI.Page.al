namespace Sucasuc.Omip.API;

using Microsoft.Foundation.Address;
/// <summary>
/// page SUC Country Region API (ID 50184).
/// </summary>
page 50184 "SUC Omip Country Region API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipCountryRegionLists';
    EntityName = 'sucOmipCountryRegionList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "Country/Region";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(code; Rec."Code") { }
                field(name; Rec.Name) { }
                field(isoCode; Rec."ISO Code") { }
                field(isoNumericCode; Rec."ISO Numeric Code") { }
                field(addressFormat; Rec."Address Format") { }
                field(contactAddressFormat; Rec."Contact Address Format") { }
                field(countyName; Rec."County Name") { }
                field(euCountryRegionCode; Rec."EU Country/Region Code") { }
                field(intrastatCode; Rec."Intrastat Code") { }
                field(vatRegistrationNoDigits; Rec."VAT Registration No. digits") { }
                field(vatScheme; Rec."VAT Scheme") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}