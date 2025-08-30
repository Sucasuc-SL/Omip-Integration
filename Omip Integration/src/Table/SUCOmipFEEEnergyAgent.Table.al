namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.User;
table 50203 "SUC Omip FEE Energy Agent"
{
    DataClassification = CustomerContent;
    Caption = 'Omip FEE Energy Agent';
    LookupPageId = "SUC Omip FEE Energy Agent";
    DrillDownPageId = "SUC Omip FEE Energy Agent";

    fields
    {
        field(1; "Agent No."; Code[100])
        {
            Caption = 'Agent No.';
            TableRelation = "SUC Omip External Users"."User Name";
            DataClassification = CustomerContent;
        }
        field(2; "FEE Group Id."; Code[20])
        {
            Caption = 'FEE Group Id.';
            TableRelation = "SUC Omip FEE Groups"."Group Id.";
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
                CalculateTotalPeriods();
            end;
        }
        field(6; P2; Decimal)
        {
            Caption = 'P2';
            trigger OnValidate()
            begin
                CalculateTotalPeriods();
            end;
        }
        field(7; P3; Decimal)
        {
            Caption = 'P3';
            trigger OnValidate()
            begin
                CalculateTotalPeriods();
            end;
        }
        field(8; P4; Decimal)
        {
            Caption = 'P4';
            trigger OnValidate()
            begin
                CalculateTotalPeriods();
            end;
        }
        field(9; P5; Decimal)
        {
            Caption = 'P5';
            trigger OnValidate()
            begin
                CalculateTotalPeriods();
            end;
        }
        field(10; P6; Decimal)
        {
            Caption = 'P6';
            trigger OnValidate()
            begin
                CalculateTotalPeriods();
            end;
        }
        field(11; "Total Period"; Decimal)
        {
            Caption = 'Total Period';
        }
    }

    keys
    {
        key(Key1; "Agent No.", "FEE Group Id.", "Marketer No.", "Rate No.")
        {
            Clustered = true;
        }
    }
    local procedure CalculateTotalPeriods()
    var
        SUCOmipRatesEntrySetup: Record "SUC Omip Rates Entry Setup";
        SUCOmipConsumDistributor: Record "SUC Omip Consum. Distributor";
        TotalPeriod: Decimal;
        ErrorLbl: Label 'The total of the periods generated based on the consumption predetermined by the distributor exceeds the maximum permitted energy of %1.';
    begin
        SUCOmipRatesEntrySetup.Get(Rec."Marketer No.");
        SUCOmipRatesEntrySetup.TestField("Max. FEE Energy");

        TestField("Rate No.");
        SUCOmipConsumDistributor.Get(Rec."Rate No.");

        TotalPeriod := (P1 * (SUCOmipConsumDistributor.P1 / 100)) +
                       (P2 * (SUCOmipConsumDistributor.P2 / 100)) +
                       (P3 * (SUCOmipConsumDistributor.P3 / 100)) +
                       (P4 * (SUCOmipConsumDistributor.P4 / 100)) +
                       (P5 * (SUCOmipConsumDistributor.P5 / 100)) +
                       (P6 * (SUCOmipConsumDistributor.P6 / 100));

        if TotalPeriod > SUCOmipRatesEntrySetup."Max. FEE Energy" then
            Error(ErrorLbl, SUCOmipRatesEntrySetup."Max. FEE Energy");

        Rec."Total Period" := TotalPeriod;
    end;
}