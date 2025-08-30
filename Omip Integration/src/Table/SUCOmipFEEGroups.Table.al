namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Contracts;
table 50210 "SUC Omip FEE Groups"
{
    DataClassification = CustomerContent;
    Caption = 'Omip FEE Groups';
    DrillDownPageId = "SUC Omip FEE Groups";
    LookupPageId = "SUC Omip FEE Groups";

    fields
    {
        field(1; "Group Id."; Code[20])
        {
            Caption = 'Group Id.';
        }
        field(2; "Group Name"; Text[100])
        {
            Caption = 'Group Name';
        }
        field(3; Default; Boolean)
        {
            Caption = 'Default';
            trigger OnValidate()
            begin
                if Default then
                    ValidateFEEDefault();
            end;
        }
    }

    keys
    {
        key(Key1; "Group Id.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Group Id.", "Group Name") { }
    }
    trigger OnDelete()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        ErrorProposalsLbl: Label 'FEE Group cannot be deleted because it is used in the proposals.';
        ErrorContractsLbl: Label 'FEE Group cannot be deleted because it is used in the contracts.';
    begin
        if "Group Id." <> '' then begin
            SUCOmipProposals.Reset();
            SUCOmipProposals.SetRange("FEE Group Id.", "Group Id.");
            if not SUCOmipProposals.IsEmpty() then
                Error(ErrorProposalsLbl);

            SUCOmipEnergyContracts.Reset();
            SUCOmipEnergyContracts.SetRange("FEE Group Id.", "Group Id.");
            if not SUCOmipEnergyContracts.IsEmpty() then
                Error(ErrorContractsLbl);
        end;
    end;

    local procedure ValidateFEEDefault()
    var
        SUCOmipFEEGroups: Record "SUC Omip FEE Groups";
    begin
        SUCOmipFEEGroups.Reset();
        SUCOmipFEEGroups.SetRange(Default, true);
        SUCOmipFEEGroups.SetFilter("Group Id.", '<>%1', "Group Id.");
        if SUCOmipFEEGroups.FindSet() then
            repeat
                SUCOmipFEEGroups.Default := false;
                SUCOmipFEEGroups.Modify();
            until SUCOmipFEEGroups.Next() = 0;
    end;
}