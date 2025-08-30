namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
/// <summary>
/// Table SUC Volatility Premium (ID 50106).
/// </summary>
table 50156 "SUC Omip Volatility Premium"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Volatility Premium', Comment = 'ESP="Omip Prima Volatilidad"';
    DrillDownPageId = "SUC Omip Volatility Premium";
    LookupPageId = "SUC Omip Volatility Premium";
    fields
    {
        field(1; Times; Enum "SUC Omip Times")
        {
            Caption = 'Time', Comment = 'ESP="Tiempo"';
        }
        field(2; "Amount/MWh"; Decimal)
        {
            Caption = 'Amount / MWh', Comment = 'ESP="Importe / MWh"';
        }
    }

    keys
    {
        key(Key1; Times)
        {
            Clustered = true;
        }
    }
}