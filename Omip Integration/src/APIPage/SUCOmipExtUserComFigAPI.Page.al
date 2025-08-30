namespace Sucasuc.Omip.API;

using Sucasuc.Omip.User;
/// <summary>
/// page SUC Omip Ext User Com Fig. API (ID 50284).
/// </summary>
page 50284 "SUC Omip Ext User Com Fig. API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipExtUserComFiguresLists';
    EntityName = 'sucOmipExtUserComFiguresList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Ext User Com. Figures";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(userName; Rec."User Name") { }
                field(commercialFiguresType; Rec."Commercial Figures Type") { }
                field(commercialFigure; Rec."Commercial Figure") { }
                field(superiorOfficer; Rec."Superior Officer") { }
                field(hierarchicalLevel; Rec."Hierarchical Level") { }
                field(percentCommission; Rec."Percent Commission") { }
                field(percentCommissionDrag; Rec."Percent. Commission Drag") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}
