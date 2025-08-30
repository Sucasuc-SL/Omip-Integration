namespace Sucasuc.Omip.Ledger;
page 50234 "SUC Omip Energy Entry Prev API"
{
    PageType = API;
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipEnergyEntryPreview';
    EntityName = 'sucOmipEnergyEntryPreview';
    SourceTable = "SUC Omip Energy Entry Preview";
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
                field(times; Rec.Times) { }
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