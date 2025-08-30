namespace Sucasuc.Omip.Masters;
using Microsoft.Sales.Customer;
using Sucasuc.Omip.Ledger;
/// <summary>
/// PageExtension SUC Omip Customer Card (ID 50150) extends Record Customer Card.
/// </summary>
pageextension 50150 "SUC Omip Customer Card" extends "Customer Card"
{
    layout
    {
        addlast("Address & Contact")
        {
            group("SUC Omip App")
            {
                Caption = 'Omip';
                field("Agent No."; Rec."Agent No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent No. field.';
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Name field.';
                }
                field("SUC Customer Type"; Rec."SUC Customer Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("SUC Manager"; Rec."SUC Manager")
                {
                    ApplicationArea = All;
                    ToolTip = 'Manager of the Customer';
                }
                field("SUC Manager VAT Reg. No"; Rec."SUC Manager VAT Reg. No")
                {
                    ApplicationArea = All;
                    ToolTip = 'VAT Registration No. of the Manager';
                }
                field("SUC Manager Position"; Rec."SUC Manager Position")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manager position field.';
                }
                field("Duplicate State"; Rec."Duplicate State")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duplicate State field.';
                }
                field("Customer Type Plenitude"; Rec."Customer Type Plenitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Type Plenitude field.';
                }
            }
        }
        addbefore("VAT Registration No.")
        {
            field("SUC VAT Registration Type"; Rec."SUC VAT Registration Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Type field.';
            }
        }
        addafter("Address & Contact")
        {
            part("SUC Omip Customer Docs."; "SUC Omip Customer Docs.")
            {
                ApplicationArea = All;
                SubPageLink = "Customer No." = field("No.");
            }
        }
    }
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