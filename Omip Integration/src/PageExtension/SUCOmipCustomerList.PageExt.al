namespace Sucasuc.Omip.Masters;
using Microsoft.Sales.Customer;
/// <summary>
/// PageExtension SUC Omip Customer List (ID 50151) extends Record Customer List.
/// </summary>
pageextension 50151 "SUC Omip Customer List" extends "Customer List"
{
    actions
    {
        addlast(navigation)
        {
            action("SUC Omip CUPS")
            {
                ApplicationArea = All;
                Caption = 'Omip CUPS';
                Promoted = true;
                PromotedCategory = Category8;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = CustomerGroup;
                RunObject = page "SUC Omip Customer CUPS";
                RunPageLink = "Customer No." = field("No.");
                ToolTip = 'Executes the Omip CUPS action.';
            }
        }
    }
}