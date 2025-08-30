namespace Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Utilities;
/// <summary>
/// Page SUC Omip Entries (ID 50151).
/// </summary>
page 50151 "SUC Omip Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Omip Entry";
    Caption = 'Omip Entries';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date field.';
                }
                field(Instrument; Rec.Instrument)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Instrument field.';
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price field.';
                }
                field("Date Type"; Rec."Date Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Type field.';
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Value field.';
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Year field.';
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
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Import;
                ToolTip = 'Executes the Import Excel Files action.';
                trigger OnAction()
                var
                    SUCOmipImportFromExcel: Codeunit "SUC Omip Import From Excel";
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    ProcessPriceDate: Date;
                    FromFile: Text;
                    InStream: InStream;
                begin
                    UploadIntoStream('Import Excel', '', '', FromFile, InStream);
                    ProcessPriceDate := SUCOmipImportFromExcel.ExcelProcessImport(FromFile, InStream);

                    if ProcessPriceDate = CalcDate('<CM>', ProcessPriceDate) then
                        ProcessPriceDate := CalcDate('<+1D>', ProcessPriceDate);

                    ProcessPriceDate := CalcDate('<-CM+2M>', ProcessPriceDate);
                    SUCOmipManagement.ProcessNewPricesOmipBatch(ProcessPriceDate);
                end;
            }
        }
    }
}