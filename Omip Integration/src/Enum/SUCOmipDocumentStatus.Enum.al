namespace Sucasuc.Omip.Documents;
/// <summary>
/// Enum SUC Omip Status Proposal (ID 50162).
/// </summary>
enum 50162 "SUC Omip Document Status"
{
    Extensible = true;

    value(0; "Pending Acceptance")
    {
        Caption = 'Pending Acceptance';
    }
    value(1; Accepted)
    {
        Caption = 'Accepted';
    }
    value(2; Rejected)
    {
        Caption = 'Rejected';
    }
    value(3; "Out of Time")
    {
        Caption = 'Out of Time';
    }
    value(4; Canceled)
    {
        Caption = 'Canceled';
    }
}