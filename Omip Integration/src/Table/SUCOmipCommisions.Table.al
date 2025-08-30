namespace Sucasuc.Omip.Masters;

/// <summary>
/// Table SUC Omip Commisions (ID 50110).
/// </summary>
table 50160 "SUC Omip Commisions"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Commisions', Comment = 'ESP="Omip Comisiones"';

    fields
    {
        field(1; Distribution; Code[20])
        {
            Caption = 'Distribution', Comment = 'ESP="Reparto"';
        }
        field(2; Percent; Decimal)
        {
            Caption = 'Percent', Comment = 'ESP="Porcentaje"';
        }
        field(3; Amount; Decimal)
        {
            Caption = 'Amount', Comment = 'ESP="Importe"';
        }
    }

    keys
    {
        key(Key1; Distribution)
        {
            Clustered = true;
        }
    }
}