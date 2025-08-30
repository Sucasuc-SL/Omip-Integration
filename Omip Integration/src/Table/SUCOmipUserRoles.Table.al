namespace Sucasuc.Omip.Setup;
using Sucasuc.Omip.User;
table 50179 "SUC Omip User Roles"
{
    DataClassification = CustomerContent;
    Caption = 'User Roles';
    DrillDownPageId = "SUC Omip User Roles";
    LookupPageId = "SUC Omip User Roles";

    fields
    {
        field(1; "Role Code"; Code[20])
        {
            Caption = 'Role Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "User Type"; Enum "SUC Omip User Type")
        {
            Caption = 'User Type';
        }
    }

    keys
    {
        key(Key1; "Role Code", "User Type")
        {
            Clustered = true;
        }
    }
}