namespace Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Masters;
page 50195 "SUC Omip Power Entry API"
{
    PageType = API;
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipPowerEntry';
    EntityName = 'sucOmipPowerEntry';
    SourceTable = "SUC Omip Power Entry";
    ODataKeyFields = "Proposal Id";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(proposalId; Rec."Proposal Id") { }
                field(systemId; Rec.SystemId) { }
                field(proposalNo; Rec."Proposal No.") { }
                field(rateNo; Rec."Rate No.") { }
                field(p1; Rec.P1) { }
                field(p2; Rec.P2) { }
                field(p3; Rec.P3) { }
                field(p4; Rec.P4) { }
                field(p5; Rec.P5) { }
                field(p6; Rec.P6) { }
            }
        }
    }
}