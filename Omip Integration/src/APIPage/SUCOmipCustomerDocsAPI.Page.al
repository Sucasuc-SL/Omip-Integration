namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Ledger;
page 50250 "SUC Omip Customer Docs. API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipCustomerDocsLists';
    EntityName = 'sucOmipCustomerDocsList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Customer Docs.";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(documentType; Rec."Document Type") { }
                field(documentNo; Rec."Document No.") { }
                field(customerNo; Rec."Customer No.") { }
                field(postingDate; Rec."Posting Date") { }
                field(status; Rec.Status) { }
                field(agentNo; Rec."Agent No.") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}