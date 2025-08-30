namespace Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Auditing;
using System.Text;
using Sucasuc.Omie.Auditing;
using Sucasuc.Omie.Processing;
using System.Utilities;
codeunit 50157 "SUC Omip Web Services KON"
{
    procedure UploadOmipFile(postingDate: DateTime; omipFileName: Text[50]; omipFile: Text): Text
    var
        SUCOmipImportEntries: Record "SUC Omip Import Entries";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        SUCOmipImportFromExcel: Codeunit "SUC Omip Import From Excel";
        ProcessPriceDate: Date;
        FileName: Text[250];
        OmipFileDoc: Text;
        InStream: InStream;
        InStream1: InStream;
        OutStream: OutStream;
        FileNoDataLbl: Label 'Imported file without data';
    begin
        SUCOmipImportEntries.Init();
        SUCOmipImportEntries."Entry No." := SUCOmipImportEntries.NewEntryNo();
        SUCOmipImportEntries."Posting Date" := postingDate;
        SUCOmipImportEntries."Omip File Name" := omipFileName;
        SUCOmipImportEntries.Insert();

        SUCOmipImportEntries.SetOmipFile(omipFile);

        if SUCOmipImportEntries."Omip File".HasValue then begin
            SUCOmipImportEntries.CalcFields("Omip File");
            FileName := SUCOmipImportEntries."Omip File Name";
            SUCOmipImportEntries."Omip File".CreateInStream(InStream, TextEncoding::UTF8);
            while not (InStream.EOS) do
                InStream.Read(OmipFileDoc);
            TempBlob.CreateOutStream(OutStream);
            Base64Convert.FromBase64(OmipFileDoc, OutStream);
            TempBlob.CreateInStream(InStream1);
            ProcessPriceDate := SUCOmipImportFromExcel.ExcelProcessImport(FileName, InStream1);

            if ProcessPriceDate = CalcDate('<CM>', ProcessPriceDate) then
                ProcessPriceDate := CalcDate('<+1D>', ProcessPriceDate);

            ProcessPriceDate := CalcDate('<-CM+2M>', ProcessPriceDate);

            SUCOmipManagement.ProcessNewPricesOmipBatch(ProcessPriceDate);
            exit('Omip file uploaded successfully');
        end else
            Error(FileNoDataLbl);
    end;

    procedure UploadOmieFile(postingDate: DateTime; omieFileName: Text[50]; omieFile: Text): Text
    var
        SUCOmieImportEntries: Record "SUC Omie Import Entries";
        SUCOmieDataProcessor: Codeunit "SUC Omie Data Processor";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        FileName: Text;
        OmieFileDoc: Text;
        InStream: InStream;
        InStream1: InStream;
        OutStream: OutStream;
        FileNoDataLbl: Label 'Imported file without data';
        ProcessingErrorLbl: Label 'Omie file uploaded but processing failed.';
        ProcessingResult: Boolean;
    begin
        SUCOmieImportEntries.Init();
        SUCOmieImportEntries."Entry No." := SUCOmieImportEntries.NewEntryNo();
        SUCOmieImportEntries."Posting Date" := postingDate;
        SUCOmieImportEntries."Omie File Name" := omieFileName;
        SUCOmieImportEntries.Insert();

        SUCOmieImportEntries.SetOmieFile(omieFile);

        if SUCOmieImportEntries."Omie File".HasValue then begin
            SUCOmieImportEntries.CalcFields("Omie File");
            FileName := SUCOmieImportEntries."Omie File Name";
            SUCOmieImportEntries."Omie File".CreateInStream(InStream, TextEncoding::UTF8);
            while not (InStream.EOS) do
                InStream.Read(OmieFileDoc);
            TempBlob.CreateOutStream(OutStream);
            Base64Convert.FromBase64(OmieFileDoc, OutStream);
            TempBlob.CreateInStream(InStream1);

            // Process the OMIE data
            ProcessingResult := SUCOmieDataProcessor.ProcessOmieFile(SUCOmieImportEntries."Entry No.", InStream1);

            if ProcessingResult then
                exit('Omie file uploaded and processed successfully')
            else
                exit(ProcessingErrorLbl);
        end else
            Error(FileNoDataLbl);
    end;
}