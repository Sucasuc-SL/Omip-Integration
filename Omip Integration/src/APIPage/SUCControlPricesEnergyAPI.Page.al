namespace Sucasuc.Omip.API;
using Sucasuc.Energy.Ledger;
page 50227 "SUC Control Prices Energy API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipControlPricesLists';
    EntityName = 'sucOmipControlPricesList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Control Prices Energy";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec."Id.") { }
                field(marketerNo; Rec."Marketer No.") { }
                field(energyType; Rec."Energy Type") { }
                field(idRateWS; Rec."Id Rate WS") { }
                field(rateNo; Rec."Rate No.") { }
                field(potencyUpper; Rec."Potency Upper") { }
                field(potencyLower; Rec."Potency Lower") { }
                field(rateType; Rec."Rate Type Contract") { }
                field(gosVisible; Rec."GOs Visible") { }
                field(modality; Rec.Modality) { }
                field(discount; Rec.Discount) { }
                field(p1; Rec.P1) { }
                field(p2; Rec.P2) { }
                field(p3; Rec.P3) { }
                field(p4; Rec.P4) { }
                field(p5; Rec.P5) { }
                field(p6; Rec.P6) { }
                field(e1; Rec.E1) { }
                field(e2; Rec.E2) { }
                field(e3; Rec.E3) { }
                field(e4; Rec.E4) { }
                field(e5; Rec.E5) { }
                field(e6; Rec.E6) { }
                field(maintenance; Rec.Maintenance) { }
                field(sge; Rec.SGE) { }
                field(sgev; Rec.SGEV) { }
                field(remuneration; Rec.Remuneration) { }
            }
        }
    }
}