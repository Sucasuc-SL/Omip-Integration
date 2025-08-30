namespace Sucasuc.Omip.Masters;
page 50244 "SUC Omip Rates Entry Setup Crd"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip Rates Entry Setup";
    Caption = 'Rates Entry Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Marketer No."; Rec."Marketer No.")
                {
                    ApplicationArea = All;
                }
                field("Marketer Name"; Rec."Marketer Name")
                {
                    ApplicationArea = All;
                }
                field("Min. FEE Potency"; Rec."Min. FEE Potency")
                {
                    ApplicationArea = All;
                }
                field("Max. FEE Potency"; Rec."Max. FEE Potency")
                {
                    ApplicationArea = All;
                }
                field("Min. FEE Energy"; Rec."Min. FEE Energy")
                {
                    ApplicationArea = All;
                }
                field("Max. FEE Energy"; Rec."Max. FEE Energy")
                {
                    ApplicationArea = All;
                }
            }
            group("Applicable Conditions")
            {
                Caption = 'Applicable Conditions';
                field("Tittle Applicable Conditions"; Rec."Tittle Applicable Conditions")
                {
                    ToolTip = 'Specifies the value of the Tittle Applicable Conditions field.';
                    MultiLine = true;
                }
                field(BodyApplicableConditions12M; BodyApplicableConditions12M)
                {
                    ApplicationArea = All;
                    Caption = 'Body Applicable Conditions 12M';
                    ToolTip = 'Specifies the value of the Body Applicable Conditions 12M field.';
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        Rec.SetDataBlob(Rec.FieldNo("Body App. Conditions 12M"), BodyApplicableConditions12M);
                    end;
                }
                field(BodyApplicableConditions12Mv2; BodyApplicableConditions12Mv2)
                {
                    ApplicationArea = All;
                    Caption = 'Body Applicable Conditions +12M';
                    ToolTip = 'Specifies the value of the Body Applicable Conditions +12M field.';
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        Rec.SetDataBlob(Rec.FieldNo("Body App. Conditions +12M"), BodyApplicableConditions12Mv2);
                    end;
                }
                field(BodyApplicableConditions12MC; BodyApplicableConditions12MC)
                {
                    ApplicationArea = All;
                    Caption = 'Body Applicable Conditions 12MC';
                    ToolTip = 'Specifies the value of the Body Applicable Conditions 12MC field.';
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        Rec.SetDataBlob(Rec.FieldNo("Body App. Conditions 12MC"), BodyApplicableConditions12MC);
                    end;
                }
                field(BodyApplicableConditions12MCv2; BodyApplicableConditions12MCv2)
                {
                    ApplicationArea = All;
                    Caption = 'Body Applicable Conditions +12MC';
                    ToolTip = 'Specifies the value of the Body Applicable Conditions +12MC field.';
                    MultiLine = true;
                    trigger OnValidate()
                    begin
                        Rec.SetDataBlob(Rec.FieldNo("Body App. Conditions +12MC"), BodyApplicableConditions12MCv2);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        BodyApplicableConditions12M := Rec.GetDataValueBlob(Rec.FieldNo("Body App. Conditions 12M"));
        BodyApplicableConditions12Mv2 := Rec.GetDataValueBlob(Rec.FieldNo("Body App. Conditions +12M"));
        BodyApplicableConditions12MC := Rec.GetDataValueBlob(Rec.FieldNo("Body App. Conditions 12MC"));
        BodyApplicableConditions12MCv2 := Rec.GetDataValueBlob(Rec.FieldNo("Body App. Conditions +12MC"));
    end;

    var
        BodyApplicableConditions12M: Text;
        BodyApplicableConditions12Mv2: Text;
        BodyApplicableConditions12MC: Text;
        BodyApplicableConditions12MCv2: Text;
}