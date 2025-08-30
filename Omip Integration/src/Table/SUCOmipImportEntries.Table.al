namespace Sucasuc.Omip.Auditing;
using System.Utilities;
using System.Text;
table 50176 "SUC Omip Import Entries"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Import Entries';
    DrillDownPageId = "SUC Omip Import Entries";
    LookupPageId = "SUC Omip Import Entries";

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
        field(3; "Omip File Name"; Text[50])
        {
            Caption = 'File Name';
        }
        field(4; "Omip File"; Blob)
        {
            Caption = 'Omip File';
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
        SUCOmipImportEntries: Record "SUC Omip Import Entries";
    begin
        SUCOmipImportEntries.Reset();
        if SUCOmipImportEntries.FindLast() then
            exit(SUCOmipImportEntries."Entry No." + 1)
        else
            exit(1);
    end;

    procedure SetOmipFile(NewOmipFile: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Omip File");
        "Omip File".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(NewOmipFile);
        Modify();
    end;

    procedure DownloadOmipFile()
    var
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
        InStream1: InStream;
        OutStream: OutStream;
        OmipFileDoc: Text;
        FileName: Text;
        FileNoDataLbl: Label 'Imported file without data';
    begin
        if Rec."Omip File".HasValue then begin
            Rec.CalcFields("Omip File");
            FileName := Rec."Omip File Name";
            Rec."Omip File".CreateInStream(InStream, TextEncoding::UTF8);
            while not (InStream.EOS) do
                InStream.Read(OmipFileDoc);
            TempBlob.CreateOutStream(OutStream);
            Base64Convert.FromBase64(OmipFileDoc, OutStream);
            TempBlob.CreateInStream(InStream1);
            DownloadFromStream(InStream1, '', '', '', FileName);
        end else
            Error(FileNoDataLbl);
    end;
}