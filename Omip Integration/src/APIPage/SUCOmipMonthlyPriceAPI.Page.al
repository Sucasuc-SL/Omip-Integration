namespace Sucasuc.Omip.API;

using Sucasuc.Omip.Masters;
page 50282 "SUC Omip Monthly Price API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipMonthlyPriceHistoryLists';
    EntityName = 'sucOmipMonthlyPriceHistoryList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Monthly Price Hist";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(postingDate; Rec."Posting Date") { }
                field(year; Rec.Year) { }
                field(month; Rec.Month) { }
                field(refTrim; Rec."Ref. Trim") { }
                field(refMonth; Rec."Ref. Month") { }
                field(price; Rec.Price) { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}
