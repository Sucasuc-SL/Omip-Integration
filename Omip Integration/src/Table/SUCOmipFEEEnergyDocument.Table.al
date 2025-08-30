namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Documents;
table 50204 "SUC Omip FEE Energy Document"
{
    DataClassification = CustomerContent;
    Caption = 'Omip FEE Energy Document';
    LookupPageId = "SUC Omip FEE Energy Document";
    DrillDownPageId = "SUC Omip FEE Energy Document";

    fields
    {
        field(1; "Document Type"; Enum "SUC Omip Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(2; "Document No."; Code[100])
        {
            Caption = 'Document No.';
            TableRelation = if ("Document Type" = const(Proposal)) "SUC Omip Proposals"."No."
            else if ("Document Type" = const(Contract)) "SUC Omip Energy Contracts"."No."
            else if ("Document Type" = const("Proposal Preview")) "SUC Omip Proposal Preview"."No.";
            DataClassification = CustomerContent;
        }
        field(3; "Marketer No."; Code[20])
        {
            Caption = 'Marketer No.';
            TableRelation = "SUC Omip Marketers"."No.";
        }
        field(4; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
        }
        field(5; P1; Decimal)
        {
            Caption = 'P1';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                CalculateTotalPeriodsByConsum();
            end;
        }
        field(6; P2; Decimal)
        {
            Caption = 'P2';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                CalculateTotalPeriodsByConsum();
            end;
        }
        field(7; P3; Decimal)
        {
            Caption = 'P3';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                CalculateTotalPeriodsByConsum();
            end;
        }
        field(8; P4; Decimal)
        {
            Caption = 'P4';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                CalculateTotalPeriodsByConsum();
            end;
        }
        field(9; P5; Decimal)
        {
            Caption = 'P5';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                CalculateTotalPeriodsByConsum();
            end;
        }
        field(10; P6; Decimal)
        {
            Caption = 'P6';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                CalculateTotalPeriodsByConsum();
            end;
        }
        field(11; "Total Period"; Decimal)
        {
            Caption = 'Total Period';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Marketer No.", "Rate No.")
        {
            Clustered = true;
        }
    }
    local procedure CalculateTotalPeriodsByConsum()
    var
        SUCOmipRatesEntrySetup: Record "SUC Omip Rates Entry Setup";
        // SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        EnergyCalculationMatrix: array[6] of Decimal;
        RealFEE: array[6] of Decimal;
        RealFEEActual: array[6] of Decimal;
        WithSIPSInfo: Boolean;
        TotalPeriod: Decimal;
        ErrorLbl: Label 'The average total of the periods exceed the maximum allowed energy of %1.';
    begin
        SUCOmipRatesEntrySetup.Get(Rec."Marketer No.");
        SUCOmipRatesEntrySetup.TestField("Max. FEE Energy");

        SUCOmipManagement.ValidateWithSIPSInformation("Document Type", CopyStr("Document No.", 1, 20), "Rate No.", WithSIPSInfo, EnergyCalculationMatrix, RealFEE);

        RealFEEActual[1] := P1 * EnergyCalculationMatrix[1];
        RealFEEActual[2] := P2 * EnergyCalculationMatrix[2];
        RealFEEActual[3] := P3 * EnergyCalculationMatrix[3];
        RealFEEActual[4] := P4 * EnergyCalculationMatrix[4];
        RealFEEActual[5] := P5 * EnergyCalculationMatrix[5];
        RealFEEActual[6] := P6 * EnergyCalculationMatrix[6];

        TotalPeriod := RealFEEActual[1] + RealFEEActual[2] + RealFEEActual[3] + RealFEEActual[4] + RealFEEActual[5] + RealFEEActual[6];

        if TotalPeriod > SUCOmipRatesEntrySetup."Max. FEE Energy" then
            Error(ErrorLbl, SUCOmipRatesEntrySetup."Max. FEE Energy");

        Rec."Total Period" := TotalPeriod;
    end;

    local procedure ValidateStatusDocument()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    begin
        case "Document Type" of
            "Document Type"::Contract:
                begin
                    SUCOmipEnergyContracts.Get("Document No.");
                    SUCOmipEnergyContracts.TestField(Status, SUCOmipEnergyContracts.Status::"Pending Acceptance");
                end;
            "Document Type"::Proposal:
                begin
                    SUCOmipProposals.Get("Document No.");
                    SUCOmipProposals.TestField(Status, SUCOmipProposals.Status::"Pending Acceptance");
                end;
        end;
    end;
}