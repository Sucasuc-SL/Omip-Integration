namespace Sucasuc.Omip.Contracts;
enum 50175 "SUC Contratation Type"
{
    Extensible = true;

    value(0; "")
    {
        Caption = ' ';
    }
    value(1; Catchment)
    {
        Caption = 'Catchment';
    }
    value(2; Renewal)
    {
        Caption = 'Renewal';
    }
    value(3; Recovery)
    {
        Caption = 'Recovery';
    }
    value(4; Recapture)
    {
        Caption = 'Recapture';
    }
    value(5; "Change modality")
    {
        Caption = 'Change modality';
    }
}