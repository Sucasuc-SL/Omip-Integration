namespace Sucasuc.Omip.User;
using Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Setup;
using Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC External Users
/// </summary>
page 50162 "SUC Omip External Users"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Omip External Users";
    Caption = 'Omip External Users';
    CardPageId = "SUC Omip External Users Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Users)
            {
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Full Name field.';
                }
                field("Contact Email"; Rec."Contact Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contact Email field.';
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the State field.';
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Code field.';
                }
                field("User Type"; Rec."User Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Type field.';
                }
                field("Filter Marketer"; Rec."Filter Marketer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Filter Marketer field.';
                }
                field("Marketer No."; Rec."Marketer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketer No. field.';
                }
                field("Active Commisions"; Rec."Active Commisions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active Commisions field.';
                }
                field("Commercial Figures Type"; '')
                {
                    Caption = 'Commercial Figures Type';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commercial Figures Type field.';
                    Editable = Rec."Active Commisions";
                    Visible = false;
                }
                field("Commercial Figure"; '')
                {
                    Caption = 'Commercial Figure';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commercial Figure field.';
                    Editable = Rec."Active Commisions";
                    Visible = false;
                }
                field("Superior Officer"; '')
                {
                    Caption = 'Superior Officer';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Superior Officer field.';
                    Editable = Rec."Active Commisions";
                    Visible = false;
                }
                field("Percent Commission"; 0)
                {
                    Caption = 'Percent Commission';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Percent Commission field.';
                    Editable = Rec."Active Commisions";
                    Visible = false;
                }
                field("Percent. Commission Drag"; '')
                {
                    Caption = 'Percent. Commission Drag';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the commission drag percentage calculated.';
                    Visible = false;
                }
                field("Last Access Date"; Rec."Last Access Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Access Date field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Reset Password")
            {
                ApplicationArea = All;
                Caption = 'Reset Password';
                Image = ResetStatus;
                ToolTip = 'Executes the Reset Password action.';
                trigger OnAction()
                var
                    SUCOmipResetPassExternals: Page "SUC Omip Reset Pass. Externals";
                    NewPassword: Text;
                    NewConfirmPassword: Text;
                    ErrorPasswordLbl: Label 'Passwords must match.';
                begin
                    Clear(SUCOmipResetPassExternals);
                    SUCOmipResetPassExternals.SetData(Rec."User Security ID", Rec."Full Name");
                    if SUCOmipResetPassExternals.RunModal() = Action::OK then begin
                        SUCOmipResetPassExternals.GetData(NewPassword, NewConfirmPassword);
                        if NewPassword = NewConfirmPassword then
                            Rec.SetPassword(NewPassword)
                        else
                            Error(ErrorPasswordLbl);
                    end;
                end;
            }
            action("Import Users")
            {
                ApplicationArea = All;
                Caption = 'Import Users';
                Image = Import;
                ToolTip = 'Executes the Import Users action.';
                trigger OnAction()
                var
                    SUCOmipImportFromExcel: Codeunit "SUC Omip Import From Excel";
                    FromFile: Text;
                    InStream: InStream;
                begin
                    UploadIntoStream('Import Excel', '', '', FromFile, InStream);
                    SUCOmipImportFromExcel.ExcelUsersProcessImport(FromFile, InStream);
                end;
            }
            action("User Roles")
            {
                ApplicationArea = All;
                Caption = 'User Roles';
                Image = ResourceLedger;
                RunObject = page "SUC Omip User Roles";
            }
            action("SUC External Users Log")
            {
                ApplicationArea = All;
                Caption = 'Log';
                Image = Track;
                RunObject = page "SUC Omip External Users Log";
                RunPageLink = "User Name" = field("User Name");
                RunPageView = sorting("User Name", "Line No.") order(descending);
                ToolTip = 'Executes the External Users Log.';
            }
            action("SUC Assign Group FEEs")
            {
                ApplicationArea = All;
                Caption = 'Assign Group FEEs';
                ToolTip = 'Executes the Assign Group FEEs.';
                Image = Default;
                trigger OnAction()
                var
                    SUCOmipExternalUsers: Record "SUC Omip External Users";
                    SUCOmipExternalUsers2: Record "SUC Omip External Users";
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    SUCControlAssignGroupFEEs: Page "SUC Control Assign Group FEEs";
                    RecordRef: RecordRef;
                    NoRows: Integer;
                    Groups: Code[250];
                begin
                    Clear(SUCControlAssignGroupFEEs);
                    if SUCControlAssignGroupFEEs.RunModal() = Action::OK then begin
                        SUCControlAssignGroupFEEs.GetDataGroups(Groups);
                        CurrPage.SetSelectionFilter(SUCOmipExternalUsers);
                        SUCOmipExternalUsers.Next();
                        NoRows := SUCOmipExternalUsers.Count;

                        if NoRows = 1 then
                            SUCOmipManagement.AssignFEEGroupsExternalUsers(Rec, Groups)
                        else begin
                            RecordRef.GetTable(SUCOmipExternalUsers);
                            RecordRef.SetTable(SUCOmipExternalUsers2);
                            if SUCOmipExternalUsers2.FindSet() then
                                repeat
                                    SUCOmipManagement.AssignFEEGroupsExternalUsers(SUCOmipExternalUsers2, Groups);
                                until SUCOmipExternalUsers2.Next() = 0;
                        end;
                    end;
                end;
            }
            // action("SUC Delete Group FEEs")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Delete Group FEEs';
            //     ToolTip = 'Executes the Delete Group FEEs.';
            //     Image = Default;
            //     trigger OnAction()
            //     var
            //         SUCOmipExtUsersGroupsFEE: Record "SUC Omip Ext. Users Groups FEE";
            //         SUCOmipFEEPowerAgent: Record "SUC Omip FEE Power Agent";
            //         SUCOmipFEEEnergyAgent: Record "SUC Omip FEE Energy Agent";
            //     begin
            //         SUCOmipExtUsersGroupsFEE.Reset();
            //         if SUCOmipExtUsersGroupsFEE.FindSet() then
            //             repeat
            //                 SUCOmipExtUsersGroupsFEE.Delete();
            //             until SUCOmipExtUsersGroupsFEE.Next() = 0;
            //         SUCOmipFEEPowerAgent.Reset();
            //         if SUCOmipFEEPowerAgent.FindSet() then
            //             repeat
            //                 SUCOmipFEEPowerAgent.Delete();
            //             until SUCOmipFEEPowerAgent.Next() = 0;

            //         SUCOmipFEEEnergyAgent.Reset();
            //         if SUCOmipFEEEnergyAgent.FindSet() then
            //             repeat
            //                 SUCOmipFEEEnergyAgent.Delete();
            //             until SUCOmipFEEEnergyAgent.Next() = 0;
            //     end;
            // }
            action("SUC Set Default FEE's ")
            {
                ApplicationArea = All;
                Caption = 'Set Default FEE''s';
                ToolTip = 'Executes the Set Default FEE''s.';
                Image = ResourceLedger;
                trigger OnAction()
                var
                    SUCOmipExternalUsers: Record "SUC Omip External Users";
                    SUCOmipExternalUsers2: Record "SUC Omip External Users";
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    RecordRef: RecordRef;
                    NoRows: Integer;
                    ConfirmLbl: Label 'The FEEs will be updated to the predefined ones, do you want to continue?';
                begin
                    if Confirm(ConfirmLbl) then begin
                        CurrPage.SetSelectionFilter(SUCOmipExternalUsers);
                        SUCOmipExternalUsers.Next();
                        NoRows := SUCOmipExternalUsers.Count;

                        if NoRows = 1 then
                            SUCOmipManagement.SetDefaultsFEEExternalUsers(Rec)
                        else begin
                            RecordRef.GetTable(SUCOmipExternalUsers);
                            RecordRef.SetTable(SUCOmipExternalUsers2);
                            if SUCOmipExternalUsers2.FindSet() then
                                repeat
                                    SUCOmipManagement.SetDefaultsFEEExternalUsers(SUCOmipExternalUsers2);
                                until SUCOmipExternalUsers2.Next() = 0;
                        end;
                    end;
                end;
            }
            action("SUC Validate FEE's")
            {
                ApplicationArea = All;
                Caption = 'Validate FEE''s';
                ToolTip = 'Executes the validation FEE''s.';
                Image = ResourceLedger;
                trigger OnAction()
                var
                    SUCOmipExternalUsers: Record "SUC Omip External Users";
                    SUCOmipExternalUsers2: Record "SUC Omip External Users";
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    RecordRef: RecordRef;
                    NoRows: Integer;
                begin
                    CurrPage.SetSelectionFilter(SUCOmipExternalUsers);
                    SUCOmipExternalUsers.Next();
                    NoRows := SUCOmipExternalUsers.Count;

                    if NoRows = 1 then
                        SUCOmipManagement.ValidateFEEExternalUsers(Rec, true, '')
                    else begin
                        RecordRef.GetTable(SUCOmipExternalUsers);
                        RecordRef.SetTable(SUCOmipExternalUsers2);
                        if SUCOmipExternalUsers2.FindSet() then
                            repeat
                                SUCOmipManagement.ValidateFEEExternalUsers(SUCOmipExternalUsers2, true, '');
                            until SUCOmipExternalUsers2.Next() = 0;
                    end;
                end;
            }
            action("Update Total Period")
            {
                ApplicationArea = All;
                Caption = 'Update Total Period';
                Image = Import;
                ToolTip = 'Executes the Update Total Period action.';
                trigger OnAction()
                var
                    SUCOmipFEEEnergyAgent: Record "SUC Omip FEE Energy Agent";
                begin
                    SUCOmipFEEEnergyAgent.Reset();
                    if SUCOmipFEEEnergyAgent.FindSet() then
                        repeat
                            SUCOmipFEEEnergyAgent.Validate(P1);
                            SUCOmipFEEEnergyAgent.Modify();
                        until SUCOmipFEEEnergyAgent.Next() = 0;
                end;
            }
            action("Calculate Commission Drag")
            {
                ApplicationArea = All;
                Caption = 'Calculate Commission Drag %';
                Image = Calculate;
                ToolTip = 'Calculate the commission drag percentage for selected users.';
                trigger OnAction()
                var
                    SUCOmipExternalUsers: Record "SUC Omip External Users";
                    SUCOmipExternalUsers2: Record "SUC Omip External Users";
                    SUCOmipUserSupervTypes: Record "SUC Omip Ext User Com. Figures";
                    RecordRef: RecordRef;
                    NoRows: Integer;
                    ProcessedUsers: Integer;
                    ConfirmLbl: Label 'This will calculate the commission drag percentage for all selected users. Do you want to continue?';
                    CompletedLbl: Label 'Commission drag percentage calculated for %1 user(s).';
                begin
                    if not Confirm(ConfirmLbl) then
                        exit;

                    CurrPage.SetSelectionFilter(SUCOmipExternalUsers);
                    NoRows := SUCOmipExternalUsers.Count;

                    if NoRows = 0 then
                        exit;

                    Clear(ProcessedUsers);

                    if NoRows = 1 then begin
                        // Calculate for all commercial figures of the selected user
                        SUCOmipUserSupervTypes.Reset();
                        SUCOmipUserSupervTypes.SetRange("User Name", Rec."User Name");
                        if SUCOmipUserSupervTypes.FindSet() then
                            repeat
                                SUCOmipUserSupervTypes.CalculateCommissionDragPercentage();
                            until SUCOmipUserSupervTypes.Next() = 0;
                        ProcessedUsers := 1;
                    end else begin
                        RecordRef.GetTable(SUCOmipExternalUsers);
                        RecordRef.SetTable(SUCOmipExternalUsers2);
                        if SUCOmipExternalUsers2.FindSet() then
                            repeat
                                // Calculate for all commercial figures of each selected user
                                SUCOmipUserSupervTypes.Reset();
                                SUCOmipUserSupervTypes.SetRange("User Name", SUCOmipExternalUsers2."User Name");
                                if SUCOmipUserSupervTypes.FindSet() then
                                    repeat
                                        SUCOmipUserSupervTypes.CalculateCommissionDragPercentage();
                                    until SUCOmipUserSupervTypes.Next() = 0;
                                ProcessedUsers += 1;
                            until SUCOmipExternalUsers2.Next() = 0;
                    end;

                    Message(CompletedLbl, ProcessedUsers);
                    CurrPage.Update(false);
                end;
            }
            action("Migrate to Supervision Types")
            {
                ApplicationArea = All;
                Caption = 'Migrate to Supervision Types';
                Image = MoveUp;
                ToolTip = 'Migrate selected users with commissions to supervision types table respecting hierarchy.';
                trigger OnAction()
                var
                    SUCOmipExternalUsers: Record "SUC Omip External Users";
                    SUCOmipExternalUsers2: Record "SUC Omip External Users";
                    RecordRef: RecordRef;
                    NoRows: Integer;
                    ProcessedUsers: Integer;
                    ConfirmLbl: Label 'This will migrate the selected users with active commissions to the supervision types table respecting the hierarchy. Do you want to continue?';
                    CompletedLbl: Label 'Migration completed. %1 user(s) processed.';
                begin
                    if not Confirm(ConfirmLbl) then
                        exit;

                    CurrPage.SetSelectionFilter(SUCOmipExternalUsers);
                    NoRows := SUCOmipExternalUsers.Count;

                    if NoRows = 0 then
                        exit;

                    Clear(ProcessedUsers);

                    if NoRows = 1 then
                        ProcessedUsers := MigrateUserToSupervisionTypes(Rec)
                    else begin
                        RecordRef.GetTable(SUCOmipExternalUsers);
                        RecordRef.SetTable(SUCOmipExternalUsers2);
                        if SUCOmipExternalUsers2.FindSet() then
                            repeat
                                ProcessedUsers += MigrateUserToSupervisionTypes(SUCOmipExternalUsers2);
                            until SUCOmipExternalUsers2.Next() = 0;
                    end;

                    Message(CompletedLbl, ProcessedUsers);
                    CurrPage.Update(false);
                end;
            }
            action("Commercial Figures Users")
            {
                ApplicationArea = All;
                Caption = 'Commercial Figures Users';
                Image = SetupList;
                RunObject = page "SUC Omip Ext User Com Fig List";
                ToolTip = 'Open the external user commercial figures list.';
            }
            /*action("Show User Password")
            {
                ApplicationArea = All;
                Caption = 'Show User Password';
                Image = Import;
                ToolTip = 'Executes the Show User Password action.';
                trigger OnAction()
                var
                begin
                    Message(Rec.GetPassword());
                end;
            }*/
        }
    }

    /// <summary>
    /// Migrate a single external user to supervision types table
    /// </summary>
    local procedure MigrateUserToSupervisionTypes(UserToMigrate: Record "SUC Omip External Users"): Integer
    var
        SUCOmipUserSupervTypes: Record "SUC Omip Ext User Com. Figures";
    begin
        // Validate that user has the required data
        if not UserToMigrate."Active Commisions" then
            exit(0);

        if (UserToMigrate."Commercial Figures Type" = '') or (UserToMigrate."Commercial Figure" = '') then
            exit(0);

        // Check if record already exists in supervision types table
        SUCOmipUserSupervTypes.Reset();
        SUCOmipUserSupervTypes.SetRange("User Name", UserToMigrate."User Name");
        SUCOmipUserSupervTypes.SetRange("Commercial Figures Type", UserToMigrate."Commercial Figures Type");

        if SUCOmipUserSupervTypes.IsEmpty() then begin
            // Create new record in supervision types table
            SUCOmipUserSupervTypes.Init();
            SUCOmipUserSupervTypes."User Name" := UserToMigrate."User Name";
            SUCOmipUserSupervTypes.Validate("Commercial Figures Type", UserToMigrate."Commercial Figures Type");
            SUCOmipUserSupervTypes.Validate("Commercial Figure", UserToMigrate."Commercial Figure");
            SUCOmipUserSupervTypes.Validate("Superior Officer", UserToMigrate."Superior Officer");
            SUCOmipUserSupervTypes.Insert(true);
            exit(1);
        end;

        exit(0);
    end;
}