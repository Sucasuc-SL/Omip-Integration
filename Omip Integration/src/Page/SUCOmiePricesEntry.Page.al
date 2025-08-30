namespace Sucasuc.Omie.Pages;
using Sucasuc.Omie.Master;

page 50269 "SUC Omie Prices Entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Omie Prices Entry";
    SourceTableView = sorting("Date", "Hour") order(descending);
    Caption = 'Omie Prices Entry';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date for the marginal price.';
                }
                field("Hour"; Rec."Hour")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the hour (1-24) for the marginal price.';
                }
                field("Price"; Rec."Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the marginal price.';
                }
                field("Price 2"; Rec."Price 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the second marginal price.';
                }
                field("Import Entry No."; Rec."Import Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the import entry number.';
                }
                field("Created Date Time"; Rec."Created Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was created.';
                }
                field("Modified Date Time"; Rec."Modified Date Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the record was last modified.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DeleteByDate)
            {
                ApplicationArea = All;
                Caption = 'Delete by Date Range';
                ToolTip = 'Delete records within a specific date range.';
                Image = Delete;

                trigger OnAction()
                var
                    SUCOmiePricesEntry: Record "SUC Omie Prices Entry";
                    DeleteByDateRange: Page "SUC Delete Omie Prices";
                    StartDate: Date;
                    EndDate: Date;
                    DeleteConfirmLbl: Label 'Are you sure you want to delete all records from %1 to %2?';
                    RecordsDeletedLbl: Label '%1 records have been deleted.';
                    RecordsCount: Integer;
                begin
                    DeleteByDateRange.SetDateRange(Today - 30, Today); // Set default date range
                    if DeleteByDateRange.RunModal() = Action::OK then
                        if DeleteByDateRange.GetDateRange(StartDate, EndDate) then begin
                            if not Confirm(DeleteConfirmLbl, false, StartDate, EndDate) then
                                exit;

                            SUCOmiePricesEntry.Reset();
                            SUCOmiePricesEntry.SetRange("Date", StartDate, EndDate);
                            RecordsCount := SUCOmiePricesEntry.Count;
                            if RecordsCount > 0 then begin
                                SUCOmiePricesEntry.DeleteAll();
                                Message(RecordsDeletedLbl, RecordsCount);
                                CurrPage.Update(false);
                            end else
                                Message('No records found in the specified date range.');
                        end else
                            Error('Please specify valid From Date and To Date.');
                end;
            }
        }
    }
}
