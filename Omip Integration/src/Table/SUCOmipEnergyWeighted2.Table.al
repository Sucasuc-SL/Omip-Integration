namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
/// <summary>
/// Table SUC Omip Energy Weighted (ID 50112).
/// </summary>
table 50183 "SUC Omip Energy Weighted 2"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Energy Weighted';
    DrillDownPageId = "SUC Omip Energy Weighted 2";
    LookupPageId = "SUC Omip Energy Weighted 2";

    fields
    {
        field(1; "Marketer No."; Code[20])
        {
            Caption = 'Marketer No.';
            TableRelation = "SUC Omip Marketers"."No.";
        }
        field(2; "Rate Code"; Code[20])
        {
            TableRelation = "SUC Omip Rates".Code;
            Caption = 'Rate Code';
        }
        field(3; Times; Enum "SUC Omip Times")
        {
            Caption = 'Time', Comment = 'ESP="Tiempo"';
        }
        field(4; P1; Decimal)
        {
            Caption = 'P1';
            ObsoleteState = Pending;
            ObsoleteReason = 'Not use anymore';
            ObsoleteTag = '25.4';
        }
        field(5; P2; Decimal)
        {
            Caption = 'P2';
            ObsoleteState = Pending;
            ObsoleteReason = 'Not use anymore';
            ObsoleteTag = '25.4';
        }
        field(6; P3; Decimal)
        {
            Caption = 'P3';
            ObsoleteState = Pending;
            ObsoleteReason = 'Not use anymore';
            ObsoleteTag = '25.4';
        }
        field(7; P4; Decimal)
        {
            Caption = 'P4';
            ObsoleteState = Pending;
            ObsoleteReason = 'Not use anymore';
            ObsoleteTag = '25.4';
        }
        field(8; P5; Decimal)
        {
            Caption = 'P5';
            ObsoleteState = Pending;
            ObsoleteReason = 'Not use anymore';
            ObsoleteTag = '25.4';
        }
        field(9; P6; Decimal)
        {
            Caption = 'P6';
            ObsoleteState = Pending;
            ObsoleteReason = 'Not use anymore';
            ObsoleteTag = '25.4';
        }
        field(10; FEE; Decimal)
        {
            Caption = 'FEE';
        }
        field(11; "FEE P1"; Decimal)
        {
            Caption = 'FEE P1';
        }
        field(12; "FEE P2"; Decimal)
        {
            Caption = 'FEE P2';
        }
        field(13; "FEE P3"; Decimal)
        {
            Caption = 'FEE P3';
        }
        field(14; "FEE P4"; Decimal)
        {
            Caption = 'FEE P4';
        }
        field(15; "FEE P5"; Decimal)
        {
            Caption = 'FEE P5';
        }
        field(16; "FEE P6"; Decimal)
        {
            Caption = 'FEE P6';
        }
    }

    keys
    {
        key(Key1; "Marketer No.", "Rate Code", Times)
        {
            Clustered = true;
        }
    }
}