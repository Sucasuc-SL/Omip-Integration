namespace Sucasuc.Omip.Masters;
using System.Utilities;

/// <summary>
/// Page SUC Omip Monthly Price History (ID 50282).
/// </summary>
page 50281 "SUC Omip Monthly Price History"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Omip Monthly Price Hist";
    SourceTableView = sorting("Posting Date") order(descending);
    Caption = 'Omip Monthly Prices History';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting date of the monthly price record.';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the year of the price record.';
                }
                field(Month; Rec.Month)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the month of the price record.';
                }
                field("Ref. Trim"; Rec."Ref. Trim")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quarter reference (Q1, Q2, Q3, Q4).';
                }
                field("Ref. Month"; Rec."Ref. Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the month-year reference.';
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price for this period.';
                    DecimalPlaces = 2 : 6;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Monthly Prices")
            {
                ApplicationArea = All;
                Caption = 'Current Monthly Prices';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Navigate to the current monthly prices page.';
                trigger OnAction()
                var
                    SUCOmipMonthlyPrices: Record "SUC Omip Monthly Prices";
                    SUCOmipMonthlyPricesPage: Page "SUC Omip Monthly Prices";
                begin
                    SUCOmipMonthlyPrices.Reset();
                    if SUCOmipMonthlyPrices.FindSet() then begin
                        SUCOmipMonthlyPricesPage.SetTableView(SUCOmipMonthlyPrices);
                        SUCOmipMonthlyPricesPage.Run();
                    end;
                end;
            }
        }
    }
}
