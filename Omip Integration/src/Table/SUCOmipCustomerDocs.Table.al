namespace Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.User;
using Microsoft.Sales.Customer;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Proposals;
table 50208 "SUC Omip Customer Docs."
{
    DataClassification = CustomerContent;
    Caption = 'Omip Customer Docs';

    fields
    {
        field(1; "Document Type"; Enum "SUC Omip Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = if ("Document Type" = const("Proposal")) "SUC Omip Proposals"."No."
            else
            if ("Document Type" = const("Contract")) "SUC Omip Energy Contracts"."No.";
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(4; "Posting Date"; DateTime)
        {
            Caption = 'Posting Date';
        }
        field(5; Status; Enum "SUC Omip Document Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(6; "Agent No."; Code[100])
        {
            Caption = 'Agent No.';
            TableRelation = "SUC Omip External Users"."User Name";
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Customer No.", "Posting Date")
        {
            Clustered = true;
        }
        key(Key2; "Posting Date") { }
    }
}