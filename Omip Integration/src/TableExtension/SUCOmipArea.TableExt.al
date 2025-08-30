namespace Sucasuc.Omip.Masters;
using Microsoft.Finance.VAT.Setup;
using Microsoft.Inventory.Intrastat;
tableextension 50153 "SUC Omip Area" extends "Area"
{
    fields
    {
        field(50150; "SUC VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(50151; "SUC VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
    }
}