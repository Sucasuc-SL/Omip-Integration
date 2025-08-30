namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Utilities;
/// <summary>
/// Page SUC Omip Average Prices Cont. (ID 50158).
/// </summary>
page 50158 "SUC Omip Average Prices Cont."
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Omip Average Prices Cont.";
    Caption = 'Omip Average Prices Contract', Comment = 'ESP="Omip Precios Medios Contrato"';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Times; Rec.Times)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time field.', Comment = 'ESP="Tiempo"';
                }
                field("Type 1"; Rec."Type 1")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the M1 field.';
                }
                field("Type 2"; Rec."Type 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the M2 field.';
                }
                field("Type 3"; Rec."Type 3")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the M3 field.';
                }
                field("Type 4"; Rec."Type 4")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the M4 field.';
                }
                field("Type 5"; Rec."Type 5")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the M5 field.';
                }
                field("Type 6"; Rec."Type 6")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the M6 field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Initialize values")
            {
                ApplicationArea = All;
                Caption = 'Initialize values';
                Image = Calculate;
                ToolTip = 'Executes the Initialize values action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    ConfirmLbl: Label 'Do you want to initialize values for average prices contract?';
                begin
                    if Confirm(ConfirmLbl) then
                        SUCOmipManagement.InitializedOmipAveragePricesContract();
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
                    SUCOmipManagement.CalculateOmipAveragePricesContract();
                end;
            }
            action("Average Prices")
            {
                Caption = 'Average Prices';
                ApplicationArea = All;
                Image = PeriodStatus;
                ToolTip = 'Executes the Average Prices action.';
                trigger OnAction()
                var
                    SUCOmipAveragePrices: Page "SUC Omip Average Prices";
                begin
                    SUCOmipAveragePrices.Run();
                end;
            }
            action("Volatility Premium")
            {
                Caption = 'Volatility Premium';
                ApplicationArea = All;
                Image = Period;
                ToolTip = 'Executes the Volatility Premium action.';
                trigger OnAction()
                var
                    SUCOmipVolatilityPremium: Page "SUC Omip Volatility Premium";
                begin
                    SUCOmipVolatilityPremium.Run();
                end;
            }
        }
    }
}