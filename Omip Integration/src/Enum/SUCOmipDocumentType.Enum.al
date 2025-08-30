namespace Sucasuc.Omip.Documents;

/// <summary>
/// Enum SUC Omip Document Type (ID 50164).
/// </summary>
enum 50164 "SUC Omip Document Type"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Proposal)
    {
        Caption = 'Proposal';
    }
    value(2; Contract)
    {
        Caption = 'Contract';
    }
    value(3; "Proposal Preview")
    {
        Caption = 'Proposal Preview';
    }
}