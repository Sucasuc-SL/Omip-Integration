namespace Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Masters;
using System.Reflection;
using Sucasuc.Omip.Setup;
using Sucasuc.Omip.Ledger;
using System.Globalization;
using Microsoft.Sales.Customer;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Utilities;
report 50162 "SUC Omip Proposal ACIS MC"
{
    Caption = 'Omip Proposal Comercial';
    WordLayout = './src/Report/Layouts/Proposals/Acis/SUCOmipProposalACISMC.docx';
    DefaultLayout = Word;
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem(SUCOmipProposel; "SUC Omip Proposals")
        {
            DataItemTableView = sorting("No.") order(ascending);
            RequestFilterFields = "No.";

            column(Rate_No_; "Rate No.") { }
            column(Energy_Origen; UpperCase(Format("Energy Origen"))) { }
            column(Type_; UpperCase(Format(Type))) { }
            column(Date_Proposel; Format("Date Proposal", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(TimesProposel; UpperCase(GetMonthProposel(Times))) { }
            column(Contract_Start_Date; Format("Contract Start Date", 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(Customer_Name; CopyStr("Customer Name" + ' ' + Customer."Name 2", 1, 145)) { }
            column(Agent_Name; "Agent Name") { }
            column(Marketer_Name; "Marketer Name") { }
            column(CustomerVATRegNo; Customer."VAT Registration No.") { }
            column(CustomerManager; Customer."SUC Manager") { }
            column(CustomerPhone; Customer."Phone No.") { }
            column(CustomerEmail; Customer."E-Mail") { }
            column(ContractType; ContractType) { }
            column(ContractPeriod; ContractPeriod) { }
            column(EndDate; Format(EndDate, 0, '<Day,2>/<Month,2>/<Year4>')) { }
            column(CUPS; "Customer CUPS") { }
            column(Volume; Volume) { }
            column(PropValidUntil; Format(PropValidUntil, 0, '<Day,2>/<Month,2>/<Year4>')) { }
            dataitem(SUCOmipPowerEntry; "SUC Omip Power Entry")
            {
                DataItemTableView = sorting("Rate No.") order(ascending);
                DataItemLink = "Proposal No." = field("No.");
                dataitem(SUCOmipEnergyEntry; "SUC Omip Energy Entry")
                {
                    DataItemTableView = sorting("Rate No.", Times, Type);
                    DataItemLink = "Proposal No." = field("Proposal No."), "Rate No." = field("Rate No.");
                    column(PETimes; "Times Text") { }
                    column(PE1; BlankZeroFormatted(Format(P1))) { }
                    column(PE2; BlankZeroFormatted(Format(P2))) { }
                    column(PE3; BlankZeroFormatted(Format(P3))) { }
                    column(PE4; BlankZeroFormatted(Format(P4))) { }
                    column(PE5; BlankZeroFormatted(Format(P5))) { }
                    column(PE6; BlankZeroFormatted(Format(P6))) { }
                    column(OmipPrice; "Omip price") { }
                    column(EnergyPeriodByTram; EnergyPeriodByTram) { }
                    trigger OnPreDataItem()
                    begin
                        Clear(EnergyPeriodByTram);
                        Clear(EnergyStartDate);
                        Clear(EnergyEndDate);
                        EnergyStartDate := SUCOmipProposel."Contract Start Date";
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        if P1 = 0 then
                            CurrReport.Skip();
                        EnergyEndDate := CalcDate('<+1Y-1D>', EnergyStartDate);
                        EnergyPeriodByTram := Format(EnergyStartDate, 0, '<Day,2>/<Month,2>/<Year4>') + ' - ' + Format(EnergyEndDate, 0, '<Day,2>/<Month,2>/<Year4>');
                        EnergyStartDate := CalcDate('<+1Y>', EnergyStartDate);
                    end;
                }
                dataitem(SUCOmipProposalMulticups; "SUC Omip Proposal Multicups")
                {
                    DataItemTableView = sorting("Proposal No.", "Customer CUPS");
                    DataItemLink = "Proposal No." = field("Proposal No."), "Rate No." = field("Rate No.");
                    dataitem(SUCOmipContractedPower; "SUC Omip Contracted Power")
                    {
                        DataItemTableView = sorting("Document Type", "Document No.", CUPS);
                        DataItemLink = "Document No." = field("Proposal No."), "CUPS" = field("Customer CUPS");
                        column(P1CP; BlankZeroFormatted(Format(P1))) { }
                        column(P2CP; BlankZeroFormatted(Format(P2))) { }
                        column(P3CP; BlankZeroFormatted(Format(P3))) { }
                        column(P4CP; BlankZeroFormatted(Format(P4))) { }
                        column(P5CP; BlankZeroFormatted(Format(P5))) { }
                        column(P6CP; BlankZeroFormatted(Format(P6))) { }
                        trigger OnPreDataItem()
                        begin
                            SetRange("Document Type", "Document Type"::Proposal);
                        end;
                    }
                    dataitem(SUCOmipConsumptionDeclared; "SUC Omip Consumption Declared")
                    {
                        DataItemTableView = sorting("Document Type", "Document No.", CUPS);
                        DataItemLink = "Document No." = field("Proposal No."), "CUPS" = field("Customer CUPS");
                        column(P1CD; BlankZeroFormatted(Format(P1))) { }
                        column(P2CD; BlankZeroFormatted(Format(P2))) { }
                        column(P3CD; BlankZeroFormatted(Format(P3))) { }
                        column(P4CD; BlankZeroFormatted(Format(P4))) { }
                        column(P5CD; BlankZeroFormatted(Format(P5))) { }
                        column(P6CD; BlankZeroFormatted(Format(P6))) { }
                        trigger OnPreDataItem()
                        begin
                            SetRange("Document Type", "Document Type"::Proposal);
                        end;
                    }
                    column(CustomerCUPSMC; "Customer CUPS") { }
                    column(RateNoMC; "Rate No.") { }
                    column(VolumeMC; Volume) { }
                    column(DummyMulticups; DummyMulticups) { }
                    trigger OnPreDataItem()
                    begin
                        Clear(DummyMulticups);
                        Clear(LineNoMulticups);
                        LastLineMulticups := SUCOmipProposalMulticups.Count;
                    end;

                    trigger OnAfterGetRecord()
                    var
                        LastLineMulticups2: Integer;
                    begin
                        LastLineMulticups2 := LastLineMulticups - 1;
                        LineNoMulticups += 1;
                        if LastLineMulticups = LineNoMulticups then begin

                            if (LastLineMulticups = 1) or (LastLineMulticups2 mod 3 = 0) then //* 1 CUPS per page 
                                DummyMulticups := LineBreak(30);

                            if (LastLineMulticups mod 3 = 2) then //* 2 CUPS per page 
                                DummyMulticups := LineBreak(15);
                        end else
                            DummyMulticups := '';
                    end;
                }
                column(RateNo; "Rate No.") { }
                column(PP1; BlankZeroFormatted(Format(P1))) { }
                column(PP2; BlankZeroFormatted(Format(P2))) { }
                column(PP3; BlankZeroFormatted(Format(P3))) { }
                column(PP4; BlankZeroFormatted(Format(P4))) { }
                column(PP5; BlankZeroFormatted(Format(P5))) { }
                column(PP6; BlankZeroFormatted(Format(P6))) { }
                column(DummyEnergyEntry; DummyEnergyEntry) { }
                trigger OnPreDataItem()
                begin
                    Clear(LineNoPowerEntry);
                end;

                trigger OnAfterGetRecord()
                begin
                    LineNoPowerEntry += 1;
                    CalculateLineBreaks();
                end;
            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Customer Name", "Marketer Name");
                Customer.Get("Customer No.");
                case Times of
                    Times::" ", Times::"12M":
                        ContractType := CustomPriceLbl;
                    else
                        ContractType := LongTermLbl;
                end;
                SUCOmipManagement.GetDataFromTime(Times, "Contract Start Date", ContractPeriod, EndDate);
                PropValidUntil := CalcDate(SUCOmipSetup."Time Validity Proposals", "Date Proposal");
            end;
        }
    }

    trigger OnPreReport()
    var
        Language: Codeunit Language;
    begin
        SUCOmipSetup.Get();
        CurrReport.Language(Language.GetLanguageId('ESP'));
    end;

    local procedure GetMonthProposel(TimesMonthIn: Enum "SUC Omip Times"): Text[10]
    begin
        case TimesMonthIn of
            TimesMonthIn::"12M":
                exit('12 MESES');
            TimesMonthIn::"24M":
                exit('24 MESES');
            TimesMonthIn::"36M":
                exit('36 MESES');
            TimesMonthIn::"48M":
                exit('48 MESES');
            TimesMonthIn::"60M":
                exit('60 MESES');
        end;
    end;

    local procedure BlankZeroFormatted(NumberFormatted: Text): Text
    var
        Number: Integer;
    begin
        if Evaluate(Number, NumberFormatted) and (Number = 0) then
            exit('-')
        else
            exit(NumberFormatted);
    end;

    local procedure CalculateLineBreaks()
    begin
        case LineNoPowerEntry of
            1:
                case SUCOmipProposel.Times.AsInteger() of
                    1:
                        DummyEnergyEntry := LineBreak(10);
                    2:
                        DummyEnergyEntry := LineBreak(8);
                    3:
                        DummyEnergyEntry := LineBreak(5);
                    4:
                        DummyEnergyEntry := LineBreak(2);
                    5:
                        DummyEnergyEntry := '';
                end;
            else
                case SUCOmipProposel.Times.AsInteger() of
                    1:
                        DummyEnergyEntry := LineBreak(30);
                    2:
                        DummyEnergyEntry := LineBreak(28);
                    3:
                        DummyEnergyEntry := LineBreak(25);
                    4:
                        DummyEnergyEntry := LineBreak(22);
                    5:
                        DummyEnergyEntry := LineBreak(19);
                end;
        end;
    end;

    procedure LineBreak(QtyLineBreak: Integer) ReturnValue: Text
    var
        TypeHelper: Codeunit "Type Helper";
        i: Integer;
    begin
        ReturnValue := '';

        for i := 1 to QtyLineBreak do
            ReturnValue += TypeHelper.CRLFSeparator();
    end;

    var
        Customer: Record Customer;
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        ContractType: Text;
        ContractPeriod: Text;
        EndDate: Date;
        EnergyStartDate: Date;
        EnergyEndDate: Date;
        PropValidUntil: Date;
        EnergyPeriodByTram: Text;
        DummyEnergyEntry: Text;
        DummyMulticups: Text;
        LineNoPowerEntry: Integer;
        LastLineMulticups: Integer;
        LineNoMulticups: Integer;
        CustomPriceLbl: Label 'Custom Price';
        LongTermLbl: Label 'Long Term';
}