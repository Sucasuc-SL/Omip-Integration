namespace Sucasuc.Omip.Contracts;
/// <summary>
/// Enum SUC Omip SEPA Services Type (ID 50156).
/// </summary>
enum 50156 "SUC Omip SEPA Services Type"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; CORE)
    {
        Caption = 'CORE';
    }
    value(2; B2B)
    {
        Caption = 'B2B';
    }
}