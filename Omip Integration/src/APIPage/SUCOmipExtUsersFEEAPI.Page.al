namespace Sucasuc.Omip.API;
using Sucasuc.Omip.User;
page 50255 "SUC Omip Ext. Users FEE API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipExtUsersGroupsFEELists';
    EntityName = 'sucOmipExtUsersGroupsFEEList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Ext. Users Groups FEE";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(userName; Rec."User Name") { }
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