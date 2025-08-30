namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Contracts;
table 50191 "SUC Omip Power Entry Contract"
{
    Caption = 'Omip Power Entry';
    DataClassification = CustomerContent;
    LookupPageId = "SUC Omip Power Entry Sub Cont.";
    DrillDownPageId = "SUC Omip Power Entry Sub Cont.";

    fields
    {
        field(1; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
        }
        field(2; P1; Decimal)
        {
            Caption = 'P1';
            DecimalPlaces = 0 : 6;
        }
        field(3; P2; Decimal)
        {
            Caption = 'P2';
            DecimalPlaces = 0 : 6;
        }
        field(4; P3; Decimal)
        {
            Caption = 'P3';
            DecimalPlaces = 0 : 6;
        }
        field(5; P4; Decimal)
        {
            Caption = 'P4';
            DecimalPlaces = 0 : 6;
        }
        field(6; P5; Decimal)
        {
            Caption = 'P5';
            DecimalPlaces = 0 : 6;
        }
        field(7; P6; Decimal)
        {
            Caption = 'P6';
            DecimalPlaces = 0 : 6;
        }
        field(8; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            TableRelation = "SUC Omip Energy Contracts"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetContract();
            end;
        }
        field(9; "Contract Id"; Guid)
        {
            Caption = 'Contract Id';
            TableRelation = "SUC Omip Energy Contracts".SystemId;
            DataClassification = CustomerContent;
        }
        field(10; "P1 Incl. VAT"; Decimal)
        {
            Caption = 'P1 Incl. VAT';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(11; "P2 Incl. VAT"; Decimal)
        {
            Caption = 'P2 Incl. VAT';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(12; "P3 Incl. VAT"; Decimal)
        {
            Caption = 'P3 Incl. VAT';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(13; "P4 Incl. VAT"; Decimal)
        {
            Caption = 'P4 Incl. VAT';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(14; "P5 Incl. VAT"; Decimal)
        {
            Caption = 'P5 Incl. VAT';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(15; "P6 Incl. VAT"; Decimal)
        {
            Caption = 'P6 Incl. VAT';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Contract No.", "Rate No.")
        {
            Clustered = true;
        }
    }

    local procedure GetContract()
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    begin
        if SUCOmipEnergyContracts.Get("Contract No.") then
            Validate("Contract Id", SUCOmipEnergyContracts.SystemId);
    end;
}