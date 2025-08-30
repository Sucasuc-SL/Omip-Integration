namespace Sucasuc.Omip.API;
using Sucasuc.Omie.Master;
page 50275 "SUC Omie Prices Entry API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmiePricesEntries';
    EntityName = 'sucOmiePricesEntry';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omie Prices Entry";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(date; Rec."Date") { }
                field(hour; Rec."Hour") { }
                field(price; Rec."Price") { }
                field(price2; Rec."Price 2") { }
                field(importEntryNo; Rec."Import Entry No.") { }
                field(createdDateTime; Rec."Created Date Time") { }
                field(modifiedDateTime; Rec."Modified Date Time") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}
