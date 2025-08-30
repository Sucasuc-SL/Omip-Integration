namespace Sucasuc.Omip.API;

using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Setup;
using Sucasuc.Omip.Masters;
/// <summary>
/// page SUC Omip Rates Entry API (ID 50174).
/// </summary>
page 50174 "SUC Omip Rates Entry API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipRatesEntryLists';
    EntityName = 'sucOmipRatesEntryList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Rates Entry 2";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(marketerNo; Rec."Marketer No.") { }
                field(rateNo; Rec."Rate No.") { }
                field(hiredPotency; Rec."Hired Potency") { }
                field(omipTimes; Rec."Omip Times") { }
                field(ratesEntryPremiumOpenPos; Rec."Rates Entry Premium Open Pos.") { }
                field(omie; Rec.Omip) { }
                field(apuntament; Rec.Apuntament) { }
                field(sscc; Rec.SSCC) { }
                field(osom; Rec."OS/OM") { }
                field(priceCapacity; Rec."Price Capacity") { }
                field(socialBonus; Rec."Social Bonus") { }
                field(losses; Rec.Losses) { }
                field(detours; Rec.Detours) { }
                field(afnee; Rec.AFNEE) { }
                field(egreen; Rec.EGREEN) { }
                field(operatingExpenses; Rec."Operating Expenses") { }
                field(im; Rec.IM) { }
                field(atr; Rec.ATR) { }
                field(final; Rec.Final) { }
                field(finalPLUSatr; Rec."Final + ATR") { }
                field(totalFinal; Rec."Total Final") { }
                field(availableProposals; AvailableProposals) { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
    trigger OnOpenPage()
    begin
        SUCOmipSetup.Get();
    end;

    trigger OnAfterGetRecord()
    var
        SUCOmipRatesTimes: Record "SUC Omip Rates Times";
    begin
        if SUCOmipRatesTimes.Get(Rec."Rate No.", Rec."Omip Times") then
            AvailableProposals := true
        else
            AvailableProposals := false;
    end;

    var
        SUCOmipSetup: Record "SUC Omip Setup";
        AvailableProposals: Boolean;
}