namespace Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Setup;
/// <summary>
/// Page SUC Omip Rates Entry (ID 50210).
/// </summary>
page 50210 "SUC Omip Rates Entry 2"
{
    ApplicationArea = All;
    Caption = 'Omip Rates Entry';
    PageType = List;
    SourceTable = "SUC Omip Rates Entry 2";
    UsageCategory = Lists;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Marketer No."; Rec."Marketer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketer No. field.';
                }

                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rate No. field.';
                }
                field("Hired Potency"; Rec."Hired Potency")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Hired Potency field.';
                }
                field("Omip Times"; Rec."Omip Times")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Times field.';
                }
                field(Omnie; Rec.Omip)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Omie field.';
                }
                field("Rates Entry Premium Open Pos."; Rec."Rates Entry Premium Open Pos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rates Entry Premium Open Pos. field.';
                }
                field("Apunt."; Rec.Apuntament)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Apunt. field.';
                }
                field(SSCC; Rec.SSCC)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SSCC field.';
                }
                field("OS/OM"; Rec."OS/OM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the OS/OM field.';
                }
                field("P. Capac."; Rec."Price Capacity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the P. Capac. field.';
                }
                field("Bono Social"; Rec."Social Bonus")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bono Social field.';
                }
                field(Perdidas; Rec.Losses)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Perdidas field.';
                }
                field(Desvios; Rec.Detours)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Desvios field.';
                }
                field(AFNEE; Rec.AFNEE)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AFNEE field.';
                }
                field(EGREEN; Rec.EGREEN)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EGREEN field.';
                }
                field("G. Oper."; Rec."Operating Expenses")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the G. Oper. field.';
                }
                field(IM; Rec.IM)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IM field.';
                }
                field(ATR; Rec.ATR)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ATR field.';
                }
                field(Final; Rec.Final)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final field.';
                }
                field("Final + ATR"; Rec."Final + ATR")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final + ATR field.';
                }
                field("Total Final"; Rec."Total Final")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Final field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Excel")
            {
                Caption = 'Import Excel Files';
                ApplicationArea = All;
                Image = Import;
                ToolTip = 'Executes the Import Excel Files action.';
                trigger OnAction()
                var
                    SUCOmipRatesEntry2: Record "SUC Omip Rates Entry 2";
                begin
                    SUCOmipRatesEntry2.ProcessExcel();
                end;
            }
            action("Monthly Prices")
            {
                Caption = 'Monthly Prices';
                ApplicationArea = All;
                Image = PriceWorksheet;
                ToolTip = 'Executes the Monthly Prices action.';
                trigger OnAction()
                var
                    SUCOmipMonthlyPrices: Page "SUC Omip Monthly Prices";
                begin
                    SUCOmipMonthlyPrices.Run();
                end;
            }
            action("Average Prices Contract")
            {
                Caption = 'Average Prices Contract';
                ApplicationArea = All;
                Image = PeriodEntries;
                ToolTip = 'Executes the Average Prices Contract action.';
                trigger OnAction()
                var
                    SUCOmipAveragePricesCont: Page "SUC Omip Average Prices Cont.";
                begin
                    SUCOmipAveragePricesCont.Run();
                end;
            }
            action("Energy Weighted")
            {
                ApplicationArea = All;
                Caption = 'Energy Weighted';
                Image = InsertStartingFee;
                ToolTip = 'Executes the Energy Weighted action.';
                trigger OnAction()
                var
                    SUCOmipEnergyWeighted2: Page "SUC Omip Energy Weighted 2";
                begin
                    SUCOmipEnergyWeighted2.Run();
                end;
            }
            action("FEE Corrector")
            {
                ApplicationArea = All;
                Caption = 'FEE Corrector';
                Image = InsertStartingFee;
                ToolTip = 'Executes the FEE Corrector action.';
                trigger OnAction()
                var
                    SUCOmipFEECorrector2: Page "SUC Omip FEE Corrector 2";
                begin
                    SUCOmipFEECorrector2.Run();
                end;
            }
            action("Power Calculation")
            {
                ApplicationArea = All;
                Caption = 'Power Calculation';
                Image = CalculateSimulation;
                ToolTip = 'Executes the Power Calculation action.';
                trigger OnAction()
                var
                    SUCOmipPowerCalculation2: Page "SUC Omip Power Calculation 2";
                begin
                    SUCOmipPowerCalculation2.Run();
                end;
            }
            action("Regulated Price Power")
            {
                ApplicationArea = All;
                Caption = 'Regulated Price Power';
                Image = Price;
                ToolTip = 'Executes the Regulated Price Power action.';
                trigger OnAction()
                var
                    SUCOmipRegPricePower2: Page "SUC Omip Reg. Price Power 2";
                begin
                    SUCOmipRegPricePower2.Run();
                end;
            }
            action(Calculate)
            {
                ApplicationArea = All;
                Caption = 'Calculate';
                Image = PostedOrder;
                ToolTip = 'Executes the Calculate action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.GetDataOmipRatesEntry();
                end;
            }
            action("Update Prices Variables")
            {
                Caption = 'Update Prices Variables';
                ApplicationArea = All;
                Image = Import;
                ToolTip = 'Executes the Update Prices Variables action.';
                RunObject = page "SUC Omip Rate Entry Update";
            }
        }
    }
    trigger OnOpenPage()
    begin
        SUCOmipSetup.Get();
    end;

    var
        SUCOmipSetup: Record "SUC Omip Setup";
}