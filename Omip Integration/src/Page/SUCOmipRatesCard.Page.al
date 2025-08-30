namespace Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC Omip Rates (ID 50154).
/// </summary>
page 50154 "SUC Omip Rates Card"
{
    Caption = 'Omip Rates';
    PageType = Document;
    UsageCategory = None;
    SourceTable = "SUC Omip Rates";
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Energy Type"; Rec."Energy Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Energy Type field.';
                }
                field("No. Potency"; Rec."No. Potency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Potency field.';
                }
                field("No. Consumption"; Rec."No. Consumption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Consumption field.';
                }
                field("Marketing Type"; Rec."Marketing Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketing Type field.';
                    Visible = false;
                }
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID field.';
                    Visible = false;
                }
                field("Green Energy"; Rec."Green Energy")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Green Energy field.';
                    Visible = false;
                }
                field("Voltage No."; Rec."Voltage No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Voltage No. field.';
                    Visible = false;
                }
                field("OMIP Indexed"; Rec."OMIP Indexed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the OMIP Indexed field.';
                    Visible = false;
                }
                field("OMIP Indexed 5"; Rec."OMIP Indexed 5")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the OMIP Indexed 5 field.';
                    Visible = false;
                }
                field("Available on Agents portal"; Rec."Available on Agents portal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Available on Agents portal field.';
                    Visible = false;
                }
                field("Available to Renew"; Rec."Available to Renew")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Available to Renew field.';
                    Visible = false;
                }
                field("Commission Plan No."; Rec."Commission Plan No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commission Plan No. field.';
                    Visible = false;
                }
                field("Valid from"; Rec."Valid from")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Valid from field.';
                    Visible = false;
                }
                field("Valid Until"; Rec."Valid Until")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Valid until field.';
                    Visible = false;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year field.';
                    Visible = false;
                }
                field("Energy Management"; Rec."Energy Management")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Energy Management field.';
                    Visible = false;
                }
                field("Fee kWh"; Rec."Rate kWh")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rate kWh field.';
                    Visible = false;
                }
                field("Conditions Text"; Rec."Conditions Text")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Conditions Text field.';
                    Visible = false;
                }
                field("Conditions Tariff"; Rec."Conditions Tariff")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Conditions Tariff field.';
                    Visible = false;
                }
                field("Conditions Tariff 2"; Rec."Conditions Tariff 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Conditions Tariff 2 field.';
                    Visible = false;
                }
                field("Id. Plenitude"; Rec."Id. Plenitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Id. Plenitude field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("SUC Omip Rate Times")
            {
                Image = Timeline;
                Caption = 'Rates Times';
                ToolTip = 'View the Rates Times List.';
                ApplicationArea = All;
                RunObject = page "SUC Omip Rates Times";
                RunPageLink = "Code Rate" = field(code);
            }
        }
    }
}