namespace Sucasuc.Omip.Masters;
using Microsoft.Foundation.Address;
pageextension 50152 "SUC Omip Post Code" extends "Post Codes"
{
    layout
    {
        addlast(Control1)
        {
            field("SUC Id. Plenitude"; Rec."SUC Id. Province Plenitude")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Id. Plenitude field.';
            }
            field("SUC Id. Locality Plenitude"; Rec."SUC Id. Locality Plenitude")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Id. Locality Plenitude field.';
            }
        }
    }
}