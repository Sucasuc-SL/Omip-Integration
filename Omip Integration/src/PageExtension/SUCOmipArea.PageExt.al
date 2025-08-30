namespace Sucasuc.Omip.Masters;
using Microsoft.Inventory.Intrastat;
pageextension 50154 "SUC Omip Area" extends Areas
{
    layout
    {
        addlast(Control1)
        {
            field("SUC VAT Bus. Posting Group"; Rec."SUC VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Business Posting Group field.';
            }
            field("SUC VAT Prod. Posting Group"; Rec."SUC VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Product Posting Group field.';
            }
        }
    }
}