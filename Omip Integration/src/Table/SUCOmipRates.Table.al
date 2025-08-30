namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Proposals;
/// <summary>
/// Table SUC Omip Rates (ID 50103).
/// </summary>
table 50153 "SUC Omip Rates"
{
    Caption = 'Omip Rates';
    DataClassification = CustomerContent;
    DrillDownPageId = "SUC Omip Rates List";
    LookupPageId = "SUC Omip Rates List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Marketing Type"; Code[10])
        {
            Caption = 'Marketing Type';
        }
        field(4; ID; Code[10])
        {
            Caption = 'ID';
        }
        field(5; "Green Energy"; Boolean)
        {
            Caption = 'Green Energy';
        }
        field(6; "Voltage No."; Code[20])
        {
            Caption = 'Voltage No.';
        }
        field(7; "OMIP Indexed"; Boolean)
        {
            Caption = 'OMIP Indexed';
        }
        field(8; "OMIP Indexed 5"; Boolean)
        {
            Caption = 'OMIP Indexed 5';
        }
        field(9; "Available on Agents portal"; Boolean)
        {
            Caption = 'Available on Agents portal';
        }
        field(10; "Available to Renew"; Boolean)
        {
            Caption = 'Available to Renew';
        }
        field(11; "Commission Plan No."; Code[20])
        {
            Caption = 'Commission Plan No.';
        }
        field(12; "Valid from"; Date)
        {
            Caption = 'Valid from';
        }
        field(13; "Valid Until"; Date)
        {
            Caption = 'Valid until';
        }
        field(14; Year; Integer)
        {
            Caption = 'Year';
        }
        field(15; "Energy Management"; Integer)
        {
            Caption = 'Energy Management';
        }
        field(16; "Rate kWh"; Decimal)
        {
            Caption = 'Rate kWh';
            DecimalPlaces = 5 : 5;
        }
        field(17; "Conditions Text"; Code[20])
        {
            Caption = 'Conditions Text';
        }
        field(18; "Conditions Tariff"; Text[2048])
        {
            Caption = 'Conditions Tariff';
        }
        field(19; "Conditions Tariff 2"; Text[2048])
        {
            Caption = 'Conditions Tariff 2';
        }
        field(20; "No. Potency"; Enum "SUC Omip Hired Potency")
        {
            Caption = 'No. Potency';
        }
        field(21; "No. Consumption"; Enum "SUC Omip Hired Potency")
        {
            Caption = 'No. Consumption';
        }
        field(22; "Id. Plenitude"; Integer)
        {
            Caption = 'Id. Plenitude';
        }
        field(23; "Energy Type"; Enum "SUC Energy Type")
        {
            Caption = 'Energy Type';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        ErrorProposalsLbl: Label 'Rate cannot be deleted because it is used in the proposals.';
        ErrorContractsLbl: Label 'Rate cannot be deleted because it is used in the contracts.';
    begin
        SUCOmipProposals.Reset();
        SUCOmipProposals.SetRange("Rate No.", Code);
        if not SUCOmipProposals.IsEmpty() then
            Error(ErrorProposalsLbl);

        SUCOmipEnergyContracts.Reset();
        SUCOmipEnergyContracts.SetRange("Rate No.", Code);
        if not SUCOmipEnergyContracts.IsEmpty() then
            Error(ErrorContractsLbl);
    end;
}