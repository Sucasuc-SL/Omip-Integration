namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Masters;
page 50203 "SUC Omip Consump. Declared API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipConsumptionDeclaredLists';
    EntityName = 'sucOmipConsumptionDeclaredList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Consumption Declared";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(documentType; Rec."Document Type") { }
                field(documentNo; Rec."Document No.") { }
                field(cups; Rec.CUPS) { }
                field(p1; Rec.P1) { }
                field(p2; Rec.P2) { }
                field(p3; Rec.P3) { }
                field(p4; Rec.P4) { }
                field(p5; Rec.P5) { }
                field(p6; Rec.P6) { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}