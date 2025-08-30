namespace Sucasuc.Omie.Auditing;
using System.Utilities;
using System.Text;
table 50213 "SUC Omie Import Entries"
{
    DataClassification = CustomerContent;
    Caption = 'Omie Import Entries';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Posting Date"; DateTime)
        {
            Caption = 'Posting Date';
        }
        field(3; "Omie File Name"; Text[50])
        {
            Caption = 'File Name';
        }
        field(4; "Omie File"; Blob)
        {
            Caption = 'Omie File';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    procedure NewEntryNo(): Integer
    var
        SUCOmieImportEntries: Record "SUC Omie Import Entries";
    begin
        SUCOmieImportEntries.Reset();
        if SUCOmieImportEntries.FindLast() then
            exit(SUCOmieImportEntries."Entry No." + 1)
        else
            exit(1);
    end;

    procedure SetOmieFile(NewOmieFile: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Omie File");
        "Omie File".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(NewOmieFile);
        Modify();
    end;

    procedure DownloadOmieFile()
    var
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
        InStream1: InStream;
        OutStream: OutStream;
        OmieFileDoc: Text;
        FileName: Text;
        FileNoDataLbl: Label 'Imported file without data';
    begin
        if Rec."Omie File".HasValue then begin
            Rec.CalcFields("Omie File");
            FileName := Rec."Omie File Name";
            Rec."Omie File".CreateInStream(InStream, TextEncoding::UTF8);
            while not (InStream.EOS) do
                InStream.Read(OmieFileDoc);
            TempBlob.CreateOutStream(OutStream);
            Base64Convert.FromBase64(OmieFileDoc, OutStream);
            TempBlob.CreateInStream(InStream1);
            DownloadFromStream(InStream1, '', '', '', FileName);
        end else
            Error(FileNoDataLbl);
    end;
}