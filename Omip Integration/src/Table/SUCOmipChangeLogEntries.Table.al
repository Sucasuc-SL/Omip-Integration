namespace Sucasuc.Omip.Auditing;
using System.Security.AccessControl;
using System.Reflection;
using System.Diagnostics;

/// <summary>
/// Table SUC Omip Change Log Entries (ID 50171).
/// </summary>
table 50171 "SUC Omip Change Log Entries"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "Date and Time"; DateTime)
        {
            Caption = 'Date and Time';
        }
        field(3; "Time"; Time)
        {
            Caption = 'Time';
        }
        field(4; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
        }
        field(5; "Table No."; Integer)
        {
            Caption = 'Table No.';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
        }
        field(6; "Table Caption"; Text[250])
        {
            Caption = 'Table Caption';
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Table), "Object ID" = field("Table No.")));
            FieldClass = FlowField;
        }
        field(7; "field No."; Integer)
        {
            Caption = 'Field No.';
            TableRelation = Field."No." where(TableNo = field("Table No."));
        }
        field(8; "field Caption"; Text[250])
        {
            Caption = 'Field Caption';
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."), "No." = field("field No.")));
            FieldClass = FlowField;
        }
        field(9; "Type of Change"; Enum "Change Log Entry Type")
        {
            Caption = 'Type of Change';
        }
        field(10; "Old Value"; Text[2048])
        {
            Caption = 'Old Value';
        }
        field(11; "New Value"; Text[2048])
        {
            Caption = 'New Value';
        }
        field(12; "Primary Key"; Text[250])
        {
            Caption = 'Primary Key';
        }
        field(13; "Primary Key field 1 No."; Integer)
        {
            Caption = 'Primary Key field 1 No.';
            TableRelation = Field."No." where(TableNo = field("Table No."));
        }
        field(14; "Primary Key field 1 Caption"; Text[80])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."), "No." = field("Primary Key field 1 No.")));
            Caption = 'Primary Key field 1 Caption';
            FieldClass = FlowField;
        }
        field(15; "Primary Key field 1 Value"; Text[50])
        {
            Caption = 'Primary Key field 1 Value';
        }
        field(16; "Primary Key field 2 No."; Integer)
        {
            Caption = 'Primary Key field 2 No.';
            TableRelation = Field."No." where(TableNo = field("Table No."));
        }
        field(17; "Primary Key field 2 Caption"; Text[80])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."), "No." = field("Primary Key field 2 No.")));
            Caption = 'Primary Key field 2 Caption';
            FieldClass = FlowField;
        }
        field(18; "Primary Key field 2 Value"; Text[50])
        {
            Caption = 'Primary Key field 2 Value';
        }
        field(19; "Primary Key field 3 No."; Integer)
        {
            Caption = 'Primary Key field 3 No.';
            TableRelation = Field."No." where(TableNo = field("Table No."));
        }
        field(20; "Primary Key field 3 Caption"; Text[80])
        {
            CalcFormula = lookup(Field."Field Caption" where(TableNo = field("Table No."), "No." = field("Primary Key field 3 No.")));
            Caption = 'Primary Key field 3 Caption';
            FieldClass = FlowField;
        }
        field(21; "Primary Key field 3 Value"; Text[50])
        {
            Caption = 'Primary Key field 3 Value';
        }
        field(22; "Record ID"; RecordId)
        {
            Caption = 'Record ID';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}