namespace Sucasuc.Energy.Ledger;
using Sucasuc.Omip.Masters;

table 50268 "SUC Historical Prices"
{
    DataClassification = CustomerContent;
    Caption = 'Historical Prices';
    DrillDownPageId = "SUC Historical Prices";
    LookupPageId = "SUC Historical Prices";

    fields
    {
        field(1; "Control Prices Id."; Integer)
        {
            Caption = 'Control Prices ID';
            TableRelation = "SUC Control Prices Energy"."Id.";
        }
        field(2; "Marketer No."; Code[20])
        {
            Caption = 'Marketer No.';
            TableRelation = "SUC Omip Marketers"."No.";
        }
        field(3; Modality; Text[100])
        {
            Caption = 'Modality';
        }
        field(4; "Month"; Integer)
        {
            Caption = 'Month';
            MinValue = 1;
            MaxValue = 12;
        }
        field(5; "Period"; Code[2])
        {
            Caption = 'Period';
            InitValue = 'P1';
        }
        field(6; "Index Value"; Decimal)
        {
            Caption = 'Index Value';
            DecimalPlaces = 0 : 6;
        }
        field(7; "Year"; Integer)
        {
            Caption = 'Year';
            InitValue = 2024;
        }
        field(8; "Created Date"; DateTime)
        {
            Caption = 'Created Date';
        }
        field(9; "Excel Column Description"; Text[50])
        {
            Caption = 'Excel Column Description';
            Editable = false;
        }
        field(10; Version; Code[10])
        {
            Caption = 'Version';
            DataClassification = CustomerContent;
        }
        field(11; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
        }
    }

    keys
    {
        key(Key1; "Control Prices Id.", Modality, Version, "Rate No.", "Year", "Month", "Period")
        {
            Clustered = true;
        }
        key(Key2; "Marketer No.", Modality, "Year", "Month") { }
        key(Key3; "Year", "Month", "Period") { }
        key(Key4; "Control Prices Id.", "Year", "Month", "Period") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Marketer No.", Modality, "Year", "Month", "Period", "Index Value") { }
    }

    trigger OnInsert()
    begin
        if "Created Date" = 0DT then
            "Created Date" := CurrentDateTime;
    end;

    procedure DeleteHistoricalData(ControlPricesID: Integer)
    var
        HistoricalPrices: Record "SUC Historical Prices";
    begin
        HistoricalPrices.Reset();
        HistoricalPrices.SetRange("Control Prices Id.", ControlPricesID);

        // Delete from last to first to avoid navigation issues
        if HistoricalPrices.FindLast() then
            repeat
                HistoricalPrices.Delete(true);
            until HistoricalPrices.Next(-1) = 0;
    end;

    procedure InsertHistoricalPrice(ControlPricesID: Integer; MarketerNo: Code[20]; ModalityValue: Text[100]; MonthValue: Integer; PeriodValue: Code[2]; IndexValue: Decimal; YearValue: Integer; ExcelColumnDescription: Text[50]; VersionValue: Code[10]; RateNoValue: Code[20])
    var
        HistoricalPrices: Record "SUC Historical Prices";
    begin
        if IndexValue = 0 then
            exit; // Don't insert zero values

        // Since DeleteHistoricalData is called before this procedure,
        // we know all records will be new, so we can directly insert
        HistoricalPrices.Init();
        HistoricalPrices."Control Prices Id." := ControlPricesID;
        HistoricalPrices."Marketer No." := MarketerNo;
        HistoricalPrices.Modality := ModalityValue;
        HistoricalPrices."Month" := MonthValue;
        HistoricalPrices."Period" := PeriodValue;
        HistoricalPrices."Index Value" := IndexValue;
        HistoricalPrices."Year" := YearValue;
        HistoricalPrices."Excel Column Description" := ExcelColumnDescription;
        HistoricalPrices.Version := VersionValue;
        HistoricalPrices."Rate No." := RateNoValue;
        HistoricalPrices."Created Date" := CurrentDateTime;
        HistoricalPrices.Insert();
    end;

    procedure GetHistoricalPrices(ControlPricesID: Integer; var TempHistoricalPrices: Record "SUC Historical Prices" temporary)
    var
        HistoricalPrices: Record "SUC Historical Prices";
    begin
        TempHistoricalPrices.Reset();
        TempHistoricalPrices.DeleteAll();

        HistoricalPrices.Reset();
        HistoricalPrices.SetRange("Control Prices Id.", ControlPricesID);
        if HistoricalPrices.FindSet() then
            repeat
                TempHistoricalPrices := HistoricalPrices;
                TempHistoricalPrices.Insert();
            until HistoricalPrices.Next() = 0;
    end;
}
