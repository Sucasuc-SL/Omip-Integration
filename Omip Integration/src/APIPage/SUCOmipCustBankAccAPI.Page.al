namespace Sucasuc.Omip.API;
using Microsoft.Sales.Customer;
page 50199 "SUC Omip Cust. Bank Acc. API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipCustBankAccountLists';
    EntityName = 'sucOmipCustBankAccountList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "Customer Bank Account";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(customerNo; Rec."Customer No.") { }
                field(code; Rec.Code) { }
                field(name; Rec.Name) { }
                field(iban; Rec."IBAN") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}