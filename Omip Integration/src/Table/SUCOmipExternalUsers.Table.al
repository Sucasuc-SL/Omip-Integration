namespace Sucasuc.Omip.User;
using System.Security.Encryption;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Utilities;
using System.Reflection;
using Sucasuc.Omip.Setup;
using Sucasuc.Omip.Masters;
/// <summary>
/// Table SUC External Users
/// </summary>
table 50161 "SUC Omip External Users"
{
    DataClassification = CustomerContent;
    Caption = 'External Users';
    DrillDownPageId = "SUC Omip External Users";
    LookupPageId = "SUC Omip External Users";

    fields
    {
        field(1; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
        }
        field(2; "User Name"; Code[100])
        {
            Caption = 'User Name';
        }
        field(3; "Full Name"; Text[100])
        {
            Caption = 'Full Name';
        }
        field(4; State; Enum "SUC Omip Users State")
        {
            Caption = 'State';
        }
        field(5; "Expiry Date"; DateTime)
        {
            Caption = 'Expiry Date';
        }
        field(8; "Change Password"; Boolean)
        {
            Caption = 'Change Password';
        }
        field(10; "License Type"; Enum "SUC Omip Users License Type")
        {
            Caption = 'License Type';
        }
        field(11; "Authentication Email"; Text[250])
        {
            Caption = 'Authentication Email';
        }
        field(14; "Contact Email"; Text[250])
        {
            Caption = 'Contact Email';
        }
        field(15; Password; Blob)
        {
            Caption = 'Password';
        }
        field(16; "User Type"; Enum "SUC Omip User Type")
        {
            Caption = 'User Type';
            trigger OnValidate()
            begin
                Validate(Role, '');
            end;
        }
        field(17; Role; Code[20])
        {
            Caption = 'Role';
            TableRelation = if ("User Type" = const("External User")) "SUC Omip User Roles"."Role Code" where("User Type" = const("External User"))
            else if ("User Type" = const("Internal User")) "SUC Omip User Roles"."Role Code" where("User Type" = const("Internal User"))
            else if ("User Type" = const("Global User")) "SUC Omip User Roles"."Role Code";
        }
        field(18; "Marketer No."; Code[20])
        {
            Caption = 'Marketer No.';
            TableRelation = "SUC Omip Marketers"."No.";
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                SUCOmipMarketer: Record "SUC Omip Marketers";
                SUCOmipMarketers: Page "SUC Omip Marketers";
            begin
                SUCOmipMarketer.Reset();
                if SUCOmipMarketer.FindSet() then begin
                    SUCOmipMarketers.SetRecord(SUCOmipMarketer);
                    SUCOmipMarketers.SetTableView(SUCOmipMarketer);
                    SUCOmipMarketers.LookupMode(true);
                    if SUCOmipMarketers.RunModal() = Action::LookupOK then begin
                        SUCOmipMarketers.GetRecord(SUCOmipMarketer);
                        if "Marketer No." <> '' then
                            "Marketer No." += '|' + SUCOmipMarketer."No."
                        else
                            "Marketer No." := SUCOmipMarketer."No.";

                        SUCOmipManagement.ValidateFEEExternalUsersByMarketer("User Name", "Filter Marketer", "Marketer No.", true, '')
                    end;
                end;
            end;

            trigger OnValidate()
            begin
                if "Filter Marketer" then
                    SUCOmipManagement.ValidateFEEExternalUsersByMarketer("User Name", "Filter Marketer", "Marketer No.", true, '')
            end;
        }
        field(19; "Filter Status Documents"; Code[20])
        {
            Caption = 'Filter Status Documents';
        }
        field(20; "Filter Marketer"; Boolean)
        {
            Caption = 'Filter Marketer';
            trigger OnValidate()
            begin
                if not "Filter Marketer" then
                    "Marketer No." := '';

                SUCOmipManagement.ValidateFEEExternalUsersByMarketer("User Name", "Filter Marketer", "Marketer No.", true, '')
            end;
        }
        field(21; "Agent Code"; Code[10])
        {
            Caption = 'Agent Code';
        }
        field(22; "Last Access Date"; DateTime)
        {
            Caption = 'Last Access Date';
        }
        field(23; "Id. Commercial Plenitude"; Code[10])
        {
            Caption = 'Id. Commercial Plenitude';
            TableRelation = "SUC Commercials Plenitude"."Id.";
        }
        field(24; "Active Commisions"; Boolean)
        {
            Caption = 'Active Commisions';
            trigger OnValidate()
            begin
                if not "Active Commisions" then

                    // Delete all supervision types records for this user
                    DeleteSupervisionTypesRecords();
            end;
        }
        field(25; "Commercial Figures Type"; Code[20])
        {
            Caption = 'Commercial Figures Type';
            TableRelation = "SUC Commercial Figures Type"."Id.";
            ObsoleteState = Pending;
            ObsoleteReason = 'Moved to SUC Omip Ext User Com. Figures table';
            ObsoleteTag = '26.0';
            // trigger OnValidate()
            // begin
            //     TestField("Active Commisions");
            //     Validate("Commercial Figure", '');
            //     CalcFields("Hierarchical Level");

            //     // Recalculate Percent. Commission Drag when Commercial Figures Type changes
            //     if "Superior Officer" <> '' then
            //         Validate("Superior Officer");
            // end;
        }
        field(26; "Commercial Figure"; Code[20])
        {
            Caption = 'Commercial Figure';
            TableRelation = "SUC Commercial Figures"."Id." where(Type = field("Commercial Figures Type"));
            ObsoleteState = Pending;
            ObsoleteReason = 'Moved to SUC Omip Ext User Com. Figures table';
            ObsoleteTag = '26.0';
            // trigger OnValidate()
            // begin
            //     TestField("Active Commisions");
            //     CalcFields("Hierarchical Level");

            //     // Recalculate Percent. Commission Drag when Commercial Figure changes
            //     if "Superior Officer" <> '' then
            //         Validate("Superior Officer");
            // end;
        }
        field(27; "Superior Officer"; Code[100])
        {
            Caption = 'Superior Officer';
            TableRelation = "SUC Omip External Users"."User Name";
            ObsoleteState = Pending;
            ObsoleteReason = 'Moved to SUC Omip Ext User Com. Figures table';
            ObsoleteTag = '26.0';
            // trigger OnValidate()
            // var
            //     SUCOmipExternalUsers: Record "SUC Omip External Users";
            //     SUCOmipUserSupervisionTypes: Record "SUC Omip Ext User Com. Figures";
            //     SuperiorCommercialFigures: Record "SUC Commercial Figures";
            //     ErrorHierarchicalLbl: Label 'The superior officer must have a higher hierarchical level.';
            //     ErrorCannotSuperviseLbl: Label 'The superior officer cannot supervise users of commercial figure type %1.';
            // begin
            //     TestField("Active Commisions");
            //     CalcFields("Hierarchical Level");

            //     if "Superior Officer" <> '' then begin
            //         SUCOmipExternalUsers.Get("Superior Officer");

            //         // Verificar en la tabla de tipos de supervisión que el superior puede supervisar este tipo
            //         SUCOmipUserSupervisionTypes.Reset();
            //         SUCOmipUserSupervisionTypes.SetRange("User Name", "Superior Officer");
            //         SUCOmipUserSupervisionTypes.SetRange("Commercial Figures Type", "Commercial Figures Type");
            //         if SUCOmipUserSupervisionTypes.IsEmpty() then
            //             Error(ErrorCannotSuperviseLbl, "Commercial Figures Type");

            //         // Usar la figura comercial de la tabla de supervisión para validaciones
            //         SUCOmipUserSupervisionTypes.FindFirst();
            //         SuperiorCommercialFigures.Get(SUCOmipUserSupervisionTypes."Commercial Figures Type", SUCOmipUserSupervisionTypes."Commercial Figure");
            //         SuperiorCommercialFigures.TestField(Distribution);
            //         SuperiorCommercialFigures.TestField("Hierarchical Level");

            //         // Validar nivel jerárquico
            //         if SuperiorCommercialFigures."Hierarchical Level" >= "Hierarchical Level" then
            //             Error(ErrorHierarchicalLbl);
            //     end;

            //     // Calculate commission drag percentage using the centralized procedure
            //     CalculateCommissionDragPercentage();
            // end;
        }
        field(28; "View Commissions"; Boolean)
        {
            Caption = 'View Commissions';
            trigger OnValidate()
            begin
                TestField("Active Commisions");
            end;
        }
        field(29; "Hierarchical Level"; Integer)
        {
            Caption = 'Hierarchical Level';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Commercial Figures"."Hierarchical Level" where(Type = field("Commercial Figures Type"), "Id." = field("Commercial Figure")));
            ObsoleteState = Pending;
            ObsoleteReason = 'Moved to SUC Omip Ext User Com. Figures table';
            ObsoleteTag = '26.0';
        }
        field(30; "Percent. Commission Drag"; Decimal)
        {
            Caption = 'Percent. Commission Drag';
            DecimalPlaces = 0 : 6;
            Editable = false;
            ObsoleteState = Pending;
            ObsoleteReason = 'Moved to SUC Omip Ext User Com. Figures table';
            ObsoleteTag = '26.0';
        }
        field(31; "Percent Commission"; Decimal)
        {
            Caption = 'Percent Commission';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Commercial Figures".Distribution where(Type = field("Commercial Figures Type"), "Id." = field("Commercial Figure")));
            ObsoleteState = Pending;
            ObsoleteReason = 'Moved to SUC Omip Ext User Com. Figures table';
            ObsoleteTag = '26.0';
        }
    }

    keys
    {
        key(Key1; "User Name")
        {
            Clustered = true;
        }
        key(Key2; "User Security ID")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "User Name", "Full Name")
        {
        }
    }
    trigger OnInsert()
    begin
        Validate("User Security ID", CreateGuid());
    end;

    trigger OnDelete()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        ErrorProposalsLbl: Label 'User cannot be deleted because it is used in the proposals.';
        ErrorContractsLbl: Label 'User cannot be deleted because it is used in the contracts.';
    begin
        SUCOmipProposals.Reset();
        SUCOmipProposals.SetRange("Agent No.", "User Name");
        if not SUCOmipProposals.IsEmpty() then
            Error(ErrorProposalsLbl);

        SUCOmipEnergyContracts.Reset();
        SUCOmipEnergyContracts.SetRange("Agent No.", "User Name");
        if not SUCOmipEnergyContracts.IsEmpty() then
            Error(ErrorContractsLbl);

        // Delete all supervision types records for this user
        DeleteSupervisionTypesRecords();
    end;
    /// <summary>
    /// SetPassword.
    /// </summary>
    /// <param name="NewPassword">Text.</param>
    procedure SetPassword(NewPassword: Text)
    var
        CryptographyManagement: Codeunit "Cryptography Management";
        OutStream: OutStream;
        NewPassword2: Text;
    begin
        Clear(Password);
        NewPassword2 := CryptographyManagement.EncryptText(CopyStr(NewPassword, 1, 215));
        Password.CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(NewPassword2);
        Modify();
    end;
    /// <summary>
    /// GetPassword.
    /// </summary>
    /// <returns>Return variable Password of type Text.</returns>
    procedure GetPassword() Password: Text
    var
        TypeHelper: Codeunit "Type Helper";
        CryptographyManagement: Codeunit "Cryptography Management";
        InStream: InStream;
        NewPassword2: Text;
    begin
        CalcFields(Rec.Password);
        Rec.Password.CreateInStream(InStream, TextEncoding::UTF8);
        NewPassword2 := TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName(Rec.Password));
        exit(CryptographyManagement.Decrypt(NewPassword2));
    end;

    /// <summary>
    /// Calculate the commission drag percentage for the current user
    /// </summary>
    [Obsolete('Moved to SUC Omip Ext User Com. Figures table', '26.0')]
    procedure CalculateCommissionDragPercentage()
    begin
        // This procedure is obsolete. Commission calculations are now handled in the SUC Omip Ext User Com. Figures table.
    end;
    // var
    //     SUCOmipExternalUsers: Record "SUC Omip External Users";
    //     SUCOmipUserSupervisionTypes: Record "SUC Omip Ext User Com. Figures";
    //     CurrentUserCommercialFigures: Record "SUC Commercial Figures";
    //     UsersWithSameFigure: Record "SUC Omip External Users";
    //     SuperiorPercentage: Decimal;
    //     CurrentUserPercentage: Decimal;
    //     UsersCount: Integer;
    // begin
    //     // Reset the percentage
    //     "Percent. Commission Drag" := 0;

    //     if not "Active Commisions" then
    //         exit;

    //     if "Superior Officer" = '' then
    //         exit;

    //     if ("Commercial Figures Type" = '') or ("Commercial Figure" = '') then
    //         exit;

    //     // Get superior officer's commercial figure data from supervision types table
    //     if SUCOmipExternalUsers.Get("Superior Officer") then begin
    //         // Verificar en la tabla de tipos de supervisión que el superior puede supervisar este tipo
    //         SUCOmipUserSupervisionTypes.Reset();
    //         SUCOmipUserSupervisionTypes.SetRange("User Name", "Superior Officer");
    //         SUCOmipUserSupervisionTypes.SetRange("Commercial Figures Type", "Commercial Figures Type");
    //         if SUCOmipUserSupervisionTypes.FindFirst() then begin
    //             SUCOmipUserSupervisionTypes.CalcFields("Percent Commission");
    //             SuperiorPercentage := SUCOmipUserSupervisionTypes."Percent Commission";
    //         end;
    //     end;

    //     // Get current user's commercial figure distribution
    //     if CurrentUserCommercialFigures.Get("Commercial Figures Type", "Commercial Figure") then begin
    //         CurrentUserPercentage := CurrentUserCommercialFigures.Distribution;

    //         // Check if current user's commercial figure has "Distribution by Figure" enabled
    //         if CurrentUserCommercialFigures."Distribution by Figure" then begin
    //             // Count users with the same commercial figure
    //             Clear(UsersCount);
    //             UsersWithSameFigure.Reset();
    //             UsersWithSameFigure.SetRange("Active Commisions", true);
    //             UsersWithSameFigure.SetRange("Commercial Figures Type", "Commercial Figures Type");
    //             UsersWithSameFigure.SetRange("Commercial Figure", "Commercial Figure");
    //             UsersCount := UsersWithSameFigure.Count();

    //             if UsersCount > 0 then
    //                 CurrentUserPercentage := CurrentUserPercentage / UsersCount;

    //             // When Distribution by Figure is enabled, use the adjusted current user percentage
    //             "Percent. Commission Drag" := CurrentUserPercentage;

    //             // Update all other users with the same commercial figure
    //             UpdateAllUsersWithSameFigure("Commercial Figures Type", "Commercial Figure", CurrentUserPercentage);
    //         end else
    //             // When Distribution by Figure is disabled, calculate as superior minus current user
    //             "Percent. Commission Drag" := SuperiorPercentage - CurrentUserPercentage;
    //     end;
    // end;

    /// <summary>
    /// Update commission drag percentage for all users with the same commercial figure
    /// when Distribution by Figure is enabled
    /// </summary>
    [Obsolete('Moved to SUC Omip Ext User Com. Figures table', '26.0')]
    local procedure UpdateAllUsersWithSameFigure(CommercialFiguresType: Code[20]; CommercialFigure: Code[20]; NewPercentage: Decimal)
    begin
        // This procedure is obsolete. Commission calculations are now handled in the SUC Omip Ext User Com. Figures table.
    end;
    // var
    //     UsersWithSameFigure: Record "SUC Omip External Users";
    //     SUCOmipUserSupervisionTypes: Record "SUC Omip Ext User Com. Figures";
    // begin
    //     // Update in main external users table
    //     UsersWithSameFigure.Reset();
    //     UsersWithSameFigure.SetRange("Active Commisions", true);
    //     UsersWithSameFigure.SetRange("Commercial Figures Type", CommercialFiguresType);
    //     UsersWithSameFigure.SetRange("Commercial Figure", CommercialFigure);
    //     if UsersWithSameFigure.FindSet() then
    //         repeat
    //             if UsersWithSameFigure."User Name" <> "User Name" then begin // Don't update the current record
    //                 UsersWithSameFigure."Percent. Commission Drag" := NewPercentage;
    //                 UsersWithSameFigure.Modify();
    //             end;
    //         until UsersWithSameFigure.Next() = 0;

    //     // Also update in supervision types table
    //     SUCOmipUserSupervisionTypes.Reset();
    //     SUCOmipUserSupervisionTypes.SetRange("Commercial Figures Type", CommercialFiguresType);
    //     SUCOmipUserSupervisionTypes.SetRange("Commercial Figure", CommercialFigure);
    //     if SUCOmipUserSupervisionTypes.FindSet() then
    //         repeat
    //             if SUCOmipUserSupervisionTypes."User Name" <> "User Name" then begin // Don't update the current record
    //                 SUCOmipUserSupervisionTypes."Percent. Commission Drag" := NewPercentage;
    //                 SUCOmipUserSupervisionTypes.Modify();
    //             end;
    //         until SUCOmipUserSupervisionTypes.Next() = 0;
    // end;

    /// <summary>
    /// Delete all supervision types records when commissions are deactivated
    /// </summary>
    local procedure DeleteSupervisionTypesRecords()
    var
        SUCOmipUserSupervisionTypes: Record "SUC Omip Ext User Com. Figures";
    begin
        SUCOmipUserSupervisionTypes.Reset();
        SUCOmipUserSupervisionTypes.SetRange("User Name", "User Name");
        if not SUCOmipUserSupervisionTypes.IsEmpty() then
            SUCOmipUserSupervisionTypes.DeleteAll();
    end;

    var
        SUCOmipManagement: Codeunit "SUC Omip Management";
}