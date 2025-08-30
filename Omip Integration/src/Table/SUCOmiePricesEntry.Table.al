namespace Sucasuc.Omie.Master;
using Sucasuc.Omie.Auditing;

table 50267 "SUC Omie Prices Entry"
{
    DataClassification = CustomerContent;
    Caption = 'Omie Prices Entry';

    fields
    {
        field(1; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(2; "Hour"; Integer)
        {
            Caption = 'Hour';
        }
        field(3; "Price"; Decimal)
        {
            Caption = 'Price';
            DecimalPlaces = 2 : 5;
        }
        field(4; "Price 2"; Decimal)
        {
            Caption = 'Price 2';
            DecimalPlaces = 2 : 5;
        }
        field(5; "Import Entry No."; Integer)
        {
            Caption = 'Import Entry No.';
            TableRelation = "SUC Omie Import Entries"."Entry No.";
        }
        field(6; "Created Date Time"; DateTime)
        {
            Caption = 'Created Date Time';
        }
        field(7; "Modified Date Time"; DateTime)
        {
            Caption = 'Modified Date Time';
        }
    }

    keys
    {
        key(PK; "Date", "Hour")
        {
            Clustered = true;
        }
        key(Key2; "Import Entry No.")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date Time" := CurrentDateTime;
        "Modified Date Time" := CurrentDateTime;
    end;

    trigger OnModify()
    begin
        "Modified Date Time" := CurrentDateTime;
    end;
}
