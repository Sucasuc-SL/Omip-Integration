namespace Sucasuc.Omip.Masters;
/// <summary>
/// Table SUC Omip Monthly Price History (ID 50225).
/// </summary>
table 50225 "SUC Omip Monthly Price Hist"
{
    Caption = 'Omip Monthly Prices History';
    DataClassification = CustomerContent;
    DataCaptionFields = "Posting Date", "Ref. Month";

    fields
    {
        field(1; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = false;
        }
        field(2; Year; Integer)
        {
            Caption = 'Year';
            Editable = false;
        }
        field(3; Month; Integer)
        {
            Caption = 'Month';
            Editable = false;
        }
        field(4; "Ref. Trim"; Code[2])
        {
            Caption = 'Ref. Trim';
            Editable = false;
        }
        field(5; "Ref. Month"; Text[15])
        {
            Caption = 'Ref. Month';
            Editable = false;
        }
        field(6; Price; Decimal)
        {
            Caption = 'Price';
        }
    }

    keys
    {
        key(PK; "Posting Date")
        {
            Clustered = true;
        }
        key(DateKey; Year, Month)
        {
        }
        key(RefKey; "Ref. Month")
        {
        }
    }

    /// <summary>
    /// InsertOrUpdateHistoryRecord.
    /// Inserts a new record if it doesn't exist, or updates the existing one.
    /// </summary>
    procedure InsertOrUpdateHistoryRecord(SourceRecord: Record "SUC Omip Monthly Prices")
    var
        ExistingRecord: Record "SUC Omip Monthly Price Hist";
    begin
        if FindExistingRecord(SourceRecord, ExistingRecord) then
            UpdateExistingRecord(ExistingRecord, SourceRecord)
        else
            InsertNewRecord(SourceRecord);
    end;

    local procedure FindExistingRecord(SourceRecord: Record "SUC Omip Monthly Prices"; var ExistingRecord: Record "SUC Omip Monthly Price Hist"): Boolean
    begin
        ExistingRecord.Reset();
        // Find existing record by posting date (which corresponds to Start Date Month)
        ExistingRecord.SetRange("Posting Date", SourceRecord."Start Date Month");
        exit(ExistingRecord.FindFirst());
    end;

    local procedure UpdateExistingRecord(var ExistingRecord: Record "SUC Omip Monthly Price Hist"; SourceRecord: Record "SUC Omip Monthly Prices")
    begin
        // Update only the data fields, preserving the existing key structure
        ExistingRecord.Validate(Price, SourceRecord."Range Prices");
        ExistingRecord.Validate("Ref. Trim", SourceRecord."Ref. Trim");
        ExistingRecord.Validate("Ref. Month", SourceRecord."Ref. Month");
        ExistingRecord.Modify();
    end;

    local procedure InsertNewRecord(SourceRecord: Record "SUC Omip Monthly Prices")
    begin
        Rec.Reset();

        // Map fields from source record to history record
        "Posting Date" := SourceRecord."Start Date Month";
        Year := SourceRecord.Year;
        Month := SourceRecord.Month;
        "Ref. Trim" := SourceRecord."Ref. Trim";
        "Ref. Month" := SourceRecord."Ref. Month";
        Price := SourceRecord."Range Prices";
        Rec.Insert();
    end;

    /// <summary>
    /// CopyFromMonthlyPrices.
    /// Copies all records from SUC Omip Monthly Prices to history.
    /// </summary>
    procedure CopyFromMonthlyPrices()
    var
        SUCOmipMonthlyPrices: Record "SUC Omip Monthly Prices";
    begin
        SUCOmipMonthlyPrices.Reset();
        if SUCOmipMonthlyPrices.FindSet() then
            repeat
                InsertOrUpdateHistoryRecord(SUCOmipMonthlyPrices);
            until SUCOmipMonthlyPrices.Next() = 0;
    end;
}
