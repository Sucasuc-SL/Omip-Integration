namespace Sucasuc.Omip.Prosegur.API;
using Sucasuc.Omip.Prosegur;
page 50264 "SUC Prosegur Type Uses API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipProsegurUses';
    EntityName = 'sucOmipProsegurTypeUse';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Prosegur Type Uses";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(no; Rec."No.") { }
                field(description; Rec.Description) { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}