namespace Sucasuc.Omip.Auditing;
using System.Diagnostics;
/// <summary>
/// Codeunit SUC Omip Change Log Management (ID 50153).
/// </summary>
codeunit 50153 "SUC Omip Change Log Management"
{
    /// <summary>
    /// InsertLogEntry.
    /// </summary>
    /// <param name="FieldRef">VAR FieldRef.</param>
    /// <param name="xFieldRef">VAR FieldRef.</param>
    /// <param name="RecordRef">VAR RecordRef.</param>
    /// <param name="TypeOfChange">Enum "Change Log Entry Type".</param>
    /// <param name="IsReadable">Boolean.</param>
    procedure InsertLogEntry(var FieldRef: FieldRef; var xFieldRef: FieldRef; var RecordRef: RecordRef; TypeOfChange: Enum "Change Log Entry Type"; IsReadable: Boolean)
    var
        SUCOmipChangeLogEntries: Record "SUC Omip Change Log Entries";
        FieldRef1: FieldRef;
        i: Integer;
        KeyRef1: KeyRef;
    begin
        SUCOmipChangeLogEntries.Init();
        SUCOmipChangeLogEntries.Validate("Date and Time", CurrentDateTime);
        SUCOmipChangeLogEntries.Validate(Time, DT2Time(SUCOmipChangeLogEntries."Date and Time"));
        SUCOmipChangeLogEntries.Validate("User ID", CopyStr(UserId(), 1, MaxStrLen(SUCOmipChangeLogEntries."User ID")));
        SUCOmipChangeLogEntries.Validate("Table No.", RecordRef.Number);
        SUCOmipChangeLogEntries.Validate("field No.", FieldRef.Number);
        SUCOmipChangeLogEntries.Validate("Type of Change", TypeOfChange);
        if TypeOfChange <> TypeOfChange::Insertion then
            if IsReadable then
                SUCOmipChangeLogEntries.Validate("Old Value", Format(xFieldRef.Value, 0, 9))
            else
                SUCOmipChangeLogEntries.Validate("Old Value", '');
        if TypeOfChange <> TypeOfChange::Deletion then
            SUCOmipChangeLogEntries.Validate("New Value", Format(FieldRef.Value, 0, 9));


        SUCOmipChangeLogEntries.Validate("Record ID", RecordRef.RecordId);
        SUCOmipChangeLogEntries.Validate("Primary Key", CopyStr(RecordRef.GetPosition(false), 1, MaxStrLen(SUCOmipChangeLogEntries."Primary Key")));

        KeyRef1 := RecordRef.KeyIndex(1);
        for i := 1 to KeyRef1.FieldCount do begin
            FieldRef1 := KeyRef1.FieldIndex(i);

            case i of
                1:
                    begin
                        SUCOmipChangeLogEntries.Validate("Primary Key field 1 No.", FieldRef1.Number);
                        SUCOmipChangeLogEntries.Validate("Primary Key field 1 Value",
                            CopyStr(Format(FieldRef1.Value, 0, 9), 1, MaxStrLen(SUCOmipChangeLogEntries."Primary Key field 1 Value")));
                    end;
                2:
                    begin
                        SUCOmipChangeLogEntries.Validate("Primary Key field 2 No.", FieldRef1.Number);
                        SUCOmipChangeLogEntries.Validate("Primary Key field 2 Value",
                            CopyStr(Format(FieldRef1.Value, 0, 9), 1, MaxStrLen(SUCOmipChangeLogEntries."Primary Key field 2 Value")));
                    end;
                3:
                    begin
                        SUCOmipChangeLogEntries.Validate("Primary Key field 3 No.", FieldRef1.Number);
                        SUCOmipChangeLogEntries.Validate("Primary Key field 3 Value",
                            CopyStr(Format(FieldRef1.Value, 0, 9), 1, MaxStrLen(SUCOmipChangeLogEntries."Primary Key field 3 Value")));
                    end;
            end;
        end;
        SUCOmipChangeLogEntries.Insert();
    end;

    /// <summary>
    /// LogInsertion.
    /// </summary>
    /// <param name="RecordRef">VAR RecordRef.</param>
    procedure LogInsertion(var RecordRef: RecordRef)
    var
        FieldRef: FieldRef;
        i: Integer;
    begin
        if RecordRef.IsTemporary then
            exit;

        for i := 1 to RecordRef.FieldCount do begin
            FieldRef := RecordRef.FieldIndex(i);
            if IsNormalField(FieldRef) then
                InsertLogEntry(FieldRef, FieldRef, RecordRef, "Change Log Entry Type"::Insertion, true);
        end;
    end;

    /// <summary>
    /// LogModification.
    /// </summary>
    /// <param name="RecordRef">VAR RecordRef.</param>
    procedure LogModification(var RecordRef: RecordRef)
    var
        xRecordRef: RecordRef;
        FieldRef: FieldRef;
        xFieldRef: FieldRef;
        IsReadable: Boolean;
        i: Integer;
    begin
        if RecordRef.IsTemporary then
            exit;

        xRecordRef.Open(RecordRef.Number, false, RecordRef.CurrentCompany());

        xRecordRef."SecurityFiltering" := SecurityFilter::Filtered;
        if xRecordRef.ReadPermission then begin
            IsReadable := true;
            if not xRecordRef.Get(RecordRef.RecordId) then
                exit;
        end;

        for i := 1 to RecordRef.FieldCount do begin
            FieldRef := RecordRef.FieldIndex(i);
            xFieldRef := xRecordRef.FieldIndex(i);
            if IsNormalField(FieldRef) then
                if Format(FieldRef.Value) <> Format(xFieldRef.Value) then
                    InsertLogEntry(FieldRef, xFieldRef, RecordRef, "Change Log Entry Type"::Modification, IsReadable);
        end;
    end;

    /// <summary>
    /// LogRename.
    /// </summary>
    /// <param name="RecordRef">VAR RecordRef.</param>
    /// <param name="xRecordRef">VAR RecordRef.</param>
    procedure LogRename(var RecordRef: RecordRef; var xRecordRef: RecordRef)
    var
        xRecordRef1: RecordRef;
        FieldRef: FieldRef;
        xFieldRef: FieldRef;
        i: Integer;
    begin
        if RecordRef.IsTemporary then
            exit;

        xRecordRef1.Open(xRecordRef.Number, false, RecordRef.CurrentCompany);
        xRecordRef1.Get(xRecordRef.RecordId);
        for i := 1 to RecordRef.FieldCount do begin
            FieldRef := RecordRef.FieldIndex(i);
            xFieldRef := xRecordRef1.FieldIndex(i);
            if IsNormalField(FieldRef) then
                if Format(FieldRef.Value) <> Format(xFieldRef.Value) then
                    InsertLogEntry(FieldRef, xFieldRef, RecordRef, "Change Log Entry Type"::Modification, true);
        end;
    end;

    /// <summary>
    /// LogDeletion.
    /// </summary>
    /// <param name="RecordRef">VAR RecordRef.</param>
    procedure LogDeletion(var RecordRef: RecordRef)
    var
        FieldRef: FieldRef;
        i: Integer;
    begin
        if RecordRef.IsTemporary then
            exit;

        for i := 1 to RecordRef.FieldCount do begin
            FieldRef := RecordRef.FieldIndex(i);
            if HasValue(FieldRef) then
                if IsNormalField(FieldRef) then
                    InsertLogEntry(FieldRef, FieldRef, RecordRef, "Change Log Entry Type"::Deletion, true);
        end;
    end;

    /// <summary>
    /// IsNormalField.
    /// </summary>
    /// <param name="FieldRef">FieldRef.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsNormalField(FieldRef: FieldRef): Boolean
    begin
        exit(FieldRef.Class = FieldClass::Normal)
    end;

    /// <summary>
    /// HasValue.
    /// </summary>
    /// <param name="FieldRef">FieldRef.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure HasValue(FieldRef: FieldRef): Boolean
    var
        HasValues: Boolean;
        D: Date;
        Dec: Decimal;
        Int: Integer;
        T: Time;
    begin
        case FieldRef.Type of
            FieldType::Boolean:
                HasValues := FieldRef.Value;
            FieldType::Option:
                HasValues := true;
            FieldType::Integer:
                begin
                    Int := FieldRef.Value;
                    HasValues := Int <> 0;
                end;
            FieldType::Decimal:
                begin
                    Dec := FieldRef.Value;
                    HasValues := Dec <> 0;
                end;
            FieldType::Date:
                begin
                    D := FieldRef.Value;
                    HasValues := D <> 0D;
                end;
            FieldType::Time:
                begin
                    T := FieldRef.Value;
                    HasValues := T <> 0T;
                end;
            FieldType::Blob:
                HasValues := false;
            else
                HasValues := Format(FieldRef.Value) <> '';
        end;

        exit(HasValues);
    end;
}