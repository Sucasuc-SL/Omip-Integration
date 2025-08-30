namespace Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Masters;
using Sucasuc.Energy.Ledger;

table 50250 "SUC Modality Version Control"
{
    DataClassification = CustomerContent;
    Caption = 'Modality Version Control';
    DrillDownPageId = "SUC Modality Version Control";
    LookupPageId = "SUC Modality Version Control";

    fields
    {
        field(1; "Marketer No."; Code[20])
        {
            Caption = 'Marketer No.';
            TableRelation = "SUC Omip Marketers"."No.";
            DataClassification = CustomerContent;
        }
        field(2; "Energy Type"; Enum "SUC Energy Type")
        {
            Caption = 'Energy Type';
            DataClassification = CustomerContent;
        }
        field(3; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
            DataClassification = CustomerContent;
        }
        field(4; "Base Modality Name"; Text[100])
        {
            Caption = 'Base Modality Name';
            DataClassification = CustomerContent;
        }
        field(5; "Version Code"; Code[10])
        {
            Caption = 'Version Code';
            DataClassification = CustomerContent;
        }
        field(6; "Full Modality Name"; Text[100])
        {
            Caption = 'Full Modality Name';
            DataClassification = CustomerContent;
        }
        field(7; "Version Number"; Integer)
        {
            Caption = 'Version Number';
            DataClassification = CustomerContent;
        }
        field(8; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Is Active"; Boolean)
        {
            Caption = 'Is Active';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateControlPricesStatus();
            end;
        }
        field(10; "Last Modified Date"; Date)
        {
            Caption = 'Last Modified Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
        }
        field(12; "Imported File Name"; Text[250])
        {
            Caption = 'Imported File Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; Quarter; Code[10])
        {
            Caption = 'Quarter';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Marketer No.", "Energy Type", "Rate No.", "Base Modality Name", "Version Code", Quarter)
        {
            Clustered = true;
        }
        key(Key2; "Full Modality Name") { }
        key(Key3; "Marketer No.", "Energy Type", "Rate No.", "Base Modality Name", "Version Number", Quarter) { }
        key(Key4; "Is Active") { }
        key(Key5; Quarter) { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Marketer No.", "Energy Type", "Rate No.", "Base Modality Name", "Version Code", Quarter, "Is Active") { }
    }

    trigger OnInsert()
    begin
        if "Creation Date" = 0D then
            "Creation Date" := Today();
        "Last Modified Date" := Today();
        "Modified By" := CopyStr(UserId(), 1, 50);
    end;

    trigger OnModify()
    begin
        "Last Modified Date" := Today();
        "Modified By" := CopyStr(UserId(), 1, 50);
    end;

    trigger OnDelete()
    var
        ControlPricesEnergy: Record "SUC Control Prices Energy";
    begin
        // Count related control prices records
        ControlPricesEnergy.Reset();
        ControlPricesEnergy.SetRange("Marketer No.", "Marketer No.");
        ControlPricesEnergy.SetRange("Energy Type", "Energy Type");
        ControlPricesEnergy.SetRange("Rate No.", "Rate No.");
        ControlPricesEnergy.SetRange(Modality, "Base Modality Name");
        ControlPricesEnergy.SetRange(Version, "Version Code");
        // Note: Assuming Quarter field exists in Control Prices Energy table, if not, remove this line
        // ControlPricesEnergy.SetRange(Quarter, Quarter);

        // Delete all related control prices records
        if ControlPricesEnergy.FindSet() then
            ControlPricesEnergy.DeleteAll();
    end;

    /// <summary>
    /// Extracts version and quarter information from a full modality name
    /// </summary>
    /// <param name="FullModalityName">The complete modality name with version and quarter</param>
    /// <param name="BaseModalityName">Returns the base name without version and quarter</param>
    /// <param name="VersionCode">Returns the version code (e.g., "V4")</param>
    /// <param name="VersionNumber">Returns the numeric version</param>
    /// <param name="QuarterCode">Returns the quarter code (e.g., "2T")</param>
    procedure ExtractVersionInfo(FullModalityName: Text[100]; var BaseModalityName: Text[100]; var VersionCode: Code[10]; var VersionNumber: Integer; var QuarterCode: Code[10]): Boolean
    var
        TempText: Text;
        i: Integer;
        BestVersionPos: Integer;
        BestVersionCode: Code[10];
        BestQuarterPos: Integer;
        BestQuarterCode: Code[10];
    begin
        BaseModalityName := FullModalityName;
        VersionCode := '';
        VersionNumber := 0;
        QuarterCode := '';
        BestVersionPos := 0;
        BestQuarterPos := 0;

        // Look for version pattern "V" followed by a number and quarter pattern "T" preceded by a number
        TempText := UpperCase(FullModalityName);

        // Search for all possible version patterns and choose the best one
        for i := 1 to StrLen(TempText) - 1 do begin
            if TempText[i] = 'V' then
                // Check if this V is followed by numbers
                if IsValidVersionPattern(TempText, i) then
                    // This is a valid version pattern, but we want the rightmost one (latest position)
                    if i > BestVersionPos then begin
                        BestVersionPos := i;
                        BestVersionCode := ExtractVersionCodeFromPosition(FullModalityName, i);
                    end;

            // Look for quarter pattern: digit followed by T
            if TempText[i] = 'T' then
                if IsValidQuarterPattern(TempText, i) then
                    if i > BestQuarterPos then begin
                        BestQuarterPos := i;
                        BestQuarterCode := ExtractQuarterCodeFromPosition(FullModalityName, i);
                    end;
        end;

        // Extract base name by removing both version and quarter
        BaseModalityName := ExtractBaseModalityName(FullModalityName, BestVersionPos, BestVersionCode, BestQuarterPos, BestQuarterCode);

        // Set version information
        if BestVersionPos > 0 then begin
            VersionCode := BestVersionCode;
            VersionNumber := ExtractNumericVersion(VersionCode);
        end;

        // Set quarter information
        if BestQuarterPos > 0 then
            QuarterCode := BestQuarterCode;

        exit((BestVersionPos > 0) or (BestQuarterPos > 0));
    end;

    local procedure ExtractVersionCodeFromPosition(TextValidate: Text; Position: Integer): Code[10]
    var
        i: Integer;
        VersionCode: Text;
    begin
        VersionCode := 'V';

        // Extract the V and the numbers following it
        for i := Position + 1 to StrLen(TextValidate) do
            if TextValidate[i] in ['0' .. '9'] then
                VersionCode := VersionCode + Format(TextValidate[i])
            else
                break; // Stop at first non-digit character

        exit(CopyStr(VersionCode, 1, 10));
    end;

    local procedure ExtractQuarterCodeFromPosition(TextValidate: Text; Position: Integer): Code[10]
    var
        i: Integer;
        QuarterCode: Text;
    begin
        QuarterCode := '';

        // Extract the digit before T and the T
        for i := Position - 1 downto 1 do
            if TextValidate[i] in ['0' .. '9'] then
                QuarterCode := Format(TextValidate[i]) + QuarterCode
            else
                break; // Stop at first non-digit character

        QuarterCode := QuarterCode + 'T';

        exit(CopyStr(QuarterCode, 1, 10));
    end;

    local procedure ExtractBaseModalityName(FullModalityName: Text[100]; VersionPos: Integer; VersionCode: Code[10]; QuarterPos: Integer; QuarterCode: Code[10]): Text[100]
    var
        BaseModality: Text;
        TempText: Text;
    begin
        TempText := FullModalityName;

        // Remove version code if present
        if (VersionPos > 0) and (VersionCode <> '') then
            TempText := DelStr(TempText, VersionPos, StrLen(VersionCode));

        // Remove quarter code if present (need to recalculate position after version removal)
        if (QuarterPos > 0) and (QuarterCode <> '') then begin
            // If quarter was after version, adjust position
            if QuarterPos > VersionPos then
                QuarterPos := QuarterPos - StrLen(VersionCode);

            // Calculate the start position of the quarter code (including the digit before T)
            TempText := DelStr(TempText, QuarterPos - StrLen(QuarterCode) + 1, StrLen(QuarterCode));
        end;

        BaseModality := TempText;

        // Clean up multiple spaces and trim
        BaseModality := DelChr(BaseModality, '<>', ' '); // Trim leading/trailing spaces

        // Replace multiple consecutive spaces with single space
        while StrPos(BaseModality, '  ') > 0 do
            BaseModality := DelStr(BaseModality, StrPos(BaseModality, '  '), 1);

        exit(CopyStr(BaseModality, 1, 100));
    end;

    local procedure IsValidVersionPattern(TextValidate: Text; Position: Integer): Boolean
    var
        i: Integer;
        HasNumber: Boolean;
        PrevChar: Char;
    begin
        if Position >= StrLen(TextValidate) then
            exit(false);

        // Check if there's at least one digit after V
        HasNumber := false;
        for i := Position + 1 to StrLen(TextValidate) do
            if TextValidate[i] in ['0' .. '9'] then
                HasNumber := true
            else
                break; // Stop at first non-digit

        if not HasNumber then
            exit(false);

        // Additional validation: check context
        // The V should be either:
        // 1. At the beginning of the string
        // 2. Preceded by a space or other delimiter
        // 3. Part of a version pattern like " V1 ", " V2", etc.

        if Position = 1 then
            exit(true); // V at the beginning is valid

        if Position > 1 then begin
            PrevChar := TextValidate[Position - 1];
            // V should be preceded by space, dash, or other non-letter character for it to be a version
            if PrevChar in [' ', '-', '(', '[', '_'] then
                exit(true);
        end;

        exit(false);
    end;

    local procedure IsValidQuarterPattern(TextValidate: Text; Position: Integer): Boolean
    var
        PrevChar: Char;
        NextChar: Char;
    begin
        // Position should be the position of 'T'
        if Position <= 1 then
            exit(false);

        if Position > StrLen(TextValidate) then
            exit(false);

        // Check if there's a digit before T
        PrevChar := TextValidate[Position - 1];
        if not (PrevChar in ['1' .. '4']) then // Only quarters 1-4 are valid
            exit(false);

        // Additional validation: check context
        // The digit+T should be either:
        // 1. At the end of the string
        // 2. Followed by a space or other delimiter
        // 3. Part of a quarter pattern like "1T ", "2T", etc.

        if Position = StrLen(TextValidate) then
            exit(true); // T at the end is valid

        if Position < StrLen(TextValidate) then begin
            NextChar := TextValidate[Position + 1];
            // T should be followed by space, dash, or other non-letter character for it to be a quarter
            if NextChar in [' ', '-', ')', ']', '_'] then
                exit(true);
        end;

        exit(false);
    end;

    local procedure ExtractNumericVersion(VersionCode: Code[10]): Integer
    var
        NumericPart: Text;
        i: Integer;
        ResultInt: Integer;
    begin
        NumericPart := '';

        // Skip the 'V' and extract only digits
        for i := 2 to StrLen(VersionCode) do
            if VersionCode[i] in ['0' .. '9'] then
                NumericPart := NumericPart + Format(VersionCode[i])
            else
                break;

        if Evaluate(ResultInt, NumericPart) then
            exit(ResultInt);

        exit(0);
    end;

    /// <summary>
    /// Creates or updates a modality version control record
    /// </summary>
    /// <param name="MarketerNo">Marketer number</param>
    /// <param name="EnergyType">Energy type</param>
    /// <param name="RateNo">Rate number for tariff-based version control</param>
    /// <param name="FullModalityName">Complete modality name with version and quarter</param>
    /// <param name="ImportedFileName">Name of the imported file</param>
    /// <returns>The version control record</returns>
    procedure CreateOrUpdateVersion(MarketerNo: Code[20]; EnergyType: Enum "SUC Energy Type"; RateNo: Code[20]; FullModalityName: Text[100]; ImportedFileName: Text[250]): Record "SUC Modality Version Control"
    var
        ModalityVersionControl: Record "SUC Modality Version Control";
        BaseModalityName: Text[100];
        VersionCode: Code[10];
        VersionNumber: Integer;
        QuarterCode: Code[10];
    begin
        if not ExtractVersionInfo(FullModalityName, BaseModalityName, VersionCode, VersionNumber, QuarterCode) then begin
            // If no version or quarter found, treat the entire name as base name
            BaseModalityName := FullModalityName;
            VersionCode := '';
            VersionNumber := 0;
            QuarterCode := '';
        end;

        // Check if this exact version already exists
        ModalityVersionControl.Reset();
        ModalityVersionControl.SetRange("Marketer No.", MarketerNo);
        ModalityVersionControl.SetRange("Energy Type", EnergyType);
        ModalityVersionControl.SetRange("Rate No.", RateNo);
        ModalityVersionControl.SetRange("Base Modality Name", BaseModalityName);
        ModalityVersionControl.SetRange("Version Code", VersionCode);
        ModalityVersionControl.SetRange(Quarter, QuarterCode);

        if not ModalityVersionControl.FindFirst() then begin
            // Create new version control record
            ModalityVersionControl.Init();
            ModalityVersionControl."Marketer No." := MarketerNo;
            ModalityVersionControl."Energy Type" := EnergyType;
            ModalityVersionControl."Rate No." := RateNo;
            ModalityVersionControl."Base Modality Name" := BaseModalityName;
            ModalityVersionControl."Version Code" := VersionCode;
            ModalityVersionControl.Quarter := QuarterCode;
            ModalityVersionControl."Full Modality Name" := FullModalityName;
            ModalityVersionControl."Version Number" := VersionNumber;
            ModalityVersionControl."Creation Date" := Today();
            ModalityVersionControl."Imported File Name" := ImportedFileName;
            ModalityVersionControl."Is Active" := true; // New versions are active by default
            ModalityVersionControl.Insert(true);
        end else
            // Update existing record with file name if it's not already set
            if ModalityVersionControl."Imported File Name" = '' then begin
                ModalityVersionControl."Imported File Name" := ImportedFileName;
                ModalityVersionControl.Modify();
            end;

        exit(ModalityVersionControl);
    end;

    /// <summary>
    /// Updates the active status of all control prices records for this specific version
    /// </summary>
    local procedure UpdateControlPricesStatus()
    var
        ControlPricesEnergy: Record "SUC Control Prices Energy";
    begin
        ControlPricesEnergy.Reset();
        ControlPricesEnergy.SetRange("Marketer No.", "Marketer No.");
        ControlPricesEnergy.SetRange("Energy Type", "Energy Type");
        ControlPricesEnergy.SetRange("Rate No.", "Rate No.");
        ControlPricesEnergy.SetRange(Modality, "Base Modality Name"); // Use base modality name, not full
        ControlPricesEnergy.SetRange(Version, "Version Code"); // Filter by specific version
        ControlPricesEnergy.ModifyAll(Active, "Is Active");
    end;

    /// <summary>
    /// Activates a specific version and optionally deactivates others for the same base modality
    /// </summary>
    /// <param name="DeactivateOthers">If true, deactivates all other versions of the same base modality</param>
    procedure ActivateVersion(DeactivateOthers: Boolean)
    var
        OtherVersions: Record "SUC Modality Version Control";
        ControlPricesEnergy: Record "SUC Control Prices Energy";
    begin
        if DeactivateOthers then begin
            // Deactivate all other versions of the same base modality
            OtherVersions.Reset();
            OtherVersions.SetRange("Marketer No.", "Marketer No.");
            OtherVersions.SetRange("Energy Type", "Energy Type");
            OtherVersions.SetRange("Rate No.", "Rate No.");
            OtherVersions.SetRange("Base Modality Name", "Base Modality Name");
            OtherVersions.SetFilter("Version Code", '<>%1', "Version Code");
            if OtherVersions.FindSet() then
                repeat
                    OtherVersions."Is Active" := false;
                    OtherVersions.Modify();

                    // Update related control prices records for this specific version to inactive
                    ControlPricesEnergy.Reset();
                    ControlPricesEnergy.SetRange("Marketer No.", OtherVersions."Marketer No.");
                    ControlPricesEnergy.SetRange("Energy Type", OtherVersions."Energy Type");
                    ControlPricesEnergy.SetRange("Rate No.", OtherVersions."Rate No.");
                    ControlPricesEnergy.SetRange(Modality, OtherVersions."Base Modality Name");
                    ControlPricesEnergy.SetRange(Version, OtherVersions."Version Code");
                    if ControlPricesEnergy.FindSet() then
                        repeat
                            ControlPricesEnergy.Active := false;
                            ControlPricesEnergy.Modify();
                        until ControlPricesEnergy.Next() = 0;
                until OtherVersions.Next() = 0;
        end;

        // Activate this version
        "Is Active" := true;
        Modify();

        // Update related control prices records for this specific version to active
        ControlPricesEnergy.Reset();
        ControlPricesEnergy.SetRange("Marketer No.", "Marketer No.");
        ControlPricesEnergy.SetRange("Energy Type", "Energy Type");
        ControlPricesEnergy.SetRange("Rate No.", "Rate No.");
        ControlPricesEnergy.SetRange(Modality, "Base Modality Name");
        ControlPricesEnergy.SetRange(Version, "Version Code");
        if ControlPricesEnergy.FindSet() then
            repeat
                ControlPricesEnergy.Active := true;
                ControlPricesEnergy.Modify();
            until ControlPricesEnergy.Next() = 0;
    end;

    /// <summary>
    /// Deactivates this version and updates related control prices records
    /// </summary>
    procedure DeactivateVersion()
    var
        ControlPricesEnergy: Record "SUC Control Prices Energy";
    begin
        "Is Active" := false;
        Modify();

        // Update related control prices records for this specific version to inactive
        ControlPricesEnergy.Reset();
        ControlPricesEnergy.SetRange("Marketer No.", "Marketer No.");
        ControlPricesEnergy.SetRange("Energy Type", "Energy Type");
        ControlPricesEnergy.SetRange("Rate No.", "Rate No.");
        ControlPricesEnergy.SetRange(Modality, "Base Modality Name");
        ControlPricesEnergy.SetRange(Version, "Version Code");
        if ControlPricesEnergy.FindSet() then
            repeat
                ControlPricesEnergy.Active := false;
                ControlPricesEnergy.Modify();
            until ControlPricesEnergy.Next() = 0;
    end;
}
