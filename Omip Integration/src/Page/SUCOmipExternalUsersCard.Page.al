namespace Sucasuc.Omip.User;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Utilities;
page 50197 "SUC Omip External Users Card"
{
    PageType = Card;
    UsageCategory = None;
    ApplicationArea = All;
    SourceTable = "SUC Omip External Users";
    Caption = 'Omip External Users';
    layout
    {
        area(Content)
        {
            group(General)
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
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Expiry Date field.';
                }
                field("License Type"; Rec."License Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the License Type field.';
                }
                field(Passwd; Passwd)
                {
                    Caption = 'Password';
                    ExtendedDatatype = Masked;
                    Visible = ViewPasswdField;
                    trigger OnValidate()
                    begin
                        Rec.SetPassword(Passwd);
                        Clear(Passwd);
                    end;
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

                field("Filter Status Documents"; Rec."Filter Status Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Filter Status Documents field.';
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Code field.';
                }
                field("Last Access Date"; Rec."Last Access Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Last Access Date field.';
                }
                field("Id. Commercial Plenitude"; Rec."Id. Commercial Plenitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Id. Commercial Plenitude field.';
                }
            }
            group(Commisions)
            {
                Caption = 'Commisions';
                field("Active Commisions"; Rec."Active Commisions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active Commisions field.';
                }
                field("Commercial Figures Type"; '')
                {
                    Caption = 'Commercial Figures Type';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commercial Figures Type field.';
                    Editable = Rec."Active Commisions";
                }
                field("Commercial Figure"; '')
                {
                    Caption = 'Commercial Figure';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commercial Figure field.';
                    Editable = Rec."Active Commisions";
                }
                field("Superior Officer"; '')
                {
                    Caption = 'Superior Officer';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Superior Officer field.';
                    Editable = Rec."Active Commisions";
                }
                field("View Commissions"; Rec."View Commissions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the View Commissions field.';
                }
                field("Hierarchical Level"; '')
                {
                    Caption = 'Hierarchical Level';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hierarchical Level field.';
                }
                field("Percent Commission"; '')
                {
                    Caption = 'Percent Commission';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Percent Commission field.';
                    Editable = false;
                }
                field("Percent. Commission Drag"; '')
                {
                    Caption = 'Percent. Commission Drag';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Percent. Commission Drag field.';
                    Editable = false;
                }
            }
            part(SupervisionTypes; "SUC Omip Ext User Com. Figures")
            {
                ApplicationArea = All;
                SubPageLink = "User Name" = field("User Name");
                Editable = Rec."Active Commisions";
            }
            part(GroupsFEE; "SUC Omip Ext. Users Groups FEE")
            {
                ApplicationArea = All;
                Caption = 'Groups FEE';
                SubPageLink = "User Name" = field("User Name");
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
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    SUCControlAssignGroupFEEs: Page "SUC Control Assign Group FEEs";
                    Groups: Code[250];
                begin
                    Clear(SUCControlAssignGroupFEEs);
                    if SUCControlAssignGroupFEEs.RunModal() = Action::OK then begin
                        SUCControlAssignGroupFEEs.GetDataGroups(Groups);
                        SUCOmipManagement.AssignFEEGroupsExternalUsers(Rec, Groups)
                    end;
                end;
            }
            action("SUC Set Default FEE's ")
            {
                ApplicationArea = All;
                Caption = 'Set Default FEE''s';
                ToolTip = 'Executes the Set Default FEE''s.';
                Image = ResourceLedger;
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    ConfirmLbl: Label 'The FEEs will be updated to the predefined ones, do you want to continue?';
                begin
                    if Confirm(ConfirmLbl) then
                        SUCOmipManagement.SetDefaultsFEEExternalUsers(Rec);
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
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.ValidateFEEExternalUsers(Rec, true, '');
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        if Rec.Password.HasValue then
            ViewPasswdField := false
        else
            ViewPasswdField := true;
    end;

    var
        Passwd: Text;
        ViewPasswdField: Boolean;
}