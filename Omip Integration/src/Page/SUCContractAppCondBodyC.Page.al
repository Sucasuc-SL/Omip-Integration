namespace Sucasuc.Omip.Contracts;
page 50271 "SUC Contract App. Cond. Body C"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Contract App. Cond. Body";
    Caption = 'Contract Applicable Conditions Body';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                }
                field(BodyApplicableConditions; BodyApplicableConditions)
                {
                    ApplicationArea = All;
                    Caption = 'Body Applicable Conditions';
                    ToolTip = 'Specifies the value of the Body Applicable Conditions field.';
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        Rec.SetDataBlob(Rec.FieldNo("Body Applicable Conditions"), BodyApplicableConditions);
                    end;
                }
                field("Body Complement 1"; Rec."Body Complement 1")
                {
                    ToolTip = 'Specifies the value of the Body Complement 1 field.';
                    Visible = false;
                }
                field("Body Complement 2"; Rec."Body Complement 2")
                {
                    ToolTip = 'Specifies the value of the Body Complement 2 field.';
                    Visible = false;
                }
                field("Body Complement 3"; Rec."Body Complement 3")
                {
                    ToolTip = 'Specifies the value of the Body Complement 3 field.';
                    Visible = false;
                }
                field("Body Complement 4"; Rec."Body Complement 4")
                {
                    ToolTip = 'Specifies the value of the Body Complement 4 field.';
                    Visible = false;
                }
                field("Body Complement 5"; Rec."Body Complement 5")
                {
                    ToolTip = 'Specifies the value of the Body Complement 5 field.';
                    Visible = false;
                }
                field("Body Complement 6"; Rec."Body Complement 6")
                {
                    ToolTip = 'Specifies the value of the Body Complement 6 field.';
                    Visible = false;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        BodyApplicableConditions := Rec.GetDataValueBlob(Rec.FieldNo("Body Applicable Conditions"));
    end;

    var
        BodyApplicableConditions: Text;
}