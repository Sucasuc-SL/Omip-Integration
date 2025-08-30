namespace Sucasuc.Omip.Documents;
/// <summary>
/// Enum SUC Omip Acceptance Method (ID 50163).
/// </summary>
enum 50163 "SUC Omip Acceptance Method"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; SMS)
    {
        Caption = 'SMS';
    }
    value(2; Email)
    {
        Caption = 'Email';
    }
    value(3; Paper)
    {
        Caption = 'Paper';
    }
}