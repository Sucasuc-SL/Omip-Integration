namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Proposals;
page 50217 "SUC Omip Prop. Multicups API"
{
    PageType = API;
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipProposalMulticups';
    EntityName = 'sucOmipProposalMulticups';
    SourceTable = "SUC Omip Proposal Multicups";
    ODataKeyFields = "Proposal Id";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(proposalId; Rec."Proposal Id") { }
                field(proposalNo; Rec."Proposal No.") { }
                field(customerNo; Rec."Customer No.") { }
                field(customerCUPS; Rec."Customer CUPS") { }
                field(rateNo; Rec."Rate No.") { }
                field(supplyPointAddress; Rec."SUC Supply Point Address") { }
                field(supplyPointPostCode; Rec."SUC Supply Point Post Code") { }
                field(supplyPointCity; Rec."SUC Supply Point City") { }
                field(supplyPointCounty; Rec."SUC Supply Point County") { }
                field(supplyPointCountry; Rec."SUC Supply Point Country") { }
                field(p1; Rec.P1) { }
                field(p2; Rec.P2) { }
                field(p3; Rec.P3) { }
                field(p4; Rec.P4) { }
                field(p5; Rec.P5) { }
                field(p6; Rec.P6) { }
                field(activationDate; Rec."Activation Date") { }
                field(volume; Rec.Volume) { }
            }
        }
    }
}