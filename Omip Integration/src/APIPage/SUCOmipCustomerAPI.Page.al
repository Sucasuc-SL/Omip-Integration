namespace Sucasuc.Omip.API;

using Microsoft.Sales.Customer;
/// <summary>
/// page SUC Omip Customer API (ID 50189).
/// </summary>
page 50189 "SUC Omip Customer API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipCustomers';
    EntityName = 'sucOmipCustomer';
    PageType = API;
    DelayedInsert = true;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(no; Rec."No.") { }
                field(name; Rec.Name) { }
                field(name2; Rec."Name 2") { }
                field(fullName; Rec."SUC Full Name") { }
                field(postCode; Rec."Post Code") { }
                field(city; Rec.City) { }
                field(county; Rec.County) { }
                field(countryRegionCode; Rec."Country/Region Code") { }
                field(phoneNo; Rec."Phone No.") { }
                field(mobilePhoneNo; Rec."Mobile Phone No.") { }
                field(email; Rec."E-Mail") { }
                field(vatRegistrationType; Rec."SUC VAT Registration Type") { }
                field(vatRegistrationNo; Rec."VAT Registration No.") { }
                field(paymentTermsCode; Rec."Payment Terms Code") { }
                field(address; Rec.Address) { }
                field(address2; Rec."Address 2") { }
                field(preferredBankAccountCode; Rec."Preferred Bank Account Code") { }
                field(manager; Rec."SUC Manager") { }
                field(managerVATRegNo; Rec."SUC Manager VAT Reg. No") { }
                field(managerPosition; Rec."SUC Manager Position") { }
                field(supplyPointType; Rec."SUC Customer Type") { }
                field(agentNo; Rec."Agent No.") { }
                field(agentName; Rec."Agent Name") { }
                field(duplicateState; Rec."Duplicate State") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
                part(sucomipCustBankAccount; "SUC Omip Cust. Bank Acc. API")
                {
                    EntitySetName = 'sucOmipCustBankAccountLists';
                    EntityName = 'sucOmipCustBankAccountList';
                    SubPageLink = "Customer No." = field("No.");
                }
                part(sucomipCustomerDocs; "SUC Omip Customer Docs. API")
                {
                    EntitySetName = 'sucOmipCustomerDocsLists';
                    EntityName = 'sucOmipCustomerDocsList';
                    SubPageLink = "Customer No." = field("No.");
                }
            }
        }
    }
}