namespace Sucasuc.Omip.Test;
using Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Setup;
using Microsoft.Sales.Customer;
using Sucasuc.Omip.API;
using System.Utilities;

/// <summary>
/// Test Codeunit for SUC Omip Report Functions (ID 50159).
/// Tests all the refactored report selection and PDF generation functions.
/// </summary>
codeunit 50159 "SUC Tests Runner Omip"
{
    SubType = Test;
    TestPermissions = Disabled;

    var
        SUCOmipManagement: Codeunit "SUC Omip Management";
        SUCOmipWebServices: Codeunit "SUC Omip Web Services";
        SUCOmipRateEntryTypes: Enum "SUC Omip Rate Entry Types";
        SUCOmipEnergyOrigen: Enum "SUC Omip Energy Origen";
        SUCOmipAcceptanceMethod: Enum "SUC Omip Acceptance Method";
        IsInitialized: Boolean;
        CustomerNo: Code[20];
        CustomerCUPS: Text[25];
        ExecutionLogTxt: Label 'Execution %1: Marketer=%2, Multicups=%3, Rate=%4, Time=%5';
        ExportFileNameTxt: Label 'OmipTestExecutionLog_%1.txt';
        ExportHeaderTxt: Label '=== OMIP TEST EXECUTION LOG ===';
        ExportSeparatorTxt: Label '=====================================';
        ExportTimestampTxt: Label 'Test executed at: %1';
        ExportSummaryTxt: Label 'Total executions: %1';
        DebugExecutionLog: List of [Text];

    [Test]
    procedure TestCreateProposals()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipRates: Record "SUC Omip Rates";
        SUCOmipTimes: Record "SUC Omip Times";
        SUCOmipMarketers: Record "SUC Omip Marketers";
        ReportID: Integer;
        i: Integer;
        ProposalNo: Code[20];
        Base64Result: Text;
        Multicups: Boolean;
        LogEntry: Text;
    begin
        // [GIVEN] Initialize test data
        Initialize();
        Multicups := false; // Set to false for single CUPS test

        // [WHEN] Create proposals for all electricity rates and times and marketers
        for i := 1 to 2 do begin //* Iteration for cups and multicups test scenarios
            SUCOmipMarketers.Reset();
            if SUCOmipMarketers.FindSet() then
                repeat
                    SUCOmipRates.Reset();
                    SUCOmipRates.SetRange("Energy Type", SUCOmipRates."Energy Type"::Electricity);
                    if SUCOmipRates.FindSet() then
                        repeat
                            // Get all times configured for current marketer
                            SUCOmipTimes.Reset();
                            SUCOmipTimes.SetRange("Marketer No.", SUCOmipMarketers."No.");
                            if SUCOmipTimes.FindSet() then
                                repeat
                                    LogEntry := StrSubstNo(ExecutionLogTxt, DebugExecutionLog.Count() + 1, SUCOmipMarketers."No.", Multicups, SUCOmipRates.Code, SUCOmipTimes."SUC Time");
                                    DebugExecutionLog.Add(LogEntry);
                                    // Create proposal with specific rate and time
                                    ProposalNo := SUCOmipWebServices.GenerateProposal3API(
                                        '', // proposalNo
                                        SUCOmipRates.Code, // rateCode
                                        SUCOmipRateEntryTypes::"Type 1", // rateEntryType
                                        SUCOmipTimes."SUC Time", // timeCode
                                        'CONFORT', // rateCategory
                                        SUCOmipEnergyOrigen::"Non-Renewable", // energyOrigen
                                        'JPC', // agentNo
                                        CustomerNo, // customerNo
                                        CustomerCUPS, // customerCUPS
                                        DMY2Date(1, 5, 2024), // contractStartDate
                                        SUCOmipAcceptanceMethod::Email, // acceptanceMethod
                                        'jesus.patarroyo@gmail.com', // acceptanceSend
                                        SUCOmipMarketers."No.", // marketerNo
                                        true, // receiveInvoiceElectronically
                                        true, // sendingCommunications
                                        Multicups, // multicups
                                        'AD2212345678909348579834', // customerIBAN
                                        '' // feeGroupID
                                    );

                                    // Validate report selection for this proposal
                                    if SUCOmipProposals.Get(ProposalNo) then begin
                                        // Ensure we're working with a single record
                                        SUCOmipProposals.SetRecFilter();

                                        ReportID := SUCOmipManagement.GetProposalReportID(SUCOmipProposals);

                                        // [THEN] Should return a valid report ID
                                        if ReportID = 0 then
                                            Error('Invalid report ID for proposal %1 with rate %2 and time %3',
                                                ProposalNo, SUCOmipRates.Code, SUCOmipTimes."SUC Time");

                                        // Test PDF generation for this specific proposal
                                        Base64Result := SUCOmipManagement.PrintProposalToPDF(SUCOmipProposals);
                                        // [THEN] Should generate a valid PDF
                                        if Base64Result = '' then
                                            Error('Failed to generate PDF for proposal %1 with rate %2 and time %3',
                                                ProposalNo, SUCOmipRates.Code, SUCOmipTimes."SUC Time");
                                    end;
                                until SUCOmipTimes.Next() = 0;
                        until SUCOmipRates.Next() = 0;
                until SUCOmipMarketers.Next() = 0;
            Multicups := true;
        end;

        // Export execution log to downloadable text file
        ExportExecutionLogToFile();

    end;

    local procedure Initialize()
    var
        SUCOmipMarketers: Record "SUC Omip Marketers";
        Customer: Record Customer;
    begin
        if IsInitialized then
            exit;

        // Create test marketers if they don't exist
        CreateTestMarketer(SUCOmipMarketers, 'NAB', "SUC Omip Marketers"::Nabalia);
        CreateTestMarketer(SUCOmipMarketers, 'ACIS', "SUC Omip Marketers"::Acis);
        CreateTestMarketer(SUCOmipMarketers, 'AVA', "SUC Omip Marketers"::Avanza);

        // Create test customer if doesn't exist
        CustomerNo := 'TEST001';
        CustomerCUPS := 'ASDIA23498098402938409230'; // Example CUPS
        CreateTestCustomer(Customer, CustomerNo);

        IsInitialized := true;
    end;

    local procedure CreateTestMarketer(var SUCOmipMarketers: Record "SUC Omip Marketers"; MarketerCode: Code[20]; MarketerType: Enum "SUC Omip Marketers")
    begin
        if not SUCOmipMarketers.Get(MarketerCode) then begin
            SUCOmipMarketers.Init();
            SUCOmipMarketers."No." := MarketerCode;
            SUCOmipMarketers.Marketer := MarketerType;
            SUCOmipMarketers.Insert();
        end;
    end;

    local procedure CreateTestCustomer(var Customer: Record Customer; CustomerCode: Code[20])
    begin
        if not Customer.Get(CustomerCode) then begin
            Customer.Init();
            Customer."No." := CustomerCode;
            Customer.Name := 'Test Customer';
            Customer.Insert();
            CreateTestCustomerCUPS(CustomerCode, CustomerCUPS); // Example CUPS
        end;
    end;

    local procedure CreateTestCustomerCUPS(CustomerNoIn: Code[20]; CUPSIn: Code[25])
    var
        SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
    begin
        if not SUCOmipCustomerCUPS.Get(CustomerNoIn, CUPSIn) then begin
            SUCOmipCustomerCUPS.Init();
            SUCOmipCustomerCUPS."Customer No." := CustomerNoIn;
            SUCOmipCustomerCUPS."CUPS" := CUPSIn;
            SUCOmipCustomerCUPS.Insert();
            SUCOmipCustomerCUPS.Validate("SUC Supply Point Address", '123 Test Street'); // Example address
            SUCOmipCustomerCUPS.Validate("SUC Supply Point Country", 'ES'); // Example country code
            SUCOmipCustomerCUPS.Validate("SUC Supply Point Post Code", '08001'); // Example post code
            SUCOmipCustomerCUPS.Modify();
        end;
    end;

    local procedure ExportExecutionLogToFile()
    var
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;
        OutStream: OutStream;
        FileName: Text;
        LogEntry: Text;
        CurrentDateTime: DateTime;
        FileText: Text;
        CR: Text[1];
        LF: Text[1];
        CRLF: Text[2];
    begin
        // Create file name with timestamp
        CurrentDateTime := CurrentDateTime();
        FileName := StrSubstNo(ExportFileNameTxt, Format(CurrentDateTime, 0, '<Year4><Month,2><Day,2>_<Hours24><Minutes,2><Seconds,2>'));

        // Initialize line breaks
        CR[1] := 13;
        LF[1] := 10;
        CRLF := CR + LF;

        // Build file content as text
        FileText := ExportHeaderTxt + CRLF;
        FileText += StrSubstNo(ExportTimestampTxt, Format(CurrentDateTime)) + CRLF;
        FileText += ExportSeparatorTxt + CRLF + CRLF;

        // Add all execution entries
        foreach LogEntry in DebugExecutionLog do
            FileText += LogEntry + CRLF;

        // Add summary
        FileText += CRLF + ExportSeparatorTxt + CRLF;
        FileText += StrSubstNo(ExportSummaryTxt, DebugExecutionLog.Count()) + CRLF;
        FileText += ExportSeparatorTxt;

        // Create blob with file content and download
        TempBlob.CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.WriteText(FileText);
        TempBlob.CreateInStream(InStream, TextEncoding::UTF8);

        // Download the file using the standard Business Central method
        DownloadFromStream(InStream, 'Export Execution Log', '', 'Text Files (*.txt)|*.txt', FileName);
    end;
}