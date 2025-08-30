namespace Sucasuc.Omip.Masters;
using Microsoft.Foundation.Address;
tableextension 50151 "SUC Omip Post Code" extends "Post Code"
{
    fields
    {
        field(50150; "SUC Id. Province Plenitude"; Integer)
        {
            Caption = 'Id. Province Plenitude';
            DataClassification = CustomerContent;
        }
        field(50151; "SUC Id. Locality Plenitude"; Integer)
        {
            Caption = 'Id. Locality Plenitude';
            DataClassification = CustomerContent;
        }
    }
}