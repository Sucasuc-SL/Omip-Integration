namespace Sucasuc.Omip.Contracts;
/// <summary>
/// Enum SUC Omip Status Light Meter (ID 50152).
/// </summary>
enum 50152 "SUC Omip Status Light Meter"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Disassembled)
    {
        Caption = 'Disassembled';
    }
    value(2; Assembled)
    {
        Caption = 'Assembled';
    }
}