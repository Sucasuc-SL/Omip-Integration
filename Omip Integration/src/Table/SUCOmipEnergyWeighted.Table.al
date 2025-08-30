namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
/// <summary>
/// Table SUC Omip Energy Weighted (ID 50112).
/// </summary>
table 50162 "SUC Omip Energy Weighted"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Energy Weighted';
    DrillDownPageId = "SUC Omip Energy Weighted";
    LookupPageId = "SUC Omip Energy Weighted";
    ObsoleteState = Removed;
    ObsoleteReason = 'Table change by Omip "SUC Omip Energy Weighted 2"';
    ObsoleteTag = '24.36';
    fields
    {
        field(1; "Rate Code"; Code[20])
        {
            TableRelation = "SUC Omip Rates".Code;
            Caption = 'Rate Code';
        }
        field(2; Times; Enum "SUC Omip Times")
        {
            Caption = 'Time', Comment = 'ESP="Tiempo"';
        }
        field(3; P1; Decimal)
        {
            Caption = 'P1';
        }
        field(4; P2; Decimal)
        {
            Caption = 'P2';
        }
        field(5; P3; Decimal)
        {
            Caption = 'P3';
        }
        field(6; P4; Decimal)
        {
            Caption = 'P4';
        }
        field(7; P5; Decimal)
        {
            Caption = 'P5';
        }
        field(8; P6; Decimal)
        {
            Caption = 'P6';
        }
        field(9; FEE; Decimal)
        {
            Caption = 'FEE';
        }
        field(10; "FEE P1"; Decimal)
        {
            Caption = 'FEE P1';
        }
        field(11; "FEE P2"; Decimal)
        {
            Caption = 'FEE P2';
        }
        field(12; "FEE P3"; Decimal)
        {
            Caption = 'FEE P3';
        }
        field(13; "FEE P4"; Decimal)
        {
            Caption = 'FEE P4';
        }
        field(14; "FEE P5"; Decimal)
        {
            Caption = 'FEE P5';
        }
        field(15; "FEE P6"; Decimal)
        {
            Caption = 'FEE P6';
        }
    }

    keys
    {
        key(Key1; "Rate Code", Times)
        {
            Clustered = true;
        }
    }
}