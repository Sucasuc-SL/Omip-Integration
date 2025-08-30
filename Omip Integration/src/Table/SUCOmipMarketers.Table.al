namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Contracts;
/// <summary>
/// Table SUC Marketers (ID 50123).
/// </summary>
table 50173 "SUC Omip Marketers"
{
    DataClassification = CustomerContent;
    Caption = 'Marketers';
    DrillDownPageId = "SUC Omip Marketers";
    LookupPageId = "SUC Omip Marketers";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';
        }
        field(3; Marketer; Enum "SUC Omip Marketers")
        {
            Caption = 'Marketer';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        ErrorProposalsLbl: Label 'Marketer cannot be deleted because it is used in the proposals.';
        ErrorContractsLbl: Label 'Marketer cannot be deleted because it is used in the contracts.';
    begin
        SUCOmipProposals.Reset();
        SUCOmipProposals.SetRange("Marketer No.", "No.");
        if not SUCOmipProposals.IsEmpty() then
            Error(ErrorProposalsLbl);

        SUCOmipEnergyContracts.Reset();
        SUCOmipEnergyContracts.SetRange("Marketer No.", "No.");
        if not SUCOmipEnergyContracts.IsEmpty() then
            Error(ErrorContractsLbl);
    end;
}