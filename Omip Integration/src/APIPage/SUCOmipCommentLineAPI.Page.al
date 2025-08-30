namespace Sucasuc.Omip.API;

using Sucasuc.Omip.Documents;
/// <summary>
/// page SUC Omip Comment Line API (ID 50173).
/// </summary>
page 50173 "SUC Omip Comment Line API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipCommentLineLists';
    EntityName = 'sucOmipCommentLineList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Comment Line";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(documentType; Rec."Document Type") { }
                field(no; Rec."No.") { }
                field(lineNo; Rec."Line No.") { }
                field(date; Rec.Date) { }
                field(comment; Rec.Comment) { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}