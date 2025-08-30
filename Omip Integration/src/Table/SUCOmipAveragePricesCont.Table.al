namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
/// <summary>
/// Table SUC Omip Average Prices Cont. (ID 50158).
/// </summary>
table 50158 "SUC Omip Average Prices Cont."
{
    DataClassification = CustomerContent;
    Caption = 'Omip Average Prices Contract', Comment = 'ESP="Omip Precios Medios Contrato"';
    DrillDownPageId = "SUC Omip Average Prices Cont.";
    LookupPageId = "SUC Omip Average Prices Cont.";

    fields
    {
        field(1; Times; Enum "SUC Omip Times")
        {
            Caption = 'Time';
        }
        field(2; "Type 1"; Decimal)
        {
            Caption = 'M1';
            DecimalPlaces = 0 : 6;
        }
        field(3; "Type 2"; Decimal)
        {
            Caption = 'M2';
            DecimalPlaces = 0 : 6;
        }
        field(4; "Type 3"; Decimal)
        {
            Caption = 'M3';
            DecimalPlaces = 0 : 6;
        }
        field(5; "Type 4"; Decimal)
        {
            Caption = 'M4';
            DecimalPlaces = 0 : 6;
        }
        field(6; "Type 5"; Decimal)
        {
            Caption = 'M5';
            DecimalPlaces = 0 : 6;
        }
        field(7; "Type 6"; Decimal)
        {
            Caption = 'M6';
            DecimalPlaces = 0 : 6;
        }
    }

    keys
    {
        key(Key1; Times)
        {
            Clustered = true;
        }
    }
}