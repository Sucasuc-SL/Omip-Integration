namespace Sucasuc.Omip.RoleCenters;

using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.User;
using Sucasuc.Omip.Masters;
using Microsoft.Sales.Customer;
using System.Email;
using Microsoft.Foundation.Task;
using System.Visualization;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Setup;

page 50176 "SUC Omip Role Center"
{
    PageType = RoleCenter;
    Caption = 'Omip Role Center';

    layout
    {
        area(RoleCenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }
            part("User Tasks Activities"; "User Tasks Activities")
            {
                ApplicationArea = Suite;
            }
            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(Sections)
        {
            group(Prices)
            {
                Caption = 'Prices';
                action("Omip Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Omip Entries';
                    Image = LedgerEntries;
                    RunObject = page "SUC Omip Entries";
                }
                action("Omip Monthly Prices")
                {
                    ApplicationArea = All;
                    Caption = 'Monthly Prices';
                    Image = PriceWorksheet;
                    RunObject = page "SUC Omip Monthly Prices";
                }
                action("Omip Rates Entry")
                {
                    ApplicationArea = All;
                    Caption = 'Rates Entry';
                    Image = EntryStatistics;
                    RunObject = page "SUC Omip Rates Entry 2";
                }
                action("Omip Average Prices Cont.")
                {
                    ApplicationArea = All;
                    Caption = 'Average Prices Cont.';
                    Image = LedgerEntries;
                    RunObject = page "SUC Omip Average Prices Cont.";
                }
                action("Omip Energy Weighted")
                {
                    ApplicationArea = All;
                    Caption = 'Energy Weighted';
                    Image = ElectronicRegister;
                    RunObject = page "SUC Omip Energy Weighted 2";
                }
                action("Omip FEE Corrector")
                {
                    ApplicationArea = All;
                    Caption = 'FEE Corrector';
                    Image = ElectronicRegister;
                    RunObject = page "SUC Omip FEE Corrector 2";
                }
                action("Omip Power Calculation")
                {
                    ApplicationArea = All;
                    Caption = 'Power Calculation';
                    Image = LedgerEntries;
                    RunObject = page "SUC Omip Power Calculation 2";
                }
                action("Omip Regulated Price Power")
                {
                    ApplicationArea = All;
                    Caption = 'Regulated Price Power';
                    Image = LedgerEntries;
                    RunObject = page "SUC Omip Reg. Price Power 2";
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                action(Proposal)
                {
                    ApplicationArea = All;
                    Caption = 'Proposals';
                    Image = OrderList;
                    RunObject = page "SUC Omip Proposals";
                }
                action(Contracts)
                {
                    ApplicationArea = All;
                    Caption = 'Contracts';
                    Image = ContractPayment;
                    RunObject = page "SUC Omip Energy Contracts List";
                }
            }
        }
        area(embedding)
        {
            action("Setup Omip")
            {
                ApplicationArea = All;
                Caption = 'Setup Omip';
                Image = Setup;
                RunObject = page "SUC Omip Setup";
            }
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action("External Users")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'External Users';
                RunObject = Page "SUC Omip External Users";
            }
        }
    }
}