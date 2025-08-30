namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Masters;
page 50241 "SUC Omip FEE Power Agent API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipFEEPowerAgentLists';
    EntityName = 'sucOmipFEEPowerAgentList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip FEE Power Agent";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(agentNo; Rec."Agent No.") { }
                field(feeGroupId; Rec."FEE Group Id.") { }
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