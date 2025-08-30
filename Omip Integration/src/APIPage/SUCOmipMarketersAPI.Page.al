namespace Sucasuc.Omip.API;

using Sucasuc.Omip.Masters;
/// <summary>
/// page SUC Marketers API (ID 50187).
/// </summary>
page 50187 "SUC Omip Marketers API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipMarketersLists';
    EntityName = 'sucOmipMarketersList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Marketers";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(no; Rec."No.") { }
                field(name; Rec.Name) { }
                field(marketer; Rec.Marketer) { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}