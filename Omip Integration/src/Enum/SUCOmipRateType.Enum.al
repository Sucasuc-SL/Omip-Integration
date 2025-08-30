namespace Sucasuc.Omip.Contracts;
/// <summary>
/// Enum SUC Omip Rate Type (ID 50153).
/// </summary>
enum 50153 "SUC Omip Rate Type"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Normal)
    {
        Caption = 'Normal';
    }
    value(2; Social)
    {
        Caption = 'Social';
    }
}