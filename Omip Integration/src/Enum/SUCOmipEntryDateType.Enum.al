namespace Sucasuc.Omip.Ledger;
/// <summary>
/// Enum SUC Omip Entry Date Type (ID 50159).
/// </summary>
enum 50159 "SUC Omip Entry Date Type"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Month)
    {
        Caption = 'Month';
    }
    value(2; Quarter)
    {
        Caption = 'Quarter';
    }
    value(3; Year)
    {
        Caption = 'Year';
    }
}