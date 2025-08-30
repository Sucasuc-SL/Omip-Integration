namespace Sucasuc.Omip.Contracts;

page 50243 "SUC Contract Modalities Card"
{
    ApplicationArea = All;
    Caption = 'Contract Modalities';
    PageType = Card;
    SourceTable = "SUC Contract Modalities";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Marketer No."; Rec."Marketer No.")
                {
                    ToolTip = 'Specifies the value of the Marketer field.';
                }
                field("Energy Type"; Rec."Energy Type")
                {
                    ToolTip = 'Specifies the value of the Energy Type field.';
                }
                field("Family Code"; Rec."Family Code")
                {
                    ToolTip = 'Specifies the value of the Family Code field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Custom Name"; Rec."Custom Name")
                {
                    ToolTip = 'Specifies the value of the Custom Name field.';
                }
                field("Reference Contract Code"; Rec."Reference Contract Code")
                {
                    ToolTip = 'Specifies the value of the Reference Contract Code field.';
                }
                field(Observations; Rec.Observations)
                {
                    ToolTip = 'Specifies the value of the Observations field.';
                }
            }
            group("Applicable Conditions")
            {
                Caption = 'Applicable Conditions';
                field("No. Contract App. Cond. Tittle"; Rec."No. Contract App. Cond. Tittle")
                {
                    ToolTip = 'Specifies the value of the No. Contract App. Conditions Tittle field.';
                    ApplicationArea = All;
                }
                field("No. Contract App. Conditions"; Rec."No. Contract App. Cond. Body")
                {
                    ToolTip = 'Specifies the value of the No. Contract App. Conditions field.';
                    ApplicationArea = All;
                }
                field(Tittle; Rec.Tittle)
                {
                    ToolTip = 'Specifies the value of the Tittle field.';
                    MultiLine = true;
                    Visible = false;
                }
                field("Tittle Complement 1"; Rec."Tittle Complement 1")
                {
                    ToolTip = 'Specifies the value of the Tittle Complement 1 field.';
                }
                field("Tittle Complement 2"; Rec."Tittle Complement 2")
                {
                    ToolTip = 'Specifies the value of the Tittle Complement 2 field.';
                }
                field("Tittle Complement 3"; Rec."Tittle Complement 3")
                {
                    ToolTip = 'Specifies the value of the Tittle Complement 3 field.';
                }
                field(BodyApplicableConditions; BodyApplicableConditions)
                {
                    ApplicationArea = All;
                    Caption = 'Body Applicable Conditions';
                    ToolTip = 'Specifies the value of the Body Applicable Conditions field.';
                    MultiLine = true;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        Rec.SetDataBlob(Rec.FieldNo("Body Applicable Conditions"), BodyApplicableConditions);
                    end;
                }
                field("Body Complement 1"; Rec."Body Complement 1")
                {
                    ToolTip = 'Specifies the value of the Body Complement 1 field.';
                }
                field("Body Complement 2"; Rec."Body Complement 2")
                {
                    ToolTip = 'Specifies the value of the Body Complement 2 field.';
                }
                field("Body Complement 3"; Rec."Body Complement 3")
                {
                    ToolTip = 'Specifies the value of the Body Complement 3 field.';
                }
                field("Body Complement 4"; Rec."Body Complement 4")
                {
                    ToolTip = 'Specifies the value of the Body Complement 4 field.';
                }
                field("Body Complement 5"; Rec."Body Complement 5")
                {
                    ToolTip = 'Specifies the value of the Body Complement 5 field.';
                }
            }
            part("SUC Modality Version Control"; "SUC Modality Version Control")
            {
                Caption = 'Modality Version Control';
                ApplicationArea = All;
                SubPageLink = "Marketer No." = field("Marketer No."),
                             "Energy Type" = field("Energy Type"),
                             "Base Modality Name" = field(Name);
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
