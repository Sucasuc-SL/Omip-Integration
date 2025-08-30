namespace Sucasuc.Omip.Contracts;
page 50216 "SUC Omip Energy Contracts Mul."
{
    UsageCategory = None;
    Caption = 'Multicups';
    PageType = ListPart;
    SourceTable = "SUC Omip Energy Contracts Mul.";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Customer CUPS"; Rec."Customer CUPS")
                {
                    ApplicationArea = All;
                    ToolTip = 'CUPS of the Customer';
                }
                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Rate No.';
                    Visible = VisibleOmipFields;
                }
                field("SUC Supply Point Address"; Rec."SUC Supply Point Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Address of the Supply Point';
                }
                field("SUC Supply Point Country"; Rec."SUC Supply Point Country")
                {
                    ApplicationArea = All;
                    ToolTip = 'Country of the Supply Point';
                }
                field("SUC Supply Point Postal Code"; Rec."SUC Supply Point Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Postal Code of the Supply Point';
                }
                field("SUC Supply Point City"; Rec."SUC Supply Point City")
                {
                    ApplicationArea = All;
                    ToolTip = 'City of the Supply Point';
                }
                field("SUC Supply Point County"; Rec."SUC Supply Point County")
                {
                    ApplicationArea = All;
                    ToolTip = 'County of the Supply Point';
                }
                field(P1; Rec.P1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P1 field.';
                }
                field(P2; Rec.P2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P2 field.';
                }
                field(P3; Rec.P3)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P3 field.';
                }
                field(P4; Rec.P4)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P4 field.';
                }
                field(P5; Rec.P5)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P5 field.';
                }
                field(P6; Rec.P6)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P6 field.';
                }
                field("Activation Date"; Rec."Activation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Activation Date';
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        ViewFields();
    end;

    trigger OnAfterGetRecord()
    begin
        ViewFields();
    end;

    var
        VisibleOmipFields: Boolean;

    local procedure ViewFields()
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    begin
        if SUCOmipEnergyContracts.Get(Rec."Contract No.") then
            case SUCOmipEnergyContracts."Product Type" of
                SUCOmipEnergyContracts."Product Type"::Omip:
                    VisibleOmipFields := true;
                else
                    VisibleOmipFields := false;
            end;
    end;
}