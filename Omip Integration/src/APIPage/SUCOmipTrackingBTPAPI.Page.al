namespace Sucasuc.Omip.API;

using Sucasuc.Omip.Auditing;
page 50194 "SUC Omip Tracking BTP API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipTrackingBTPLists';
    EntityName = 'sucOmipTrackingBTPList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Tracking BTP";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(documentType; Rec."Document Type") { }
                field(documentNo; Rec."Document No.") { }
                field(lineNo; Rec."Line No.") { }
                field(executionDate; Rec."Execution Date") { }
                field(responseStatus; Rec."Response Status") { }
                field(responseDescription; Rec."Response Description") { }
                field(acceptanceMethod; Rec."Acceptance Method") { }
                field(acceptanceSend; Rec."Acceptance Send") { }
                field(typeTracking; Rec."Action Tracking") { }
                field(btpncal; Rec."BTP ncal") { }
                field(btpnop; Rec."BTP nop") { }
                field(btpstatus; Rec."BTP status") { }
                field(btpdescription; Rec."BTP description") { }
                field(btpdate; Rec."BTP date") { }
                field(duplicateDocument; Rec."Duplicate Document") { }
                field(duplicateDocumentNo; Rec."Duplicate Document No.") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}