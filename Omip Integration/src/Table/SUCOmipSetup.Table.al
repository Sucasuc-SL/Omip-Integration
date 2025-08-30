namespace Sucasuc.Omip.Setup;
using Microsoft.Foundation.NoSeries;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Masters;
using Microsoft.Sales.Customer;
using System.Utilities;
using System.Text;
/// <summary>
/// Table SUC Omip Setup (ID 50100).
/// </summary>
table 50150 "SUC Omip Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Setup';
    DrillDownPageId = "SUC Omip Setup";
    LookupPageId = "SUC Omip Setup";
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Rates Entry SSCC"; Decimal)
        {
            Caption = 'Rates Entry SSCC';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by Omip Entry';
        }
        field(3; "Rates Entry Detours"; Decimal)
        {
            Caption = 'Rates Entry Detours';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by Omip Entry';
        }
        field(4; "Rates Entry AFNEE"; Decimal)
        {
            Caption = 'Rates Entry AFNEE';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by Omip Entry';
        }
        field(5; "Rates Entry IM"; Decimal)
        {
            Caption = 'Rates Entry IM';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by Omip Entry';
        }
        field(6; "Rates Entry Premium Open Pos."; Decimal)
        {
            Caption = 'Rates Entry Premium Open Position';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by Omip Entry';
        }
        field(7; "Rates Entry Social Bonus"; Decimal)
        {
            Caption = 'Rates Entry Social Bonus';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by Omip Entry';
        }
        field(8; "Rates Entry GdOs"; Decimal)
        {
            Caption = 'Rates Entry GdOs';
            DecimalPlaces = 0 : 6;
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Rates Entry Setup';
        }
        field(9; "Rates Entry Energy Origen"; Enum "SUC Omip Energy Origen")
        {
            Caption = 'Rates Entry Energy Origen';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by Omip Entry';
        }
        field(10; "Max. FEE Potency"; Decimal)
        {
            Caption = 'Max. FEE Potency';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Rates Entry Setup';
        }
        field(11; "Max. FEE Energy"; Decimal)
        {
            Caption = 'Max. FEE Energy';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Rates Entry Setup';
        }
        field(12; "Proposal Nos."; Code[20])
        {
            Caption = 'Proposal Nos.';
            TableRelation = "No. Series";
        }
        field(13; "Email Proposal Confirmation"; Text[250])
        {
            Caption = 'Email Proposal Confirmation';
        }
        field(14; "Contract Nos."; Code[20])
        {
            Caption = 'Contract Nos.';
            TableRelation = "No. Series";
        }
        field(15; "Time Validity Proposals"; DateFormula)
        {
            Caption = 'Time Validity Proposals';
        }
        field(16; "Channel Code"; Code[5])
        {
            Caption = 'Channel Code';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip E-Send Doc. Setup';
        }
        field(17; "Operator Code"; Text[20])
        {
            Caption = 'Operator Code';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip E-Send Doc. Setup';
        }
        field(18; "URL E-Send"; Text[250])
        {
            Caption = 'URL E-Send';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip E-Send Doc. Setup';
        }
        field(19; "Email Delivery Provider"; Enum "SUC Omip Email Delivery Prov.")
        {
            Caption = 'Email Delivery Provider';
        }
        field(20; "Message Body Proposals"; Text[2048])
        {
            Caption = 'Message Body Proposals';
        }
        field(21; "Message Body Contracts"; Text[2048])
        {
            Caption = 'Message Body Contracts';
        }
        field(22; "Email Contract Confirmation"; Text[250])
        {
            Caption = 'Email Contract Confirmation';
        }
        field(23; "Time Validity Contracts"; DateFormula)
        {
            Caption = 'Time Validity Contracts';
        }
        field(24; "URL SIPS"; Text[250])
        {
            Caption = 'URL';
        }
        field(25; "Min. FEE Potency"; Decimal)
        {
            Caption = 'Min. FEE Potency';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Rates Entry Setup';
        }
        field(26; "Min. FEE Energy"; Decimal)
        {
            Caption = 'Min. FEE Energy';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Rates Entry Setup';
        }
        field(27; "Email Prices Confirmation"; Text[250])
        {
            Caption = 'Email Prices Confirmation';
        }
        field(28; "Allow Delete Related Documents"; Boolean)
        {
            Caption = 'Allow Delete Related Documents';
        }
        field(29; "Rates Entry GdOs 2"; Decimal)
        {
            Caption = 'Rates Entry GdOs';
            DecimalPlaces = 0 : 6;
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Rates Entry Setup';
        }
        field(30; "Min. FEE Potency 2"; Decimal)
        {
            Caption = 'Min. FEE Potency';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Rates Entry Setup';
        }
        field(31; "Min. FEE Energy 2"; Decimal)
        {
            Caption = 'Min. FEE Energy';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Rates Entry Setup';
        }
        field(32; "Max. FEE Potency 2"; Decimal)
        {
            Caption = 'Max. FEE Potency';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Rates Entry Setup';
        }
        field(33; "Max. FEE Energy 2"; Decimal)
        {
            Caption = 'Max. FEE Energy';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Rates Entry Setup';
        }
        field(34; "URL BTP 2 E-Send"; Text[250])
        {
            Caption = 'URL E-Send';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip E-Send Doc. Setup';
        }
        field(35; "Channel Code BTP 2"; Code[5])
        {
            Caption = 'Channel Code';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip E-Send Doc. Setup';
        }
        field(36; "Operator Code BTP 2"; Text[20])
        {
            Caption = 'Operator Code';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip E-Send Doc. Setup';
        }
        field(37; "Manual File"; Blob)
        {
            Caption = 'Manual File';
        }
        field(38; "Manual Date"; DateTime)
        {
            Caption = 'Manual Date';
        }
        field(39; "Manual File Name"; Text[50])
        {
            Caption = 'Manual File Name';
        }
        field(40; "Order TED Addendum"; Text[100])
        {
            Caption = 'Order TED Addendum';
        }
        field(41; "Resolution Addendum"; Text[100])
        {
            Caption = 'Resolution Addendum';
        }
        field(42; "Show BTP Request"; Boolean)
        {
            Caption = 'Show BTP Request';
        }
        field(43; "Default Reference Contract"; Text[50])
        {
            Caption = 'Default Reference Contract';
        }
        field(44; "Preview Proposal Nos."; Code[20])
        {
            Caption = 'Preview Proposal Nos.';
            TableRelation = "No. Series";
        }
        field(45; "Email Duplicate Customers"; Text[250])
        {
            Caption = 'Email Duplicate Customers';
        }
        field(46; "URL Plenitude"; Text[250])
        {
            Caption = 'URL';
        }
        field(47; "User Plenitude"; Text[50])
        {
            Caption = 'User';
        }
        field(48; "Password Plenitude"; Text[100])
        {
            Caption = 'Password';
        }
        field(49; "Version Plenitude"; Text[10])
        {
            Caption = 'Version';
        }
        field(50; "Show Plenitude Request"; Boolean)
        {
            Caption = 'Show Plenitude Request';
        }
        field(51; "Customer No. Proposal Preview"; Code[20])
        {
            Caption = 'Customer No. Proposal Preview';
            TableRelation = Customer."No.";
        }
        field(52; "Default Marketer Ext. Users"; Code[20])
        {
            Caption = 'Default Marketer External Users';
            TableRelation = "SUC Omip Marketers"."No.";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    procedure SetManualFile(NewManualFile: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Manual File");
        "Manual File".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(NewManualFile);
        Modify();
    end;

    procedure DownloadManualFile()
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
        if Rec."Manual File".HasValue then begin
            Rec.CalcFields("Manual File");
            FileName := Rec."Manual File Name";
            Rec."Manual File".CreateInStream(InStream, TextEncoding::UTF8);
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