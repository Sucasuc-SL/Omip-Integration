namespace Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Documents;

/// <summary>
/// Table SUC Omip Commision Calculation
/// </summary>
table 50159 "SUC Omip Commision Calculation"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Commision Calculation', Comment = 'ESP="Omip Calculo Comisiones"';

    fields
    {
        field(1; "Type"; Enum "SUC Omip Commision Type")
        {
            Caption = 'Time', Comment = 'ESP="Tiempo"';
        }
        field(2; P1; Decimal)
        {
            Caption = 'P1';
        }
        field(3; P2; Decimal)
        {
            Caption = 'P2';
        }
        field(4; P3; Decimal)
        {
            Caption = 'P3';
        }
        field(5; P4; Decimal)
        {
            Caption = 'P4';
        }
        field(6; P5; Decimal)
        {
            Caption = 'P5';
        }
        field(7; P6; Decimal)
        {
            Caption = 'P6';
        }
    }

    keys
    {
        key(Key1; Type)
        {
            Clustered = true;
        }
    }
}