namespace Sucasuc.Omip.Contracts;
page 50273 "SUC Contract App. Cond. Tittle"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Contract App. Cond. Tittle";
    CardPageId = "SUC Contract App Cond Tittle C";
    Caption = 'Contract Applicable Conditions Tittle';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(TittleApplicableConditions; TittleApplicableConditions)
                {
                    ApplicationArea = All;
                    Caption = 'Tittle Applicable Conditions';
                    ToolTip = 'Specifies the value of the Tittle Applicable Conditions field.';
                    trigger OnValidate()
                    begin
                        Rec.SetDataBlob(Rec.FieldNo("Tittle Applicable Conditions"), TittleApplicableConditions);
                    end;
                }
                field("Tittle Complement 1"; Rec."Tittle Complement 1")
                {
                    ToolTip = 'Specifies the value of the Tittle Complement 1 field.';
                    Visible = false;
                }
                field("Tittle Complement 2"; Rec."Tittle Complement 2")
                {
                    ToolTip = 'Specifies the value of the Tittle Complement 2 field.';
                    Visible = false;
                }
                field("Tittle Complement 3"; Rec."Tittle Complement 3")
                {
                    ToolTip = 'Specifies the value of the Tittle Complement 3 field.';
                    Visible = false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        TittleApplicableConditions := Rec.GetDataValueBlob(Rec.FieldNo("Tittle Applicable Conditions"));
    end;

    var
        TittleApplicableConditions: Text;
}