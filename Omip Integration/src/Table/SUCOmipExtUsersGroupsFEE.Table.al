namespace Sucasuc.Omip.User;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Utilities;
table 50211 "SUC Omip Ext. Users Groups FEE"
{
    DataClassification = CustomerContent;
    Caption = 'External Users Groups FEE';
    DrillDownPageId = "SUC Omip Ext. Users Groups FEE";
    LookupPageId = "SUC Omip Ext. Users Groups FEE";

    fields
    {
        field(1; "User Name"; Code[100])
        {
            Caption = 'User Name';
            TableRelation = "SUC Omip External Users"."User Name";
        }
        field(2; "Group Id."; Code[20])
        {
            Caption = 'Group Id.';
            TableRelation = "SUC Omip FEE Groups"."Group Id.";
            trigger OnValidate()
            begin
                CalcFields("Group Name");
                SUCOmipExternalUsers.Get("User Name");
                SUCOmipManagement.ValidateFEEExternalUsers(SUCOmipExternalUsers, false, "Group Id.");
            end;
        }
        field(3; "Group Name"; Text[100])
        {
            Caption = 'Group Name';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip FEE Groups"."Group Name" where("Group Id." = field("Group Id.")));
        }
        field(4; Default; Boolean)
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
        key(Key1; "User Name", "Group Id.")
        {
            Clustered = true;
        }
        key(Key2; Default) { }
    }
    trigger OnDelete()
    var
        SUCOmipFEEPowerAgent: Record "SUC Omip FEE Power Agent";
        SUCOmipFEEEnergyAgent: Record "SUC Omip FEE Energy Agent";
    begin
        SUCOmipFEEPowerAgent.Reset();
        SUCOmipFEEPowerAgent.SetRange("Agent No.", "User Name");
        SUCOmipFEEPowerAgent.SetRange("FEE Group Id.", "Group Id.");
        if SUCOmipFEEPowerAgent.FindSet() then
            repeat
                SUCOmipFEEPowerAgent.Delete();
            until SUCOmipFEEPowerAgent.Next() = 0;

        SUCOmipFEEEnergyAgent.Reset();
        SUCOmipFEEEnergyAgent.SetRange("Agent No.", "User Name");
        SUCOmipFEEEnergyAgent.SetRange("FEE Group Id.", "Group Id.");
        if SUCOmipFEEEnergyAgent.FindSet() then
            repeat
                SUCOmipFEEEnergyAgent.Delete();
            until SUCOmipFEEEnergyAgent.Next() = 0;
    end;

    local procedure ValidateFEEDefault()
    var
        SUCOmipExtUsersGroupsFEE: Record "SUC Omip Ext. Users Groups FEE";
    begin
        SUCOmipExtUsersGroupsFEE.Reset();
        SUCOmipExtUsersGroupsFEE.SetRange("User Name", "User Name");
        SUCOmipExtUsersGroupsFEE.SetRange(Default, true);
        SUCOmipExtUsersGroupsFEE.SetFilter("Group Id.", '<>%1', "Group Id.");
        if SUCOmipExtUsersGroupsFEE.FindSet() then
            repeat
                SUCOmipExtUsersGroupsFEE.Default := false;
                SUCOmipExtUsersGroupsFEE.Modify();
            until SUCOmipExtUsersGroupsFEE.Next() = 0;
    end;

    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        SUCOmipManagement: Codeunit "SUC Omip Management";
}