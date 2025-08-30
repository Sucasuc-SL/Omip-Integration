namespace Sucasuc.Omip.Masters;
using Microsoft.Foundation.Address;
using Sucasuc.Omip.Utilities;
pageextension 50153 "SUC Omip Countries Regions" extends "Countries/Regions"
{
    layout
    {
        addlast(Control1)
        {
            field("SUC Id. Country Plenitude"; Rec."SUC Id. Country Plenitude")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Id. Country Plenitude field.';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action("Get Countries Plenitude")
            {
                Caption = 'Get Countries Plenitude';
                ApplicationArea = All;
                ToolTip = 'Get Countries Plenitude';
                Image = GetEntries;
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.GetCountriesPlenitude();
                end;
            }
        }
    }
}