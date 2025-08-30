namespace Sucasuc.Omip.Contracts;
/// <summary>
/// Enum SUC Omip Channel Elect. Inv. (ID 50155)
/// </summary>
enum 50155 "SUC Omip Channel Elect. Inv."
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Document Type")
    {
        Caption = 'Document Type';
    }
    value(2; Email)
    {
        Caption = 'Email';
    }
    value(3; Phone)
    {
        Caption = 'Phone';
    }
    value(4; Site)
    {
        Caption = 'Site';
    }
    value(5; Contract)
    {
        Caption = 'Contract';
    }
}