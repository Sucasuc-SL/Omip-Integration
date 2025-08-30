namespace Sucasuc.Omip.User;
table 50200 "SUC Omip External Users Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User Name"; Code[100])
        {
            Caption = 'User Name';
            TableRelation = "SUC Omip External Users"."User Name";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Date"; DateTime)
        {
            Caption = 'Date';
        }
        field(4; "Description"; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "User Name", "Line No.")
        {
            Clustered = true;
        }
    }
}