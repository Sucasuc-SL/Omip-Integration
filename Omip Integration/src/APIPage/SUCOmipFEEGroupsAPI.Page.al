namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Masters;
page 50256 "SUC Omip FEE Groups API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipFEEGroupsLists';
    EntityName = 'sucOmipFEEGroupsList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip FEE Groups";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(groupId; Rec."Group Id.") { }
                field(groupName; Rec."Group Name") { }
                field(default; Rec.Default) { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}