namespace Sucasuc.Omip.Contracts;

table 50221 "SUC Condition Import Log"
{
    DataClassification = CustomerContent;
    Caption = 'Condition Import Log';
    DrillDownPageId = "SUC Condition Import Log";
    LookupPageId = "SUC Condition Import Log";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Import Date"; DateTime)
        {
            Caption = 'Import Date';
        }
        field(3; "Row No."; Integer)
        {
            Caption = 'Row No.';
        }
        field(4; "Modality Name"; Text[100])
        {
            Caption = 'Modality Name';
        }
        field(5; "Condition Code"; Code[20])
        {
            Caption = 'Condition Code';
            TableRelation = "SUC Contract App. Cond. Body"."Entry No.";
        }
        field(6; "Status"; Enum "SUC Import Status")
        {
            Caption = 'Status';
        }
        field(7; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
        }
        field(8; "Condition Text Preview"; Text[100])
        {
            Caption = 'Condition Text Preview';
        }
        field(9; "Source"; Text[20])
        {
            Caption = 'Source';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Import Date", "Status")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", "Source", "Modality Name", "Status", "Error Message")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Entry No." = 0 then
            "Entry No." := GetNextEntryNo();
    end;

    /// <summary>
    /// Gets the next available Entry No. by finding the maximum + 1
    /// </summary>
    local procedure GetNextEntryNo(): Integer
    var
        ConditionImportLog: Record "SUC Condition Import Log";
    begin
        ConditionImportLog.Reset();
        if ConditionImportLog.FindLast() then
            exit(ConditionImportLog."Entry No." + 1)
        else
            exit(1);
    end;
}
