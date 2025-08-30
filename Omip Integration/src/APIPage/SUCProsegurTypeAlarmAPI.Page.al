namespace Sucasuc.Omip.Prosegur.API;
using Sucasuc.Omip.Prosegur;
page 50260 "SUC Prosegur Type Alarm API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipProsegurTypeAlarms';
    EntityName = 'sucOmipProsegurTypeAlarm';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Prosegur Type Alarm";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(noTypeUse; Rec."No. Type Use") { }
                field(noTypeAlarm; Rec."No. Type Alarm") { }
                field(description; Rec.Description) { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}