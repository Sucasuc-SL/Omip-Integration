namespace Sucasuc.Omip.Masters;
/// <summary>
/// Page SUC Omip Rates List (ID 50164).
/// </summary>
page 50164 "SUC Omip Rates List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Omip Rates";
    Caption = 'Omip Rates';
    CardPageId = "SUC Omip Rates Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Rates)
            {
                field(Code; Rec.Code)
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
                field("Fee kWh"; Rec."Rate kWh")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rate kWh field.';
                    Visible = false;
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