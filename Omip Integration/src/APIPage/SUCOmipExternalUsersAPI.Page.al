namespace Sucasuc.Omip.API;

using Sucasuc.Omip.User;
/// <summary>
/// page SUC External Users API (ID 50186).
/// </summary>
page 50186 "SUC Omip External Users API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipExternalUsersLists';
    EntityName = 'sucOmipExternalUsersList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip External Users";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(userSecurityID; Rec."User Security ID") { }
                field(userName; Rec."User Name") { }
                field(fullName; Rec."Full Name") { }
                field(state; Rec.State) { }
                field(expiryDate; Rec."Expiry Date") { }
                field(licenseType; Rec."License Type") { }
                field(contactEmail; Rec."Contact Email") { }
                field(userType; Rec."User Type") { }
                field(role; Rec.Role) { }
                field(filterMarketer; Rec."Filter Marketer") { }
                field(marketerNo; Rec."Marketer No.") { }
                field(filterStatusDocuments; Rec."Filter Status Documents") { }
                field(agentCode; Rec."Agent Code") { }
                field(activeCommisions; Rec."Active Commisions") { }
                field(viewCommissions; Rec."View Commissions") { }
                field(commercialFiguresType; Rec."Commercial Figures Type") { }
                field(commercialFigure; Rec."Commercial Figure") { }
                field(superiorOfficer; Rec."Superior Officer") { }
                field(hierarchicalLevel; Rec."Hierarchical Level") { }
                field(percentCommission; Rec."Percent Commission") { }
                field(percentCommissionDrag; Rec."Percent. Commission Drag") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
                part(sucOmipExtUsersGroupsFEE; "SUC Omip Ext. Users FEE API")
                {
                    EntitySetName = 'sucOmipExtUsersGroupsFEELists';
                    EntityName = 'sucOmipExtUsersGroupsFEEList';
                    SubPageLink = "User Name" = field("User Name");
                }
                part(sucOmipExtUserCommercialFigures; "SUC Omip Ext User Com Fig. API")
                {
                    EntitySetName = 'sucOmipExtUserComFiguresLists';
                    EntityName = 'sucOmipExtUserComFiguresList';
                    SubPageLink = "User Name" = field("User Name");
                }
                part(sucomipFEEPowerAgent; "SUC Omip FEE Power Agent API")
                {
                    EntitySetName = 'sucOmipFEEPowerAgentLists';
                    EntityName = 'sucOmipFEEPowerAgentList';
                    SubPageLink = "Agent No." = field("User Name");
                }
                part(sucomipFEEEnergyAgent; "SUC Omip FEE Energy Agent API")
                {
                    EntitySetName = 'sucOmipFEEEnergyAgentLists';
                    EntityName = 'sucOmipFEEEnergyAgentList';
                    SubPageLink = "Agent No." = field("User Name");
                }
            }
        }
    }
}