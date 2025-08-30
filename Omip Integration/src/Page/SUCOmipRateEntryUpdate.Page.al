namespace Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Utilities;
page 50251 "SUC Omip Rate Entry Update"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip Rates Entry Update";
    Caption = 'Omip Rates Entry Update';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Marketer No."; Rec."Marketer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketer No. field.';
                }
                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rate No. field.';
                }
                field("Omip Times"; Rec."Omip Times")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Omip Times field.';
                }
                field(SSCC; Rec.SSCC)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the SSCC field.';
                }
                field(Detours; Rec.Detours)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Detours field.';
                }
                field(AFNEE; Rec.AFNEE)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AFNEE field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Excel")
            {
                Caption = 'Import Excel Files';
                ApplicationArea = All;
                Image = Import;
                ToolTip = 'Executes the Import Excel Files action.';
                trigger OnAction()
                var
                    SUCOmipRatesEntryUpdate: Record "SUC Omip Rates Entry Update";
                begin
                    SUCOmipRatesEntryUpdate.ProcessExcel();
                end;
            }
            action("Update Prices")
            {
                Caption = 'Update Prices';
                ApplicationArea = All;
                Image = UpdateUnitCost;
                ToolTip = 'Executes the Update Prices action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    ConfirmLbl: Label 'Would you like to update your rate analysis based on these prices?';
                begin
                    if Confirm(ConfirmLbl) then
                        SUCOmipManagement.SetPricesVarRatesEntry();
                end;
            }
        }
    }
}