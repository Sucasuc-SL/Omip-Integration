namespace Sucasuc.Omip.Contracts;
/// <summary>
/// Enum SUC Omip Contract Status (ID 50151).
/// </summary>
enum 50151 "SUC Omip Contract Status"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Pre-Contract")
    {
        Caption = 'Pre-Contract';
    }
    value(2; Active)
    {
        Caption = 'Active';
    }
    value(3; Finished)
    {
        Caption = 'Finished';
    }
    value(4; Cutted)
    {
        Caption = 'Cutted';
    }
    value(5; "Quote Contract")
    {
        Caption = 'Quote Contract';
    }
    value(6; Canceled)
    {
        Caption = 'Canceled';
    }
}