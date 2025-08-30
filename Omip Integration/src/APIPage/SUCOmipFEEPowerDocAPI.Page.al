namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Masters;
page 50245 "SUC Omip FEE Power Doc. API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipFEEPowerDocLists';
    EntityName = 'sucOmipFEEPowerDocList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip FEE Power Document";

    layout
    {
        area(Content)
        {
            repeater(Control)
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
                field(p1Percent; Rec."P1 %") { }
                field(p2Percent; Rec."P2 %") { }
                field(p3Percent; Rec."P3 %") { }
                field(p4Percent; Rec."P4 %") { }
                field(p5Percent; Rec."P5 %") { }
                field(p6Percent; Rec."P6 %") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}