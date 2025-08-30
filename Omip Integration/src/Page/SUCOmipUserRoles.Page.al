namespace Sucasuc.Omip.Setup;
page 50205 "SUC Omip User Roles"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip User Roles";
    Caption = 'User Roles';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("User Type"; Rec."User Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Type field.';
                }
                field("Role Code"; Rec."Role Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Role Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}