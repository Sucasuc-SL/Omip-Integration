namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Documents;
table 50205 "SUC Omip FEE Power Document"
{
    DataClassification = CustomerContent;
    Caption = 'Omip FEE Power Document';
    LookupPageId = "SUC Omip FEE Power Document";
    DrillDownPageId = "SUC Omip FEE Power Document";

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
                CalculateTotalPeriods();
            end;
        }
        field(6; P2; Decimal)
        {
            Caption = 'P2';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                CalculateTotalPeriods();
            end;
        }
        field(7; P3; Decimal)
        {
            Caption = 'P3';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                CalculateTotalPeriods();
            end;
        }
        field(8; P4; Decimal)
        {
            Caption = 'P4';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                CalculateTotalPeriods();
            end;
        }
        field(9; P5; Decimal)
        {
            Caption = 'P5';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                CalculateTotalPeriods();
            end;
        }
        field(10; P6; Decimal)
        {
            Caption = 'P6';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                CalculateTotalPeriods();
            end;
        }
        field(11; "P1 %"; Decimal)
        {
            Caption = 'P1 %';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:2><Standard Format,0>%';
            Editable = false;
        }
        field(12; "P2 %"; Decimal)
        {
            Caption = 'P2 %';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:2><Standard Format,0>%';
            Editable = false;
        }
        field(13; "P3 %"; Decimal)
        {
            Caption = 'P3 %';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:2><Standard Format,0>%';
            Editable = false;
        }
        field(14; "P4 %"; Decimal)
        {
            Caption = 'P4 %';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:2><Standard Format,0>%';
            Editable = false;
        }
        field(15; "P5 %"; Decimal)
        {
            Caption = 'P5 %';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:2><Standard Format,0>%';
            Editable = false;
        }
        field(16; "P6 %"; Decimal)
        {
            Caption = 'P6 %';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:2><Standard Format,0>%';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Marketer No.", "Rate No.")
        {
            Clustered = true;
        }
    }
    local procedure CalculateTotalPeriods()
    var
        SUCOmipRatesEntrySetup: Record "SUC Omip Rates Entry Setup";
        TotalPeriod: Decimal;
        ErrorLbl: Label 'The total periods exceed the maximum allowed potency of %1.';
    begin
        SUCOmipRatesEntrySetup.Get(Rec."Marketer No.");
        SUCOmipRatesEntrySetup.TestField("Max. FEE Potency");
        TotalPeriod := P1 + P2 + P3 + P4 + P5 + P6;
        if TotalPeriod > SUCOmipRatesEntrySetup."Max. FEE Potency" then
            Error(ErrorLbl, SUCOmipRatesEntrySetup."Max. FEE Potency");

        if TotalPeriod <> 0 then begin
            "P1 %" := P1 / TotalPeriod;
            "P2 %" := P2 / TotalPeriod;
            "P3 %" := P3 / TotalPeriod;
            "P4 %" := P4 / TotalPeriod;
            "P5 %" := P5 / TotalPeriod;
            "P6 %" := P6 / TotalPeriod;
        end else begin
            "P1 %" := 0;
            "P2 %" := 0;
            "P3 %" := 0;
            "P4 %" := 0;
            "P5 %" := 0;
            "P6 %" := 0;
        end;
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