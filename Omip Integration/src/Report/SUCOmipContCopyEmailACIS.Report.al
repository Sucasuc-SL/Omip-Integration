namespace Sucasuc.Omip.Contract;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Proposals;
using Microsoft.Sales.Customer;
report 50164 "SUC Omip Cont. Copy Email ACIS"
{
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Proposal Copy Email';
    DefaultLayout = Word;
    WordLayout = './src/Report/Layouts/Common/SUCOmipContractCopyEmailACIS.docx';

    dataset
    {
        dataitem("SUC Omip Energy Contracts"; "SUC Omip Energy Contracts")
        {
            column(No_; "No.") { }
            column(Date_Created; Format("Date Created", 0, '<Day> de <Month Text> de <Year4>')) { }
            column(Customer_No_; "Customer No.") { }
            column(Customer_Name; "Customer Name") { }
            column(Customer_CUPS; CustomerCUPS) { }
            column(Customer_Phone_No_; Customer."Phone No.") { }
            column(Customer_VAT_Registration_No_; Customer."VAT Registration No.") { }
            column(CustomerMobile_Phone_No_; Customer."Mobile Phone No.") { }
            trigger OnAfterGetRecord()
            var
                SUCOmipProposals: Record "SUC Omip Proposals";
            begin
                Clear(CustomerCUPS);
                Customer.Get("Customer No.");
                if SUCOmipProposals.Get("Proposal No.") then
                    CustomerCUPS := SUCOmipProposals."Customer CUPS";
            end;
        }
    }
    var
        Customer: Record Customer;
        CustomerCUPS: Text[25];
}