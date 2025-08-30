namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Contracts;
page 50228 "SUC Omip Cont. Multicups API"
{
    PageType = API;
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipContractMulticups';
    EntityName = 'sucOmipContractMulticups';
    SourceTable = "SUC Omip Energy Contracts Mul.";
    ODataKeyFields = "Contract Id";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(contractId; Rec."Contract Id") { }
                field(contractNo; Rec."Contract No.") { }
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