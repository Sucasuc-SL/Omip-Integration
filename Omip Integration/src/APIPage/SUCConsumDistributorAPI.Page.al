namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Masters;
page 50258 "SUC Consum. Distributor API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipConsumptionByDistributors';
    EntityName = 'sucOmipConsumptionByDistributor';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Consum. Distributor";
    layout
    {
        area(Content)
        {
            repeater(General)
            {
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