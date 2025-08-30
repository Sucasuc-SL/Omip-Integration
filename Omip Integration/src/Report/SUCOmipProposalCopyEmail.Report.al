namespace Sucasuc.Omip.Proposals;
using Microsoft.Sales.Customer;
report 50153 "SUC Omip Proposal Copy Email"
{
    ApplicationArea = All;
    UsageCategory = None;
    Caption = 'Proposal Copy Email';
    DefaultLayout = Word;
    WordLayout = './src/Report/Layouts/Common/SUCOmipProposalCopyEmail.docx';

    dataset
    {
        dataitem("SUC Omip Proposals"; "SUC Omip Proposals")
        {
            column(No_; "No.")
            { }
            column(Date_Proposal; Format("Date Proposal", 0, '<Day> de <Month Text> de <Year4>'))
            { }
            column(Customer_No_; "Customer No.")
            { }
            column(Customer_Name; "Customer Name")
            { }
            column(Customer_CUPS; "Customer CUPS")
            { }
            column(Customer_Phone_No_; "Customer Phone No.")
            { }
            column(Customer_VAT_Registration_No_; "Customer VAT Registration No.")
            { }
            column(CustomerMobile_Phone_No_; Customer."Mobile Phone No.")
            { }
            trigger OnAfterGetRecord()
            begin
                Customer.Get("Customer No.");
            end;
        }
    }
    var
        Customer: Record Customer;
}