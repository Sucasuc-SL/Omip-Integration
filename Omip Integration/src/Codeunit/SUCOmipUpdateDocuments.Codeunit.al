namespace Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Setup;
using Sucasuc.Omip.Contracts;
codeunit 50158 "SUC Omip Update Documents"
{
    trigger OnRun()
    begin
        UpdateStatusExpired();
    end;

    local procedure UpdateStatusExpired()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipSetup: Record "SUC Omip Setup";
        ValidTime: Time;
        TodayDT: DateTime;
        DueDT: DateTime;
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Time Validity Proposals");
        SUCOmipSetup.TestField("Time Validity Contracts");
        SUCOmipProposals.Reset();
        SUCOmipProposals.SetRange(Status, SUCOmipProposals.Status::"Pending Acceptance");
        if SUCOmipProposals.FindSet() then
            repeat
                ValidTime := DT2Time(SUCOmipProposals."DateTime Created");
                TodayDT := CreateDateTime(Today, ValidTime);
                DueDT := CreateDateTime(CalcDate(Format(SUCOmipSetup."Time Validity Contracts"), SUCOmipProposals."Date Created"), ValidTime);

                if (TodayDT > DueDT) then begin
                    SUCOmipProposals.Status := SUCOmipProposals.Status::"Out of Time";
                    SUCOmipProposals.Modify();
                end;
            until SUCOmipProposals.Next() = 0;

        SUCOmipEnergyContracts.Reset();
        SUCOmipEnergyContracts.SetRange(Status, SUCOmipEnergyContracts.Status::"Pending Acceptance");
        if SUCOmipEnergyContracts.FindSet() then
            repeat
                ValidTime := DT2Time(SUCOmipEnergyContracts."DateTime Created");
                TodayDT := CreateDateTime(Today, ValidTime);
                DueDT := CreateDateTime(CalcDate(Format(SUCOmipSetup."Time Validity Contracts"), SUCOmipEnergyContracts."Date Created"), ValidTime);

                if (TodayDT > DueDT) then begin
                    SUCOmipEnergyContracts.Status := SUCOmipEnergyContracts.Status::"Out of Time";
                    SUCOmipEnergyContracts.Modify();
                end;
            until SUCOmipEnergyContracts.Next() = 0;
    end;
}