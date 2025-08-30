namespace Sucasuc.Omip.Utilities;
/// <summary>
/// Page SUC Omip Av. Prices Calculate (ID 50161).
/// </summary>
page 50161 "SUC Omip Av. Prices Calculate"
{
    PageType = StandardDialog;
    Caption = 'Average Prices Calculate';
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(DateToCalculate; DateToCalculate)
                {
                    ApplicationArea = All;
                    Caption = 'Date to calculate';
                    ToolTip = 'Specify a date to calculate average prices for predetermined periods.';
                    ShowMandatory = true;
                }
            }
        }
    }

    var
        DateToCalculate: Date;

    /// <summary>
    /// GetDateToCalculate.
    /// </summary>
    /// <returns>Return value of type Date.</returns>
    procedure GetDateToCalculate(): Date
    var
        ErrorLbl: Label 'You must assign a valid date to calculate.';
    begin
        if DateToCalculate <> 0D then
            exit(DateToCalculate)
        else
            Error(ErrorLbl);
    end;
}