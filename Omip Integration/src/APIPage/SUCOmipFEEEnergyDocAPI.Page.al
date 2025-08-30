namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Masters;
page 50246 "SUC Omip FEE Energy Doc. API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipFEEEnergyDocLists';
    EntityName = 'sucOmipFEEEnergyDocList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip FEE Energy Document";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(documentType; Rec."Document Type") { }
                field(documentNo; Rec."Document No.") { }
                field(marketerNo; Rec."Marketer No.") { }
                field(rateNo; Rec."Rate No.") { }
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