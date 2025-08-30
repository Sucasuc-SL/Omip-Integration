namespace Sucasuc.Omip.Documents;
/// <summary>
/// Enum SUC Omip Energy Origen (ID 50160).
/// </summary>
enum 50160 "SUC Omip Energy Origen"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Renewable)
    {
        Caption = 'Renewable';
    }
    value(2; "Non-Renewable")
    {
        Caption = 'Non-Renewable';
    }
}