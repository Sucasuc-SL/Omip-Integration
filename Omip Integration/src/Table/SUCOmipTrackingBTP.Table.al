namespace Sucasuc.Omip.Auditing;
using Sucasuc.Omip.Documents;
using System.Reflection;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.BTP;
using System.Utilities;
using System.Text;
table 50175 "SUC Omip Tracking BTP"
{
    DataClassification = CustomerContent;
    Caption = 'Tracking';
    DrillDownPageId = "SUC Omip Tracking BTP";
    LookupPageId = "SUC Omip Tracking BTP";

    fields
    {
        field(1; "Document Type"; Enum "SUC Omip Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Execution Date"; DateTime)
        {
            Caption = 'Execution Date';
        }
        field(5; Request; Blob)
        {
            Caption = 'Request';
        }
        field(6; "Response Status"; Text[10])
        {
            Caption = 'Response Status';
        }
        field(7; "Response Description"; Text[50])
        {
            Caption = 'Response Description';
        }
        field(8; "Acceptance Method"; Enum "SUC Omip Acceptance Method")
        {
            Caption = 'Acceptance Method';
        }
        field(15; "Acceptance Send"; Text[250])
        {
            Caption = 'Acceptance Send';
        }
        field(16; "Action Tracking"; Enum "SUC Omip Action Tracking BTP")
        {
            Caption = 'Action Tracking';
        }
        field(17; "BTP ncal"; Text[5])
        {
            Caption = 'BTP ncal';
        }
        field(18; "BTP nop"; Text[20])
        {
            Caption = 'BTP nop';
        }
        field(19; "BTP status"; Integer)
        {
            Caption = 'BTP status';
            trigger OnValidate()
            var
                SUCOmipProposals: Record "SUC Omip Proposals";
                SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
            begin
                case "BTP status" of
                    20, 21, 70: //20, 21 - sms, 70 - email
                        case "Document Type" of
                            "Document Type"::Proposal:
                                if SUCOmipProposals.Get("Document No.") then begin
                                    SUCOmipProposals.Validate(Status, SUCOmipProposals.Status::Accepted);
                                    SUCOmipProposals.Modify();
                                end;
                            "Document Type"::Contract:
                                if SUCOmipEnergyContracts.Get("Document No.") then begin
                                    SUCOmipEnergyContracts.Validate(Status, SUCOmipEnergyContracts.Status::Accepted);
                                    SUCOmipEnergyContracts.Modify();
                                end;
                        end;
                end;
            end;
        }
        field(20; "BTP description"; Text[250])
        {
            Caption = 'BTP description';
        }
        field(21; "BTP doc"; Blob)
        {
            Caption = 'BTP doc';
        }
        field(22; "BTP date"; DateTime)
        {
            Caption = 'BTP date';
        }
        field(23; "Duplicate Document"; Boolean)
        {
            Caption = 'Duplicate Document';
        }
        field(24; "Duplicate Document No."; Code[20])
        {
            Caption = 'Duplicate Document No.';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure SetRequest(NewRequest: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Request);
        Request.CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(NewRequest);
        Modify();
    end;

    procedure DownloadRequest()
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
        OutRequest: Text;
        FileName: Text;
    begin
        if Request.HasValue then begin
            CalcFields(Request);
            FileName := Format("Document Type") + ' - ' + "Document No." + '.json';
            Request.CreateInStream(InStream, TextEncoding::UTF8);
            OutRequest := TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName(Request));
            DownloadFromStream(InStream, '', '', '', FileName);
        end;
    end;

    procedure SetDocBTP(NewDocumentSupport: Text)
    var
        OutStream: OutStream;
    begin
        Clear("BTP doc");
        "BTP doc".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(NewDocumentSupport);
        Modify();
    end;

    procedure DownloadDocBTP()
    var
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        InStream: InStream;
        InStream1: InStream;
        OutStream: OutStream;
        BTPdoc: Text;
        FileName: Text;
    begin
        if "BTP doc".HasValue then begin
            CalcFields("BTP doc");
            FileName := Format("Document Type") + ' - ' + "Document No." + '.pdf';
            "BTP doc".CreateInStream(InStream, TextEncoding::UTF8);
            while not (InStream.EOS) do
                InStream.Read(BTPdoc);
            TempBlob.CreateOutStream(OutStream);
            Base64Convert.FromBase64(BTPdoc, OutStream);
            TempBlob.CreateInStream(InStream1);
            DownloadFromStream(InStream1, '', '', '', FileName);
        end;
    end;
}