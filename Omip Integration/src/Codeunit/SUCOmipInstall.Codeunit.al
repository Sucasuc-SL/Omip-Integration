namespace Sucasuc.Omip.Setup;

using System.Integration;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.User;
codeunit 50155 "SUC Omip Install"
{
    Subtype = Install;
    trigger OnInstallAppPerCompany()
    begin
        CreateOmipWS();
        UpdateOmipExternalUsers();
        UpdateOmipEnergyEntry();
    end;

    local procedure CreateOmipWS()
    var
        TenantWebService: Record "Tenant Web Service";
        WebServiceManagement: Codeunit "Web Service Management";
    begin
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Codeunit, 50152, 'sucOmipWebServices', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Codeunit, 50156, 'sucOmipBTP', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Codeunit, 50157, 'sucOmipKON', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50173, 'sucOmipCommentLineLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50174, 'sucOmipRatesEntryLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50175, 'sucOmipCUPSCustomers', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50184, 'sucOmipCountryRegionLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50185, 'sucOmipPostalCodesLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50186, 'sucOmipExternalUsersLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50187, 'sucOmipMarketersLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50188, 'sucOmipContractsLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50189, 'sucOmipCustomers', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50190, 'sucOmipProposalsLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50191, 'sucOmipRateCategoryLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50192, 'sucOmipRateLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50194, 'sucOmipTrackingBTPLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50199, 'sucOmipCustBankAccountLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50203, 'sucOmipConsumptionDeclaredLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50204, 'sucOmipContractedPowerLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50207, 'sucOmipTypesLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50209, 'sucOmipRatesTimesLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50217, 'sucOmipProposalMulticups', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50227, 'sucOmipControlPricesLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50228, 'sucOmipContractMulticups', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50232, 'sucOmipProposalPreviewLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50233, 'sucOmipPowerEntryPreview', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50234, 'sucOmipEnergyEntryPreview', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50241, 'sucOmipFEEPowerAgentLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50242, 'sucOmipFEEEnergyAgentLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50245, 'sucOmipFEEPowerDocumentLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50246, 'sucOmipFEEEnergyDocumentLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50256, 'sucOmipFEEGroupsLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50250, 'sucOmipCustomerDocsLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50258, 'sucOmipConsumptionByDistributors', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50259, 'sucOmipProsegurUses', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50260, 'sucOmipProsegurTypeAlarms', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50275, 'sucOmiePricesEntries', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Page, 50277, 'sucCommissionsEntryLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Query, 50150, 'sucOmipSetupLists', true);
        WebServiceManagement.CreateTenantWebService(TenantWebService."Object Type"::Query, 50151, 'sucOmipRatesEntrySetupLists', true);
    end;

    local procedure UpdateOmipExternalUsers()
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
    begin
        SUCOmipExternalUsers.Reset();
        SUCOmipExternalUsers.SetFilter("Marketer No.", '=%1', '');
        if SUCOmipExternalUsers.FindSet() then
            repeat
                SUCOmipExternalUsers."Marketer No." := 'NAB';
                SUCOmipExternalUsers.Modify();
            until SUCOmipExternalUsers.Next() = 0;
    end;

    local procedure UpdateOmipEnergyEntry()
    var
        SUCOmipEnergyEntry: Record "SUC Omip Energy Entry";
    begin
        SUCOmipEnergyEntry.Reset();
        SUCOmipEnergyEntry.SetFilter("Omip price", '<>%1', 0);
        if SUCOmipEnergyEntry.FindSet() then
            repeat
                SUCOmipEnergyEntry.Enabled := true;
                SUCOmipEnergyEntry.Modify();
            until SUCOmipEnergyEntry.Next() = 0;
    end;
}