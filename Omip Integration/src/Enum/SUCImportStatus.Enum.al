namespace Sucasuc.Omip.Contracts;

enum 50180 "SUC Import Status"
{
    Extensible = true;
    Caption = 'Import Status';

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Success")
    {
        Caption = 'Success';
    }
    value(2; "Error")
    {
        Caption = 'Error';
    }
    value(3; "Warning")
    {
        Caption = 'Warning';
    }
}
