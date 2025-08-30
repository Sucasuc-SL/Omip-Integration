namespace Sucasuc.Omie.Processing;
using Sucasuc.Omie.Master;
codeunit 50268 "SUC Omie Data Processor"
{
    procedure ProcessOmieFile(ImportEntryNo: Integer; FileInStream: InStream): Boolean
    var
        LineText: Text;
        IsFirstLine: Boolean;
        ProcessedLines: Integer;
    begin
        IsFirstLine := true;
        ProcessedLines := 0;

        while not FileInStream.EOS do begin
            FileInStream.ReadText(LineText);
            LineText := DelChr(LineText, '<>', ' ');

            // Skip empty lines and the header line
            if (LineText <> '') and (LineText <> '*') then
                if IsFirstLine then begin
                    // Skip the header line (MARGINALPDBC)
                    if UpperCase(LineText) = 'MARGINALPDBC' then
                        IsFirstLine := false
                    else begin
                        // Process the line if it's not the header
                        if ProcessOmieLine(LineText, ImportEntryNo) then
                            ProcessedLines += 1;
                        IsFirstLine := false;
                    end;
                end else
                    if ProcessOmieLine(LineText, ImportEntryNo) then
                        ProcessedLines += 1;
        end;

        exit(ProcessedLines > 0);
    end;

    local procedure ProcessOmieLine(LineText: Text; ImportEntryNo: Integer): Boolean
    var
        SUCOmieMarginalPrices: Record "SUC Omie Prices Entry";
        FieldArray: array[10] of Text;
        Year: Integer;
        Month: Integer;
        Day: Integer;
        Hour: Integer;
        Price1: Decimal;
        Price2: Decimal;
        ProcessDate: Date;
        SeparatorPos: Integer;
        RemainingText: Text;
        FieldIndex: Integer;
    begin
        // Parse fields using semicolon delimiter
        RemainingText := LineText;
        FieldIndex := 1;

        // Extract each field separated by semicolon
        while (RemainingText <> '') and (FieldIndex <= 10) do begin
            SeparatorPos := StrPos(RemainingText, ';');
            if SeparatorPos > 0 then begin
                FieldArray[FieldIndex] := CopyStr(RemainingText, 1, SeparatorPos - 1);
                RemainingText := CopyStr(RemainingText, SeparatorPos + 1);
            end else begin
                FieldArray[FieldIndex] := RemainingText;
                RemainingText := '';
            end;
            FieldIndex += 1;
        end;

        // We need at least 6 fields: Year, Month, Day, Hour, Price1, Price2
        if (FieldArray[1] = '') or (FieldArray[2] = '') or (FieldArray[3] = '') or
           (FieldArray[4] = '') or (FieldArray[5] = '') or (FieldArray[6] = '') then
            exit(false);

        // Parse the fields
        if not Evaluate(Year, FieldArray[1]) then exit(false);
        if not Evaluate(Month, FieldArray[2]) then exit(false);
        if not Evaluate(Day, FieldArray[3]) then exit(false);
        if not Evaluate(Hour, FieldArray[4]) then exit(false);
        if not Evaluate(Price1, FieldArray[5]) then exit(false);
        if not Evaluate(Price2, FieldArray[6]) then exit(false);

        // Validate data
        if (Year < 2000) or (Year > 2100) or
           (Month < 1) or (Month > 12) or
           (Day < 1) or (Day > 31) or
           (Hour < 1) or (Hour > 24) then
            exit(false);

        ProcessDate := DMY2Date(Day, Month, Year);

        // Check if record already exists
        SUCOmieMarginalPrices.Reset();
        SUCOmieMarginalPrices.SetRange("Date", ProcessDate);
        SUCOmieMarginalPrices.SetRange("Hour", Hour);

        if SUCOmieMarginalPrices.FindFirst() then begin
            // Update existing record
            SUCOmieMarginalPrices."Price" := Price1;
            SUCOmieMarginalPrices."Price 2" := Price2;
            SUCOmieMarginalPrices."Import Entry No." := ImportEntryNo;
            SUCOmieMarginalPrices.Modify();
        end else begin
            // Create new record
            SUCOmieMarginalPrices.Init();
            SUCOmieMarginalPrices."Date" := ProcessDate;
            SUCOmieMarginalPrices."Hour" := Hour;
            SUCOmieMarginalPrices."Price" := Price1;
            SUCOmieMarginalPrices."Price 2" := Price2;
            SUCOmieMarginalPrices."Import Entry No." := ImportEntryNo;
            SUCOmieMarginalPrices."Created Date Time" := CurrentDateTime;
            SUCOmieMarginalPrices."Modified Date Time" := CurrentDateTime;
            SUCOmieMarginalPrices.Insert();
        end;

        exit(true);
    end;
}
