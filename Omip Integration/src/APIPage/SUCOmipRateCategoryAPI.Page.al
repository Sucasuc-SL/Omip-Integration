namespace Sucasuc.Omip.API;

using Sucasuc.Omip.Masters;
/// <summary>
/// page SUC Omip Rate Category API (ID 50191).
/// </summary>
page 50191 "SUC Omip Rate Category API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipRateCategoryLists';
    EntityName = 'sucOmipRateCategoryList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Rate Category";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(categoryCode; Rec."Category Code") { }
                field(fEEPotency; Rec."FEE Potency")
                {
                    Visible = false;
                }
                field(fEEEnergy; Rec."FEE Energy")
                {
                    Visible = false;
                }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}