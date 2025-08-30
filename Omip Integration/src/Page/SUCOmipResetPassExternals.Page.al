namespace Sucasuc.Omip.User;
page 50198 "SUC Omip Reset Pass. Externals"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Reset Password';
    layout
    {
        area(Content)
        {
            group(Options)
            {
                Caption = 'Update password';
                field(UserID; UserID)
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                    Editable = false;
                }
                field(UserName; UserName)
                {
                    ApplicationArea = All;
                    Caption = 'User name';
                    Editable = false;
                }
                field(NewPassword; NewPassword)
                {
                    ApplicationArea = All;
                    Caption = 'New password';
                    ShowMandatory = true;
                    ExtendedDatatype = Masked;
                }
                field(ConfirmPassword; ConfirmPassword)
                {
                    ApplicationArea = All;
                    Caption = 'Confirm password';
                    ShowMandatory = true;
                    ExtendedDatatype = Masked;
                }
            }
        }
    }
    /// <summary>
    /// SetData.
    /// </summary>
    /// <param name="UserIDIn">Guid.</param>
    /// <param name="UserNameIn">Text[50].</param>
    procedure SetData(UserIDIn: Guid; UserNameIn: Text[100])
    begin
        UserID := UserIDIn;
        UserName := UserNameIn;
    end;
    /// <summary>
    /// GetData.
    /// </summary>
    /// <param name="NewPasswordOut">VAR Text.</param>
    /// <param name="ConfirmPasswordOut">VAR Text.</param>
    procedure GetData(var NewPasswordOut: Text; var ConfirmPasswordOut: Text)
    begin
        NewPasswordOut := NewPassword;
        ConfirmPasswordOut := ConfirmPassword;
    end;

    var
        UserID: Guid;
        UserName: Text[100];
        NewPassword: Text;
        ConfirmPassword: Text;
}