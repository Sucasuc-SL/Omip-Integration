namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Setup;
page 50207 "SUC Omip Types API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipTypesLists';
    EntityName = 'sucOmipTypesList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Types";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(type; Rec.Type) { }
                field(startDateContract; Rec."Start Date Contract") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}