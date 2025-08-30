namespace Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Documents;

table 50192 "SUC Omip Energy Entry Contract"
{
    Caption = 'Omip Energy Entry';
    DataClassification = CustomerContent;
    LookupPageId = "SUC Omip Energy Entry Sub Cont";
    DrillDownPageId = "SUC Omip Energy Entry Sub Cont";

    fields
    {
        field(1; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
        }
        field(2; Times; Enum "SUC Omip Times")
        {
            Caption = 'Time', Comment = 'ESP="Tiempo"';

            trigger OnValidate()
            begin
                case Times of
                    Times::"12M":
                        "Times Text" := 'AÑO 01';
                    Times::"24M":
                        "Times Text" := 'AÑO 02';
                    Times::"36M":
                        "Times Text" := 'AÑO 03';
                    Times::"48M":
                        "Times Text" := 'AÑO 04';
                    Times::"60M":
                        "Times Text" := 'AÑO 05';
                end;
            end;
        }
        field(3; Type; Enum "SUC Omip Rate Entry Types")
        {
            Caption = 'Type';
        }
        field(4; P1; Decimal)
        {
            Caption = 'P1';
            DecimalPlaces = 0 : 6;
        }
        field(5; P2; Decimal)
        {
            Caption = 'P2';
            DecimalPlaces = 0 : 6;
        }
        field(6; P3; Decimal)
        {
            Caption = 'P3';
            DecimalPlaces = 0 : 6;
        }
        field(7; P4; Decimal)
        {
            Caption = 'P4';
            DecimalPlaces = 0 : 6;
        }
        field(8; P5; Decimal)
        {
            Caption = 'P5';
            DecimalPlaces = 0 : 6;
        }
        field(9; P6; Decimal)
        {
            Caption = 'P6';
            DecimalPlaces = 0 : 6;
        }
        field(10; "Times Text"; Text[50])
        {
            Caption = 'Times Text';
        }
        field(11; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            TableRelation = "SUC Omip Energy Contracts"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetContract();
            end;
        }
        field(12; "Contract Id"; Guid)
        {
            Caption = 'Contract Id';
            TableRelation = "SUC Omip Energy Contracts".SystemId;
            DataClassification = CustomerContent;
        }
        field(13; "Omip price"; Decimal)
        {
            Caption = 'Omip price';
        }
        field(14; Enabled; Boolean)
        {
            Caption = 'Enabled';
        }
        field(15; "P1 Incl. VAT"; Decimal)
        {
            Caption = 'P1 Incl. VAT';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(16; "P2 Incl. VAT"; Decimal)
        {
            Caption = 'P2 Incl. VAT';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(17; "P3 Incl. VAT"; Decimal)
        {
            Caption = 'P3 Incl. VAT';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(18; "P4 Incl. VAT"; Decimal)
        {
            Caption = 'P4 Incl. VAT';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(19; "P5 Incl. VAT"; Decimal)
        {
            Caption = 'P5 Incl. VAT';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(20; "P6 Incl. VAT"; Decimal)
        {
            Caption = 'P6 Incl. VAT';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
        field(21; Discount; Decimal)
        {
            Caption = 'Discount';
        }
    }

    keys
    {
        key(PK; "Contract No.", "Rate No.", Times, Type)
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