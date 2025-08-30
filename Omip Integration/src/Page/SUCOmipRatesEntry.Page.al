namespace Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Setup;
/// <summary>
/// Page SUC Omip Rates Entry (ID 50153).
/// </summary>
page 50153 "SUC Omip Rates Entry"
{
    ApplicationArea = All;
    Caption = 'Omip Rates Entry';
    PageType = List;
    // SourceTable = "SUC Omip Rates Entry";
    UsageCategory = None;
    ModifyAllowed = false;
    InsertAllowed = false;
    ObsoleteState = Pending;
    ObsoleteReason = 'Page change by Omip "SUC Omip Rates Entry 2"';
    ObsoleteTag = '24.36';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Rate No."; '')
                {
                    ApplicationArea = All;
                    Caption = 'Rate No.';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field("Hired Potency"; '')
                {
                    ApplicationArea = All;
                    Caption = 'Hired Potency';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field("Rates Entry Premium Open Pos."; '')
                {
                    ApplicationArea = All;
                    Caption = 'Rates Entry Premium Open Pos.';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field("Omip Times"; '')
                {
                    ApplicationArea = All;
                    Caption = 'Omip Times';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }

                field(Omnie; '')
                {
                    ApplicationArea = All;
                    Caption = 'Omnie';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field("Apunt."; '')
                {
                    ApplicationArea = All;
                    Caption = 'Apunt.';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field(SSCC; '')
                {
                    ApplicationArea = All;
                    Caption = 'SSCC';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field("OS/OM"; '')
                {
                    ApplicationArea = All;
                    Caption = 'OS/OM';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field("P. Capac."; '')
                {
                    ApplicationArea = All;
                    Caption = 'P. Capac.';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field("Bono Social"; '')
                {
                    ApplicationArea = All;
                    Caption = 'Bono Social';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field(Perdidas; '')
                {
                    ApplicationArea = All;
                    Caption = 'Perdidas';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field(Desvios; '')
                {
                    ApplicationArea = All;
                    Caption = 'Desvios';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field(AFNEE; '')
                {
                    ApplicationArea = All;
                    Caption = 'AFNEE';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field(EGREEN; '')
                {
                    ApplicationArea = All;
                    Caption = 'EGREEN';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field("G. Oper."; '')
                {
                    ApplicationArea = All;
                    Caption = 'G. Oper.';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field(IM; '')
                {
                    ApplicationArea = All;
                    Caption = 'IM';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field(ATR; '')
                {
                    ApplicationArea = All;
                    Caption = 'ATR';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field(Final; '')
                {
                    ApplicationArea = All;
                    Caption = 'Final';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field("Final + ATR"; '')
                {
                    ApplicationArea = All;
                    Caption = 'Final + ATR';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
                field("Total Final"; '')
                {
                    ApplicationArea = All;
                    Caption = 'Total Final';
                    ToolTip = 'Field removed. Placeholder to avoid AS0032.';
                    StyleExpr = 'Unfavorable';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            // action("Import Excel")
            // {
            //     Caption = 'Import Excel Files';
            //     ApplicationArea = All;
            //     Image = Import;
            //     ToolTip = 'Executes the Import Excel Files action.';
            //     trigger OnAction()
            //     var
            //         // SUCOmipRatesEntry: Record "SUC Omip Rates Entry";
            //     begin
            //         // SUCOmipRatesEntry.ProcessExcel();
            //     end;
            // }
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
                    SUCOmipEnergyWeighted: Page "SUC Omip Energy Weighted";
                begin
                    SUCOmipEnergyWeighted.Run();
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
                    SUCOmipFEECorrector: Page "SUC Omip FEE Corrector";
                begin
                    SUCOmipFEECorrector.Run();
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
                    SUCOmipPowerCalculation: Page "SUC Omip Power Calculation";
                begin
                    SUCOmipPowerCalculation.Run();
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
                    SUCOmipRegulatedPricePower: Page "SUC Omip Regulated Price Power";
                begin
                    SUCOmipRegulatedPricePower.Run();
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
        }
    }
    trigger OnOpenPage()
    begin
        SUCOmipSetup.Get();
    end;

    var
        SUCOmipSetup: Record "SUC Omip Setup";
}