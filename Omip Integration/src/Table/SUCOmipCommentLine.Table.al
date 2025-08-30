namespace Sucasuc.Omip.Documents;
table 50174 "SUC Omip Comment Line"
{
    DataClassification = CustomerContent;
    Caption = 'Comment line';
    DrillDownPageId = "SUC Omip Comment Line";
    LookupPageId = "SUC Omip Comment Line";

    fields
    {
        field(1; "Document Type"; Enum "SUC Omip Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; Comment; Text[150])
        {
            Caption = 'Comment';
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        NewLineNo();
    end;

    local procedure NewLineNo()
    var
        SUCOmipCommentLine: Record "SUC Omip Comment Line";
    begin
        SUCOmipCommentLine.Reset();
        SUCOmipCommentLine.SetRange("Document Type", "Document Type");
        SUCOmipCommentLine.SetRange("No.", "No.");
        if SUCOmipCommentLine.FindLast() then
            "Line No." := SUCOmipCommentLine."Line No." + 10000
        else
            "Line No." := 10000;
    end;
}