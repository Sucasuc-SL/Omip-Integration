namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Masters;
page 50209 "SUC Omip Rates Times API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipRatesTimesLists';
    EntityName = 'sucOmipRatesTimesList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Rates Times";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(codeRate; Rec."Code Rate") { }
                field(time; Rec.Time) { }
            }
        }
    }
}