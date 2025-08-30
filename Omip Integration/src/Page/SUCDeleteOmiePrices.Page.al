namespace Sucasuc.Omie.Pages;
using Sucasuc.Omie.Master;

page 50270 "SUC Delete Omie Prices"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    Caption = 'Delete Omie Prices by Date Range';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Date Range';
                field(FromDate; FromDate)
                {
                    ApplicationArea = All;
                    Caption = 'From Date';
                    ToolTip = 'Specifies the start date for deletion.';
                }
                field(ToDate; ToDate)
                {
                    ApplicationArea = All;
                    Caption = 'To Date';
                    ToolTip = 'Specifies the end date for deletion.';
                }
            }
        }
    }

    actions
    {
    }

    var
        FromDate: Date;
        ToDate: Date;

    procedure GetDateRange(var StartDate: Date; var EndDate: Date): Boolean
    begin
        StartDate := FromDate;
        EndDate := ToDate;
        exit((FromDate <> 0D) and (ToDate <> 0D) and (FromDate <= ToDate));
    end;

    procedure SetDateRange(StartDate: Date; EndDate: Date)
    begin
        FromDate := StartDate;
        ToDate := EndDate;
    end;
}
