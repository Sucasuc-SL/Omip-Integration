namespace Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.User;
using Microsoft.Inventory.Intrastat;
using System.Text;
using System.Email;
using System.Utilities;
using Microsoft.Sales.Customer;
using Sucasuc.Omip.Contracts;
using Microsoft.Finance.VAT.Setup;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Contract;
using Microsoft.Foundation.NoSeries;
using Microsoft.Foundation.Address;
using Sucasuc.Omip.Setup;
using Sucasuc.Omip.BTP;
using Sucasuc.Energy.Ledger;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Auditing;
/// <summary>
/// Codeunit SUC Omip Management (ID 50151).
/// </summary>
codeunit 50151 "SUC Omip Management"
{
    var
        SUCOmipDocumentType: Enum "SUC Omip Document Type";
        SUCOmipAcceptanceMethod: Enum "SUC Omip Acceptance Method";
        SUCOmipActionTrackingBTP: Enum "SUC Omip Action Tracking BTP";
        ErrorLbl: Label 'Document Type not found';

    /// <summary>
    /// InitializedOmipAveragePrices.
    /// </summary>
    procedure InitializedOmipAveragePrices()
    var
        SUCOmipAveragePrices: Record "SUC Omip Average Prices";
        SUCOmipAveragePricesCont: Record "SUC Omip Average Prices Cont.";
        SUCOmipTimes: Enum "SUC Omip Times";
    begin
        if not SUCOmipAveragePrices.Get(SUCOmipTimes::"12M") then
            NewOmipAveragePrices(1, SUCOmipTimes::"12M")
        else
            UpdateTypesOmipAveragePrices(1, SUCOmipAveragePrices, SUCOmipAveragePricesCont);

        if not SUCOmipAveragePrices.Get(SUCOmipTimes::"24M") then
            NewOmipAveragePrices(1, SUCOmipTimes::"24M")
        else
            UpdateTypesOmipAveragePrices(1, SUCOmipAveragePrices, SUCOmipAveragePricesCont);

        if not SUCOmipAveragePrices.Get(SUCOmipTimes::"36M") then
            NewOmipAveragePrices(1, SUCOmipTimes::"36M")
        else
            UpdateTypesOmipAveragePrices(1, SUCOmipAveragePrices, SUCOmipAveragePricesCont);

        if not SUCOmipAveragePrices.Get(SUCOmipTimes::"48M") then
            NewOmipAveragePrices(1, SUCOmipTimes::"48M")
        else
            UpdateTypesOmipAveragePrices(1, SUCOmipAveragePrices, SUCOmipAveragePricesCont);

        if not SUCOmipAveragePrices.Get(SUCOmipTimes::"60M") then
            NewOmipAveragePrices(1, SUCOmipTimes::"60M")
        else
            UpdateTypesOmipAveragePrices(1, SUCOmipAveragePrices, SUCOmipAveragePricesCont);
    end;
    /// <summary>
    /// InitializedOmipAveragePricesContract.
    /// </summary>
    procedure InitializedOmipAveragePricesContract()
    var
        SUCOmipAveragePrices: Record "SUC Omip Average Prices";
        SUCOmipAveragePricesCont: Record "SUC Omip Average Prices Cont.";
        SUCOmipTimes: Enum "SUC Omip Times";
    begin
        if not SUCOmipAveragePricesCont.Get(SUCOmipTimes::"12M") then
            NewOmipAveragePrices(2, SUCOmipTimes::"12M")
        else
            UpdateTypesOmipAveragePrices(2, SUCOmipAveragePrices, SUCOmipAveragePricesCont);

        if not SUCOmipAveragePricesCont.Get(SUCOmipTimes::"24M") then
            NewOmipAveragePrices(2, SUCOmipTimes::"24M")
        else
            UpdateTypesOmipAveragePrices(2, SUCOmipAveragePrices, SUCOmipAveragePricesCont);

        if not SUCOmipAveragePricesCont.Get(SUCOmipTimes::"36M") then
            NewOmipAveragePrices(2, SUCOmipTimes::"36M")
        else
            UpdateTypesOmipAveragePrices(2, SUCOmipAveragePrices, SUCOmipAveragePricesCont);

        if not SUCOmipAveragePricesCont.Get(SUCOmipTimes::"48M") then
            NewOmipAveragePrices(2, SUCOmipTimes::"48M")
        else
            UpdateTypesOmipAveragePrices(2, SUCOmipAveragePrices, SUCOmipAveragePricesCont);

        if not SUCOmipAveragePricesCont.Get(SUCOmipTimes::"60M") then
            NewOmipAveragePrices(2, SUCOmipTimes::"60M")
        else
            UpdateTypesOmipAveragePrices(2, SUCOmipAveragePrices, SUCOmipAveragePricesCont);
    end;

    local procedure NewOmipAveragePrices(PricesType: Integer; TimesIn: Enum "SUC Omip Times")
    var
        SUCOmipAveragePrices: Record "SUC Omip Average Prices";
        SUCOmipAveragePricesCont: Record "SUC Omip Average Prices Cont.";
    begin
        case PricesType of
            1:
                begin
                    SUCOmipAveragePrices.Init();
                    SUCOmipAveragePrices.Validate(Times, TimesIn);
                    SUCOmipAveragePrices.Insert();
                end;
            2:
                begin
                    SUCOmipAveragePricesCont.Init();
                    SUCOmipAveragePricesCont.Validate(Times, TimesIn);
                    SUCOmipAveragePricesCont.Insert();
                end;
        end;
    end;

    local procedure UpdateTypesOmipAveragePrices(PricesType: Integer; SUCOmipAveragePrices: Record "SUC Omip Average Prices"; SUCOmipAveragePricesCont: Record "SUC Omip Average Prices Cont.")
    begin
        case PricesType of
            1:
                begin
                    SUCOmipAveragePrices.Validate("Type 1", 0);
                    SUCOmipAveragePrices.Validate("Type 2", 0);
                    SUCOmipAveragePrices.Validate("Type 3", 0);
                    SUCOmipAveragePrices.Validate("Type 4", 0);
                    SUCOmipAveragePrices.Validate("Type 5", 0);
                    SUCOmipAveragePrices.Validate("Type 6", 0);
                    SUCOmipAveragePrices.Modify();
                end;
            2:
                begin
                    SUCOmipAveragePricesCont.Validate("Type 1", 0);
                    SUCOmipAveragePricesCont.Validate("Type 2", 0);
                    SUCOmipAveragePricesCont.Validate("Type 3", 0);
                    SUCOmipAveragePricesCont.Validate("Type 4", 0);
                    SUCOmipAveragePricesCont.Validate("Type 5", 0);
                    SUCOmipAveragePricesCont.Validate("Type 6", 0);
                    SUCOmipAveragePricesCont.Modify();
                end;
        end;
    end;

    /// <summary>
    /// CalculateOmipAveragePrices.
    /// </summary>
    procedure GetDateOmipAveragePrices()
    var
        SUCOmipAvPricesCalculate: Page "SUC Omip Av. Prices Calculate";
        ProcessDate: Date;
    begin
        Clear(SUCOmipAvPricesCalculate);
        if SUCOmipAvPricesCalculate.RunModal() = Action::OK then begin
            ProcessDate := SUCOmipAvPricesCalculate.GetDateToCalculate();
            CalculateOmipAveragePrices(ProcessDate);
        end;
    end;

    local procedure CalculateOmipAveragePrices(ProcessDateIn: Date)
    var
        SUCOmipMonthlyPrices: Record "SUC Omip Monthly Prices";
    begin
        if ProcessDateIn = 0D then
            exit;

        InitializeMonthlyPricesData(SUCOmipMonthlyPrices, ProcessDateIn);
        ProcessPricesByAllPeriods(SUCOmipMonthlyPrices);
        CalculateAveragePricesByTimeRanges(ProcessDateIn);

        // Copy calculated prices to historical table for audit and tracking purposes
        CopyMonthlyPricesToHistory();
    end;

    local procedure CopyMonthlyPricesToHistory()
    var
        SUCOmipMonthlyPriceHist: Record "SUC Omip Monthly Price Hist";
    begin
        SUCOmipMonthlyPriceHist.CopyFromMonthlyPrices();
    end;

    local procedure InitializeMonthlyPricesData(var SUCOmipMonthlyPrices: Record "SUC Omip Monthly Prices"; ProcessDateIn: Date)
    var
        ProcessDate: Date;
        i: Integer;
    begin
        SUCOmipMonthlyPrices.DeleteAll();
        ProcessDate := CalcDate('<-CM>', ProcessDateIn);

        for i := 1 to 100 do begin
            SUCOmipMonthlyPrices.Init();
            InitializeDistributionMonth(SUCOmipMonthlyPrices, i, ProcessDate);
            SUCOmipMonthlyPrices.Insert();
        end;
    end;

    local procedure ProcessPricesByAllPeriods(var SUCOmipMonthlyPrices: Record "SUC Omip Monthly Prices")
    begin
        PricesByMonth(SUCOmipMonthlyPrices);
        PricesByQuater(SUCOmipMonthlyPrices);
        PricesByYear(SUCOmipMonthlyPrices);
    end;

    local procedure InitializeDistributionMonth(var SUCOmipMonthlyPricesIn: Record "SUC Omip Monthly Prices"; EntryIndex: Integer; var ProcessDateIn: Date)
    var
        Month: Integer;
        Year: Integer;
        MonthLbl: Label 'MES';
    begin
        // Advance date for entries after the first one
        if EntryIndex > 1 then
            ProcessDateIn := CalcDate('<1M>', ProcessDateIn);

        PopulateBasicDateFields(SUCOmipMonthlyPricesIn, ProcessDateIn, Month, Year);
        PopulateCalculatedFields(SUCOmipMonthlyPricesIn, Month, Year, MonthLbl, EntryIndex);
    end;

    local procedure PopulateBasicDateFields(var SUCOmipMonthlyPricesIn: Record "SUC Omip Monthly Prices"; ProcessDateIn: Date; var Month: Integer; var Year: Integer)
    begin
        Month := Date2DMY(ProcessDateIn, 2);
        Year := Date2DMY(ProcessDateIn, 3);

        // Convert year to 2 digits to maintain consistency with SUC Omip Entry
        if Year > 100 then
            Year := Year mod 100;

        SUCOmipMonthlyPricesIn.Validate("Entry No.", GetLastEntry(SUCOmipMonthlyPricesIn));
        SUCOmipMonthlyPricesIn.Validate("Start Date Month", ProcessDateIn);
        SUCOmipMonthlyPricesIn.Validate(Year, Year);
        SUCOmipMonthlyPricesIn.Validate(Month, Month);
    end;

    local procedure PopulateCalculatedFields(var SUCOmipMonthlyPricesIn: Record "SUC Omip Monthly Prices"; Month: Integer; Year: Integer; MonthLabel: Text; EntryIndex: Integer)
    begin
        // Calculate quarter reference (Q1, Q2, Q3, Q4)
        SUCOmipMonthlyPricesIn.Validate("Ref. Trim", 'Q' + Format((Month - 1) div 3 + 1));

        // Set month-year reference
        SUCOmipMonthlyPricesIn.Validate("Ref. Month", GetNameMonthYear(Month, Year));

        // Set formatted month type with proper zero padding
        SUCOmipMonthlyPricesIn.Validate("Type Month", FormatMonthType(MonthLabel, EntryIndex));
    end;

    local procedure FormatMonthType(MonthLabel: Text; EntryIndex: Integer): Text
    begin
        if EntryIndex <= 9 then
            exit(MonthLabel + ' 0' + Format(EntryIndex))
        else
            exit(MonthLabel + ' ' + Format(EntryIndex));
    end;

    local procedure GetLastEntry(var SUCOmipMonthlyPricesIn: Record "SUC Omip Monthly Prices"): Integer
    begin
        SUCOmipMonthlyPricesIn.Reset();
        if SUCOmipMonthlyPricesIn.FindLast() then
            exit(SUCOmipMonthlyPricesIn."Entry No." + 1)
        else
            exit(1);
    end;

    local procedure PricesByMonth(var SUCOmipMonthlyPricesIn: Record "SUC Omip Monthly Prices")
    var
        CountRecord: Integer;
    begin
        if SUCOmipMonthlyPricesIn.FindSet() then
            repeat
                CountRecord += 1;
                UpdatePriceFromEntry(SUCOmipMonthlyPricesIn, "SUC Omip Entry Date Type"::Month,
                    Format(SUCOmipMonthlyPricesIn.Month));
            until (SUCOmipMonthlyPricesIn.Next() = 0) or (CountRecord = 6);
    end;

    local procedure PricesByQuater(var SUCOmipMonthlyPricesIn: Record "SUC Omip Monthly Prices")
    begin
        SUCOmipMonthlyPricesIn.Reset();
        SUCOmipMonthlyPricesIn.SetRange("Range Prices", 0);
        if SUCOmipMonthlyPricesIn.FindSet() then
            repeat
                UpdatePriceFromEntry(SUCOmipMonthlyPricesIn, "SUC Omip Entry Date Type"::Quarter,
                    CopyStr(SUCOmipMonthlyPricesIn."Ref. Trim", 2, 2));
            until SUCOmipMonthlyPricesIn.Next() = 0;
    end;

    local procedure PricesByYear(var SUCOmipMonthlyPricesIn: Record "SUC Omip Monthly Prices")
    begin
        SUCOmipMonthlyPricesIn.Reset();
        SUCOmipMonthlyPricesIn.SetRange("Range Prices", 0);
        if SUCOmipMonthlyPricesIn.FindSet() then
            repeat
                UpdatePriceFromEntry(SUCOmipMonthlyPricesIn, "SUC Omip Entry Date Type"::Year, '');
            until SUCOmipMonthlyPricesIn.Next() = 0;
    end;

    local procedure UpdatePriceFromEntry(var SUCOmipMonthlyPricesIn: Record "SUC Omip Monthly Prices"; DateType: Enum "SUC Omip Entry Date Type"; ValueFilter: Text)
    var
        SUCOmipEntry: Record "SUC Omip Entry";
    begin
        SUCOmipEntry.Reset();
        SUCOmipEntry.SetRange("Date Type", DateType);
        SUCOmipEntry.SetRange(Year, SUCOmipMonthlyPricesIn.Year);

        if ValueFilter <> '' then
            SUCOmipEntry.SetRange(Value, ValueFilter);

        if SUCOmipEntry.FindFirst() then begin
            SUCOmipMonthlyPricesIn."Range Prices" := SUCOmipEntry.Price;
            SUCOmipMonthlyPricesIn.Modify();
        end;
    end;

    local procedure GetNameMonthYear(MonthsIn: Integer; YearIn: Integer): Text[15]
    begin
        case MonthsIn of
            1:
                exit('Jan-' + Format(YearIn));
            2:
                exit('Feb-' + Format(YearIn));
            3:
                exit('Mar-' + Format(YearIn));
            4:
                exit('Apr-' + Format(YearIn));
            5:
                exit('May-' + Format(YearIn));
            6:
                exit('Jun-' + Format(YearIn));
            7:
                exit('Jul-' + Format(YearIn));
            8:
                exit('Aug-' + Format(YearIn));
            9:
                exit('Sep-' + Format(YearIn));
            10:
                exit('Oct-' + Format(YearIn));
            11:
                exit('Nov-' + Format(YearIn));
            12:
                exit('Dec-' + Format(YearIn));
        end;
    end;

    local procedure CalculateAveragePricesByTimeRanges(ProcessDateIn: Date)
    var
        SUCOmipAveragePrices: Record "SUC Omip Average Prices";
    begin
        SUCOmipAveragePrices.Reset();
        if SUCOmipAveragePrices.FindSet() then
            repeat
                SUCOmipAveragePrices.Validate("Calculation Date", ProcessDateIn);
                ProcessAveragePricesByTimeRange(SUCOmipAveragePrices, ProcessDateIn);
            until SUCOmipAveragePrices.Next() = 0;
    end;

    local procedure ProcessAveragePricesByTimeRange(var SUCOmipAveragePrices: Record "SUC Omip Average Prices"; ProcessDateIn: Date)
    var
        ProcessDate: Date;
    begin
        ProcessDate := GetProcessDateByTimeRange(SUCOmipAveragePrices.Times, ProcessDateIn);
        UpdateAllTypeFields(SUCOmipAveragePrices, ProcessDate);
    end;

    local procedure GetProcessDateByTimeRange(TimeRange: Enum "SUC Omip Times"; ProcessDateIn: Date): Date
    begin
        case TimeRange of
            TimeRange::"12M":
                exit(CalcDate('<-CM>', ProcessDateIn));
            TimeRange::"24M":
                exit(CalcDate('<+1Y -CM>', ProcessDateIn));
            TimeRange::"36M":
                exit(CalcDate('<+2Y -CM>', ProcessDateIn));
            TimeRange::"48M":
                exit(CalcDate('<+3Y -CM>', ProcessDateIn));
            TimeRange::"60M":
                exit(CalcDate('<+4Y -CM>', ProcessDateIn));
        end;
    end;

    local procedure UpdateAllTypeFields(var SUCOmipAveragePrices: Record "SUC Omip Average Prices"; var ProcessDate: Date)
    var
        i: Integer;
    begin
        for i := 1 to 6 do begin
            // Advance date for Types 2-6 (but not for Type 1)
            if i > 1 then
                ProcessDate := CalcDate('<+1M>', ProcessDate);

            UpdateTypeFieldByIndex(SUCOmipAveragePrices, i, GetCalculatePrice(ProcessDate));
        end;
    end;

    local procedure UpdateTypeFieldByIndex(var SUCOmipAveragePrices: Record "SUC Omip Average Prices"; TypeIndex: Integer; Price: Decimal)
    begin
        case TypeIndex of
            1:
                SUCOmipAveragePrices.Validate("Type 1", Price);
            2:
                SUCOmipAveragePrices.Validate("Type 2", Price);
            3:
                SUCOmipAveragePrices.Validate("Type 3", Price);
            4:
                SUCOmipAveragePrices.Validate("Type 4", Price);
            5:
                SUCOmipAveragePrices.Validate("Type 5", Price);
            6:
                SUCOmipAveragePrices.Validate("Type 6", Price);
        end;
        SUCOmipAveragePrices.Modify();
    end;

    local procedure GetCalculatePrice(ProcessDateIn: Date): Decimal;
    var
        SUCOmipMonthlyPrices: Record "SUC Omip Monthly Prices";
        EndDate: Date;
        StartDate: Date;
        AmountRound: Decimal;
        PriceAmount: Decimal;
    begin
        Clear(PriceAmount);

        StartDate := ProcessDateIn;
        EndDate := CalcDate('<12M -1D>', ProcessDateIn);

        SUCOmipMonthlyPrices.Reset();
        SUCOmipMonthlyPrices.SetRange("Start Date Month", StartDate, EndDate);
        if SUCOmipMonthlyPrices.FindSet() then
            repeat
                PriceAmount += SUCOmipMonthlyPrices."Range Prices";
            until SUCOmipMonthlyPrices.Next() = 0;

        AmountRound := Round(PriceAmount / 12, 0.01);

        exit(AmountRound);
    end;

    /// <summary>
    /// GetDateOmipAveragePricesContr.
    /// </summary>
    procedure CalculateOmipAveragePricesContract()
    var
        SUCOmipAveragePrices: Record "SUC Omip Average Prices";
        SUCOmipAveragePricesCont: Record "SUC Omip Average Prices Cont.";
        SUCOmipVolatilityPremium: Record "SUC Omip Volatility Premium";
    begin
        SUCOmipAveragePricesCont.Reset();
        if SUCOmipAveragePricesCont.FindSet() then
            repeat
                if (SUCOmipAveragePrices.Get(SUCOmipAveragePricesCont.Times)) and (SUCOmipVolatilityPremium.Get(SUCOmipAveragePricesCont.Times)) then begin
                    SUCOmipAveragePricesCont.Validate("Type 1", SUCOmipAveragePrices."Type 1" + SUCOmipVolatilityPremium."Amount/MWh");
                    SUCOmipAveragePricesCont.Validate("Type 2", SUCOmipAveragePrices."Type 2" + SUCOmipVolatilityPremium."Amount/MWh");
                    SUCOmipAveragePricesCont.Validate("Type 3", SUCOmipAveragePrices."Type 3" + SUCOmipVolatilityPremium."Amount/MWh");
                    SUCOmipAveragePricesCont.Validate("Type 4", SUCOmipAveragePrices."Type 4" + SUCOmipVolatilityPremium."Amount/MWh");
                    SUCOmipAveragePricesCont.Validate("Type 5", SUCOmipAveragePrices."Type 5" + SUCOmipVolatilityPremium."Amount/MWh");
                    SUCOmipAveragePricesCont.Validate("Type 6", SUCOmipAveragePrices."Type 6" + SUCOmipVolatilityPremium."Amount/MWh");
                    SUCOmipAveragePricesCont.Modify();
                end;
            until SUCOmipAveragePricesCont.Next() = 0;
    end;

    procedure GetDataOmipRatesEntry()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipRatesEntryCalculate: Page "SUC Omip Rates Entry Calculate";
        EnergyOrigen: Enum "SUC Omip Energy Origen";
        ProductType: Enum "SUC Product Type";
        GenerateDoc: Boolean;
        NewDocNo: Code[20];
        MarketerNo: Code[20];
        RateNo: Code[20];
        AgentNo: Code[100];
        ComercialFEE: array[6] of Decimal;
        EnergyCalculationMatrix: array[6] of Decimal;
        RealFEE: array[6] of Decimal;
        FEECorrector: Decimal;
        PriceBase: Decimal;
        Type: Enum "SUC Omip Rate Entry Types";
        Time: Enum "SUC Omip Times";
        ProsegurTypeUse: Code[20];
        ProsegurTypeAlarm: Code[20];
    begin
        Clear(SUCOmipRatesEntryCalculate);
        if SUCOmipRatesEntryCalculate.RunModal() = Action::OK then begin
            SUCOmipRatesEntryCalculate.GetDataToCalculate4(ProductType, MarketerNo, Type, Time, PriceBase, FEECorrector, RateNo, GenerateDoc, EnergyOrigen, AgentNo,
                                                           ProsegurTypeUse, ProsegurTypeAlarm);
            case ProductType of
                ProductType::Omip:
                    begin
                        GetComercialFEEEnergyAgent(AgentNo, MarketerNo, RateNo, ComercialFEE);
                        SetPricesByTime(Type, MarketerNo, EnergyOrigen, true, ComercialFEE, false, EnergyCalculationMatrix, RealFEE);

                        if GenerateDoc then begin
                            NewDocNo := GenerateProposal3(MarketerNo, RateNo, Type, Time, EnergyOrigen, false, '', AgentNo, '');
                            SUCOmipProposals.Get(NewDocNo);
                            Page.Run(Page::"SUC Omip Proposals Card", SUCOmipProposals);
                        end;
                    end;
                ProductType::Prosegur:
                    begin
                        NewDocNo := GenerateProposalProsegur(ProsegurTypeUse, ProsegurTypeAlarm, AgentNo);
                        SUCOmipProposals.Get(NewDocNo);
                        Page.Run(Page::"SUC Omip Proposals Card", SUCOmipProposals);
                    end;
            end;
        end;
    end;

    procedure GetDataOmipRatesEntryContract()
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCContractControlCalculate: Page "SUC Contract Control Calculate";
        EnergyOrigen: Enum "SUC Omip Energy Origen";
        EnergyType: Enum "SUC Energy Type";
        Type: Enum "SUC Omip Rate Entry Types";
        Time: Enum "SUC Omip Times";
        ContratationType: Enum "SUC Contratation Type";
        SUCRateType: Enum "SUC Rate Type Contract";
        SUCProductType: Enum "SUC Product Type";
        GenerateDoc: Boolean;
        NewDocNo: Code[20];
        MarketerNo: Code[20];
        RateNo: Code[20];
        AgentNo: Code[100];
        ComercialFEE: array[6] of Decimal;
        EnergyCalculationMatrix: array[6] of Decimal;
        RealFEE: array[6] of Decimal;
        FEECorrector: Decimal;
        PriceBase: Decimal;
        ContractModality: Text[100];
        ControlPricesEnergyId: Integer;
    begin
        Clear(SUCContractControlCalculate);
        if SUCContractControlCalculate.RunModal() = Action::OK then begin
            SUCContractControlCalculate.GetDataToCalculate3(SUCProductType, MarketerNo, Type, Time, PriceBase, FEECorrector, RateNo, GenerateDoc, EnergyOrigen, EnergyType, ContratationType, SUCRateType, ContractModality, ControlPricesEnergyId, AgentNo);
            case SUCProductType of
                SUCProductType::Omip:
                    begin
                        GetComercialFEEEnergyAgent(AgentNo, MarketerNo, RateNo, ComercialFEE);
                        SetPricesByTime(Type, MarketerNo, EnergyOrigen, true, ComercialFEE, false, EnergyCalculationMatrix, RealFEE);
                    end;
            end;

            if GenerateDoc then begin
                NewDocNo := GenerateContractInd3(SUCProductType, MarketerNo, RateNo, Type, Time, EnergyOrigen, false, EnergyType, ContratationType, SUCRateType, ContractModality, ControlPricesEnergyId, AgentNo);
                SUCOmipEnergyContracts.Get(NewDocNo);
                Page.Run(Page::"SUC Omip Energy Contracts", SUCOmipEnergyContracts);
            end;
        end;
    end;
    /// <summary>
    /// GetPriceBase.
    /// </summary>
    /// <param name="TypeIn">Enum "SUC Omip Rate Entry Types".</param>
    /// <param name="TimeIn">Integer.</param>
    /// <returns>Return variable PriceBase of type Decimal.</returns>
    procedure SUCGetPriceBase(TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Integer) PriceBase: Decimal
    var
        SUCOmipAveragePricesCont: Record "SUC Omip Average Prices Cont.";
    begin
        SUCOmipAveragePricesCont.Reset();
        SUCOmipAveragePricesCont.SetRange(Times, TimeIn);
        if SUCOmipAveragePricesCont.FindLast() then
            case TypeIn of
                TypeIn::"Type 1":
                    PriceBase := SUCOmipAveragePricesCont."Type 1";
                TypeIn::"Type 2":
                    PriceBase := SUCOmipAveragePricesCont."Type 2";
                TypeIn::"Type 3":
                    PriceBase := SUCOmipAveragePricesCont."Type 3";
                TypeIn::"Type 4":
                    PriceBase := SUCOmipAveragePricesCont."Type 4";
                TypeIn::"Type 5":
                    PriceBase := SUCOmipAveragePricesCont."Type 5";
                TypeIn::"Type 6":
                    PriceBase := SUCOmipAveragePricesCont."Type 6";
                else
                    PriceBase := 0;
            end
        else
            PriceBase := 0;
    end;

    [Obsolete('Pending removal use SUCGetEnergyWeightedFEE2', '24.36')]
    procedure SUCGetEnergyWeightedFEE(TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Integer) FEECorrector: Decimal
    begin
    end;

    [Obsolete('Replaced by GetFEECorrector', '25.02')]
    procedure SUCGetEnergyWeightedFEE2(MarketerNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Integer) FEECorrector: Decimal
    begin
    end;

    procedure GetFEECorrector(MarketerNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Integer) FEECorrector: Decimal
    var
        SUCOmipFEECorrector2: Record "SUC Omip FEE Corrector 2";
    begin
        if SUCOmipFEECorrector2.Get(MarketerNoIn, TypeIn) then
            case TimeIn of
                1: //* 12M
                    FEECorrector := SUCOmipFEECorrector2."12M";
                2: //* 24M
                    FEECorrector := SUCOmipFEECorrector2."24M";
                3: //* 36M
                    FEECorrector := SUCOmipFEECorrector2."36M";
                4: //* 48M
                    FEECorrector := SUCOmipFEECorrector2."48M";
                5: //* 60M
                    FEECorrector := SUCOmipFEECorrector2."60M";
                else
                    FEECorrector := 0;
            end
        else
            FEECorrector := 0;
    end;

    [Obsolete('Pending removal use CalculateRatesEntry2', '24.36')]
    procedure CalculateRatesEntry(TimeIn: Integer; PriceBaseIn: Decimal; EnergyOrigen: Enum "SUC Omip Energy Origen")
    begin
    end;

    procedure CalculateRatesEntry2(MarketerNoIn: Code[20]; TimeIn: Integer; PriceBaseIn: Decimal; EnergyOrigen: Enum "SUC Omip Energy Origen")
    var
        SUCOmipRatesEntry2: Record "SUC Omip Rates Entry 2";
    begin
        SUCOmipRatesEntry2.Reset();
        SUCOmipRatesEntry2.SetRange("Marketer No.", MarketerNoIn);
        SUCOmipRatesEntry2.SetRange("Omip Times", TimeIn);
        if SUCOmipRatesEntry2.FindSet() then
            repeat
                SetRatesEntryFixedData3(SUCOmipRatesEntry2, PriceBaseIn, EnergyOrigen, TimeIn);
                SetOperatingExpenses2(MarketerNoIn, TimeIn, SUCOmipRatesEntry2);
                SUCOmipRatesEntry2.Final := ((((SUCOmipRatesEntry2.Omip * SUCOmipRatesEntry2.Apuntament) + SUCOmipRatesEntry2."Rates Entry Premium Open Pos." + SUCOmipRatesEntry2.SSCC + SUCOmipRatesEntry2."Price Capacity" + SUCOmipRatesEntry2."Social Bonus" + SUCOmipRatesEntry2.Detours + SUCOmipRatesEntry2.AFNEE + SUCOmipRatesEntry2."OS/OM" + SUCOmipRatesEntry2.EGREEN) * (1 + SUCOmipRatesEntry2.Losses / 100) + SUCOmipRatesEntry2."Operating Expenses") * (1 + SUCOmipRatesEntry2.IM / 100)) / 1000;
                SUCOmipRatesEntry2."Final + ATR" := SUCOmipRatesEntry2.Final + SUCOmipRatesEntry2.ATR;
                SUCOmipRatesEntry2."Total Final" := SUCOmipRatesEntry2."Final + ATR" * 1000;
                SUCOmipRatesEntry2.Modify();
            until SUCOmipRatesEntry2.Next() = 0;
    end;

    [Obsolete('Pending removal use SetRatesEntryFixedData3', '25.02')]
    local procedure SetRatesEntryFixedData2(var SUCOmipRatesEntry2: Record "SUC Omip Rates Entry 2"; PriceBaseIn: Decimal; EnergyOrigenIn: Enum "SUC Omip Energy Origen")
    begin
    end;

    local procedure SetRatesEntryFixedData3(var SUCOmipRatesEntry2: Record "SUC Omip Rates Entry 2"; PriceBaseIn: Decimal; EnergyOrigenIn: Enum "SUC Omip Energy Origen"; TimeIn: Integer)
    var
        SUCOmipTimes: Record "SUC Omip Times";
    begin
        SUCOmipTimes.Get(SUCOmipRatesEntry2."Marketer No.", TimeIn);
        SUCOmipTimes.TestField("Rates Entry GdOs");
        SUCOmipRatesEntry2.Validate(Omip, PriceBaseIn);
        case EnergyOrigenIn of
            EnergyOrigenIn::"Non-Renewable":
                SUCOmipRatesEntry2.Validate(EGREEN, 0);
            EnergyOrigenIn::Renewable:
                SUCOmipRatesEntry2.Validate(EGREEN, SUCOmipTimes."Rates Entry GdOs");
            else
                SUCOmipRatesEntry2.Validate(EGREEN, 0);
        end;
    end;

    local procedure SetOperatingExpenses2(MarketerNo: Code[20]; TimeIn: Integer; var SUCOmipRatesEntry2: Record "SUC Omip Rates Entry 2")
    var
        SUCOmipEnergyWeighted2: Record "SUC Omip Energy Weighted 2";
    begin
        if SUCOmipEnergyWeighted2.Get(MarketerNo, SUCOmipRatesEntry2."Rate No.", TimeIn) then
            case SUCOmipRatesEntry2."Hired Potency" of
                SUCOmipRatesEntry2."Hired Potency"::P1:
                    SUCOmipRatesEntry2.Validate("Operating Expenses", SUCOmipEnergyWeighted2."FEE P1");
                SUCOmipRatesEntry2."Hired Potency"::P2:
                    SUCOmipRatesEntry2.Validate("Operating Expenses", SUCOmipEnergyWeighted2."FEE P2");
                SUCOmipRatesEntry2."Hired Potency"::P3:
                    SUCOmipRatesEntry2.Validate("Operating Expenses", SUCOmipEnergyWeighted2."FEE P3");
                SUCOmipRatesEntry2."Hired Potency"::P4:
                    SUCOmipRatesEntry2.Validate("Operating Expenses", SUCOmipEnergyWeighted2."FEE P4");
                SUCOmipRatesEntry2."Hired Potency"::P5:
                    SUCOmipRatesEntry2.Validate("Operating Expenses", SUCOmipEnergyWeighted2."FEE P5");
                SUCOmipRatesEntry2."Hired Potency"::P6:
                    SUCOmipRatesEntry2.Validate("Operating Expenses", SUCOmipEnergyWeighted2."FEE P6");
            end;
    end;

    [Obsolete('Replaced by CalculateEnergyWeighted2', '24.36')]
    procedure CalculateEnergyWeighted(TimeIn: Integer; FEEEnergyIn: Decimal; FEECorrector: Decimal)
    begin
    end;

    [Obsolete('Replaced by CalculateEnergyWeighted3', '25.02')]
    procedure CalculateEnergyWeighted2(MarketerNoIn: Code[20]; TimeIn: Integer; FEEEnergyIn: Decimal; FEECorrector: Decimal) //* Precios ponderados de la energía
    begin
    end;

    procedure CalculateEnergyWeighted3(MarketerNoIn: Code[20]; TimeIn: Integer; FEECorrector: Decimal; ComercialFEEEnergy: array[6] of Decimal; WithSIPSInformation: Boolean; FEECorrectorWithFEEReal: array[6] of Decimal; EnergyCalculationMatrix: array[6] of Decimal) //* Precios ponderados de la energía
    var
        SUCOmipEnergyWeighted2: Record "SUC Omip Energy Weighted 2";
    begin
        SUCOmipEnergyWeighted2.Reset();
        SUCOmipEnergyWeighted2.SetRange("Marketer No.", MarketerNoIn);
        SUCOmipEnergyWeighted2.SetRange(Times, TimeIn);
        if SUCOmipEnergyWeighted2.FindSet() then
            repeat
                // if WithSIPSInformation then begin
                //* With only Commercial FEE and FEE Corrector
                SUCOmipEnergyWeighted2.Validate("FEE P1", ComercialFEEEnergy[1] + FEECorrector);
                SUCOmipEnergyWeighted2.Validate("FEE P2", ComercialFEEEnergy[2] + FEECorrector);
                SUCOmipEnergyWeighted2.Validate("FEE P3", ComercialFEEEnergy[3] + FEECorrector);
                SUCOmipEnergyWeighted2.Validate("FEE P4", ComercialFEEEnergy[4] + FEECorrector);
                SUCOmipEnergyWeighted2.Validate("FEE P5", ComercialFEEEnergy[5] + FEECorrector);
                SUCOmipEnergyWeighted2.Validate("FEE P6", ComercialFEEEnergy[6] + FEECorrector);
                //* END With only Commercial FEE and FEE Corrector
                //* With Energy Calculation Matrix and FEE Corrector with FEE Real
                // SUCOmipEnergyWeighted2.Validate("FEE P1", EnergyCalculationMatrix[1] * FEECorrectorWithFEEReal[1]);
                // SUCOmipEnergyWeighted2.Validate("FEE P2", EnergyCalculationMatrix[2] * FEECorrectorWithFEEReal[2]);
                // SUCOmipEnergyWeighted2.Validate("FEE P3", EnergyCalculationMatrix[3] * FEECorrectorWithFEEReal[3]);
                // SUCOmipEnergyWeighted2.Validate("FEE P4", EnergyCalculationMatrix[4] * FEECorrectorWithFEEReal[4]);
                // SUCOmipEnergyWeighted2.Validate("FEE P5", EnergyCalculationMatrix[5] * FEECorrectorWithFEEReal[5]);
                // SUCOmipEnergyWeighted2.Validate("FEE P6", EnergyCalculationMatrix[6] * FEECorrectorWithFEEReal[6]);
                //* END With Energy Calculation Matrix and FEE Corrector with FEE Real
                //* With weighted prices and FEE Energy by Period
                // end else begin
                //     SUCOmipEnergyWeighted2.Validate("FEE P1", ((ComercialFEEEnergy[1] + FEECorrector) * SUCOmipEnergyWeighted2.P1) / 100);
                //     SUCOmipEnergyWeighted2.Validate("FEE P2", ((ComercialFEEEnergy[2] + FEECorrector) * SUCOmipEnergyWeighted2.P2) / 100);
                //     SUCOmipEnergyWeighted2.Validate("FEE P3", ((ComercialFEEEnergy[3] + FEECorrector) * SUCOmipEnergyWeighted2.P3) / 100);
                //     SUCOmipEnergyWeighted2.Validate("FEE P4", ((ComercialFEEEnergy[4] + FEECorrector) * SUCOmipEnergyWeighted2.P4) / 100);
                //     SUCOmipEnergyWeighted2.Validate("FEE P5", ((ComercialFEEEnergy[5] + FEECorrector) * SUCOmipEnergyWeighted2.P5) / 100);
                //     SUCOmipEnergyWeighted2.Validate("FEE P6", ((ComercialFEEEnergy[6] + FEECorrector) * SUCOmipEnergyWeighted2.P6) / 100);
                // end;
                //* END With weighted prices and FEE Energy by Period
                SUCOmipEnergyWeighted2.Modify();
            until SUCOmipEnergyWeighted2.Next() = 0;
    end;

    [Obsolete('Pending removal use GenerateProposal2', '25.1')]
    procedure GenerateProposal(MarketerNoIn: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times"; FEEPotencyIn: Decimal; FEEEnergyIn: Decimal; EnergyOrigen: Enum "SUC Omip Energy Origen"): Code[20]
    begin
    end;

    [Obsolete('Pending removal use GenerateProposal3', '25.2')]
    procedure GenerateProposal2(MarketerNoIn: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times"; FEEPotencyIn: Decimal; FEEEnergyIn: Decimal; EnergyOrigen: Enum "SUC Omip Energy Origen"; multicups: Boolean): Code[20]
    begin
    end;

    procedure GenerateProposal3(MarketerNoIn: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times";
                                EnergyOrigen: Enum "SUC Omip Energy Origen"; multicups: Boolean; customerIBAN: Code[50]; agentNo: Code[100]; FEEGroupID: Code[20]): Code[20]
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipSetup: Record "SUC Omip Setup";
        NoSeries: Codeunit "No. Series";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        DocNo: Code[20];
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Proposal Nos.");
        DocNo := NoSeries.GetNextNo(SUCOmipSetup."Proposal Nos.");
        SUCOmipProposals.Init();
        SUCOmipProposals."No." := DocNo;
        SUCOmipProposals.Validate("Product Type", SUCOmipProposals."Product Type"::Omip);
        SUCOmipProposals.Insert();
        SUCOmipProposals.Validate("Date Proposal", WorkDate());
        SUCOmipProposals."Marketer No." := MarketerNoIn;
        SUCOmipProposals.Validate(Multicups, multicups);
        SUCOmipProposals."Rate No." := RateNoIn;
        SUCOmipProposals.Times := TimeIn;
        SUCOmipProposals."Energy Origen" := EnergyOrigen;
        SUCOmipProposals.Type := TypeIn;
        SUCOmipProposals.Validate("Agent No.", agentNo);
        if FEEGroupID <> '' then
            SUCOmipProposals.Validate("FEE Group Id.", FEEGroupID);
        SUCOmipProposals.Validate("Customer No.", '');
        SUCOmipProposals.Validate("Date Created", Today);
        SUCOmipProposals.Validate("DateTime Created", CurrentDateTime);
        SUCOmipProposals.Validate(IBAN, customerIBAN);
        SUCOmipProposals.Modify();

        SUCOmipManagement.CalculateEnergy2(SUCOmipProposals, RateNoIn, TypeIn, TimeIn);

        exit(DocNo);
    end;

    procedure GenerateProposalProsegur(ProsegurTypeUseIn: Code[20]; ProsegurTypeAlarmIn: Code[20]; agentNo: Code[100]): Code[20]
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipSetup: Record "SUC Omip Setup";
        NoSeries: Codeunit "No. Series";
        DocNo: Code[20];
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Proposal Nos.");
        DocNo := NoSeries.GetNextNo(SUCOmipSetup."Proposal Nos.");
        SUCOmipProposals.Init();
        SUCOmipProposals."No." := DocNo;
        SUCOmipProposals.Validate("Product Type", SUCOmipProposals."Product Type"::Prosegur);
        SUCOmipProposals.Validate("DateTime Created", CurrentDateTime);
        SUCOmipProposals.Insert();
        SUCOmipProposals.Validate("Date Proposal", WorkDate());
        SUCOmipProposals.Validate("Agent No.", agentNo);
        SUCOmipProposals.Validate("Prosegur Type Use", ProsegurTypeUseIn);
        SUCOmipProposals.Validate("Prosegur Type Alarm", ProsegurTypeAlarmIn);
        SUCOmipProposals.Modify();

        exit(DocNo);
    end;

    [Obsolete('Pending removal use CalculateEnergy2', '25.2')]
    procedure CalculateEnergy(SUCOmipProposalsIn: Record "SUC Omip Proposals"; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times"; FEEPotency: Decimal)
    begin
    end;

    procedure CalculateEnergy2(SUCOmipProposalsIn: Record "SUC Omip Proposals"; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times")
    begin
        // CalculatePowerEntry(SUCOmipProposalsIn, RateNoIn, FEEPotency);
        CalculatePowerEntry(SUCOmipProposalsIn, RateNoIn);
        CalculateEnergyEntry(SUCOmipProposalsIn, RateNoIn, TypeIn, TimeIn);
    end;

    // local procedure CalculatePowerEntry(SUCOmipProposalsIn: Record "SUC Omip Proposals"; RateNoIn: Code[20]; FEEPotency: Decimal)
    local procedure CalculatePowerEntry(SUCOmipProposalsIn: Record "SUC Omip Proposals"; RateNoIn: Code[20])
    var
        SUCOmipPowerEntry: Record "SUC Omip Power Entry";
        // SUCOmipPowerCalculation2: Record "SUC Omip Power Calculation 2";
        SUCOmipRegPricePower2: Record "SUC Omip Reg. Price Power 2";
    begin
        if SUCOmipProposalsIn.Multicups then begin
            SUCOmipPowerEntry.Reset();
            SUCOmipPowerEntry.SetRange("Proposal No.", SUCOmipProposalsIn."No.");
            SUCOmipPowerEntry.SetRange("Rate No.", RateNoIn);
            SUCOmipPowerEntry.DeleteAll();

            if RateNoIn <> '' then begin //*When incoming from ODATA the RateNo is null
                SUCOmipRegPricePower2.Reset();
                SUCOmipRegPricePower2.SetRange("Marketer No.", SUCOmipProposalsIn."Marketer No.");
                SUCOmipRegPricePower2.SetRange("Rate No.", RateNoIn);
                SUCOmipRegPricePower2.FindLast();

                InsertPowerEntry(SUCOmipProposalsIn, RateNoIn, SUCOmipRegPricePower2);
            end;
        end else begin
            SUCOmipPowerEntry.Reset();
            SUCOmipPowerEntry.SetRange("Proposal No.", SUCOmipProposalsIn."No.");
            SUCOmipPowerEntry.DeleteAll();

            SUCOmipRegPricePower2.Reset();
            SUCOmipRegPricePower2.SetRange("Marketer No.", SUCOmipProposalsIn."Marketer No.");
            SUCOmipRegPricePower2.SetRange("Rate No.", SUCOmipProposalsIn."Rate No.");
            SUCOmipRegPricePower2.FindLast();

            InsertPowerEntry(SUCOmipProposalsIn, RateNoIn, SUCOmipRegPricePower2);
        end;
    end;

    local procedure InsertPowerEntry(SUCOmipProposalsIn: Record "SUC Omip Proposals"; RateNoIn: Code[20]; SUCOmipRegPricePower2In: Record "SUC Omip Reg. Price Power 2")
    var
        SUCOmipPowerEntry: Record "SUC Omip Power Entry";
        SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
    begin
        if RateNoIn <> '' then
            if not SUCOmipPowerEntry.Get(SUCOmipProposalsIn."No.", RateNoIn) then begin
                SUCOmipProposalsIn.TestField("Marketer No.");
                SUCOmipFEEPowerDocument.Get(SUCOmipFEEPowerDocument."Document Type"::Proposal, SUCOmipProposalsIn."No.", SUCOmipProposalsIn."Marketer No.", RateNoIn);

                SUCOmipPowerEntry.Init();
                SUCOmipPowerEntry."Proposal No." := SUCOmipProposalsIn."No.";
                SUCOmipPowerEntry.Validate("Rate No.", RateNoIn);
                SUCOmipPowerEntry.Validate(P1, SUCOmipRegPricePower2In.P1 + SUCOmipFEEPowerDocument.P1);
                SUCOmipPowerEntry.Validate(P2, SUCOmipRegPricePower2In.P2 + SUCOmipFEEPowerDocument.P2);
                SUCOmipPowerEntry.Validate(P3, SUCOmipRegPricePower2In.P3 + SUCOmipFEEPowerDocument.P3);
                SUCOmipPowerEntry.Validate(P4, SUCOmipRegPricePower2In.P4 + SUCOmipFEEPowerDocument.P4);
                SUCOmipPowerEntry.Validate(P5, SUCOmipRegPricePower2In.P5 + SUCOmipFEEPowerDocument.P5);
                SUCOmipPowerEntry.Validate(P6, SUCOmipRegPricePower2In.P6 + SUCOmipFEEPowerDocument.P6);
                // SUCOmipPowerEntry.Validate(P1, SUCOmipRegPricePower2In.P1 + (SUCOmipPowerCalculation2In.P1 * FEEPotency));
                // SUCOmipPowerEntry.Validate(P2, SUCOmipRegPricePower2In.P2 + (SUCOmipPowerCalculation2In.P2 * FEEPotency));
                // SUCOmipPowerEntry.Validate(P3, SUCOmipRegPricePower2In.P3 + (SUCOmipPowerCalculation2In.P3 * FEEPotency));
                // SUCOmipPowerEntry.Validate(P4, SUCOmipRegPricePower2In.P4 + (SUCOmipPowerCalculation2In.P4 * FEEPotency));
                // SUCOmipPowerEntry.Validate(P5, SUCOmipRegPricePower2In.P5 + (SUCOmipPowerCalculation2In.P5 * FEEPotency));
                // SUCOmipPowerEntry.Validate(P6, SUCOmipRegPricePower2In.P6 + (SUCOmipPowerCalculation2In.P6 * FEEPotency));
                SUCOmipPowerEntry.Validate("Proposal Id", SUCOmipProposalsIn.SystemId);
                SUCOmipPowerEntry.Insert();
            end;
    end;

    local procedure CalculateEnergyEntry(SUCOmipProposalsIn: Record "SUC Omip Proposals"; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times")
    var
        SUCOmipEnergyEntry: Record "SUC Omip Energy Entry";
    begin
        if SUCOmipProposalsIn.Multicups then begin
            SUCOmipEnergyEntry.Reset();
            SUCOmipEnergyEntry.SetRange("Proposal No.", SUCOmipProposalsIn."No.");
            SUCOmipEnergyEntry.SetRange("Rate No.", RateNoIn);
            SUCOmipEnergyEntry.DeleteAll();

            InsertEnergyEntry(SUCOmipProposalsIn, RateNoIn, TypeIn, TimeIn);
            UpdateEnergyEntryPrices(SUCOmipProposalsIn, RateNoIn, TimeIn);
        end else begin
            SUCOmipEnergyEntry.Reset();
            SUCOmipEnergyEntry.SetRange("Proposal No.", SUCOmipProposalsIn."No.");
            SUCOmipEnergyEntry.DeleteAll();

            InsertEnergyEntry(SUCOmipProposalsIn, RateNoIn, TypeIn, TimeIn);
            UpdateEnergyEntryPrices(SUCOmipProposalsIn, RateNoIn, TimeIn);
        end;
    end;

    local procedure InsertEnergyEntry(SUCOmipProposalsIn: Record "SUC Omip Proposals"; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times")
    var
        SUCOmipEnergyEntry: Record "SUC Omip Energy Entry";
        i: Integer;
    begin
        SUCOmipEnergyEntry.Reset();
        SUCOmipEnergyEntry.SetRange("Proposal No.", SUCOmipProposalsIn."No.");
        SUCOmipEnergyEntry.SetRange("Rate No.", RateNoIn);
        SUCOmipEnergyEntry.SetRange(Times, TimeIn);
        SUCOmipEnergyEntry.SetRange(Type, TypeIn);
        if not SUCOmipEnergyEntry.FindSet() then begin
            SUCOmipEnergyEntry.Init();
            for i := 1 to 5 do begin
                SUCOmipEnergyEntry."Proposal No." := SUCOmipProposalsIn."No.";
                SUCOmipEnergyEntry.Validate("Rate No.", RateNoIn);
                SUCOmipEnergyEntry.Validate(Times, Enum::"SUC Omip Times".FromInteger(i));
                SUCOmipEnergyEntry.Validate(Type, TypeIn);
                SUCOmipEnergyEntry.Validate("Proposal Id", SUCOmipProposalsIn.SystemId);
                SUCOmipEnergyEntry.Validate(Enabled, false);
                SUCOmipEnergyEntry.Insert();
            end;
        end;
    end;

    local procedure UpdateEnergyEntryPrices(SUCOmipProposalsIn: Record "SUC Omip Proposals"; RateNoIn: Code[20]; TimeIn: Enum "SUC Omip Times")
    var
        SUCOmipEnergyEntry: Record "SUC Omip Energy Entry";
        SUCOmipRatesEntry2: Record "SUC Omip Rates Entry 2";
    begin
        SUCOmipEnergyEntry.Reset();
        SUCOmipEnergyEntry.SetRange("Proposal No.", SUCOmipProposalsIn."No.");
        SUCOmipEnergyEntry.SetRange("Rate No.", RateNoIn);
        SUCOmipEnergyEntry.SetFilter(Times, '..%1', TimeIn);
        if SUCOmipEnergyEntry.FindSet() then
            repeat
                SUCOmipRatesEntry2.Reset();
                SUCOmipRatesEntry2.SetRange("Marketer No.", SUCOmipProposalsIn."Marketer No.");
                SUCOmipRatesEntry2.SetRange("Rate No.", SUCOmipEnergyEntry."Rate No.");
                SUCOmipRatesEntry2.SetRange("Omip Times", SUCOmipEnergyEntry.Times);
                if SUCOmipRatesEntry2.FindSet() then
                    repeat
                        case SUCOmipRatesEntry2."Hired Potency" of
                            SUCOmipRatesEntry2."Hired Potency"::P1:
                                SUCOmipEnergyEntry.Validate(P1, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P2:
                                SUCOmipEnergyEntry.Validate(P2, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P3:
                                SUCOmipEnergyEntry.Validate(P3, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P4:
                                SUCOmipEnergyEntry.Validate(P4, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P5:
                                SUCOmipEnergyEntry.Validate(P5, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P6:
                                SUCOmipEnergyEntry.Validate(P6, SUCOmipRatesEntry2."Final + ATR");
                        end;
                        SUCOmipEnergyEntry.Validate("Omip price", SUCOmipRatesEntry2.Omip);
                        SUCOmipEnergyEntry.Validate(Enabled, true);
                        SUCOmipEnergyEntry.Modify();
                    until SUCOmipRatesEntry2.Next() = 0;
            until SUCOmipEnergyEntry.Next() = 0;
    end;

    procedure ProcessNewPricesOmipBatch(ProcessPriceDate: Date)
    var
        SUCOmipMarketers: Record "SUC Omip Marketers";
        Type: Enum "SUC Omip Rate Entry Types";
        EnergyOrigen: Enum "SUC Omip Energy Origen";
        ComercialFEE: array[6] of Decimal;
        EnergyCalculationMatrix: array[6] of Decimal;
        RealFEE: array[6] of Decimal;
        i: Integer;
    begin
        CalculateOmipAveragePrices(ProcessPriceDate); //* Precios medios

        CalculateOmipAveragePricesContract(); //* Precios medios contrato (precios medios + prima volatilidad)

        //* Análisis de tarifas
        for i := 1 to 5 do
            ComercialFEE[i] := 0.25;

        SUCOmipMarketers.Reset();
        if SUCOmipMarketers.FindSet() then
            repeat
                SetPricesByTime(Type::"Type 1", SUCOmipMarketers."No.", EnergyOrigen::" ", false, ComercialFEE, false, EnergyCalculationMatrix, RealFEE);
            until SUCOmipMarketers.Next() = 0;
        SendEmailPricesConfirm();
    end;

    procedure SetPricesByTime(TypeIn: Enum "SUC Omip Rate Entry Types"; MarketerNoIn: Code[20]; EnergyOrigenIn: Enum "SUC Omip Energy Origen"; ConfirmIn: Boolean; ComercialFEEEnergyIn: array[6] of Decimal; WithSIPSInformation: Boolean; EnergyCalculationMatrix: array[6] of Decimal; RealFEE: array[6] of Decimal)
    var
        PriceBaseGeneral: Decimal;
        FEECorrectorGeneral: Decimal;
        FEECorrectorWithFEEReal: array[6] of Decimal;
        i: Integer;
        ConfirmLbl: Label 'The base price is zero, do you want to continue?';
    begin
        for i := 1 to 5 do begin //*5 times
            PriceBaseGeneral := SUCGetPriceBase(TypeIn, i);
            if ConfirmIn then
                if PriceBaseGeneral = 0 then
                    if not Confirm(ConfirmLbl) then
                        exit;
            FEECorrectorGeneral := GetFEECorrector(MarketerNoIn, TypeIn, i);

            FEECorrectorWithFEEReal[1] := RealFEE[1] + FEECorrectorGeneral;
            FEECorrectorWithFEEReal[2] := RealFEE[2] + FEECorrectorGeneral;
            FEECorrectorWithFEEReal[3] := RealFEE[3] + FEECorrectorGeneral;
            FEECorrectorWithFEEReal[4] := RealFEE[4] + FEECorrectorGeneral;
            FEECorrectorWithFEEReal[5] := RealFEE[5] + FEECorrectorGeneral;
            FEECorrectorWithFEEReal[6] := RealFEE[6] + FEECorrectorGeneral;

            CalculateEnergyWeighted3(MarketerNoIn, i, FEECorrectorGeneral, ComercialFEEEnergyIn, WithSIPSInformation, FEECorrectorWithFEEReal, EnergyCalculationMatrix);
            CalculateRatesEntry2(MarketerNoIn, i, PriceBaseGeneral, EnergyOrigenIn);
        end;
    end;

    /// <summary>
    /// This codeunit contains the ContractAcceptance procedure which is responsible for accepting energy contracts.
    /// </summary>
    /// <param name="SUCOmipEnergyContractsIn">The input energy contract record to be accepted.</param>
    /// <returns>The status message indicating the result of the contract acceptance.</returns>
    procedure ContractAcceptance(var SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts"): Text
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        ValidTime: Time;
        TodayDT: DateTime;
        DueDT: DateTime;
        SuccessStatusLbl: Label 'The contract status %1 is: %2';
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Time Validity Contracts");
        SUCOmipEnergyContractsIn.TestField("Date Created");
        SUCOmipEnergyContractsIn.TestField("DateTime Created");
        SUCOmipEnergyContractsIn.TestField("Acceptance Method");
        if SUCOmipEnergyContractsIn."Acceptance Method" <> SUCOmipEnergyContractsIn."Acceptance Method"::Paper then
            SUCOmipEnergyContractsIn.TestField("Acceptance Send");

        ValidTime := DT2Time(SUCOmipEnergyContractsIn."DateTime Created");
        TodayDT := CreateDateTime(Today, ValidTime);
        DueDT := CreateDateTime(CalcDate(Format(SUCOmipSetup."Time Validity Contracts"), SUCOmipEnergyContractsIn."Date Created"), ValidTime);

        if (TodayDT <= DueDT) then begin
            if SendContract(SUCOmipEnergyContractsIn, false) then begin
                SUCOmipEnergyContractsIn.Status := SUCOmipEnergyContractsIn.Status::Accepted;

                if not (CurrentClientType in [ClientType::OData, ClientType::ODataV4, ClientType::SOAP, ClientType::Api]) then
                    SendEmailToPurchases(SUCOmipEnergyContractsIn."No.", SUCOmipDocumentType::Contract);

                SUCOmipEnergyContractsIn.Modify();
                exit(StrSubstNo(SuccessStatusLbl, SUCOmipEnergyContractsIn."No.", SUCOmipEnergyContractsIn.Status));
            end;
        end else begin
            SUCOmipEnergyContractsIn.Status := SUCOmipEnergyContractsIn.Status::"Out of Time";
            SUCOmipEnergyContractsIn.Modify();
            exit(StrSubstNo(SuccessStatusLbl, SUCOmipEnergyContractsIn."No.", Format(SUCOmipEnergyContractsIn.Status)));
        end;
    end;

    /// <summary>
    /// Sends a contract.
    /// </summary>
    /// <param name="SUCOmipEnergyContractsIn">The input energy contract record.</param>
    /// <returns>Returns a boolean value indicating the success of sending the contract.</returns>
    procedure SendContract(var SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts"; ValidateStatus: Boolean): Boolean
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipExcludedDomains: Record "SUC Omip Excluded Domains";
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipMarketers: Record "SUC Omip Marketers";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecordRef: RecordRef;
        EmailScenario: Enum "Email Scenario";
        InStream: InStream;
        ExcludeMailLbl: Label 'You are using an excluded mail, so it is not corporate.';
        FileNameLbl: Label 'Contract Commercial';
        SubjectLbl: Label 'Contract acceptance';
        OutStream: OutStream;
        JsonText: Text;
        BodyMail: Text;
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Message Body Contracts");
        SUCOmipEnergyContractsIn.CalcFields("Customer Name");
        SUCOmipEnergyContractsIn.TestField("Marketer No.");
        SUCOmipMarketers.Get(SUCOmipEnergyContractsIn."Marketer No.");

        if ValidateStatus then
            SUCOmipEnergyContractsIn.TestField(Status, SUCOmipEnergyContractsIn.Status::"Pending Acceptance");

        case SUCOmipMarketers.Marketer of
            SUCOmipMarketers.Marketer::Plenitude:
                SendContractPlenitude(SUCOmipEnergyContractsIn);
            else
                case SUCOmipEnergyContractsIn."Acceptance Method" of
                    SUCOmipEnergyContractsIn."Acceptance Method"::Email:
                        begin
                            SUCOmipEnergyContracts.Reset();
                            SUCOmipEnergyContracts.SetRange("No.", SUCOmipEnergyContractsIn."No.");
                            if SUCOmipEnergyContracts.FindSet() then begin
                                RecordRef.GetTable(SUCOmipEnergyContracts);
                                TempBlob.CreateOutStream(OutStream);
                            end;

                            case SUCOmipMarketers.Marketer of
                                SUCOmipMarketers.Marketer::Acis:
                                    begin
                                        BodyMail := HTMLToBTPContractACIS(SUCOmipEnergyContractsIn."Customer Name");
                                        case SUCOmipEnergyContractsIn.Times of
                                            SUCOmipEnergyContractsIn.Times::"12M":
                                                if SUCOmipEnergyContractsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M MC ACIS", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M ACIS", '', ReportFormat::Pdf, OutStream, RecordRef);
                                            else
                                                if SUCOmipEnergyContractsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Contract 12MMC ACISv2", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M ACIS v2", '', ReportFormat::Pdf, OutStream, RecordRef);
                                        end;
                                    end;
                                SUCOmipMarketers.Marketer::Nabalia:
                                    begin
                                        BodyMail := HTMLToBTPContractNabalia(SUCOmipEnergyContractsIn."Customer Name");
                                        case SUCOmipEnergyContractsIn.Times of
                                            SUCOmipEnergyContractsIn.Times::"12M":
                                                if SUCOmipEnergyContractsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M MC NAB", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M NAB", '', ReportFormat::Pdf, OutStream, RecordRef);
                                            else
                                                if SUCOmipEnergyContractsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Contract 12MMC NAB v2", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M NAB v2", '', ReportFormat::Pdf, OutStream, RecordRef);
                                        end;
                                    end;
                                SUCOmipMarketers.Marketer::Avanza:
                                    begin
                                        BodyMail := HTMLToBTPContractAVA(SUCOmipEnergyContractsIn."Customer Name");
                                        case SUCOmipEnergyContractsIn.Times of
                                            SUCOmipEnergyContractsIn.Times::"12M":
                                                if SUCOmipEnergyContractsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M MC AVA", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M AVA", '', ReportFormat::Pdf, OutStream, RecordRef);
                                            else
                                                if SUCOmipEnergyContractsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Contract 12MMC AVA v2", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M AVA v2", '', ReportFormat::Pdf, OutStream, RecordRef);
                                        end;
                                    end;
                                else begin
                                    BodyMail := HTMLToBTPContractNabalia(SUCOmipEnergyContractsIn."Customer Name");
                                    case SUCOmipEnergyContractsIn.Times of
                                        SUCOmipEnergyContractsIn.Times::"12M":
                                            Report.SaveAs(Report::"SUC Omip Contract 12M NAB", '', ReportFormat::Pdf, OutStream, RecordRef);
                                        else
                                            Report.SaveAs(Report::"SUC Omip Contract 12M NAB v2", '', ReportFormat::Pdf, OutStream, RecordRef);
                                    end;
                                end;
                            end;

                            SUCOmipExcludedDomains.Reset();
                            SUCOmipExcludedDomains.SetRange("Domains Email", CopyStr(SUCOmipEnergyContractsIn."Acceptance Send", StrPos(SUCOmipEnergyContractsIn."Acceptance Send", '@'), StrLen(SUCOmipEnergyContractsIn."Acceptance Send")));
                            if not SUCOmipExcludedDomains.IsEmpty then
                                Error(ExcludeMailLbl);

                            TempBlob.CreateInStream(InStream);

                            case SUCOmipSetup."Email Delivery Provider" of
                                SUCOmipSetup."Email Delivery Provider"::"Business Central":
                                    if SendEMailMessage(SUCOmipEnergyContractsIn."Acceptance Send", SubjectLbl, BodyMail, true, FileNameLbl + '_' + SUCOmipEnergyContractsIn."Proposal No." + '.pdf', 'PDF', InStream, EmailScenario::Default) then begin
                                        SUCOmipEnergyContractsIn."Proposal Transmitted" := true;
                                        SUCOmipEnergyContractsIn.Modify();
                                        exit(true);
                                    end;
                                SUCOmipSetup."Email Delivery Provider"::BTP:
                                    begin
                                        SendAcceptanceEmail(SUCOmipDocumentType::Contract, SUCOmipEnergyContractsIn."No.", SUCOmipEnergyContractsIn."Customer Name", Base64Convert.ToBase64(InStream), BodyMail, SUCOmipEnergyContractsIn."Acceptance Send", JsonText);
                                        SUCOmipEnergyContractsIn."Request Acceptance" := CopyStr(JsonText, 1, 100);
                                        SUCOmipEnergyContractsIn.Modify();
                                        exit(true);
                                    end;
                            end;
                        end;
                    SUCOmipEnergyContractsIn."Acceptance Method"::SMS:
                        begin
                            SUCOmipEnergyContractsIn.TestField("Acceptance Method");
                            SUCOmipEnergyContractsIn.TestField("Acceptance Send");
                            SUCOmipEnergyContractsIn.CalcFields("Customer Name");

                            SUCOmipEnergyContracts.Reset();
                            SUCOmipEnergyContracts.SetRange("No.", SUCOmipEnergyContractsIn."No.");
                            if SUCOmipEnergyContracts.FindSet() then begin
                                RecordRef.GetTable(SUCOmipEnergyContracts);
                                TempBlob.CreateOutStream(OutStream);
                            end;

                            case SUCOmipMarketers.Marketer of
                                SUCOmipMarketers.Marketer::Acis:
                                    begin
                                        BodyMail := HTMLToBTPContractACIS(SUCOmipEnergyContractsIn."Customer Name");
                                        case SUCOmipEnergyContractsIn.Times of
                                            SUCOmipEnergyContractsIn.Times::"12M":
                                                if SUCOmipEnergyContractsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M MC ACIS", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M ACIS", '', ReportFormat::Pdf, OutStream, RecordRef);
                                            else
                                                if SUCOmipEnergyContractsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Contract 12MMC ACISv2", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M ACIS v2", '', ReportFormat::Pdf, OutStream, RecordRef);
                                        end;
                                    end;
                                SUCOmipMarketers.Marketer::Nabalia:
                                    begin
                                        BodyMail := HTMLToBTPContractNabalia(SUCOmipEnergyContractsIn."Customer Name");
                                        case SUCOmipEnergyContractsIn.Times of
                                            SUCOmipEnergyContractsIn.Times::"12M":
                                                if SUCOmipEnergyContractsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M MC NAB", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M NAB", '', ReportFormat::Pdf, OutStream, RecordRef);
                                            else
                                                if SUCOmipEnergyContractsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Contract 12MMC NAB v2", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M NAB v2", '', ReportFormat::Pdf, OutStream, RecordRef);
                                        end;
                                    end;
                                SUCOmipMarketers.Marketer::Avanza:
                                    begin
                                        BodyMail := HTMLToBTPContractAVA(SUCOmipEnergyContractsIn."Customer Name");
                                        case SUCOmipEnergyContractsIn.Times of
                                            SUCOmipEnergyContractsIn.Times::"12M":
                                                if SUCOmipEnergyContractsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M MC AVA", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M AVA", '', ReportFormat::Pdf, OutStream, RecordRef);
                                            else
                                                if SUCOmipEnergyContractsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Contract 12MMC AVA v2", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Contract 12M AVA v2", '', ReportFormat::Pdf, OutStream, RecordRef);
                                        end;
                                    end;
                                else begin
                                    BodyMail := HTMLToBTPContractNabalia(SUCOmipEnergyContractsIn."Customer Name");
                                    case SUCOmipEnergyContractsIn.Times of
                                        SUCOmipEnergyContractsIn.Times::"12M":
                                            Report.SaveAs(Report::"SUC Omip Contract 12M NAB", '', ReportFormat::Pdf, OutStream, RecordRef);
                                        else
                                            Report.SaveAs(Report::"SUC Omip Contract 12M NAB v2", '', ReportFormat::Pdf, OutStream, RecordRef);
                                    end;
                                end;
                            end;

                            TempBlob.CreateInStream(InStream);

                            SendAcceptanceSMS(SUCOmipDocumentType::Contract, SUCOmipEnergyContractsIn."No.", SUCOmipEnergyContractsIn."Customer Name", Base64Convert.ToBase64(InStream), SUCOmipSetup."Message Body Contracts", SUCOmipEnergyContractsIn."Acceptance Send", JsonText);
                            SUCOmipEnergyContractsIn."Request Acceptance" := CopyStr(JsonText, 1, 100);
                            SUCOmipEnergyContractsIn.Modify();
                            exit(true);
                        end;
                    SUCOmipEnergyContractsIn."Acceptance Method"::" ", SUCOmipEnergyContractsIn."Acceptance Method"::Paper:
                        exit(true);
                end;
        end;
    end;

    /// <summary>
    /// Generates a contract from a proposal.
    /// </summary>
    /// <param name="SUCOmipProposalsIn">The proposal record to convert to a contract.</param>
    /// <returns>Success message or error text.</returns>
    procedure GenerateContract(var SUCOmipProposalsIn: Record "SUC Omip Proposals"): Text
    begin
        case SUCOmipProposalsIn."Product Type" of
            SUCOmipProposalsIn."Product Type"::Omip:
                begin
                    ValidateProposalForContractGeneration(SUCOmipProposalsIn);

                    if IsProposalStillValid(SUCOmipProposalsIn) then
                        CreateContractFromProposal(SUCOmipProposalsIn)
                    else
                        exit(HandleExpiredProposal(SUCOmipProposalsIn));
                end;
        end;
    end;

    local procedure ValidateProposalForContractGeneration(var SUCOmipProposalsIn: Record "SUC Omip Proposals")
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCDefaultModalityByTime: Record "SUC Default Modality By Time";
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Contract Nos.");
        SUCOmipSetup.TestField("Time Validity Proposals");
        SUCOmipSetup.TestField("Default Reference Contract");

        SUCDefaultModalityByTime.Get(SUCOmipProposalsIn.Times);

        SUCOmipProposalsIn.TestField("Date Created");
        SUCOmipProposalsIn.TestField("DateTime Created");
        SUCOmipProposalsIn.TestField(Status, SUCOmipProposalsIn.Status::Accepted);
    end;

    local procedure IsProposalStillValid(var SUCOmipProposalsIn: Record "SUC Omip Proposals"): Boolean
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        ValidTime: Time;
        TodayDT: DateTime;
        DueDT: DateTime;
    begin
        SUCOmipSetup.Get();
        ValidTime := DT2Time(SUCOmipProposalsIn."DateTime Created");
        TodayDT := CreateDateTime(Today, ValidTime);
        DueDT := CreateDateTime(CalcDate(Format(SUCOmipSetup."Time Validity Contracts"), SUCOmipProposalsIn."Date Created"), ValidTime);

        exit(TodayDT <= DueDT);
    end;

    local procedure HandleExpiredProposal(var SUCOmipProposalsIn: Record "SUC Omip Proposals"): Text
    var
        ProposalOutTimeLbl: Label 'Proposal %1 is out of time';
    begin
        SUCOmipProposalsIn.Status := SUCOmipProposalsIn.Status::"Out of Time";
        SUCOmipProposalsIn.Modify();
        exit(StrSubstNo(ProposalOutTimeLbl, SUCOmipProposalsIn."No."));
    end;

    local procedure CreateContractFromProposal(var SUCOmipProposalsIn: Record "SUC Omip Proposals")
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        DocNo: Code[20];
    begin
        DocNo := InitializeNewContract(SUCOmipEnergyContracts);
        PopulateContractFromProposal(SUCOmipProposalsIn, SUCOmipEnergyContracts);
        CopyProposalDataToContract(SUCOmipProposalsIn, DocNo, SUCOmipEnergyContracts);
        FinalizeProposalContract(SUCOmipProposalsIn, DocNo);
    end;

    local procedure InitializeNewContract(var SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"): Code[20]
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        NoSeries: Codeunit "No. Series";
        DocNo: Code[20];
    begin
        SUCOmipSetup.Get();
        DocNo := NoSeries.GetNextNo(SUCOmipSetup."Contract Nos.");

        SUCOmipEnergyContracts.Init();
        SUCOmipEnergyContracts."No." := DocNo;
        SUCOmipEnergyContracts.Insert();

        exit(DocNo);
    end;

    local procedure PopulateContractFromProposal(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; var SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts")
    var
        Customer: Record Customer;
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCDefaultModalityByTime: Record "SUC Default Modality By Time";
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        TittleAppConditions: Text[250];
        AppConditions: Text;
    begin
        SUCOmipSetup.Get();
        SUCDefaultModalityByTime.Get(SUCOmipProposalsIn.Times);
        Customer.Get(SUCOmipProposalsIn."Customer No.");

        // Basic contract information
        SUCOmipEnergyContracts."Date Created" := Today;
        SUCOmipEnergyContracts."DateTime Created" := CurrentDateTime;
        SUCOmipEnergyContracts.Validate("Customer No.", SUCOmipProposalsIn."Customer No.");

        // Customer manager position logic
        if Customer."SUC Customer Type" = Customer."SUC Customer Type"::Particular then
            SUCOmipEnergyContracts."SUC Customer Manager Position" := 'TITULAR'
        else
            SUCOmipEnergyContracts."SUC Customer Manager Position" := Customer."SUC Manager Position";

        // Transfer proposal data to contract
        SUCOmipEnergyContracts."Marketer No." := SUCOmipProposalsIn."Marketer No.";
        SUCOmipEnergyContracts."Rate No." := SUCOmipProposalsIn."Rate No.";
        SUCOmipEnergyContracts.Times := SUCOmipProposalsIn.Times;
        SUCOmipEnergyContracts.Multicups := SUCOmipProposalsIn.Multicups;
        SUCOmipEnergyContracts."Agent No." := SUCOmipProposalsIn."Agent No.";

        // Set agent code
        if SUCOmipExternalUsers.Get(SUCOmipProposalsIn."Agent No.") then
            SUCOmipEnergyContracts.Validate("Agent Code", SUCOmipExternalUsers."Agent Code")
        else
            SUCOmipEnergyContracts.Validate("Agent Code", '');

        SUCOmipEnergyContracts."Energy Origen" := SUCOmipProposalsIn."Energy Origen";

        if SUCOmipProposalsIn."Rate Category" <> '' then
            SUCOmipEnergyContracts."Rate Category" := SUCOmipProposalsIn."Rate Category";

        SUCOmipEnergyContracts."Supply Start Date" := SUCOmipProposalsIn."Contract Start Date";
        SUCOmipEnergyContracts.Validate("Acceptance Method", SUCOmipProposalsIn."Acceptance Method");
        SUCOmipEnergyContracts."Acceptance Send" := SUCOmipProposalsIn."Acceptance Send";
        SUCOmipEnergyContracts.Type := SUCOmipProposalsIn.Type;
        SUCOmipEnergyContracts."Contract Status" := SUCOmipEnergyContracts."Contract Status"::Active;
        SUCOmipEnergyContracts."Customer CUPS" := SUCOmipProposalsIn."Customer CUPS";

        // Handle supply point address for non-multicups contracts
        if not SUCOmipProposalsIn.Multicups then
            SetSupplyPointAddress(SUCOmipProposalsIn, SUCOmipEnergyContracts);

        // Additional contract fields
        SUCOmipEnergyContracts."Receive invoice electronically" := SUCOmipProposalsIn."Receive invoice electronically";
        SUCOmipEnergyContracts."Sending Communications" := SUCOmipProposalsIn."Sending Communications";
        SUCOmipEnergyContracts.IBAN := SUCOmipProposalsIn.IBAN;
        SUCOmipEnergyContracts."Order TED Addendum" := SUCOmipSetup."Order TED Addendum";
        SUCOmipEnergyContracts."Resolution Addendum" := SUCOmipSetup."Resolution Addendum";
        SUCOmipEnergyContracts.Volume := SUCOmipProposalsIn.Volume;
        SUCOmipEnergyContracts."Proposal No." := SUCOmipProposalsIn."No.";
        SUCOmipEnergyContracts."FEE Group Id." := SUCOmipProposalsIn."FEE Group Id.";
        SUCOmipEnergyContracts."Product Type" := SUCOmipEnergyContracts."Product Type"::Omip;
        SUCOmipEnergyContracts."Reference Contract" := SUCOmipSetup."Default Reference Contract";
        SUCOmipEnergyContracts."Contract Modality" := SUCDefaultModalityByTime."Default Contract Modality";

        // Set applicable conditions
        GetContractApplicableConditions2(SUCOmipEnergyContracts."Product Type", SUCOmipEnergyContracts."Marketer No.",
            SUCOmipEnergyContracts.Times, SUCOmipEnergyContracts.Multicups, SUCOmipEnergyContracts."Supply Start Date",
            TittleAppConditions, AppConditions);
        SUCOmipEnergyContracts."Tittle Applicable Conditions" := TittleAppConditions;
        SUCOmipEnergyContracts.Modify();

        SUCOmipEnergyContracts.SetDataBlob(SUCOmipEnergyContracts.FieldNo("Body Applicable Conditions"), AppConditions);
    end;

    local procedure SetSupplyPointAddress(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; var SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts")
    var
        SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
    begin
        SUCOmipCustomerCUPS.Get(SUCOmipProposalsIn."Customer No.", SUCOmipProposalsIn."Customer CUPS");
        SUCOmipEnergyContracts.Validate("SUC Supply Point Address", SUCOmipCustomerCUPS."SUC Supply Point Address");
        SUCOmipEnergyContracts.Validate("SUC Supply Point City", SUCOmipCustomerCUPS."SUC Supply Point City");
        SUCOmipEnergyContracts.Validate("SUC Supply Point Post Code", SUCOmipCustomerCUPS."SUC Supply Point Post Code");
        SUCOmipEnergyContracts.Validate("SUC Supply Point County", SUCOmipCustomerCUPS."SUC Supply Point County");
        SUCOmipEnergyContracts.Validate("SUC Supply Point Country", SUCOmipCustomerCUPS."SUC Supply Point Country");
    end;

    local procedure CopyProposalDataToContract(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; DocNo: Code[20]; var SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts")
    begin
        CopyMulticupsData(SUCOmipProposalsIn, DocNo);
        CopyPowerEntryData(SUCOmipProposalsIn, DocNo, SUCOmipEnergyContracts);
        CopyEnergyEntryData(SUCOmipProposalsIn, DocNo, SUCOmipEnergyContracts);
        CopyContractedPowerData(SUCOmipProposalsIn, DocNo);
        CopyConsumptionDeclaredData(SUCOmipProposalsIn, DocNo);
        CopyFEEPowerDocumentData(SUCOmipProposalsIn, DocNo, SUCOmipEnergyContracts);
        CopyFEEEnergyDocumentData(SUCOmipProposalsIn, DocNo, SUCOmipEnergyContracts);
        CopyCommissionsEntryData(SUCOmipProposalsIn, DocNo);
        UpdateCommissionsAfterContractGeneration(SUCOmipProposalsIn, DocNo);
    end;

    local procedure CopyMulticupsData(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; DocNo: Code[20])
    var
        SUCOmipProposalMulticups: Record "SUC Omip Proposal Multicups";
    begin
        if not SUCOmipProposalsIn.Multicups then
            exit;

        SUCOmipProposalMulticups.Reset();
        SUCOmipProposalMulticups.SetRange("Proposal No.", SUCOmipProposalsIn."No.");
        if SUCOmipProposalMulticups.FindSet() then
            repeat
                CreateContractMulticupEntry(SUCOmipProposalMulticups, DocNo);
            until SUCOmipProposalMulticups.Next() = 0;
    end;

    local procedure CreateContractMulticupEntry(var SUCOmipProposalMulticups: Record "SUC Omip Proposal Multicups"; DocNo: Code[20])
    var
        SUCOmipEnergyContractsMul: Record "SUC Omip Energy Contracts Mul.";
    begin
        SUCOmipEnergyContractsMul.Init();
        SUCOmipEnergyContractsMul.Validate("Contract No.", DocNo);
        SUCOmipEnergyContractsMul."Customer CUPS" := SUCOmipProposalMulticups."Customer CUPS";
        SUCOmipEnergyContractsMul."Rate No." := SUCOmipProposalMulticups."Rate No.";

        // Set supply point information
        SUCOmipEnergyContractsMul.Validate("SUC Supply Point Address", SUCOmipProposalMulticups."SUC Supply Point Address");
        SUCOmipEnergyContractsMul.Validate("SUC Supply Point Post Code", SUCOmipProposalMulticups."SUC Supply Point Post Code");
        SUCOmipEnergyContractsMul.Validate("SUC Supply Point City", SUCOmipProposalMulticups."SUC Supply Point City");
        SUCOmipEnergyContractsMul.Validate("SUC Supply Point County", SUCOmipProposalMulticups."SUC Supply Point County");
        SUCOmipEnergyContractsMul.Validate("SUC Supply Point Country", SUCOmipProposalMulticups."SUC Supply Point Country");

        // Copy power values
        SUCOmipEnergyContractsMul.P1 := SUCOmipProposalMulticups.P1;
        SUCOmipEnergyContractsMul.P2 := SUCOmipProposalMulticups.P2;
        SUCOmipEnergyContractsMul.P3 := SUCOmipProposalMulticups.P3;
        SUCOmipEnergyContractsMul.P4 := SUCOmipProposalMulticups.P4;
        SUCOmipEnergyContractsMul.P5 := SUCOmipProposalMulticups.P5;
        SUCOmipEnergyContractsMul.P6 := SUCOmipProposalMulticups.P6;

        SUCOmipEnergyContractsMul.Validate("Activation Date", SUCOmipProposalMulticups."Activation Date");
        SUCOmipEnergyContractsMul.Validate(Volume, SUCOmipProposalMulticups.Volume);
        SUCOmipEnergyContractsMul.Insert();
    end;

    local procedure CopyPowerEntryData(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; DocNo: Code[20]; var SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts")
    var
        SUCOmipPowerEntry: Record "SUC Omip Power Entry";
    begin
        SUCOmipPowerEntry.Reset();
        SUCOmipPowerEntry.SetRange("Proposal No.", SUCOmipProposalsIn."No.");
        if SUCOmipPowerEntry.FindSet() then
            repeat
                CreateContractPowerEntry(SUCOmipPowerEntry, DocNo, SUCOmipEnergyContracts);
            until SUCOmipPowerEntry.Next() = 0;
    end;

    local procedure CreateContractPowerEntry(var SUCOmipPowerEntry: Record "SUC Omip Power Entry"; DocNo: Code[20]; var SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts")
    var
        SUCOmipPowerEntryContract: Record "SUC Omip Power Entry Contract";
    begin
        SUCOmipPowerEntryContract.Init();
        SUCOmipPowerEntryContract."Contract No." := DocNo;
        SUCOmipPowerEntryContract."Rate No." := SUCOmipPowerEntry."Rate No.";
        SUCOmipPowerEntryContract.P1 := SUCOmipPowerEntry.P1;
        SUCOmipPowerEntryContract.P2 := SUCOmipPowerEntry.P2;
        SUCOmipPowerEntryContract.P3 := SUCOmipPowerEntry.P3;
        SUCOmipPowerEntryContract.P4 := SUCOmipPowerEntry.P4;
        SUCOmipPowerEntryContract.P5 := SUCOmipPowerEntry.P5;
        SUCOmipPowerEntryContract.P6 := SUCOmipPowerEntry.P6;
        SUCOmipPowerEntryContract."Contract Id" := SUCOmipEnergyContracts.SystemId;
        SUCOmipPowerEntryContract.Insert();
    end;

    local procedure CopyEnergyEntryData(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; DocNo: Code[20]; var SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts")
    var
        SUCOmipEnergyEntry: Record "SUC Omip Energy Entry";
    begin
        SUCOmipEnergyEntry.Reset();
        SUCOmipEnergyEntry.SetRange("Proposal No.", SUCOmipProposalsIn."No.");
        if SUCOmipEnergyEntry.FindSet() then
            repeat
                CreateContractEnergyEntry(SUCOmipEnergyEntry, DocNo, SUCOmipEnergyContracts);
            until SUCOmipEnergyEntry.Next() = 0;
    end;

    local procedure CreateContractEnergyEntry(var SUCOmipEnergyEntry: Record "SUC Omip Energy Entry"; DocNo: Code[20]; var SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts")
    var
        SUCOmipEnergyEntryContract: Record "SUC Omip Energy Entry Contract";
    begin
        SUCOmipEnergyEntryContract.Init();
        SUCOmipEnergyEntryContract."Contract No." := DocNo;
        SUCOmipEnergyEntryContract."Rate No." := SUCOmipEnergyEntry."Rate No.";
        SUCOmipEnergyEntryContract.Times := SUCOmipEnergyEntry.Times;
        SUCOmipEnergyEntryContract.Type := SUCOmipEnergyEntry.Type;
        SUCOmipEnergyEntryContract.P1 := SUCOmipEnergyEntry.P1;
        SUCOmipEnergyEntryContract.P2 := SUCOmipEnergyEntry.P2;
        SUCOmipEnergyEntryContract.P3 := SUCOmipEnergyEntry.P3;
        SUCOmipEnergyEntryContract.P4 := SUCOmipEnergyEntry.P4;
        SUCOmipEnergyEntryContract.P5 := SUCOmipEnergyEntry.P5;
        SUCOmipEnergyEntryContract.P6 := SUCOmipEnergyEntry.P6;
        SUCOmipEnergyEntryContract."Times Text" := SUCOmipEnergyEntry."Times Text";
        SUCOmipEnergyEntryContract."Omip price" := SUCOmipEnergyEntry."Omip price";
        SUCOmipEnergyEntryContract.Enabled := SUCOmipEnergyEntry.Enabled;
        SUCOmipEnergyEntryContract."Contract Id" := SUCOmipEnergyContracts.SystemId;
        SUCOmipEnergyEntryContract.Insert();
    end;

    local procedure CopyContractedPowerData(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; DocNo: Code[20])
    var
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
        SUCOmipContractedPower2: Record "SUC Omip Contracted Power";
    begin
        SUCOmipContractedPower.Reset();
        SUCOmipContractedPower.SetRange("Document Type", SUCOmipDocumentType::Proposal);
        SUCOmipContractedPower.SetRange("Document No.", SUCOmipProposalsIn."No.");
        if SUCOmipContractedPower.FindSet() then
            repeat
                SUCOmipContractedPower2.Init();
                SUCOmipContractedPower2.TransferFields(SUCOmipContractedPower);
                SUCOmipContractedPower2."Document Type" := SUCOmipDocumentType::Contract;
                SUCOmipContractedPower2."Document No." := DocNo;
                SUCOmipContractedPower2.CUPS := SUCOmipContractedPower.CUPS;
                SUCOmipContractedPower2.Insert();
            until SUCOmipContractedPower.Next() = 0;
    end;

    local procedure CopyConsumptionDeclaredData(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; DocNo: Code[20])
    var
        SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
        SUCOmipConsumptionDeclared2: Record "SUC Omip Consumption Declared";
    begin
        SUCOmipConsumptionDeclared.Reset();
        SUCOmipConsumptionDeclared.SetRange("Document Type", SUCOmipDocumentType::Proposal);
        SUCOmipConsumptionDeclared.SetRange("Document No.", SUCOmipProposalsIn."No.");
        if SUCOmipConsumptionDeclared.FindSet() then
            repeat
                SUCOmipConsumptionDeclared2.Init();
                SUCOmipConsumptionDeclared2.TransferFields(SUCOmipConsumptionDeclared);
                SUCOmipConsumptionDeclared2."Document Type" := SUCOmipDocumentType::Contract;
                SUCOmipConsumptionDeclared2."Document No." := DocNo;
                SUCOmipConsumptionDeclared2.CUPS := SUCOmipConsumptionDeclared.CUPS;
                SUCOmipConsumptionDeclared2.Insert();
            until SUCOmipConsumptionDeclared.Next() = 0;
    end;

    local procedure CopyFEEPowerDocumentData(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; DocNo: Code[20]; var SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts")
    var
        SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
        SUCOmipFEEPowerDocument2: Record "SUC Omip FEE Power Document";
    begin
        SUCOmipFEEPowerDocument.Reset();
        SUCOmipFEEPowerDocument.SetRange("Document Type", SUCOmipDocumentType::Proposal);
        SUCOmipFEEPowerDocument.SetRange("Document No.", SUCOmipProposalsIn."No.");
        if SUCOmipFEEPowerDocument.FindSet() then
            repeat
                SUCOmipFEEPowerDocument2.Init();
                SUCOmipFEEPowerDocument2.TransferFields(SUCOmipFEEPowerDocument);
                SUCOmipFEEPowerDocument2."Document Type" := SUCOmipDocumentType::Contract;
                SUCOmipFEEPowerDocument2."Document No." := DocNo;
                SUCOmipFEEPowerDocument2."Marketer No." := SUCOmipEnergyContracts."Marketer No.";
                SUCOmipFEEPowerDocument2."Rate No." := SUCOmipFEEPowerDocument."Rate No.";
                SUCOmipFEEPowerDocument2.Insert();
            until SUCOmipFEEPowerDocument.Next() = 0;
    end;

    local procedure CopyFEEEnergyDocumentData(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; DocNo: Code[20]; var SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts")
    var
        SUCOmipFEEEnergyDocument: Record "SUC Omip FEE Energy Document";
        SUCOmipFEEEnergyDocument2: Record "SUC Omip FEE Energy Document";
    begin
        SUCOmipFEEEnergyDocument.Reset();
        SUCOmipFEEEnergyDocument.SetRange("Document Type", SUCOmipDocumentType::Proposal);
        SUCOmipFEEEnergyDocument.SetRange("Document No.", SUCOmipProposalsIn."No.");
        if SUCOmipFEEEnergyDocument.FindSet() then
            repeat
                SUCOmipFEEEnergyDocument2.Init();
                SUCOmipFEEEnergyDocument2.TransferFields(SUCOmipFEEEnergyDocument);
                SUCOmipFEEEnergyDocument2."Document Type" := SUCOmipDocumentType::Contract;
                SUCOmipFEEEnergyDocument2."Document No." := DocNo;
                SUCOmipFEEEnergyDocument2."Marketer No." := SUCOmipEnergyContracts."Marketer No.";
                SUCOmipFEEEnergyDocument2."Rate No." := SUCOmipFEEEnergyDocument."Rate No.";
                SUCOmipFEEEnergyDocument2.Insert();
            until SUCOmipFEEEnergyDocument.Next() = 0;
    end;

    local procedure CopyCommissionsEntryData(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; DocNo: Code[20])
    var
        SUCCommissionsEntry: Record "SUC Commissions Entry";
        SUCCommissionsEntry2: Record "SUC Commissions Entry";
    begin
        SUCCommissionsEntry.Reset();
        SUCCommissionsEntry.SetRange("Document Type", SUCOmipDocumentType::Proposal);
        SUCCommissionsEntry.SetRange("Document No.", SUCOmipProposalsIn."No.");
        if SUCCommissionsEntry.FindSet() then
            repeat
                SUCCommissionsEntry2.Init();
                SUCCommissionsEntry2.TransferFields(SUCCommissionsEntry);
                SUCCommissionsEntry2."Document Type" := SUCOmipDocumentType::Contract;
                SUCCommissionsEntry2."Document No." := DocNo;
                SUCCommissionsEntry2.Insert();
            until SUCCommissionsEntry.Next() = 0;
    end;

    local procedure UpdateCommissionsAfterContractGeneration(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; DocNo: Code[20])
    var
        SUCCommissionsEntryProposal: Record "SUC Commissions Entry";
        SUCCommissionsEntryContract: Record "SUC Commissions Entry";
    begin
        // Mark proposal commissions as superseded by contract
        SUCCommissionsEntryProposal.Reset();
        SUCCommissionsEntryProposal.SetRange("Document Type", SUCOmipDocumentType::Proposal);
        SUCCommissionsEntryProposal.SetRange("Document No.", SUCOmipProposalsIn."No.");
        if SUCCommissionsEntryProposal.FindSet(true) then
            repeat
                SUCCommissionsEntryProposal."Superseded by Contract" := true;
                SUCCommissionsEntryProposal.Modify();
            until SUCCommissionsEntryProposal.Next() = 0;

        // Update contract commissions with source proposal number
        SUCCommissionsEntryContract.Reset();
        SUCCommissionsEntryContract.SetRange("Document Type", SUCOmipDocumentType::Contract);
        SUCCommissionsEntryContract.SetRange("Document No.", DocNo);
        if SUCCommissionsEntryContract.FindSet(true) then
            repeat
                SUCCommissionsEntryContract."Source Proposal No." := SUCOmipProposalsIn."No.";
                SUCCommissionsEntryContract.Modify();
            until SUCCommissionsEntryContract.Next() = 0;
    end;

    local procedure FinalizeProposalContract(var SUCOmipProposalsIn: Record "SUC Omip Proposals"; DocNo: Code[20])
    begin
        SUCOmipProposalsIn.Validate("Contract No.", DocNo);
        SUCOmipProposalsIn.Status := SUCOmipProposalsIn.Status::Accepted;
        SUCOmipProposalsIn.Modify();

        if not (CurrentClientType in [ClientType::OData, ClientType::ODataV4, ClientType::SOAP, ClientType::Api]) then
            SendEmailToPurchases(SUCOmipProposalsIn."No.", SUCOmipDocumentType::Proposal);
    end;

    procedure SendProposal(var SUCOmipProposalsIn: Record "SUC Omip Proposals"): Boolean
    var
        SUCOmipExcludedDomains: Record "SUC Omip Excluded Domains";
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipMarketers: Record "SUC Omip Marketers";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        RecordRef: RecordRef;
        EmailScenario: Enum "Email Scenario";
        InStream: InStream;
        ExcludeMailLbl: Label 'You are using an excluded mail, so it is not corporate.';
        FileNameLbl: Label 'Proposal Commercial';
        SubjectLbl: Label 'proposal acceptance';
        OutStream: OutStream;
        JsonText: Text;
        BodyMail: Text;
        ValidTime: Time;
        TodayDT: DateTime;
        DueDT: DateTime;
    begin
        case SUCOmipProposalsIn."Product Type" of
            SUCOmipProposalsIn."Product Type"::Omip:
                begin
                    SUCOmipSetup.Get();
                    SUCOmipSetup.TestField("Message Body Proposals");
                    SUCOmipProposalsIn.CalcFields("Customer Name");
                    SUCOmipProposalsIn.TestField(Status, SUCOmipProposalsIn.Status::"Pending Acceptance");
                    SUCOmipProposalsIn.TestField("Marketer No.");
                    SUCOmipProposalsIn.TestField("DateTime Created");
                    SUCOmipMarketers.Get(SUCOmipProposalsIn."Marketer No.");

                    ValidTime := DT2Time(SUCOmipProposalsIn."DateTime Created");
                    TodayDT := CreateDateTime(Today, ValidTime);
                    DueDT := CreateDateTime(CalcDate(Format(SUCOmipSetup."Time Validity Proposals"), SUCOmipProposalsIn."Date Created"), ValidTime);

                    if (TodayDT <= DueDT) then
                        case SUCOmipProposalsIn."Acceptance Method" of
                            SUCOmipProposalsIn."Acceptance Method"::Email:
                                begin
                                    SUCOmipProposalsIn.TestField("Acceptance Method");
                                    SUCOmipProposalsIn.TestField("Acceptance Send");

                                    SUCOmipProposalsIn.CalcFields("Customer Name", "Agent Name");

                                    SUCOmipProposals.Reset();
                                    SUCOmipProposals.SetRange("No.", SUCOmipProposalsIn."No.");
                                    if SUCOmipProposals.FindSet() then begin
                                        RecordRef.GetTable(SUCOmipProposals);
                                        TempBlob.CreateOutStream(OutStream);
                                    end;
                                    case SUCOmipMarketers.Marketer of
                                        SUCOmipMarketers.Marketer::Acis:
                                            begin
                                                BodyMail := HTMLToBTPProposalACIS(SUCOmipProposalsIn."Customer Name");
                                                if SUCOmipProposalsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Proposal ACIS MC", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Proposal ACIS", '', ReportFormat::Pdf, OutStream, RecordRef);
                                            end;
                                        SUCOmipMarketers.Marketer::Nabalia:
                                            begin
                                                BodyMail := HTMLToBTPProposalNabalia(SUCOmipProposalsIn."Customer Name");
                                                if SUCOmipProposalsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Proposal NAB MC", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Proposal NAB", '', ReportFormat::Pdf, OutStream, RecordRef);
                                            end;
                                        SUCOmipMarketers.Marketer::Avanza:
                                            begin
                                                BodyMail := HTMLToBTPProposalAVA(SUCOmipProposalsIn."Customer Name");
                                                if SUCOmipProposalsIn.Multicups then
                                                    Report.SaveAs(Report::"SUC Omip Proposal AVA MC", '', ReportFormat::Pdf, OutStream, RecordRef)
                                                else
                                                    Report.SaveAs(Report::"SUC Omip Proposal AVA", '', ReportFormat::Pdf, OutStream, RecordRef);
                                            end;
                                    end;
                                    SUCOmipExcludedDomains.Reset();
                                    SUCOmipExcludedDomains.SetRange("Domains Email", CopyStr(SUCOmipProposalsIn."Acceptance Send", StrPos(SUCOmipProposalsIn."Acceptance Send", '@'), StrLen(SUCOmipProposalsIn."Acceptance Send")));
                                    if not SUCOmipExcludedDomains.IsEmpty then
                                        Error(ExcludeMailLbl);

                                    TempBlob.CreateInStream(InStream);
                                    case SUCOmipSetup."Email Delivery Provider" of
                                        SUCOmipSetup."Email Delivery Provider"::"Business Central":
                                            if SendEMailMessage(SUCOmipProposalsIn."Acceptance Send", SubjectLbl, BodyMail, true, FileNameLbl + '_' + SUCOmipProposalsIn."No." + '.pdf', 'PDF', InStream, EmailScenario::Default) then begin
                                                SUCOmipProposalsIn."Proposal Transmitted" := true;
                                                SUCOmipProposalsIn.Modify();
                                                exit(true);
                                            end;
                                        SUCOmipSetup."Email Delivery Provider"::BTP:
                                            begin
                                                //Message(BodyMail);
                                                SendAcceptanceEmail(SUCOmipDocumentType::Proposal, SUCOmipProposalsIn."No.", SUCOmipProposalsIn."Customer Name", Base64Convert.ToBase64(InStream), BodyMail, SUCOmipProposalsIn."Acceptance Send", JsonText);
                                                SUCOmipProposalsIn."Request Acceptance" := CopyStr(JsonText, 1, 100);
                                                SUCOmipProposalsIn.Modify();
                                                exit(true);
                                            end;
                                    end;
                                end;
                            SUCOmipProposalsIn."Acceptance Method"::SMS:
                                begin
                                    SUCOmipProposalsIn.TestField("Acceptance Method");
                                    SUCOmipProposalsIn.TestField("Acceptance Send");
                                    SUCOmipProposalsIn.CalcFields("Customer Name", "Agent Name");

                                    SUCOmipProposals.Reset();
                                    SUCOmipProposals.SetRange("No.", SUCOmipProposalsIn."No.");
                                    if SUCOmipProposals.FindSet() then begin
                                        RecordRef.GetTable(SUCOmipProposals);
                                        TempBlob.CreateOutStream(OutStream);
                                    end;

                                    case SUCOmipMarketers.Marketer of
                                        SUCOmipMarketers.Marketer::Acis:
                                            if SUCOmipProposalsIn.Multicups then
                                                Report.SaveAs(Report::"SUC Omip Proposal ACIS MC", '', ReportFormat::Pdf, OutStream, RecordRef)
                                            else
                                                Report.SaveAs(Report::"SUC Omip Proposal ACIS", '', ReportFormat::Pdf, OutStream, RecordRef);
                                        SUCOmipMarketers.Marketer::Nabalia:
                                            if SUCOmipProposalsIn.Multicups then
                                                Report.SaveAs(Report::"SUC Omip Proposal NAB MC", '', ReportFormat::Pdf, OutStream, RecordRef)
                                            else
                                                Report.SaveAs(Report::"SUC Omip Proposal NAB", '', ReportFormat::Pdf, OutStream, RecordRef);
                                        SUCOmipMarketers.Marketer::Avanza:
                                            if SUCOmipProposalsIn.Multicups then
                                                Report.SaveAs(Report::"SUC Omip Proposal AVA MC", '', ReportFormat::Pdf, OutStream, RecordRef)
                                            else
                                                Report.SaveAs(Report::"SUC Omip Proposal AVA", '', ReportFormat::Pdf, OutStream, RecordRef);
                                    end;

                                    TempBlob.CreateInStream(InStream);
                                    SendAcceptanceSMS(SUCOmipDocumentType::Proposal, SUCOmipProposalsIn."No.", SUCOmipProposalsIn."Customer Name", Base64Convert.ToBase64(InStream), SUCOmipSetup."Message Body Proposals", SUCOmipProposalsIn."Acceptance Send", JsonText);
                                    SUCOmipProposalsIn."Request Acceptance" := CopyStr(JsonText, 1, 100);
                                    SUCOmipProposalsIn.Modify();
                                    exit(true);
                                end;
                            SUCOmipProposalsIn."Acceptance Method"::" ":
                                exit(true);
                        end
                    else begin
                        SUCOmipProposalsIn.Status := SUCOmipProposalsIn.Status::"Out of Time";
                        SUCOmipProposalsIn.Modify();
                        exit(false);
                    end;
                end;
        end;
    end;

    /// <summary>
    /// SendEMailMessage.
    /// </summary>
    /// <param name="RecipientsMail">Text.</param>
    /// <param name="SubjetMail">Text.</param>
    /// <param name="BodyMail">Text.</param>
    /// <param name="Attachmet">Boolean.</param>
    /// <param name="FileName">Text.</param>
    /// <param name="FileExtension">Text.</param>
    /// <param name="InStreamIn">InStream.</param>
    local procedure SendEMailMessage(RecipientsMail: Text; SubjetMail: Text; BodyMail: Text; Attachmet: Boolean; FileName: Text[250]; FileExtension: Text[250]; InStreamIn: InStream; EmailScenario: Enum "Email Scenario"): Boolean
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
    begin
        EmailMessage.Create(RecipientsMail, SubjetMail, BodyMail, true);
        if Attachmet then
            EmailMessage.AddAttachment(FileName, FileExtension, InStreamIn);
        if Email.Send(EmailMessage, EmailScenario) then
            exit(true)
        else
            exit(false);
    end;

    procedure SendEmailToPurchases(DocNoIn: Code[20]; DocumentType: Enum "SUC Omip Document Type")
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipTrackingBTP: Record "SUC Omip Tracking BTP";
        SUCOmipMarketers: Record "SUC Omip Marketers";
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        FieldRef: FieldRef;
        RecordRef: RecordRef;
        EmailScenario: Enum "Email Scenario";
        InStream: InStream;
        InStream2: InStream;
        InStream3: InStream;
        OutStream: OutStream;
        BTPdoc: Text;
        Subject: Text;
        Body: Text;
        FileName: Text[250];
        FileExt: Text[250];
        FileNameLbl: Label 'Proposal Commercial';
    begin
        SUCOmipSetup.Get();

        case DocumentType of
            DocumentType::Proposal:
                begin
                    SUCOmipSetup.TestField("Email Proposal Confirmation");
                    SUCOmipProposals.Get(DocNoIn);
                    SUCOmipMarketers.Get(SUCOmipProposals."Marketer No.");
                    TempBlob.CreateOutStream(OutStream);
                    RecordRef.Open(Database::"SUC Omip Proposals");
                    FieldRef := RecordRef.Field(2000000000);
                    FieldRef.SetRange(SUCOmipProposals.SystemId);

                    case SUCOmipMarketers.Marketer of
                        SUCOmipMarketers.Marketer::Acis:
                            Report.SaveAs(Report::"SUC Omip Prop. Copy Email ACIS", '', ReportFormat::Html, OutStream, RecordRef);
                        SUCOmipMarketers.Marketer::Nabalia:
                            Report.SaveAs(Report::"SUC Omip Proposal Copy Email", '', ReportFormat::Html, OutStream, RecordRef);
                        SUCOmipMarketers.Marketer::Avanza:
                            Report.SaveAs(Report::"SUC Omip Prop. Copy Email AVA", '', ReportFormat::Html, OutStream, RecordRef);
                    end;

                    TempBlob.CreateInStream(InStream, TextEncoding::UTF8);
                    InStream.ReadText(Body);
                    Body := Body.Replace('<table cellspacing="0" cellpadding="0" style="margin-right:7.1pt; margin-left:7.1pt; border-collapse:collapse; float:left">', '<table style="margin: 0 auto;">');

                    Subject := 'Propuesta Precio Personalizado ' + SUCOmipProposals."No.";

                    SUCOmipTrackingBTP.Reset();
                    SUCOmipTrackingBTP.SetRange("Document Type", DocumentType);
                    SUCOmipTrackingBTP.SetRange("Document No.", DocNoIn);
                    SUCOmipTrackingBTP.SetFilter("BTP status", '%1|%2', 20, 70);
                    if SUCOmipTrackingBTP.FindLast() then begin
                        if SUCOmipTrackingBTP."BTP doc".HasValue then begin
                            SUCOmipTrackingBTP.CalcFields("BTP doc");
                            FileName := CopyStr(Format(SUCOmipTrackingBTP."Document Type") + '_' + SUCOmipTrackingBTP."Document No." + '.pdf', 1, 250);
                            FileExt := 'PDF';
                            SUCOmipTrackingBTP."BTP doc".CreateInStream(InStream, TextEncoding::UTF8);
                            while not (InStream.EOS) do
                                InStream.Read(BTPdoc);
                            TempBlob.CreateOutStream(OutStream);
                            Base64Convert.FromBase64(BTPdoc, OutStream);
                            TempBlob.CreateInStream(InStream2);
                            SendEMailMessage(SUCOmipSetup."Email Proposal Confirmation", Subject, Body, true, FileName, FileExt, InStream2, EmailScenario::Default);
                            NewTrackingBTP2(DocumentType, DocNoIn, CurrentDateTime, '', '200', 'Send Email To Purchases', SUCOmipAcceptanceMethod::" ",
                                   SUCOmipSetup."Email Proposal Confirmation", SUCOmipActionTrackingBTP::"Notification Send",
                                   '', '', 0, '', '', CurrentDateTime, false, '');
                        end;
                    end else
                        if SUCOmipProposals."Acceptance Method" = SUCOmipProposals."Acceptance Method"::Paper then begin
                            case SUCOmipMarketers.Marketer of
                                SUCOmipMarketers.Marketer::Acis:
                                    if SUCOmipProposals.Multicups then
                                        Report.SaveAs(Report::"SUC Omip Proposal ACIS MC", '', ReportFormat::Pdf, OutStream, RecordRef)
                                    else
                                        Report.SaveAs(Report::"SUC Omip Proposal ACIS", '', ReportFormat::Pdf, OutStream, RecordRef);
                                SUCOmipMarketers.Marketer::Nabalia:
                                    if SUCOmipProposals.Multicups then
                                        Report.SaveAs(Report::"SUC Omip Proposal NAB MC", '', ReportFormat::Pdf, OutStream, RecordRef)
                                    else
                                        Report.SaveAs(Report::"SUC Omip Proposal NAB", '', ReportFormat::Pdf, OutStream, RecordRef);
                                SUCOmipMarketers.Marketer::Avanza:
                                    if SUCOmipProposals.Multicups then
                                        Report.SaveAs(Report::"SUC Omip Proposal AVA MC", '', ReportFormat::Pdf, OutStream, RecordRef)
                                    else
                                        Report.SaveAs(Report::"SUC Omip Proposal AVA", '', ReportFormat::Pdf, OutStream, RecordRef);
                            end;
                            TempBlob.CreateInStream(InStream3);
                            SendEMailMessage(SUCOmipSetup."Email Proposal Confirmation", Subject, Body, true, FileNameLbl + '_' + SUCOmipProposals."No." + '.pdf', 'PDF', InStream3, EmailScenario::Default);
                            NewTrackingBTP2(DocumentType, DocNoIn, CurrentDateTime, '', '200', 'Send Email To Purchases', SUCOmipAcceptanceMethod::" ",
                                           SUCOmipSetup."Email Proposal Confirmation", SUCOmipActionTrackingBTP::"Notification Send",
                                           '', '', 0, '', '', CurrentDateTime, false, '');
                        end;
                end;
            DocumentType::Contract:
                begin
                    SUCOmipSetup.TestField("Email Contract Confirmation");
                    SUCOmipEnergyContracts.Get(DocNoIn);
                    case SUCOmipEnergyContracts."Product Type" of
                        SUCOmipEnergyContracts."Product Type"::Omip:
                            begin
                                SUCOmipMarketers.Get(SUCOmipEnergyContracts."Marketer No.");
                                TempBlob.CreateOutStream(OutStream);
                                RecordRef.Open(Database::"SUC Omip Energy Contracts");
                                FieldRef := RecordRef.Field(2000000000);
                                FieldRef.SetRange(SUCOmipEnergyContracts.SystemId);

                                case SUCOmipMarketers.Marketer of
                                    SUCOmipMarketers.Marketer::Acis:
                                        Report.SaveAs(Report::"SUC Omip Cont. Copy Email ACIS", '', ReportFormat::Html, OutStream, RecordRef);
                                    SUCOmipMarketers.Marketer::Nabalia:
                                        Report.SaveAs(Report::"SUC Omip Contract Copy Email", '', ReportFormat::Html, OutStream, RecordRef);
                                    SUCOmipMarketers.Marketer::Avanza:
                                        Report.SaveAs(Report::"SUC Omip Cont. Copy Email AVA", '', ReportFormat::Html, OutStream, RecordRef);
                                end;

                                TempBlob.CreateInStream(InStream, TextEncoding::UTF8);
                                InStream.ReadText(Body);
                                Body := Body.Replace('<table cellspacing="0" cellpadding="0" style="margin-right:7.1pt; margin-left:7.1pt; border-collapse:collapse; float:left">', '<table style="margin: 0 auto;">');

                                Subject := 'Contrato Precio Personalizado ' + SUCOmipEnergyContracts."No.";

                                SUCOmipTrackingBTP.Reset();
                                SUCOmipTrackingBTP.SetRange("Document Type", DocumentType);
                                SUCOmipTrackingBTP.SetRange("Document No.", DocNoIn);
                                SUCOmipTrackingBTP.SetFilter("BTP status", '%1|%2', 20, 70);
                                if SUCOmipTrackingBTP.FindLast() then begin
                                    if SUCOmipTrackingBTP."BTP doc".HasValue then begin
                                        SUCOmipTrackingBTP.CalcFields("BTP doc");
                                        FileName := CopyStr(Format(SUCOmipTrackingBTP."Document Type") + '_' + SUCOmipTrackingBTP."Document No." + '.pdf', 1, 250);
                                        FileExt := 'PDF';
                                        SUCOmipTrackingBTP."BTP doc".CreateInStream(InStream, TextEncoding::UTF8);
                                        while not (InStream.EOS) do
                                            InStream.Read(BTPdoc);
                                        TempBlob.CreateOutStream(OutStream);
                                        Base64Convert.FromBase64(BTPdoc, OutStream);
                                        TempBlob.CreateInStream(InStream2);
                                        SendEMailMessage(SUCOmipSetup."Email Contract Confirmation", Subject, Body, true, FileName, FileExt, InStream2, EmailScenario::Default);
                                        NewTrackingBTP2(DocumentType, DocNoIn, CurrentDateTime, '', '200', 'Send Email To Purchases', SUCOmipAcceptanceMethod::" ",
                                               SUCOmipSetup."Email Contract Confirmation", SUCOmipActionTrackingBTP::"Notification Send",
                                               '', '', 0, '', '', CurrentDateTime, false, '');
                                    end;
                                end else
                                    if SUCOmipProposals."Acceptance Method" = SUCOmipProposals."Acceptance Method"::" " then begin
                                        SendEMailMessage(SUCOmipSetup."Email Contract Confirmation", Subject, Body, false, '', '', InStream2, EmailScenario::Default);

                                        NewTrackingBTP2(DocumentType, DocNoIn, CurrentDateTime, '', '200', 'Send Email To Purchases', SUCOmipAcceptanceMethod::" ",
                                                       SUCOmipSetup."Email Contract Confirmation", SUCOmipActionTrackingBTP::"Notification Send",
                                                       '', '', 0, '', '', CurrentDateTime, false, '');
                                    end;
                            end;
                    end;
                end;
        end;
    end;

    local procedure ReadJson(jsonText: Text; var ResponseStatus: Text; var ResponseStatusDescription: Text)
    var
        JsonObject: JsonObject;
        JsonToken: JsonToken;
    begin
        Clear(JsonObject);
        JsonObject.ReadFrom(jsonText);

        JsonObject.SelectToken('status', JsonToken);
        ResponseStatus := JsonToken.AsValue().AsText();

        JsonObject.SelectToken('description', JsonToken);
        ResponseStatusDescription := JsonToken.AsValue().AsText();
    end;

    [Obsolete('Pending removal use NewTrackingBTP2', '25.2')]
    procedure NewTrackingBTP(SUCOmipDocumentTypeIn: Enum Sucasuc.Omip.Documents."SUC Omip Document Type"; DocNoIn: Code[20]; ExecutionDate: DateTime; JsonRequest: Text;
                                 ResponseStatus: Text; ResponseDescription: Text; AcceptanceMethod: Enum "SUC Omip Acceptance Method"; AcceptanceSend: Text[250];
                                 ActionTracking: Enum "SUC Omip Action Tracking BTP";
                                 BTPncal: Text[5]; BTPnop: Text[20]; BTPstatus: Integer; BTPdescription: Text[250]; BTPdoc: Text; BTPdate: DateTime)
    begin
    end;

    procedure NewTrackingBTP2(SUCOmipDocumentTypeIn: Enum Sucasuc.Omip.Documents."SUC Omip Document Type"; DocNoIn: Code[20]; ExecutionDate: DateTime; JsonRequest: Text;
                                 ResponseStatus: Text; ResponseDescription: Text; AcceptanceMethod: Enum "SUC Omip Acceptance Method"; AcceptanceSend: Text[250];
                                 ActionTracking: Enum "SUC Omip Action Tracking BTP";
                                 BTPncal: Text[5]; BTPnop: Text[20]; BTPstatus: Integer; BTPdescription: Text[250]; BTPdoc: Text; BTPdate: DateTime;
                                 duplicateDoc: Boolean; duplicateDocNo: Code[20])
    var
        SUCOmipTrackingBTP: Record "SUC Omip Tracking BTP";
    begin
        SUCOmipTrackingBTP.Init();
        SUCOmipTrackingBTP.Validate("Document Type", SUCOmipDocumentTypeIn);
        SUCOmipTrackingBTP.Validate("Document No.", DocNoIn);
        SUCOmipTrackingBTP.Validate("Line No.", NewLineNoTrackingBTP(SUCOmipDocumentTypeIn, DocNoIn));
        SUCOmipTrackingBTP.Insert();
        SUCOmipTrackingBTP.Validate("Execution Date", ExecutionDate);
        SUCOmipTrackingBTP.SetRequest(JsonRequest);
        SUCOmipTrackingBTP.Validate("Response Status", ResponseStatus);
        SUCOmipTrackingBTP.Validate("Response Description", ResponseDescription);
        SUCOmipTrackingBTP.Validate("Acceptance Method", AcceptanceMethod);
        SUCOmipTrackingBTP.Validate("Acceptance Send", AcceptanceSend);
        SUCOmipTrackingBTP.Validate("Action Tracking", ActionTracking);

        SUCOmipTrackingBTP.Validate("BTP ncal", BTPncal);
        SUCOmipTrackingBTP.Validate("BTP nop", BTPnop);
        SUCOmipTrackingBTP.Validate("BTP status", BTPstatus);
        SUCOmipTrackingBTP.Validate("BTP description", BTPdescription);
        SUCOmipTrackingBTP.SetDocBTP(BTPdoc);
        SUCOmipTrackingBTP.Validate("BTP date", BTPdate);
        SUCOmipTrackingBTP.Validate("Duplicate Document", duplicateDoc);
        SUCOmipTrackingBTP.Validate("Duplicate Document No.", duplicateDocNo);

        SUCOmipTrackingBTP.Modify();
    end;

    local procedure NewLineNoTrackingBTP(SUCOmipDocumentTypeIn: Enum Sucasuc.Omip.Documents."SUC Omip Document Type"; DocNoIn: Code[20]): Integer
    var
        SUCOmipTrackingBTP: Record "SUC Omip Tracking BTP";
    begin
        SUCOmipTrackingBTP.Reset();
        SUCOmipTrackingBTP.SetRange("Document Type", SUCOmipDocumentTypeIn);
        SUCOmipTrackingBTP.SetRange("Document No.", DocNoIn);
        if SUCOmipTrackingBTP.FindLast() then
            exit(SUCOmipTrackingBTP."Line No." + 10000)
        else
            exit(10000);
    end;

    /// <summary>
    /// SendAcceptanceSMS.
    /// </summary>   
    /// <param name="DocNoIn">Code[20].</param>
    /// <param name="CustomerName">Text[100].</param>
    /// <param name="ToBase64">Text.</param>
    /// <param name="SMSText">Text[1000].</param>
    /// <param name="AcceptanceSend">Text[250].</param>
    /// <param name="ReadJsonText">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure SendAcceptanceSMS(SUCOmipDocumentTypeIn: Enum "SUC Omip Document Type"; DocNoIn: Code[20]; CustomerName: Text[100]; ToBase64: Text; SMSText: Text[2048]; AcceptanceSend: Text[250]; var ReadJsonText: Text): Text
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipMarketers: Record "SUC Omip Marketers";
        SUCOmipESendDocSetup: Record "SUC Omip E-Send Doc. Setup";
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        HttpContent: HttpContent;
        jsonRequest: Text;
        ResponseText: Text;
        ResponseStatus: Text;
        ResponseStatusDescription: Text;
        JsonObject: JsonObject;
    begin
        case SUCOmipDocumentTypeIn of
            SUCOmipDocumentTypeIn::Proposal:
                begin
                    SUCOmipProposals.Get(DocNoIn);
                    SUCOmipProposals.TestField("Marketer No.");
                    SUCOmipMarketers.Get(SUCOmipProposals."Marketer No.");
                end;
            SUCOmipDocumentTypeIn::Contract:
                begin
                    SUCOmipEnergyContracts.Get(DocNoIn);
                    SUCOmipEnergyContracts.TestField("Marketer No.");
                    SUCOmipMarketers.Get(SUCOmipEnergyContracts."Marketer No.");
                end;
            else
                Error(ErrorLbl);
        end;

        SUCOmipESendDocSetup.Get(SUCOmipMarketers."No.");

        Clear(JsonObject);
        JsonObject.Add('ncal', SUCOmipESendDocSetup."Channel Code");
        JsonObject.Add('nop', DocNoIn);
        JsonObject.Add('oper', SUCOmipESendDocSetup."Operator Code");
        JsonObject.Add('nomyapp', CustomerName);
        JsonObject.Add('documento1', ToBase64);
        JsonObject.Add('sms1', SMSText);
        JsonObject.Add('telefono1', AcceptanceSend);

        JsonObject.WriteTo(jsonRequest);

        HttpContent.WriteFrom(jsonRequest);
        HttpContent.GetHeaders(Headers);
        Headers.Remove('Content-type');
        Headers.Add('Content-type', 'application/json');

        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.SetRequestUri(SUCOmipESendDocSetup."URL E-Send" + '/wssolicitudes.php');
        HttpRequestMessage.Method := 'POST';

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(ResponseText);

        ReadJson(ResponseText, ResponseStatus, ResponseStatusDescription);

        NewTrackingBTP2(SUCOmipDocumentTypeIn, DocNoIn, CurrentDateTime, jsonRequest, ResponseStatus, ResponseStatusDescription, SUCOmipAcceptanceMethod::SMS,
                       AcceptanceSend, SUCOmipActionTrackingBTP::"Notification Send",
                       '', '', 0, '', '', CurrentDateTime, false, '');

        ReadJsonText := ResponseStatus + ' - ' + ResponseStatusDescription;
    end;
    /// <summary>
    /// SendAcceptanceEmail.
    /// </summary>   
    /// <param name="DocNoIn">Code[20].</param>
    /// <param name="CustomerName">Text[100].</param>
    /// <param name="ToBase64">Text.</param>
    /// <param name="EmailText">Text[1000].</param>
    /// <param name="AcceptanceSend">Text[250].</param>
    /// <param name="ReadJsonText">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure SendAcceptanceEmail(SUCOmipDocumentTypeIn: Enum "SUC Omip Document Type"; DocNoIn: Code[20]; CustomerName: Text[100]; ToBase64: Text; EmailText: Text; AcceptanceSend: Text[250]; var ReadJsonText: Text)
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipMarketers: Record "SUC Omip Marketers";
        SUCOmipESendDocSetup: Record "SUC Omip E-Send Doc. Setup";
        AcceptanceMethodBef: Enum "SUC Omip Acceptance Method";
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        HttpContent: HttpContent;
        jsonRequest: Text;
        ResponseText: Text;
        ResponseStatus: Text;
        ResponseStatusDescription: Text;
        AcceptanceSendBef: Text[250];
        ncal: Text;
        oper: Text;
        URLBTP: Text;
        Transmitted: Boolean;
        JsonObject: JsonObject;
    begin
        SUCOmipSetup.Get();
        Transmitted := BroadcastBefore(SUCOmipDocumentTypeIn, DocNoIn, AcceptanceMethodBef, AcceptanceSendBef);

        case SUCOmipDocumentTypeIn of
            SUCOmipDocumentTypeIn::Proposal:
                begin
                    SUCOmipProposals.Get(DocNoIn);
                    SUCOmipMarketers.Get(SUCOmipProposals."Marketer No.");
                end;
            SUCOmipDocumentTypeIn::Contract:
                begin
                    SUCOmipEnergyContracts.Get(DocNoIn);
                    SUCOmipMarketers.Get(SUCOmipEnergyContracts."Marketer No.");
                end;
            else
                Error(ErrorLbl);
        end;

        SUCOmipESendDocSetup.Get(SUCOmipMarketers."No.");
        SUCOmipESendDocSetup.TestField("URL E-Send");
        SUCOmipESendDocSetup.TestField("Channel Code");
        SUCOmipESendDocSetup.TestField("Operator Code");

        URLBTP := SUCOmipESendDocSetup."URL E-Send";
        ncal := SUCOmipESendDocSetup."Channel Code";
        oper := SUCOmipESendDocSetup."Operator Code";

        Clear(JsonObject);
        if not Transmitted then begin
            JsonObject.Add('ncal', ncal);
            JsonObject.Add('nop', DocNoIn);
            JsonObject.Add('oper', oper);
            JsonObject.Add('nomyapp', CustomerName);
            JsonObject.Add('documento1', ToBase64);
            JsonObject.Add('mail_txt', EmailText);
            JsonObject.Add('email', AcceptanceSend);
        end else begin
            JsonObject.Add('ncal', ncal);
            JsonObject.Add('nop', DocNoIn);
            JsonObject.Add('oper', oper);
            JsonObject.Add('emailant', AcceptanceSendBef);
            JsonObject.Add('emailnue', AcceptanceSend);
        end;

        JsonObject.WriteTo(jsonRequest);

        HttpContent.WriteFrom(jsonRequest);
        HttpContent.GetHeaders(Headers);
        Headers.Remove('Content-type');
        Headers.Add('Content-type', 'application/json');

        HttpRequestMessage.Content := HttpContent;

        if Transmitted then begin
            HttpRequestMessage.SetRequestUri(URLBTP + '/wsreenviar.php');
            SUCOmipActionTrackingBTP := SUCOmipActionTrackingBTP::"Forwarded Notification";
        end else begin
            HttpRequestMessage.SetRequestUri(URLBTP + '/wssolicitudes.php');
            SUCOmipActionTrackingBTP := SUCOmipActionTrackingBTP::"Notification Send";
        end;
        HttpRequestMessage.Method := 'POST';

        if SUCOmipSetup."Show BTP Request" then
            Message(jsonRequest);

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(ResponseText);

        ReadJson(ResponseText, ResponseStatus, ResponseStatusDescription);

        NewTrackingBTP2(SUCOmipDocumentTypeIn, DocNoIn, CurrentDateTime, jsonRequest, ResponseStatus, ResponseStatusDescription, SUCOmipAcceptanceMethod::Email,
                       AcceptanceSend, SUCOmipActionTrackingBTP,
                       '', '', 0, '', '', CurrentDateTime, false, '');

        ReadJsonText := ResponseStatus + ' - ' + ResponseStatusDescription;
    end;

    local procedure BroadcastBefore(SUCOmipDocumentTypeIn: Enum "SUC Omip Document Type"; DocNoIn: Code[20]; var AcceptanceMethod: Enum "SUC Omip Acceptance Method"; var AcceptanceSend: Text[250]): Boolean
    var
        SUCOmipTrackingBTP: Record "SUC Omip Tracking BTP";
    begin
        Clear(AcceptanceMethod);
        Clear(AcceptanceSend);
        SUCOmipTrackingBTP.Reset();
        SUCOmipTrackingBTP.SetRange("Document Type", SUCOmipDocumentTypeIn);
        SUCOmipTrackingBTP.SetRange("Document No.", DocNoIn);
        SUCOmipTrackingBTP.SetRange("Response Status", '1');
        if SUCOmipTrackingBTP.FindLast() then begin
            AcceptanceMethod := SUCOmipTrackingBTP."Acceptance Method";
            AcceptanceSend := SUCOmipTrackingBTP."Acceptance Send";
            exit(true);
        end;
        exit(false);
    end;

    procedure CancelOperation(SUCOmipDocumentTypeIn: Enum "SUC Omip Document Type"; DocNoIn: Code[20])
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipMarketers: Record "SUC Omip Marketers";
        SUCOmipESendDocSetup: Record "SUC Omip E-Send Doc. Setup";
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        HttpContent: HttpContent;
        jsonRequest: Text;
        ResponseText: Text;
        ResponseStatus: Text;
        ResponseStatusDescription: Text;
        JsonObject: JsonObject;
    begin
        case SUCOmipDocumentTypeIn of
            SUCOmipDocumentTypeIn::Proposal:
                begin
                    SUCOmipProposals.Get(DocNoIn);
                    SUCOmipProposals.TestField("Marketer No.");
                    SUCOmipMarketers.Get(SUCOmipProposals."Marketer No.");
                end;
            SUCOmipDocumentTypeIn::Contract:
                begin
                    SUCOmipEnergyContracts.Get(DocNoIn);
                    SUCOmipEnergyContracts.TestField("Marketer No.");
                    SUCOmipMarketers.Get(SUCOmipEnergyContracts."Marketer No.");
                end;
            else
                Error(ErrorLbl);
        end;

        SUCOmipESendDocSetup.Get(SUCOmipMarketers."No.");
        SUCOmipESendDocSetup.TestField("URL E-Send");
        SUCOmipESendDocSetup.TestField("Channel Code");
        SUCOmipESendDocSetup.TestField("Operator Code");

        Clear(JsonObject);
        JsonObject.Add('ncal', SUCOmipESendDocSetup."Channel Code");
        JsonObject.Add('nop', DocNoIn);
        JsonObject.Add('oper', SUCOmipESendDocSetup."Operator Code");
        JsonObject.Add('cancelar', 1);

        JsonObject.WriteTo(jsonRequest);

        HttpContent.WriteFrom(jsonRequest);
        HttpContent.GetHeaders(Headers);
        Headers.Remove('Content-type');
        Headers.Add('Content-type', 'application/json');

        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.SetRequestUri(SUCOmipESendDocSetup."URL E-Send" + '/wscancelar.php');
        HttpRequestMessage.Method := 'POST';

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(ResponseText);

        ReadJson(ResponseText, ResponseStatus, ResponseStatusDescription);

        NewTrackingBTP2(SUCOmipDocumentTypeIn, DocNoIn, CurrentDateTime, jsonRequest, ResponseStatus, ResponseStatusDescription, SUCOmipAcceptanceMethod::" ", '',
                       SUCOmipActionTrackingBTP::Cancel,
                       '', '', 0, '', '', CurrentDateTime, false, '');
    end;

    // local procedure HTMLToBTPContract2(CustomerName: Text): Text
    // var
    //     StringHTML: TextBuilder;
    // begin
    //     StringHTML.Clear();
    //     StringHTML.AppendLine('        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">');
    //     StringHTML.AppendLine('        <html');
    //     StringHTML.AppendLine('            xmlns="http://www.w3.org/1999/xhtml"');
    //     StringHTML.AppendLine('            xmlns:v="urn:schemas-microsoft-com:vml"');
    //     StringHTML.AppendLine('            xmlns:o="urn:schemas-microsoft-com:office:office"');
    //     StringHTML.AppendLine('        >');
    //     StringHTML.AppendLine('            <head>');
    //     StringHTML.AppendLine('                <meta http-equiv="X-UA-Compatible" content="IE=edge" />');
    //     StringHTML.AppendLine('                <meta name="viewport" content="width=device-width, initial-scale=1" />');
    //     StringHTML.AppendLine('                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />');
    //     StringHTML.AppendLine('                <meta name="x-apple-disable-message-reformatting" />');
    //     StringHTML.AppendLine('                <meta name="apple-mobile-web-app-capable" content="yes" />');
    //     StringHTML.AppendLine('                <meta name="apple-mobile-web-app-status-bar-style" content="black" />');
    //     StringHTML.AppendLine('                <meta name="format-detection" content="telephone=no" />');
    //     StringHTML.AppendLine('                <title></title>');
    //     StringHTML.AppendLine('                <style type="text/css">');
    //     StringHTML.AppendLine('                    table {');
    //     StringHTML.AppendLine('                        border-spacing: 0;');
    //     StringHTML.AppendLine('                    }');
    //     StringHTML.AppendLine('');
    //     StringHTML.AppendLine('                    table td {');
    //     StringHTML.AppendLine('                        border-collapse: collapse;');
    //     StringHTML.AppendLine('                    }');
    //     StringHTML.AppendLine('                </style>');
    //     StringHTML.AppendLine('            </head>');
    //     StringHTML.AppendLine('            <body');
    //     StringHTML.AppendLine('                style="');
    //     StringHTML.AppendLine('                    background-color: #e9e9e9;');
    //     StringHTML.AppendLine('                    margin: 0;');
    //     StringHTML.AppendLine('                    padding: 0;');
    //     StringHTML.AppendLine('                    font-family: Arial, sans-serif;');
    //     StringHTML.AppendLine('                "');
    //     StringHTML.AppendLine('            >');
    //     StringHTML.AppendLine('                <table');
    //     StringHTML.AppendLine('                    border="0"');
    //     StringHTML.AppendLine('                    align="center"');
    //     StringHTML.AppendLine('                    width="100%"');
    //     StringHTML.AppendLine('                    cellpadding="0"');
    //     StringHTML.AppendLine('                    cellspacing="0"');
    //     StringHTML.AppendLine('                    class="main-template"');
    //     StringHTML.AppendLine('                    bgcolor="#e9e9e9"');
    //     StringHTML.AppendLine('                >');
    //     StringHTML.AppendLine('                    <tbody>');
    //     StringHTML.AppendLine('                        <tr>');
    //     StringHTML.AppendLine('                            <td align="center" valign="top">');
    //     StringHTML.AppendLine('                                <table');
    //     StringHTML.AppendLine('                                    align="center"');
    //     StringHTML.AppendLine('                                    border="0"');
    //     StringHTML.AppendLine('                                    cellpadding="0"');
    //     StringHTML.AppendLine('                                    cellspacing="0"');
    //     StringHTML.AppendLine('                                    width="100%"');
    //     StringHTML.AppendLine('                                    style="max-width: 590px"');
    //     StringHTML.AppendLine('                                >');
    //     StringHTML.AppendLine('                                    <tr>');
    //     StringHTML.AppendLine('                                        <td align="center" bgcolor="#e9e9e9" colspan="3">&nbsp;</td>');
    //     StringHTML.AppendLine('                                    </tr>');
    //     StringHTML.AppendLine('                                    <tr>');
    //     StringHTML.AppendLine('                                        <td colspan="3" align="center" bgcolor="#ffffff">');
    //     StringHTML.AppendLine('                                            <img');
    //     StringHTML.AppendLine('                                                src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/header.jpeg"');
    //     StringHTML.AppendLine('                                                alt="Asegura un precio fijo para tu energía ahora"');
    //     StringHTML.AppendLine('                                                width="590"');
    //     StringHTML.AppendLine('                                                height="200"');
    //     StringHTML.AppendLine('                                            />');
    //     StringHTML.AppendLine('                                        </td>');
    //     StringHTML.AppendLine('                                    </tr>');
    //     StringHTML.AppendLine('                                    <tr height="230">');
    //     StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
    //     StringHTML.AppendLine('                                        <td');
    //     StringHTML.AppendLine('                                            align="left"');
    //     StringHTML.AppendLine('                                            bgcolor="#ffffff"');
    //     StringHTML.AppendLine('                                            width="522"');
    //     StringHTML.AppendLine('                                            style="color: #333333"');
    //     StringHTML.AppendLine('                                        >');
    //     StringHTML.AppendLine('                                            <p style="font-size: 17px">');
    //     StringHTML.AppendLine('                                                ¡Hola ' + CustomerName + '!');
    //     StringHTML.AppendLine('                                            </p>');
    //     StringHTML.AppendLine('                                            <p style="font-size: 16px">');
    //     StringHTML.AppendLine('                                                Nos complace presentarte una');
    //     StringHTML.AppendLine('                                                <strong>oferta exclusiva</strong> para que puedas fijar el');
    //     StringHTML.AppendLine('                                                precio de la energía para los próximos años de vigencia en');
    //     StringHTML.AppendLine('                                                tu contrato.');
    //     StringHTML.AppendLine('                                            </p>');
    //     StringHTML.AppendLine('                                            <p style="font-size: 16px">');
    //     StringHTML.AppendLine('                                                En Nabalia Energía, somos conscientes de la incertidumbre');
    //     StringHTML.AppendLine('                                                actual del mercado energético y del impacto que esto puede');
    //     StringHTML.AppendLine('                                                tener en tu economía. Por ello,');
    //     StringHTML.AppendLine('                                                <strong');
    //     StringHTML.AppendLine('                                                    >hemos diseñado esta oferta para brindarte estabilidad y');
    //     StringHTML.AppendLine('                                                    tranquilidad en el pago de tu factura.</strong');
    //     StringHTML.AppendLine('                                                >');
    //     StringHTML.AppendLine('                                            </p>');
    //     StringHTML.AppendLine('                                        </td>');
    //     StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
    //     StringHTML.AppendLine('                                    </tr>');
    //     StringHTML.AppendLine('                                    <tr height="50">');
    //     StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
    //     StringHTML.AppendLine('                                        <td');
    //     StringHTML.AppendLine('                                            align="center"');
    //     StringHTML.AppendLine('                                            bgcolor="#ffffff"');
    //     StringHTML.AppendLine('                                            width="522"');
    //     StringHTML.AppendLine('                                            style="color: #333333"');
    //     StringHTML.AppendLine('                                        >');
    //     StringHTML.AppendLine('                                            <a href="{url}"');
    //     StringHTML.AppendLine('                                                ><img');
    //     StringHTML.AppendLine('                                                    src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/firmar.jpeg"');
    //     StringHTML.AppendLine('                                                    alt="firmar"');
    //     StringHTML.AppendLine('                                                    width="104"');
    //     StringHTML.AppendLine('                                                    height="38"');
    //     StringHTML.AppendLine('                                            /></a>');
    //     StringHTML.AppendLine('                                        </td>');
    //     StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
    //     StringHTML.AppendLine('                                    </tr>');
    //     StringHTML.AppendLine('                                    <tr height="481">');
    //     StringHTML.AppendLine('                                        <td colspan="3" align="center" bgcolor="#ffffff">');
    //     StringHTML.AppendLine('                                            <img');
    //     StringHTML.AppendLine('                                                src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/offer.jpeg"');
    //     StringHTML.AppendLine('                                                alt="Asegura un precio fijo para tu energía ahora"');
    //     StringHTML.AppendLine('                                                width="590"');
    //     StringHTML.AppendLine('                                                height="481"');
    //     StringHTML.AppendLine('                                                style="display: block"');
    //     StringHTML.AppendLine('                                            />');
    //     StringHTML.AppendLine('                                        </td>');
    //     StringHTML.AppendLine('                                    </tr>');
    //     StringHTML.AppendLine('                                    <tr height="100">');
    //     StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
    //     StringHTML.AppendLine('                                        <td align="left" bgcolor="#ffffff">');
    //     StringHTML.AppendLine('                                            <p style="font-size: 15px">');
    //     StringHTML.AppendLine('                                                <br />');
    //     StringHTML.AppendLine('                                                No pierdas esta oportunidad única de protegerte de las');
    //     StringHTML.AppendLine('                                                subidas del precio de la energía y firma tu propuesta');
    //     StringHTML.AppendLine('                                                personalizada.');
    //     StringHTML.AppendLine('                                            </p>');
    //     StringHTML.AppendLine('                                        </td>');
    //     StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
    //     StringHTML.AppendLine('                                    </tr>');
    //     StringHTML.AppendLine('                                    <tr height="80">');
    //     StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
    //     StringHTML.AppendLine('                                        <td align="left" bgcolor="#ffffff" style="color: #333333">');
    //     StringHTML.AppendLine('                                            <p style="font-size: 15px">Atentamente,</p>');
    //     StringHTML.AppendLine('                                            <p style="font-size: 15px">Nabalia Energía</p>');
    //     StringHTML.AppendLine('                                        </td>');
    //     StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
    //     StringHTML.AppendLine('                                    </tr>');
    //     StringHTML.AppendLine('                                    <tr>');
    //     StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" colspan="3">');
    //     StringHTML.AppendLine('                                            <table');
    //     StringHTML.AppendLine('                                                align="center"');
    //     StringHTML.AppendLine('                                                border="0"');
    //     StringHTML.AppendLine('                                                cellpadding="0"');
    //     StringHTML.AppendLine('                                                cellspacing="0"');
    //     StringHTML.AppendLine('                                                width="590"');
    //     StringHTML.AppendLine('                                                bgcolor="#00338D"');
    //     StringHTML.AppendLine('                                            >');
    //     StringHTML.AppendLine('                                                <tr>');
    //     StringHTML.AppendLine('                                                    <td');
    //     StringHTML.AppendLine('                                                        align="center"');
    //     StringHTML.AppendLine('                                                        bgcolor="#00338D"');
    //     StringHTML.AppendLine('                                                        width="590"');
    //     StringHTML.AppendLine('                                                        colspan="3"');
    //     StringHTML.AppendLine('                                                    >');
    //     StringHTML.AppendLine('                                                        &nbsp;');
    //     StringHTML.AppendLine('                                                    </td>');
    //     StringHTML.AppendLine('                                                </tr>');
    //     StringHTML.AppendLine('                                                <tr>');
    //     StringHTML.AppendLine('                                                    <td align="center" bgcolor="#00338D" width="34">');
    //     StringHTML.AppendLine('                                                        &nbsp;');
    //     StringHTML.AppendLine('                                                    </td>');
    //     StringHTML.AppendLine('');
    //     StringHTML.AppendLine('                                                    <td');
    //     StringHTML.AppendLine('                                                        align="left"');
    //     StringHTML.AppendLine('                                                        bgcolor="#00338D"');
    //     StringHTML.AppendLine('                                                        style="color: #ffffff; font-size: 14px"');
    //     StringHTML.AppendLine('                                                    >');
    //     StringHTML.AppendLine('                                                        Plaza Urquinaona 7<br />');
    //     StringHTML.AppendLine('                                                        08010 Barcelona<br />');
    //     StringHTML.AppendLine('                                                        Gran Vía, 16. 1ª - Puerta 3<br />');
    //     StringHTML.AppendLine('                                                        28013 Madrid<br />');
    //     StringHTML.AppendLine('                                                        info@nabaliaenergia.com');
    //     StringHTML.AppendLine('                                                    </td>');
    //     StringHTML.AppendLine('                                                    <td align="right">');
    //     StringHTML.AppendLine('                                                        <a');
    //     StringHTML.AppendLine('                                                            target="_blank"');
    //     StringHTML.AppendLine('                                                            href="https://es.linkedin.com/company/nabalia-energ%C3%ADa"');
    //     StringHTML.AppendLine('                                                            style="text-decoration: none"');
    //     StringHTML.AppendLine('                                                            ><img');
    //     StringHTML.AppendLine('                                                                src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/linkedin.jpeg"');
    //     StringHTML.AppendLine('                                                                alt="LinkedIn"');
    //     StringHTML.AppendLine('                                                                width="26"');
    //     StringHTML.AppendLine('                                                        /></a>');
    //     StringHTML.AppendLine('                                                        <a');
    //     StringHTML.AppendLine('                                                            target="_blank"');
    //     StringHTML.AppendLine('                                                            href="https://www.instagram.com/nabalia_energia/"');
    //     StringHTML.AppendLine('                                                            style="text-decoration: none"');
    //     StringHTML.AppendLine('                                                            ><img');
    //     StringHTML.AppendLine('                                                                src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/instagram.jpeg"');
    //     StringHTML.AppendLine('                                                                alt="Instagram"');
    //     StringHTML.AppendLine('                                                                width="26"');
    //     StringHTML.AppendLine('                                                        /></a>');
    //     StringHTML.AppendLine('                                                        <a');
    //     StringHTML.AppendLine('                                                            target="_blank"');
    //     StringHTML.AppendLine('                                                            href="https://www.facebook.com/Nabalia-Energ%C3%ADa-1511716725803858/"');
    //     StringHTML.AppendLine('                                                            style="text-decoration: none"');
    //     StringHTML.AppendLine('                                                            ><img');
    //     StringHTML.AppendLine('                                                                src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/facebook.jpeg"');
    //     StringHTML.AppendLine('                                                                alt="Facebook"');
    //     StringHTML.AppendLine('                                                                width="26"');
    //     StringHTML.AppendLine('                                                        /></a>');
    //     StringHTML.AppendLine('                                                        <a');
    //     StringHTML.AppendLine('                                                            target="_blank"');
    //     StringHTML.AppendLine('                                                            href="https://twitter.com/nabaliaenergia"');
    //     StringHTML.AppendLine('                                                            style="text-decoration: none"');
    //     StringHTML.AppendLine('                                                            ><img');
    //     StringHTML.AppendLine('                                                                src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/x.jpeg"');
    //     StringHTML.AppendLine('                                                                alt="Twitter"');
    //     StringHTML.AppendLine('                                                                width="26"');
    //     StringHTML.AppendLine('                                                        /></a>');
    //     StringHTML.AppendLine('                                                    </td>');
    //     StringHTML.AppendLine('                                                    <td align="center" bgcolor="#00338D" width="34">');
    //     StringHTML.AppendLine('                                                        &nbsp;');
    //     StringHTML.AppendLine('                                                    </td>');
    //     StringHTML.AppendLine('                                                </tr>');
    //     StringHTML.AppendLine('                                                <tr>');
    //     StringHTML.AppendLine('                                                    <td');
    //     StringHTML.AppendLine('                                                        align="center"');
    //     StringHTML.AppendLine('                                                        bgcolor="#00338D"');
    //     StringHTML.AppendLine('                                                        width="590"');
    //     StringHTML.AppendLine('                                                        colspan="3"');
    //     StringHTML.AppendLine('                                                    >');
    //     StringHTML.AppendLine('                                                        &nbsp;');
    //     StringHTML.AppendLine('                                                    </td>');
    //     StringHTML.AppendLine('                                                </tr>');
    //     StringHTML.AppendLine('                                            </table>');
    //     StringHTML.AppendLine('                                        </td>');
    //     StringHTML.AppendLine('                                    </tr>');
    //     StringHTML.AppendLine('                                    <tr>');
    //     StringHTML.AppendLine('                                        <td align="center" bgcolor="#e9e9e9" colspan="3">&nbsp;</td>');
    //     StringHTML.AppendLine('                                    </tr>');
    //     StringHTML.AppendLine('                                </table>');
    //     StringHTML.AppendLine('                            </td>');
    //     StringHTML.AppendLine('                        </tr>');
    //     StringHTML.AppendLine('                    </tbody>');
    //     StringHTML.AppendLine('                </table>');
    //     StringHTML.AppendLine('            </body>');
    //     StringHTML.AppendLine('        </html>');

    //     exit(StringHTML.ToText());
    // end;

    /*local procedure HTMLToBTPProposal(CustomerName: Text): Text
    var
        StringHTML: TextBuilder;
    begin
        StringHTML.Clear();
        StringHTML.AppendLine('        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">');
        StringHTML.AppendLine('        <html');
        StringHTML.AppendLine('            xmlns="http://www.w3.org/1999/xhtml"');
        StringHTML.AppendLine('            xmlns:v="urn:schemas-microsoft-com:vml"');
        StringHTML.AppendLine('            xmlns:o="urn:schemas-microsoft-com:office:office"');
        StringHTML.AppendLine('        >');
        StringHTML.AppendLine('            <head>');
        StringHTML.AppendLine('                <meta http-equiv="X-UA-Compatible" content="IE=edge" />');
        StringHTML.AppendLine('                <meta name="viewport" content="width=device-width, initial-scale=1" />');
        StringHTML.AppendLine('                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />');
        StringHTML.AppendLine('                <meta name="x-apple-disable-message-reformatting" />');
        StringHTML.AppendLine('                <meta name="apple-mobile-web-app-capable" content="yes" />');
        StringHTML.AppendLine('                <meta name="apple-mobile-web-app-status-bar-style" content="black" />');
        StringHTML.AppendLine('                <meta name="format-detection" content="telephone=no" />');
        StringHTML.AppendLine('                <title></title>');
        StringHTML.AppendLine('                <style type="text/css">');
        StringHTML.AppendLine('                    table {');
        StringHTML.AppendLine('                        border-spacing: 0;');
        StringHTML.AppendLine('                    }');
        StringHTML.AppendLine('');
        StringHTML.AppendLine('                    table td {');
        StringHTML.AppendLine('                        border-collapse: collapse;');
        StringHTML.AppendLine('                    }');
        StringHTML.AppendLine('                </style>');
        StringHTML.AppendLine('            </head>');
        StringHTML.AppendLine('            <body');
        StringHTML.AppendLine('                style="');
        StringHTML.AppendLine('                    background-color: #e9e9e9;');
        StringHTML.AppendLine('                    margin: 0;');
        StringHTML.AppendLine('                    padding: 0;');
        StringHTML.AppendLine('                    font-family: Arial, sans-serif;');
        StringHTML.AppendLine('                "');
        StringHTML.AppendLine('            >');
        StringHTML.AppendLine('                <table');
        StringHTML.AppendLine('                    border="0"');
        StringHTML.AppendLine('                    align="center"');
        StringHTML.AppendLine('                    width="100%"');
        StringHTML.AppendLine('                    cellpadding="0"');
        StringHTML.AppendLine('                    cellspacing="0"');
        StringHTML.AppendLine('                    class="main-template"');
        StringHTML.AppendLine('                    bgcolor="#e9e9e9"');
        StringHTML.AppendLine('                >');
        StringHTML.AppendLine('                    <tbody>');
        StringHTML.AppendLine('                        <tr>');
        StringHTML.AppendLine('                            <td align="center" valign="top">');
        StringHTML.AppendLine('                                <table');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    border="0"');
        StringHTML.AppendLine('                                    cellpadding="0"');
        StringHTML.AppendLine('                                    cellspacing="0"');
        StringHTML.AppendLine('                                    width="100%"');
        StringHTML.AppendLine('                                    style="max-width: 590px"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <tr>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#e9e9e9" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr>');
        StringHTML.AppendLine('                                        <td colspan="3" align="center" bgcolor="#ffffff">');
        StringHTML.AppendLine('                                            <img');
        StringHTML.AppendLine('                                                src="https://assets.electryconsulting.com/mail/campaigns/2024-06-13/oferta-precio-fijo/header.jpeg"');
        StringHTML.AppendLine('                                                alt="Asegura un precio fijo para tu energía ahora"');
        StringHTML.AppendLine('                                                width="590"');
        StringHTML.AppendLine('                                                height="200"');
        StringHTML.AppendLine('                                            />');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr height="200">');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                        <td');
        StringHTML.AppendLine('                                            align="left"');
        StringHTML.AppendLine('                                            bgcolor="#ffffff"');
        StringHTML.AppendLine('                                            width="522"');
        StringHTML.AppendLine('                                            style="color: #333333"');
        StringHTML.AppendLine('                                        >');
        StringHTML.AppendLine('                                            <p style="font-size: 17px">');
        StringHTML.AppendLine('                                                ¡Hola ' + CustomerName + '!');
        StringHTML.AppendLine('                                            </p>');
        StringHTML.AppendLine('');
        StringHTML.AppendLine('                                            <p style="font-size: 16px">');
        StringHTML.AppendLine('                                                Nos complace presentarte una');
        StringHTML.AppendLine('                                                <strong>oferta exclusiva</strong> para que puedas fijar el');
        StringHTML.AppendLine('                                                precio de la energía para los próximos años de vigencia en');
        StringHTML.AppendLine('                                                tu contrato.');
        StringHTML.AppendLine('                                            </p>');
        StringHTML.AppendLine('                                            <p style="font-size: 16px">');
        StringHTML.AppendLine('                                                En ElectryConsulting, somos conscientes de la incertidumbre');
        StringHTML.AppendLine('                                                actual del mercado energético y del impacto que esto puede');
        StringHTML.AppendLine('                                                tener en tu economía. Por ello,');
        StringHTML.AppendLine('                                                <strong');
        StringHTML.AppendLine('                                                    >hemos diseñado esta oferta para brindarte estabilidad y');
        StringHTML.AppendLine('                                                    tranquilidad en el pago de tu factura.</strong');
        StringHTML.AppendLine('                                                >');
        StringHTML.AppendLine('                                            </p>');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr height="100">');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                        <td');
        StringHTML.AppendLine('                                            align="center"');
        StringHTML.AppendLine('                                            bgcolor="#ffffff"');
        StringHTML.AppendLine('                                            width="522"');
        StringHTML.AppendLine('                                            style="color: #333333"');
        StringHTML.AppendLine('                                        >');
        StringHTML.AppendLine('                                            <a href="{URL}"');
        StringHTML.AppendLine('                                                ><img');
        StringHTML.AppendLine('                                                    src="https://assets.electryconsulting.com/mail/campaigns/2024-06-13/oferta-precio-fijo/firmar.jpeg"');
        StringHTML.AppendLine('                                                    alt="firmar"');
        StringHTML.AppendLine('                                                    width="94"');
        StringHTML.AppendLine('                                                    height="40"');
        StringHTML.AppendLine('                                            /></a>');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('');
        StringHTML.AppendLine('                                    <tr height="481">');
        StringHTML.AppendLine('                                        <td colspan="3" align="center" bgcolor="#ffffff">');
        StringHTML.AppendLine('                                            <img');
        StringHTML.AppendLine('                                                src="https://assets.electryconsulting.com/mail/campaigns/2024-06-13/oferta-precio-fijo/offer.jpeg"');
        StringHTML.AppendLine('                                                alt="Asegura un precio fijo para tu energía ahora"');
        StringHTML.AppendLine('                                                width="590"');
        StringHTML.AppendLine('                                                height="534"');
        StringHTML.AppendLine('                                                style="display: block"');
        StringHTML.AppendLine('                                            />');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('');
        StringHTML.AppendLine('                                    <tr height="100">');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                        <td align="left" bgcolor="#ffffff" width="522">');
        StringHTML.AppendLine('                                            <p style="font-size: 15px">');
        StringHTML.AppendLine('                                                <br />');
        StringHTML.AppendLine('                                                No pierdas esta oportunidad única de protegerte de las');
        StringHTML.AppendLine('                                                subidas del precio de la energía y firma tu propuesta');
        StringHTML.AppendLine('                                                personalizada.');
        StringHTML.AppendLine('                                            </p>');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr height="80">');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                        <td');
        StringHTML.AppendLine('                                            align="left"');
        StringHTML.AppendLine('                                            bgcolor="#ffffff"');
        StringHTML.AppendLine('                                            width="522"');
        StringHTML.AppendLine('                                            style="color: #333333"');
        StringHTML.AppendLine('                                        >');
        StringHTML.AppendLine('                                            <p style="font-size: 15px">Atentamente,</p>');
        StringHTML.AppendLine('                                            <p style="font-size: 15px">ElectryConsulting</p>');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#303331" colspan="3">');
        StringHTML.AppendLine('                                            <table');
        StringHTML.AppendLine('                                                align="center"');
        StringHTML.AppendLine('                                                border="0"');
        StringHTML.AppendLine('                                                cellpadding="0"');
        StringHTML.AppendLine('                                                cellspacing="0"');
        StringHTML.AppendLine('                                                width="590"');
        StringHTML.AppendLine('                                                bgcolor="#303331"');
        StringHTML.AppendLine('                                            >');
        StringHTML.AppendLine('                                                <tr>');
        StringHTML.AppendLine('                                                    <td');
        StringHTML.AppendLine('                                                        align="center"');
        StringHTML.AppendLine('                                                        bgcolor="#303331"');
        StringHTML.AppendLine('                                                        width="590"');
        StringHTML.AppendLine('                                                        colspan="3"');
        StringHTML.AppendLine('                                                    >');
        StringHTML.AppendLine('                                                        &nbsp;');
        StringHTML.AppendLine('                                                    </td>');
        StringHTML.AppendLine('                                                </tr>');
        StringHTML.AppendLine('                                                <tr>');
        StringHTML.AppendLine('                                                    <td align="center" bgcolor="#303331" width="34">');
        StringHTML.AppendLine('                                                        &nbsp;');
        StringHTML.AppendLine('                                                    </td>');
        StringHTML.AppendLine('');
        StringHTML.AppendLine('                                                    <td');
        StringHTML.AppendLine('                                                        align="left"');
        StringHTML.AppendLine('                                                        bgcolor="#303331"');
        StringHTML.AppendLine('                                                        style="color: #ffffff; font-size: 14px"');
        StringHTML.AppendLine('                                                    >');
        StringHTML.AppendLine('                                                        Plaza Urquinaona 7<br />');
        StringHTML.AppendLine('                                                        08010 Barcelona<br />');
        StringHTML.AppendLine('                                                        Gran Vía, 16. 1ª - Puerta 3<br />');
        StringHTML.AppendLine('                                                        28013 Madrid<br />');
        StringHTML.AppendLine('                                                        info@electryconsulting.com');
        StringHTML.AppendLine('                                                    </td>');
        StringHTML.AppendLine('                                                    <td align="right">');
        StringHTML.AppendLine('                                                        <a');
        StringHTML.AppendLine('                                                            target="_blank"');
        StringHTML.AppendLine('                                                            href="https://www.linkedin.com/company/electryconsulting-s-l/"');
        StringHTML.AppendLine('                                                            style="text-decoration: none"');
        StringHTML.AppendLine('                                                            ><img');
        StringHTML.AppendLine('                                                                src="https://assets.electryconsulting.com/mail/campaigns/2024-06-13/oferta-precio-fijo/linkedin.jpeg"');
        StringHTML.AppendLine('                                                                alt="LinkedIn"');
        StringHTML.AppendLine('                                                                width="26"');
        StringHTML.AppendLine('                                                        /></a>');
        StringHTML.AppendLine('                                                        <a');
        StringHTML.AppendLine('                                                            target="_blank"');
        StringHTML.AppendLine('                                                            href="https://www.instagram.com/electryconsulting_oficial/"');
        StringHTML.AppendLine('                                                            style="text-decoration: none"');
        StringHTML.AppendLine('                                                            ><img');
        StringHTML.AppendLine('                                                                src="https://assets.electryconsulting.com/mail/campaigns/2024-06-13/oferta-precio-fijo/instagram.jpeg"');
        StringHTML.AppendLine('                                                                alt="Instagram"');
        StringHTML.AppendLine('                                                                width="26"');
        StringHTML.AppendLine('                                                        /></a>');
        StringHTML.AppendLine('                                                        <a');
        StringHTML.AppendLine('                                                            target="_blank"');
        StringHTML.AppendLine('                                                            href="https://www.facebook.com/electryconsultingasesoria/"');
        StringHTML.AppendLine('                                                            style="text-decoration: none"');
        StringHTML.AppendLine('                                                            ><img');
        StringHTML.AppendLine('                                                                src="https://assets.electryconsulting.com/mail/campaigns/2024-06-13/oferta-precio-fijo/facebook.jpeg"');
        StringHTML.AppendLine('                                                                alt="Facebook"');
        StringHTML.AppendLine('                                                                width="26"');
        StringHTML.AppendLine('                                                        /></a>');
        StringHTML.AppendLine('                                                        <a');
        StringHTML.AppendLine('                                                            target="_blank"');
        StringHTML.AppendLine('                                                            href="https://x.com/tuasesorenergia?lang=es"');
        StringHTML.AppendLine('                                                            style="text-decoration: none"');
        StringHTML.AppendLine('                                                            ><img');
        StringHTML.AppendLine('                                                                src="https://assets.electryconsulting.com/mail/campaigns/2024-06-13/oferta-precio-fijo/x.jpeg"');
        StringHTML.AppendLine('                                                                alt="Twitter"');
        StringHTML.AppendLine('                                                                width="26"');
        StringHTML.AppendLine('                                                        /></a>');
        StringHTML.AppendLine('                                                    </td>');
        StringHTML.AppendLine('                                                    <td align="center" bgcolor="#303331" width="34">');
        StringHTML.AppendLine('                                                        &nbsp;');
        StringHTML.AppendLine('                                                    </td>');
        StringHTML.AppendLine('                                                </tr>');
        StringHTML.AppendLine('                                                <tr>');
        StringHTML.AppendLine('                                                    <td');
        StringHTML.AppendLine('                                                        align="center"');
        StringHTML.AppendLine('                                                        bgcolor="#303331"');
        StringHTML.AppendLine('                                                        width="590"');
        StringHTML.AppendLine('                                                        colspan="3"');
        StringHTML.AppendLine('                                                    >');
        StringHTML.AppendLine('                                                        &nbsp;');
        StringHTML.AppendLine('                                                    </td>');
        StringHTML.AppendLine('                                                </tr>');
        StringHTML.AppendLine('                                            </table>');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#e9e9e9" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                </table>');
        StringHTML.AppendLine('                            </td>');
        StringHTML.AppendLine('                        </tr>');
        StringHTML.AppendLine('                    </tbody>');
        StringHTML.AppendLine('                </table>');
        StringHTML.AppendLine('            </body>');
        StringHTML.AppendLine('        </html>');

        exit(StringHTML.ToText());
    end;*/

    local procedure HTMLToBTPProposalNabalia(CustomerName: Text): Text
    var
        StringHTML: TextBuilder;
    begin
        StringHTML.Clear();
        StringHTML.AppendLine('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">');
        StringHTML.AppendLine('<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">');
        StringHTML.AppendLine('<head>');
        StringHTML.AppendLine('<meta http-equiv="X-UA-Compatible" content="IE=edge" />');
        StringHTML.AppendLine('<meta name="viewport" content="width=device-width, initial-scale=1" />');
        StringHTML.AppendLine('<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />');
        StringHTML.AppendLine('<meta name="x-apple-disable-message-reformatting" />');
        StringHTML.AppendLine('<meta name="apple-mobile-web-app-capable" content="yes" />');
        StringHTML.AppendLine('<meta name="apple-mobile-web-app-status-bar-style" content="black" />');
        StringHTML.AppendLine('<meta name="format-detection" content="telephone=no" />');
        StringHTML.AppendLine('<title></title>');
        StringHTML.AppendLine('<style type="text/css">');
        StringHTML.AppendLine('table {');
        StringHTML.AppendLine('border-spacing: 0;');
        StringHTML.AppendLine('}');
        StringHTML.AppendLine('table td {');
        StringHTML.AppendLine('border-collapse: collapse;');
        StringHTML.AppendLine('}');
        StringHTML.AppendLine('</style>');
        StringHTML.AppendLine('</head>');
        StringHTML.AppendLine('<body style="background-color: #e9e9e9; margin: 0; padding: 0; font-family: Arial, sans-serif;">');
        StringHTML.AppendLine('<table border="0" align="center" width="100%" cellpadding="0" cellspacing="0" class="main-template" bgcolor="#e9e9e9">');
        StringHTML.AppendLine('<tbody>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" valign="top">');
        StringHTML.AppendLine('<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 590px">');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#e9e9e9" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td colspan="3" align="center" bgcolor="#ffffff">');
        StringHTML.AppendLine('<img src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/header.jpeg" alt="Asegura un precio fijo para tu energía ahora" width="590" height="200" />');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="230">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('<td align="left" bgcolor="#ffffff" width="522" style="color: #333333">');
        StringHTML.AppendLine('<p style="font-size: 17px">¡Hola ' + CustomerName + '!</p>');
        StringHTML.AppendLine('<p style="font-size: 16px">Nos complace presentarte una <strong>oferta exclusiva</strong> para que puedas fijar el precio de la energía para los próximos años de vigencia en tu contrato.</p>');
        StringHTML.AppendLine('<p style="font-size: 16px">En Nabalia Energía, somos conscientes de la incertidumbre actual del mercado energético y del impacto que esto puede tener en tu economía. Por ello, <strong>hemos diseñado esta oferta para brindarte estabilidad y tranquilidad en el pago de tu factura.</strong></p>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="50">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="522" style="color: #333333">');
        StringHTML.AppendLine('<a href="{URL}"><img src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/firmar.jpeg" alt="firmar" width="104" height="38" /></a>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="481">');
        StringHTML.AppendLine('<td colspan="3" align="center" bgcolor="#ffffff">');
        StringHTML.AppendLine('<img src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/offer.jpeg" alt="Asegura un precio fijo para tu energía ahora" width="590" height="481" style="display: block" />');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="100">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('<td align="left" bgcolor="#ffffff">');
        StringHTML.AppendLine('<p style="font-size: 15px"><br />No pierdas esta oportunidad única de protegerte de las subidas del precio de la energía y firma tu propuesta personalizada.</p>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="80">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('<td align="left" bgcolor="#ffffff" style="color: #333333">');
        StringHTML.AppendLine('<p style="font-size: 15px">Atentamente,</p>');
        StringHTML.AppendLine('<p style="font-size: 15px">Nabalia Energía</p>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" colspan="3">');
        StringHTML.AppendLine('<table align="center" border="0" cellpadding="0" cellspacing="0" width="590" bgcolor="#00338D">');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#00338D" width="590" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#00338D" width="34">&nbsp;</td>');
        StringHTML.AppendLine('');
        StringHTML.AppendLine('<td align="left" bgcolor="#00338D" style="color: #ffffff; font-size: 14px">');
        StringHTML.AppendLine('Plaza Urquinaona 7<br />');
        StringHTML.AppendLine('08010 Barcelona<br />');
        StringHTML.AppendLine('Gran Vía, 16. 1ª - Puerta 3<br />');
        StringHTML.AppendLine('28013 Madrid<br />');
        StringHTML.AppendLine('info@nabaliaenergia.com');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="right">');
        StringHTML.AppendLine('<a target="_blank" href="https://es.linkedin.com/company/nabalia-energ%C3%ADa" style="text-decoration: none"><img src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/linkedin.jpeg" alt="LinkedIn" width="26" /></a>');
        StringHTML.AppendLine('<a target="_blank" href="https://www.instagram.com/nabalia_energia/" style="text-decoration: none"><img src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/instagram.jpeg" alt="Instagram" width="26" /></a>');
        StringHTML.AppendLine('<a target="_blank" href="https://www.facebook.com/Nabalia-Energ%C3%ADa-1511716725803858/" style="text-decoration: none"><img src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/facebook.jpeg" alt="Facebook" width="26" /></a>');
        StringHTML.AppendLine('<a target="_blank" href="https://twitter.com/nabaliaenergia" style="text-decoration: none"><img src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/oferta-precio-fijo/x.jpeg" alt="Twitter" width="26" /></a>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#00338D" width="34">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#00338D" width="590" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('</table>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#e9e9e9" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('</tbody>');
        StringHTML.AppendLine('</table>');
        StringHTML.AppendLine('</body>');
        StringHTML.AppendLine('</html>');

        exit(StringHTML.ToText());
    end;

    local procedure HTMLToBTPContractNabalia(CustomerName: Text): Text
    var
        StringHTML: TextBuilder;
    begin
        StringHTML.AppendLine('        <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">');
        StringHTML.AppendLine('        <html');
        StringHTML.AppendLine('            xmlns="http://www.w3.org/1999/xhtml"');
        StringHTML.AppendLine('            xmlns:v="urn:schemas-microsoft-com:vml"');
        StringHTML.AppendLine('            xmlns:o="urn:schemas-microsoft-com:office:office"');
        StringHTML.AppendLine('        >');
        StringHTML.AppendLine('            <head>');
        StringHTML.AppendLine('                <meta http-equiv="X-UA-Compatible" content="IE=edge" />');
        StringHTML.AppendLine('                <meta name="viewport" content="width=device-width, initial-scale=1" />');
        StringHTML.AppendLine('                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />');
        StringHTML.AppendLine('                <meta name="x-apple-disable-message-reformatting" />');
        StringHTML.AppendLine('                <meta name="apple-mobile-web-app-capable" content="yes" />');
        StringHTML.AppendLine('                <meta name="apple-mobile-web-app-status-bar-style" content="black" />');
        StringHTML.AppendLine('                <meta name="format-detection" content="telephone=no" />');
        StringHTML.AppendLine('                <title></title>');
        StringHTML.AppendLine('                <style type="text/css">');
        StringHTML.AppendLine('                    table {');
        StringHTML.AppendLine('                        border-spacing: 0;');
        StringHTML.AppendLine('                    }');
        StringHTML.AppendLine('');
        StringHTML.AppendLine('                    table td {');
        StringHTML.AppendLine('                        border-collapse: collapse;');
        StringHTML.AppendLine('                    }');
        StringHTML.AppendLine('                </style>');
        StringHTML.AppendLine('            </head>');
        StringHTML.AppendLine('            <body');
        StringHTML.AppendLine('                style="');
        StringHTML.AppendLine('                    background-color: #e9e9e9;');
        StringHTML.AppendLine('                    margin: 0;');
        StringHTML.AppendLine('                    padding: 0;');
        StringHTML.AppendLine('                    font-family: Arial, sans-serif;');
        StringHTML.AppendLine('                "');
        StringHTML.AppendLine('            >');
        StringHTML.AppendLine('                <table');
        StringHTML.AppendLine('                    border="0"');
        StringHTML.AppendLine('                    align="center"');
        StringHTML.AppendLine('                    width="100%"');
        StringHTML.AppendLine('                    cellpadding="0"');
        StringHTML.AppendLine('                    cellspacing="0"');
        StringHTML.AppendLine('                    class="main-template"');
        StringHTML.AppendLine('                    bgcolor="#e9e9e9"');
        StringHTML.AppendLine('                >');
        StringHTML.AppendLine('                    <tbody>');
        StringHTML.AppendLine('                        <tr>');
        StringHTML.AppendLine('                            <td align="center" valign="top">');
        StringHTML.AppendLine('                                <table');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    border="0"');
        StringHTML.AppendLine('                                    cellpadding="0"');
        StringHTML.AppendLine('                                    cellspacing="0"');
        StringHTML.AppendLine('                                    width="100%"');
        StringHTML.AppendLine('                                    style="max-width: 590px"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <tr>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#e9e9e9" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr>');
        StringHTML.AppendLine('                                        <td colspan="3" align="center" bgcolor="#ffffff">');
        StringHTML.AppendLine('                                            <img');
        StringHTML.AppendLine('                                                src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/firmar-oferta-precio-fijo//header.jpeg"');
        StringHTML.AppendLine('                                                alt="Asegura un precio fijo para tu energía ahora"');
        StringHTML.AppendLine('                                                width="590"');
        StringHTML.AppendLine('                                                height="200"');
        StringHTML.AppendLine('                                            />');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr height="230">');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                        <td');
        StringHTML.AppendLine('                                            align="left"');
        StringHTML.AppendLine('                                            bgcolor="#ffffff"');
        StringHTML.AppendLine('                                            width="522"');
        StringHTML.AppendLine('                                            style="color: #333333"');
        StringHTML.AppendLine('                                        >');
        StringHTML.AppendLine('                                            <p style="font-size: 17px">');
        StringHTML.AppendLine('                                                ¡Hola ' + CustomerName + '!');
        StringHTML.AppendLine('                                            </p>');
        StringHTML.AppendLine('                                            <p style="font-size: 16px">');
        StringHTML.AppendLine('                                                ¡Nos complace informarles que tu contrato con Nabalia');
        StringHTML.AppendLine('                                                Energía ya está listo!');
        StringHTML.AppendLine('                                            </p>');
        StringHTML.AppendLine('                                            <p style="font-size: 16px">');
        StringHTML.AppendLine('                                                Gracias por firmar la propuesta comercial que te permitirá');
        StringHTML.AppendLine('                                                disfrutar de un precio de energía estable durante los');
        StringHTML.AppendLine('                                                próximos años.');
        StringHTML.AppendLine('                                            </p>');
        StringHTML.AppendLine('                                            <p style="font-size: 16px">');
        StringHTML.AppendLine('                                                Ahora solo falta que firmes tu contrato para empezar a');
        StringHTML.AppendLine('                                                disfrutar de las ventajas que te ofrece Nabalia Energía:');
        StringHTML.AppendLine('                                            </p>');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr height="50">');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                        <td');
        StringHTML.AppendLine('                                            align="center"');
        StringHTML.AppendLine('                                            bgcolor="#ffffff"');
        StringHTML.AppendLine('                                            width="522"');
        StringHTML.AppendLine('                                            style="color: #333333"');
        StringHTML.AppendLine('                                        >');
        StringHTML.AppendLine('                                            <a href="{URL}"');
        StringHTML.AppendLine('                                                ><img');
        StringHTML.AppendLine('                                                    src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/firmar-oferta-precio-fijo//firmar-contrato.jpeg"');
        StringHTML.AppendLine('                                                    alt="firmar"');
        StringHTML.AppendLine('                                                    width="196"');
        StringHTML.AppendLine('                                                    height="38"');
        StringHTML.AppendLine('                                            /></a>');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr height="481">');
        StringHTML.AppendLine('                                        <td colspan="3" align="center" bgcolor="#ffffff">');
        StringHTML.AppendLine('                                            <img');
        StringHTML.AppendLine('                                                src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/firmar-oferta-precio-fijo//offer.jpeg"');
        StringHTML.AppendLine('                                                alt="Asegura un precio fijo para tu energía ahora"');
        StringHTML.AppendLine('                                                width="590"');
        StringHTML.AppendLine('                                                height="694"');
        StringHTML.AppendLine('                                                style="display: block"');
        StringHTML.AppendLine('                                            />');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr height="110">');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                        <td align="left" bgcolor="#ffffff" style="color: #333333">');
        StringHTML.AppendLine('                                            <p style="font-size: 15px">Atentamente,</p>');
        StringHTML.AppendLine('                                            <p style="font-size: 15px">Nabalia Energía</p>');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#ffffff" colspan="3">');
        StringHTML.AppendLine('                                            <table');
        StringHTML.AppendLine('                                                align="center"');
        StringHTML.AppendLine('                                                border="0"');
        StringHTML.AppendLine('                                                cellpadding="0"');
        StringHTML.AppendLine('                                                cellspacing="0"');
        StringHTML.AppendLine('                                                width="590"');
        StringHTML.AppendLine('                                                bgcolor="#00338D"');
        StringHTML.AppendLine('                                            >');
        StringHTML.AppendLine('                                                <tr>');
        StringHTML.AppendLine('                                                    <td');
        StringHTML.AppendLine('                                                        align="center"');
        StringHTML.AppendLine('                                                        bgcolor="#00338D"');
        StringHTML.AppendLine('                                                        width="590"');
        StringHTML.AppendLine('                                                        colspan="3"');
        StringHTML.AppendLine('                                                    >');
        StringHTML.AppendLine('                                                        &nbsp;');
        StringHTML.AppendLine('                                                    </td>');
        StringHTML.AppendLine('                                                </tr>');
        StringHTML.AppendLine('                                                <tr>');
        StringHTML.AppendLine('                                                    <td align="center" bgcolor="#00338D" width="34">');
        StringHTML.AppendLine('                                                        &nbsp;');
        StringHTML.AppendLine('                                                    </td>');
        StringHTML.AppendLine('');
        StringHTML.AppendLine('                                                    <td');
        StringHTML.AppendLine('                                                        align="left"');
        StringHTML.AppendLine('                                                        bgcolor="#00338D"');
        StringHTML.AppendLine('                                                        style="color: #ffffff; font-size: 14px"');
        StringHTML.AppendLine('                                                    >');
        StringHTML.AppendLine('                                                        Plaza Urquinaona 7<br />');
        StringHTML.AppendLine('                                                        08010 Barcelona<br />');
        StringHTML.AppendLine('                                                        Gran Vía, 16. 1ª - Puerta 3<br />');
        StringHTML.AppendLine('                                                        28013 Madrid<br />');
        StringHTML.AppendLine('                                                        info@nabaliaenergia.com');
        StringHTML.AppendLine('                                                    </td>');
        StringHTML.AppendLine('                                                    <td align="right">');
        StringHTML.AppendLine('                                                        <a');
        StringHTML.AppendLine('                                                            target="_blank"');
        StringHTML.AppendLine('                                                            href="https://es.linkedin.com/company/nabalia-energ%C3%ADa"');
        StringHTML.AppendLine('                                                            style="text-decoration: none"');
        StringHTML.AppendLine('                                                            ><img');
        StringHTML.AppendLine('                                                                src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/firmar-oferta-precio-fijo//linkedin.jpeg"');
        StringHTML.AppendLine('                                                                alt="LinkedIn"');
        StringHTML.AppendLine('                                                                width="26"');
        StringHTML.AppendLine('                                                        /></a>');
        StringHTML.AppendLine('                                                        <a');
        StringHTML.AppendLine('                                                            target="_blank"');
        StringHTML.AppendLine('                                                            href="https://www.instagram.com/nabalia_energia/"');
        StringHTML.AppendLine('                                                            style="text-decoration: none"');
        StringHTML.AppendLine('                                                            ><img');
        StringHTML.AppendLine('                                                                src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/firmar-oferta-precio-fijo//instagram.jpeg"');
        StringHTML.AppendLine('                                                                alt="Instagram"');
        StringHTML.AppendLine('                                                                width="26"');
        StringHTML.AppendLine('                                                        /></a>');
        StringHTML.AppendLine('                                                        <a');
        StringHTML.AppendLine('                                                            target="_blank"');
        StringHTML.AppendLine('                                                            href="https://www.facebook.com/Nabalia-Energ%C3%ADa-1511716725803858/"');
        StringHTML.AppendLine('                                                            style="text-decoration: none"');
        StringHTML.AppendLine('                                                            ><img');
        StringHTML.AppendLine('                                                                src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/firmar-oferta-precio-fijo//facebook.jpeg"');
        StringHTML.AppendLine('                                                                alt="Facebook"');
        StringHTML.AppendLine('                                                                width="26"');
        StringHTML.AppendLine('                                                        /></a>');
        StringHTML.AppendLine('                                                        <a');
        StringHTML.AppendLine('                                                            target="_blank"');
        StringHTML.AppendLine('                                                            href="https://twitter.com/nabaliaenergia"');
        StringHTML.AppendLine('                                                            style="text-decoration: none"');
        StringHTML.AppendLine('                                                            ><img');
        StringHTML.AppendLine('                                                                src="https://assets.nabaliaenergia.com/mail/campaigns/2024-06-13/firmar-oferta-precio-fijo//x.jpeg"');
        StringHTML.AppendLine('                                                                alt="Twitter"');
        StringHTML.AppendLine('                                                                width="26"');
        StringHTML.AppendLine('                                                        /></a>');
        StringHTML.AppendLine('                                                    </td>');
        StringHTML.AppendLine('                                                    <td align="center" bgcolor="#00338D" width="34">');
        StringHTML.AppendLine('                                                        &nbsp;');
        StringHTML.AppendLine('                                                    </td>');
        StringHTML.AppendLine('                                                </tr>');
        StringHTML.AppendLine('                                                <tr>');
        StringHTML.AppendLine('                                                    <td');
        StringHTML.AppendLine('                                                        align="center"');
        StringHTML.AppendLine('                                                        bgcolor="#00338D"');
        StringHTML.AppendLine('                                                        width="590"');
        StringHTML.AppendLine('                                                        colspan="3"');
        StringHTML.AppendLine('                                                    >');
        StringHTML.AppendLine('                                                        &nbsp;');
        StringHTML.AppendLine('                                                    </td>');
        StringHTML.AppendLine('                                                </tr>');
        StringHTML.AppendLine('                                            </table>');
        StringHTML.AppendLine('                                        </td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                    <tr>');
        StringHTML.AppendLine('                                        <td align="center" bgcolor="#e9e9e9" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('                                    </tr>');
        StringHTML.AppendLine('                                </table>');
        StringHTML.AppendLine('                            </td>');
        StringHTML.AppendLine('                        </tr>');
        StringHTML.AppendLine('                    </tbody>');
        StringHTML.AppendLine('                </table>');
        StringHTML.AppendLine('            </body>');
        StringHTML.AppendLine('        </html>');

        exit(StringHTML.ToText());
    end;

    local procedure HTMLToBTPProposalACIS(CustomerName: Text): Text
    var
        StringHTML: TextBuilder;
    begin
        StringHTML.AppendLine('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">');
        StringHTML.AppendLine('<html');
        StringHTML.AppendLine('    xmlns = "http://www.w3.org/1999/xhtml"');
        StringHTML.AppendLine('    xmlns:v = "urn:schemas-microsoft-com:vml"');
        StringHTML.AppendLine('    xmlns:o = "urn:schemas-microsoft-com:office:office"');
        StringHTML.AppendLine('>');
        StringHTML.AppendLine('    <head >');
        StringHTML.AppendLine('        <meta http - equiv = "X-UA-Compatible" content = "IE=edge" />');
        StringHTML.AppendLine('        <meta name = "viewport" content = "width=device-width, initial-scale=1" />');
        StringHTML.AppendLine('        <meta http - equiv = "Content-Type" content = "text/html; charset=utf-8" />');
        StringHTML.AppendLine('        <meta name = "x-apple-disable-message-reformatting" />');
        StringHTML.AppendLine('        <meta name = "apple-mobile-web-app-capable" content = "yes" />');
        StringHTML.AppendLine('        <meta name = "apple-mobile-web-app-status-bar-style" content = "black" />');
        StringHTML.AppendLine('        <meta name = "format-detection" content = "telephone=no" />');
        StringHTML.AppendLine('        <title></title>');
        StringHTML.AppendLine('        <style type = "text/css">');
        StringHTML.AppendLine('            table {');
        StringHTML.AppendLine('                border - spacing: 0;');
        StringHTML.AppendLine('            }');
        StringHTML.AppendLine('            table td {');
        StringHTML.AppendLine('                border-collapse: collapse;');
        StringHTML.AppendLine('            }');
        StringHTML.AppendLine('        </style>');
        StringHTML.AppendLine('    </head>');
        StringHTML.AppendLine('    <body');
        StringHTML.AppendLine('        style="');
        StringHTML.AppendLine('            background-color: #e9e9e9;');
        StringHTML.AppendLine('            margin: 0;');
        StringHTML.AppendLine('            padding: 0;');
        StringHTML.AppendLine('            font-family: Arial, sans-serif;');
        StringHTML.AppendLine('        "');
        StringHTML.AppendLine('    >');
        StringHTML.AppendLine('        <table');
        StringHTML.AppendLine('            border="0"');
        StringHTML.AppendLine('            align="center"');
        StringHTML.AppendLine('            width="100%"');
        StringHTML.AppendLine('            cellpadding="0"');
        StringHTML.AppendLine('            cellspacing="0"');
        StringHTML.AppendLine('            class="main-template"');
        StringHTML.AppendLine('            bgcolor="#e9e9e9"');
        StringHTML.AppendLine('        >');
        StringHTML.AppendLine('            <tbody>');
        StringHTML.AppendLine('                <tr>');
        StringHTML.AppendLine('                    <td align="center" valign="top">');
        StringHTML.AppendLine('                        <table');
        StringHTML.AppendLine('                            align="center"');
        StringHTML.AppendLine('                            border="0"');
        StringHTML.AppendLine('                            cellpadding="0"');
        StringHTML.AppendLine('                            cellspacing="0"');
        StringHTML.AppendLine('                            width="100%"');
        StringHTML.AppendLine('                            style="max-width: 480px"');
        StringHTML.AppendLine('                        >');
        StringHTML.AppendLine('                            <tr>');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#e9e9e9"');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr>');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <img');
        StringHTML.AppendLine('                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/oferta-precio-fijo/header.jpg"');
        StringHTML.AppendLine('                                        alt="Asegura un precio fijo para tu energía ahora"');
        StringHTML.AppendLine('                                        width="480"');
        StringHTML.AppendLine('                                        height="179"');
        StringHTML.AppendLine('                                    />');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr height="280">');
        StringHTML.AppendLine('                                <td align="center" bgcolor="#ffffff" width="30">');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    align="left"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                    style="color: #333333"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <p style="font-size: 16px; margin: 0">');
        StringHTML.AppendLine('                                        ¡Hola ' + CustomerName + '!');
        StringHTML.AppendLine('                                    </p>');
        StringHTML.AppendLine('                                    <br />');
        StringHTML.AppendLine('                                    <p style="font-size: 16px; margin: 0">');
        StringHTML.AppendLine('                                        En Acis Energía, sabemos que el mercado');
        StringHTML.AppendLine('                                        energético anda un poco revuelto');
        StringHTML.AppendLine('                                        últimamente, y entendemos lo importante');
        StringHTML.AppendLine('                                        que es para ti tener todo bajo control.');
        StringHTML.AppendLine('                                        Por eso, te traemos una');
        StringHTML.AppendLine('                                        <strong');
        StringHTML.AppendLine('                                            >oferta exclusiva para que puedas');
        StringHTML.AppendLine('                                            fijar el precio de tu energía');
        StringHTML.AppendLine('                                            durante los próximos años de tu');
        StringHTML.AppendLine('                                            contrato.</strong');
        StringHTML.AppendLine('                                        >');
        StringHTML.AppendLine('                                    </p>');
        StringHTML.AppendLine('                                    <br />');
        StringHTML.AppendLine('                                    <p style="font-size: 16px; margin: 0">');
        StringHTML.AppendLine('                                        Queremos que te olvides de sorpresas en');
        StringHTML.AppendLine('                                        la factura y disfrutes de la');
        StringHTML.AppendLine('                                        tranquilidad de saber exactamente cuánto');
        StringHTML.AppendLine('                                        vas a pagar.');
        StringHTML.AppendLine('                                        <strong');
        StringHTML.AppendLine('                                            >¡Con nosotros, estabilidad y');
        StringHTML.AppendLine('                                            tranquilidad están');
        StringHTML.AppendLine('                                            garantizadas!</strong');
        StringHTML.AppendLine('                                        >');
        StringHTML.AppendLine('                                    </p>');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                                <td align="center" bgcolor="#ffffff" width="30">');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr height="50">');
        StringHTML.AppendLine('                                <td align="center" bgcolor="#ffffff" width="30">');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                    width="522"');
        StringHTML.AppendLine('                                    style="color: #333333"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <a href="{URL}"');
        StringHTML.AppendLine('                                        ><img');
        StringHTML.AppendLine('                                            src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/oferta-precio-fijo/firmar.jpg"');
        StringHTML.AppendLine('                                            alt="firmar"');
        StringHTML.AppendLine('                                            width="104"');
        StringHTML.AppendLine('                                            height="39"');
        StringHTML.AppendLine('                                    /></a>');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                                <td align="center" bgcolor="#ffffff" width="30">');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr height="30">');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr height="556">');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <img');
        StringHTML.AppendLine('                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/oferta-precio-fijo/offer.jpg"');
        StringHTML.AppendLine('                                        alt="¿Qué incluye nuestra oferta?"');
        StringHTML.AppendLine('                                        width="480"');
        StringHTML.AppendLine('                                        height="556"');
        StringHTML.AppendLine('                                        style="display: block"');
        StringHTML.AppendLine('                                    />');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr height="130">');
        StringHTML.AppendLine('                                <td align="center" bgcolor="#ffffff" width="30">');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                                <td align="left" bgcolor="#ffffff">');
        StringHTML.AppendLine('                                    <p style="font-size: 16px; margin: 0">');
        StringHTML.AppendLine('                                        <br />');
        StringHTML.AppendLine('                                        No dejes pasar la oportunidad de protege');
        StringHTML.AppendLine('                                        tu bolsillo de las subidas del precio de');
        StringHTML.AppendLine('                                        la energía y asegura tu tranquilidad');
        StringHTML.AppendLine('                                        firmando tu propuesta personalizada.');
        StringHTML.AppendLine('                                    </p>');
        StringHTML.AppendLine('                                    <br />');
        StringHTML.AppendLine('                                    <p style="font-size: 16px; margin: 0">');
        StringHTML.AppendLine('                                        <strong');
        StringHTML.AppendLine('                                            >¡Es el momento de tomar el');
        StringHTML.AppendLine('                                            control!</strong');
        StringHTML.AppendLine('                                        >');
        StringHTML.AppendLine('                                    </p>');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                                <td align="center" bgcolor="#ffffff" width="30">');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr height="106">');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <img');
        StringHTML.AppendLine('                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/oferta-precio-fijo/footer.jpg"');
        StringHTML.AppendLine('                                        alt="Atentamente, Acis Energía"');
        StringHTML.AppendLine('                                        width="480"');
        StringHTML.AppendLine('                                        height="106"');
        StringHTML.AppendLine('                                        style="display: block"');
        StringHTML.AppendLine('                                    />');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr>');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <table');
        StringHTML.AppendLine('                                        align="center"');
        StringHTML.AppendLine('                                        border="0"');
        StringHTML.AppendLine('                                        cellpadding="0"');
        StringHTML.AppendLine('                                        cellspacing="0"');
        StringHTML.AppendLine('                                        width="480"');
        StringHTML.AppendLine('                                        bgcolor="#073C42"');
        StringHTML.AppendLine('                                    >');
        StringHTML.AppendLine('                                        <tr>');
        StringHTML.AppendLine('                                            <td');
        StringHTML.AppendLine('                                                align="center"');
        StringHTML.AppendLine('                                                bgcolor="#073C42"');
        StringHTML.AppendLine('                                                width="480"');
        StringHTML.AppendLine('                                                colspan="3"');
        StringHTML.AppendLine('                                            >');
        StringHTML.AppendLine('                                                &nbsp;');
        StringHTML.AppendLine('                                            </td>');
        StringHTML.AppendLine('                                        </tr>');
        StringHTML.AppendLine('                                        <tr>');
        StringHTML.AppendLine('                                            <td');
        StringHTML.AppendLine('                                                align="center"');
        StringHTML.AppendLine('                                                bgcolor="#073C42"');
        StringHTML.AppendLine('                                                width="30"');
        StringHTML.AppendLine('                                            >');
        StringHTML.AppendLine('                                                &nbsp;');
        StringHTML.AppendLine('                                            </td>');
        StringHTML.AppendLine('                                            <td');
        StringHTML.AppendLine('                                                align="left"');
        StringHTML.AppendLine('                                                bgcolor="#073C42"');
        StringHTML.AppendLine('                                                style="');
        StringHTML.AppendLine('                                                    color: #ffffff;');
        StringHTML.AppendLine('                                                    font-size: 14px;');
        StringHTML.AppendLine('                                                "');
        StringHTML.AppendLine('                                            >');
        StringHTML.AppendLine('                                                Acis Energía<br />');
        StringHTML.AppendLine('                                                Pl. Urquinaona, 7<br />');
        StringHTML.AppendLine('                                                08010 Barcelona<br />');
        StringHTML.AppendLine('                                                info@acisenergia.com');
        StringHTML.AppendLine('                                            </td>');
        StringHTML.AppendLine('                                            <td align="right">');
        StringHTML.AppendLine('                                                <a');
        StringHTML.AppendLine('                                                    target="_blank"');
        StringHTML.AppendLine('                                                    href="https://www.linkedin.com/company/acisenergia"');
        StringHTML.AppendLine('                                                    style="');
        StringHTML.AppendLine('                                                        text-decoration: none;');
        StringHTML.AppendLine('                                                    "');
        StringHTML.AppendLine('                                                    ><img');
        StringHTML.AppendLine('                                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/oferta-precio-fijo/linkedin.jpg"');
        StringHTML.AppendLine('                                                        alt="LinkedIn"');
        StringHTML.AppendLine('                                                        width="26"');
        StringHTML.AppendLine('                                                /></a>');
        StringHTML.AppendLine('                                                <a');
        StringHTML.AppendLine('                                                    target="_blank"');
        StringHTML.AppendLine('                                                    href="https://www.instagram.com/acis_energia/"');
        StringHTML.AppendLine('                                                    style="');
        StringHTML.AppendLine('                                                        text-decoration: none;');
        StringHTML.AppendLine('                                                    "');
        StringHTML.AppendLine('                                                    ><img');
        StringHTML.AppendLine('                                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/oferta-precio-fijo/instagram.jpg"');
        StringHTML.AppendLine('                                                        alt="Instagram"');
        StringHTML.AppendLine('                                                        width="26"');
        StringHTML.AppendLine('                                                /></a>');
        StringHTML.AppendLine('                                                <a');
        StringHTML.AppendLine('                                                    target="_blank"');
        StringHTML.AppendLine('                                                    href="https://www.facebook.com/AcisEnergia"');
        StringHTML.AppendLine('                                                    style="');
        StringHTML.AppendLine('                                                        text-decoration: none;');
        StringHTML.AppendLine('                                                    "');
        StringHTML.AppendLine('                                                    ><img');
        StringHTML.AppendLine('                                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/oferta-precio-fijo/facebook.jpg"');
        StringHTML.AppendLine('                                                        alt="Facebook"');
        StringHTML.AppendLine('                                                        width="26"');
        StringHTML.AppendLine('                                                /></a>');
        StringHTML.AppendLine('                                                <a');
        StringHTML.AppendLine('                                                    target="_blank"');
        StringHTML.AppendLine('                                                    href="https://twitter.com/acisenergia"');
        StringHTML.AppendLine('                                                    style="');
        StringHTML.AppendLine('                                                        text-decoration: none;');
        StringHTML.AppendLine('                                                    "');
        StringHTML.AppendLine('                                                    ><img');
        StringHTML.AppendLine('                                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/oferta-precio-fijo/x.jpg"');
        StringHTML.AppendLine('                                                        alt="Twitter"');
        StringHTML.AppendLine('                                                        width="26"');
        StringHTML.AppendLine('                                                /></a>');
        StringHTML.AppendLine('                                            </td>');
        StringHTML.AppendLine('                                            <td');
        StringHTML.AppendLine('                                                align="center"');
        StringHTML.AppendLine('                                                bgcolor="#073C42"');
        StringHTML.AppendLine('                                                width="30"');
        StringHTML.AppendLine('                                            >');
        StringHTML.AppendLine('                                                &nbsp;');
        StringHTML.AppendLine('                                            </td>');
        StringHTML.AppendLine('                                        </tr>');
        StringHTML.AppendLine('                                        <tr>');
        StringHTML.AppendLine('                                            <td');
        StringHTML.AppendLine('                                                align="center"');
        StringHTML.AppendLine('                                                bgcolor="#073C42"');
        StringHTML.AppendLine('                                                width="480"');
        StringHTML.AppendLine('                                                colspan="3"');
        StringHTML.AppendLine('                                            >');
        StringHTML.AppendLine('                                                &nbsp;');
        StringHTML.AppendLine('                                            </td>');
        StringHTML.AppendLine('                                        </tr>');
        StringHTML.AppendLine('                                    </table>');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr>');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#e9e9e9"');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                        </table>');
        StringHTML.AppendLine('                    </td>');
        StringHTML.AppendLine('                </tr>');
        StringHTML.AppendLine('            </tbody>');
        StringHTML.AppendLine('        </table>');
        StringHTML.AppendLine('    </body>');
        StringHTML.AppendLine('</html>');

        exit(StringHTML.ToText());
    end;

    local procedure HTMLToBTPContractACIS(CustomerName: Text): Text
    var
        StringHTML: TextBuilder;
    begin
        StringHTML.AppendLine('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">');
        StringHTML.AppendLine('<html');
        StringHTML.AppendLine('    xmlns="http://www.w3.org/1999/xhtml"');
        StringHTML.AppendLine('    xmlns:v="urn:schemas-microsoft-com:vml"');
        StringHTML.AppendLine('    xmlns:o="urn:schemas-microsoft-com:office:office"');
        StringHTML.AppendLine('>');
        StringHTML.AppendLine('    <head>');
        StringHTML.AppendLine('        <meta http-equiv="X-UA-Compatible" content="IE=edge" />');
        StringHTML.AppendLine('        <meta name="viewport" content="width=device-width, initial-scale=1" />');
        StringHTML.AppendLine('        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />');
        StringHTML.AppendLine('        <meta name="x-apple-disable-message-reformatting" />');
        StringHTML.AppendLine('        <meta name="apple-mobile-web-app-capable" content="yes" />');
        StringHTML.AppendLine('        <meta name="apple-mobile-web-app-status-bar-style" content="black" />');
        StringHTML.AppendLine('        <meta name="format-detection" content="telephone=no" />');
        StringHTML.AppendLine('        <title></title>');
        StringHTML.AppendLine('        <style type="text/css">');
        StringHTML.AppendLine('            table {');
        StringHTML.AppendLine('                border-spacing: 0;');
        StringHTML.AppendLine('            }');
        StringHTML.AppendLine('            table td {');
        StringHTML.AppendLine('                border-collapse: collapse;');
        StringHTML.AppendLine('            }');
        StringHTML.AppendLine('        </style>');
        StringHTML.AppendLine('    </head>');
        StringHTML.AppendLine('    <body');
        StringHTML.AppendLine('        style="');
        StringHTML.AppendLine('            background-color: #e9e9e9;');
        StringHTML.AppendLine('            margin: 0;');
        StringHTML.AppendLine('            padding: 0;');
        StringHTML.AppendLine('            font-family: Arial, sans-serif;');
        StringHTML.AppendLine('        "');
        StringHTML.AppendLine('    >');
        StringHTML.AppendLine('        <table');
        StringHTML.AppendLine('            border="0"');
        StringHTML.AppendLine('            align="center"');
        StringHTML.AppendLine('            width="100%"');
        StringHTML.AppendLine('            cellpadding="0"');
        StringHTML.AppendLine('            cellspacing="0"');
        StringHTML.AppendLine('            class="main-template"');
        StringHTML.AppendLine('            bgcolor="#e9e9e9"');
        StringHTML.AppendLine('        >');
        StringHTML.AppendLine('            <tbody>');
        StringHTML.AppendLine('                <tr>');
        StringHTML.AppendLine('                    <td align="center" valign="top">');
        StringHTML.AppendLine('                        <table');
        StringHTML.AppendLine('                            align="center"');
        StringHTML.AppendLine('                            border="0"');
        StringHTML.AppendLine('                            cellpadding="0"');
        StringHTML.AppendLine('                            cellspacing="0"');
        StringHTML.AppendLine('                            width="100%"');
        StringHTML.AppendLine('                            style="max-width: 480px"');
        StringHTML.AppendLine('                        >');
        StringHTML.AppendLine('                            <tr>');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#e9e9e9"');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr>');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <img');
        StringHTML.AppendLine('                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/firmar-contato/header.jpg"');
        StringHTML.AppendLine('                                        alt="Estás a un clic del ahorro"');
        StringHTML.AppendLine('                                        width="480"');
        StringHTML.AppendLine('                                        height="179"');
        StringHTML.AppendLine('                                    />');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr height="280">');
        StringHTML.AppendLine('                                <td align="center" bgcolor="#ffffff" width="30">');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    align="left"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                    style="color: #333333"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <p style="font-size: 16px; margin: 0">');
        StringHTML.AppendLine('                                        ¡Hola ' + CustomerName + '!');
        StringHTML.AppendLine('                                    </p>');
        StringHTML.AppendLine('                                    <br />');
        StringHTML.AppendLine('                                    <p style="font-size: 16px; margin: 0">');
        StringHTML.AppendLine('                                        <strong');
        StringHTML.AppendLine('                                            >Tu contrato con Acis Energía ya');
        StringHTML.AppendLine('                                            está listo. 🙌</strong');
        StringHTML.AppendLine('                                        >');
        StringHTML.AppendLine('                                    </p>');
        StringHTML.AppendLine('                                    <br />');
        StringHTML.AppendLine('                                    <p style="font-size: 16px; margin: 0">');
        StringHTML.AppendLine('                                        Gracias por confiar en nosotros y firmar');
        StringHTML.AppendLine('                                        tu propuesta comercial, con la que');
        StringHTML.AppendLine('                                        podrás disfrutar de un');
        StringHTML.AppendLine('                                        <strong');
        StringHTML.AppendLine('                                            >precio de energía estable durante');
        StringHTML.AppendLine('                                            los próximos años.</strong');
        StringHTML.AppendLine('                                        >');
        StringHTML.AppendLine('                                    </p>');
        StringHTML.AppendLine('                                    <br />');
        StringHTML.AppendLine('                                    <p style="font-size: 16px; margin: 0">');
        StringHTML.AppendLine('                                        Ahora solo queda firmar tu contrato y');
        StringHTML.AppendLine('                                        empezar a aprovechar todas las ventajas');
        StringHTML.AppendLine('                                        que te ofrece Acis Energía:');
        StringHTML.AppendLine('                                    </p>');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                                <td align="center" bgcolor="#ffffff" width="30">');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr height="50">');
        StringHTML.AppendLine('                                <td align="center" bgcolor="#ffffff" width="30">');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                    width="522"');
        StringHTML.AppendLine('                                    style="color: #333333"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <a href="{URL}"');
        StringHTML.AppendLine('                                        ><img');
        StringHTML.AppendLine('                                            src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/firmar-contato/firmar-contrato.jpg"');
        StringHTML.AppendLine('                                            alt="firmar"');
        StringHTML.AppendLine('                                            width="196"');
        StringHTML.AppendLine('                                            height="39"');
        StringHTML.AppendLine('                                    /></a>');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                                <td align="center" bgcolor="#ffffff" width="30">');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr height="30">');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr height="666">');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <img');
        StringHTML.AppendLine('                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/firmar-contato/offer.jpg"');
        StringHTML.AppendLine('                                        alt="¿Qué incluye nuestra oferta?"');
        StringHTML.AppendLine('                                        width="480"');
        StringHTML.AppendLine('                                        height="666"');
        StringHTML.AppendLine('                                        style="display: block"');
        StringHTML.AppendLine('                                    />');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr height="106">');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <img');
        StringHTML.AppendLine('                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/firmar-contato/footer.jpg"');
        StringHTML.AppendLine('                                        alt="Atentamente, Acis Energía"');
        StringHTML.AppendLine('                                        width="480"');
        StringHTML.AppendLine('                                        height="106"');
        StringHTML.AppendLine('                                        style="display: block"');
        StringHTML.AppendLine('                                    />');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr>');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#ffffff"');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    <table');
        StringHTML.AppendLine('                                        align="center"');
        StringHTML.AppendLine('                                        border="0"');
        StringHTML.AppendLine('                                        cellpadding="0"');
        StringHTML.AppendLine('                                        cellspacing="0"');
        StringHTML.AppendLine('                                        width="480"');
        StringHTML.AppendLine('                                        bgcolor="#073C42"');
        StringHTML.AppendLine('                                    >');
        StringHTML.AppendLine('                                        <tr>');
        StringHTML.AppendLine('                                            <td');
        StringHTML.AppendLine('                                                align="center"');
        StringHTML.AppendLine('                                                bgcolor="#073C42"');
        StringHTML.AppendLine('                                                width="480"');
        StringHTML.AppendLine('                                                colspan="3"');
        StringHTML.AppendLine('                                            >');
        StringHTML.AppendLine('                                                &nbsp;');
        StringHTML.AppendLine('                                            </td>');
        StringHTML.AppendLine('                                        </tr>');
        StringHTML.AppendLine('                                        <tr>');
        StringHTML.AppendLine('                                            <td');
        StringHTML.AppendLine('                                                align="center"');
        StringHTML.AppendLine('                                                bgcolor="#073C42"');
        StringHTML.AppendLine('                                                width="30"');
        StringHTML.AppendLine('                                            >');
        StringHTML.AppendLine('                                                &nbsp;');
        StringHTML.AppendLine('                                            </td>');
        StringHTML.AppendLine('                                            <td');
        StringHTML.AppendLine('                                                align="left"');
        StringHTML.AppendLine('                                                bgcolor="#073C42"');
        StringHTML.AppendLine('                                                style="');
        StringHTML.AppendLine('                                                    color: #ffffff;');
        StringHTML.AppendLine('                                                    font-size: 14px;');
        StringHTML.AppendLine('                                                "');
        StringHTML.AppendLine('                                            >');
        StringHTML.AppendLine('                                                Acis Energía<br />');
        StringHTML.AppendLine('                                                Pl. Urquinaona, 7<br />');
        StringHTML.AppendLine('                                                08010 Barcelona<br />');
        StringHTML.AppendLine('                                                info@acisenergia.com');
        StringHTML.AppendLine('                                            </td>');
        StringHTML.AppendLine('                                            <td align="right">');
        StringHTML.AppendLine('                                                <a');
        StringHTML.AppendLine('                                                    target="_blank"');
        StringHTML.AppendLine('                                                    href="https://www.linkedin.com/company/acisenergia"');
        StringHTML.AppendLine('                                                    style="');
        StringHTML.AppendLine('                                                        text-decoration: none;');
        StringHTML.AppendLine('                                                    "');
        StringHTML.AppendLine('                                                    ><img');
        StringHTML.AppendLine('                                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/firmar-contato/linkedin.jpg"');
        StringHTML.AppendLine('                                                        alt="LinkedIn"');
        StringHTML.AppendLine('                                                        width="26"');
        StringHTML.AppendLine('                                                /></a>');
        StringHTML.AppendLine('                                                <a');
        StringHTML.AppendLine('                                                    target="_blank"');
        StringHTML.AppendLine('                                                    href="https://www.instagram.com/acis_energia/"');
        StringHTML.AppendLine('                                                    style="');
        StringHTML.AppendLine('                                                        text-decoration: none;');
        StringHTML.AppendLine('                                                    "');
        StringHTML.AppendLine('                                                    ><img');
        StringHTML.AppendLine('                                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/firmar-contato/instagram.jpg"');
        StringHTML.AppendLine('                                                        alt="Instagram"');
        StringHTML.AppendLine('                                                        width="26"');
        StringHTML.AppendLine('                                                /></a>');
        StringHTML.AppendLine('                                                <a');
        StringHTML.AppendLine('                                                    target="_blank"');
        StringHTML.AppendLine('                                                    href="https://www.facebook.com/AcisEnergia"');
        StringHTML.AppendLine('                                                    style="');
        StringHTML.AppendLine('                                                        text-decoration: none;');
        StringHTML.AppendLine('                                                    "');
        StringHTML.AppendLine('                                                    ><img');
        StringHTML.AppendLine('                                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/firmar-contato/facebook.jpg"');
        StringHTML.AppendLine('                                                        alt="Facebook"');
        StringHTML.AppendLine('                                                        width="26"');
        StringHTML.AppendLine('                                                /></a>');
        StringHTML.AppendLine('                                                <a');
        StringHTML.AppendLine('                                                    target="_blank"');
        StringHTML.AppendLine('                                                    href="https://twitter.com/acisenergia"');
        StringHTML.AppendLine('                                                    style="');
        StringHTML.AppendLine('                                                        text-decoration: none;');
        StringHTML.AppendLine('                                                    "');
        StringHTML.AppendLine('                                                    ><img');
        StringHTML.AppendLine('                                                        src="https://assets.acisenergia.com/mail/campaigns/2024-11-18/firmar-contato/x.jpg"');
        StringHTML.AppendLine('                                                        alt="Twitter"');
        StringHTML.AppendLine('                                                        width="26"');
        StringHTML.AppendLine('                                                /></a>');
        StringHTML.AppendLine('                                            </td>');
        StringHTML.AppendLine('                                            <td');
        StringHTML.AppendLine('                                                align="center"');
        StringHTML.AppendLine('                                                bgcolor="#073C42"');
        StringHTML.AppendLine('                                                width="30"');
        StringHTML.AppendLine('                                            >');
        StringHTML.AppendLine('                                                &nbsp;');
        StringHTML.AppendLine('                                            </td>');
        StringHTML.AppendLine('                                        </tr>');
        StringHTML.AppendLine('                                        <tr>');
        StringHTML.AppendLine('                                            <td');
        StringHTML.AppendLine('                                                align="center"');
        StringHTML.AppendLine('                                                bgcolor="#073C42"');
        StringHTML.AppendLine('                                                width="480"');
        StringHTML.AppendLine('                                                colspan="3"');
        StringHTML.AppendLine('                                            >');
        StringHTML.AppendLine('                                                &nbsp;');
        StringHTML.AppendLine('                                            </td>');
        StringHTML.AppendLine('                                        </tr>');
        StringHTML.AppendLine('                                    </table>');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                            </tr>');
        StringHTML.AppendLine('                            <tr>');
        StringHTML.AppendLine('                                <td');
        StringHTML.AppendLine('                                    align="center"');
        StringHTML.AppendLine('                                    bgcolor="#e9e9e9"');
        StringHTML.AppendLine('                                    colspan="3"');
        StringHTML.AppendLine('                                >');
        StringHTML.AppendLine('                                    &nbsp;');
        StringHTML.AppendLine('                                </td>');
        StringHTML.AppendLine('                           </tr>');
        StringHTML.AppendLine('                        </table>');
        StringHTML.AppendLine('                    </td>');
        StringHTML.AppendLine('                </tr>');
        StringHTML.AppendLine('            </tbody>');
        StringHTML.AppendLine('        </table>');
        StringHTML.AppendLine('    </body>');
        StringHTML.AppendLine('</html>');

        exit(StringHTML.ToText());
    end;

    local procedure HTMLToBTPProposalAVA(CustomerName: Text): Text
    var
        StringHTML: TextBuilder;
    begin
        StringHTML.AppendLine('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">');
        StringHTML.AppendLine('<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">');
        StringHTML.AppendLine('<head>');
        StringHTML.AppendLine('<meta http-equiv="X-UA-Compatible" content="IE=edge" />');
        StringHTML.AppendLine('<meta name="viewport" content="width=device-width, initial-scale=1" />');
        StringHTML.AppendLine('<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />');
        StringHTML.AppendLine('<meta name="x-apple-disable-message-reformatting" />');
        StringHTML.AppendLine('<meta name="apple-mobile-web-app-capable" content="yes" />');
        StringHTML.AppendLine('<meta name="apple-mobile-web-app-status-bar-style" content="black" />');
        StringHTML.AppendLine('<meta name="format-detection" content="telephone=no" />');
        StringHTML.AppendLine('<title></title>');
        StringHTML.AppendLine('<style type="text/css">');
        StringHTML.AppendLine('table {');
        StringHTML.AppendLine('border-spacing: 0;');
        StringHTML.AppendLine('}');
        StringHTML.AppendLine('table td {');
        StringHTML.AppendLine('border-collapse: collapse;');
        StringHTML.AppendLine('}');
        StringHTML.AppendLine('</style>');
        StringHTML.AppendLine('</head>');
        StringHTML.AppendLine('<body style="background-color: #e9e9e9; margin: 0; padding: 0; font-family: Arial, sans-serif;">');
        StringHTML.AppendLine('<table border="0" align="center" width="100%" cellpadding="0" cellspacing="0" class="main-template" bgcolor="#e9e9e9">');
        StringHTML.AppendLine('<tbody>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" valign="top">');
        StringHTML.AppendLine('<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 590px">');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#e9e9e9" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td colspan="3" align="center" bgcolor="#ffffff">');
        StringHTML.AppendLine('<img src="https://avanza.solvethex.com/assets/mail/propuesta/header.jpg" alt="Asegura un precio fijo para tu energía ahora" width="590" height="245" />');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="280">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="30">&nbsp;</td>');
        StringHTML.AppendLine('<td align="left" bgcolor="#ffffff" style="color: #333333">');
        StringHTML.AppendLine('<p style="font-size: 16px; margin: 0">¡Hola ' + CustomerName + '!</p>');
        StringHTML.AppendLine('<br />');
        StringHTML.AppendLine('<p style="font-size: 16px; margin: 0">En Avanza Energía entendemos que el mercado energético está en constante cambio y sabemos lo crucial que es para ti mantener todo en orden. Por eso, hemos diseñado una <strong style="color: #a0224a">oferta exclusiva</strong> que te permitirá <strong>fijar el precio de tu energía durante los próximos años de tu contrato.</strong></p>');
        StringHTML.AppendLine('<br />');
        StringHTML.AppendLine('<p style="font-size: 16px; margin: 0"><strong>Olvídate de imprevistos en tu factura</strong> y disfruta de la seguridad de <strong>saber exactamente cuánto pagarás.</strong> Con nosotros, disfrutarás de estabilidad y tranquilidad en tu factura. <strong>¡Aprovecha esta oportunidad!</strong></p>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="30">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="50">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="30">&nbsp;</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="522" style="color: #333333">');
        StringHTML.AppendLine('<a href="{URL}"><img src="https://avanza.solvethex.com/assets/mail/propuesta/firmar.jpg" alt="firmar" width="104" height="39" /></a>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="30">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="30">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="556">');
        StringHTML.AppendLine('<td colspan="3" align="center" bgcolor="#ffffff">');
        StringHTML.AppendLine('<img src="https://avanza.solvethex.com/assets/mail/propuesta/offer.jpg" alt="¿Qué incluye nuestra oferta?" width="590" height="556" style="display: block" />');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="100">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('<td align="left" bgcolor="#ffffff">');
        StringHTML.AppendLine('<p style="font-size: 15px"><br />No dejes que las subidas del precio de la energía afecten tu bolsillo. <strong>Asegura tu tranquilidad</strong> con una propuesta personalizada y mantén el control de tus gastos.</p>');
        StringHTML.AppendLine('<p style="font-size: 15px"><b>¡Toma el control de tu consumo hoy!</b></p>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="80">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('<td align="left" bgcolor="#ffffff" style="color: #333333">');
        StringHTML.AppendLine('<p style="font-size: 15px">Atentamente,</p>');
        StringHTML.AppendLine('<p style="font-size: 15px">Avanza Energía</p>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" colspan="3">');
        StringHTML.AppendLine('<table align="center" border="0" cellpadding="0" cellspacing="0" width="590" bgcolor="#A0224A">');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#A0224A" width="590" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#A0224A" width="30">&nbsp;</td>');
        StringHTML.AppendLine('<td align="left" bgcolor="#A0224A" style="color: #ffffff; font-size: 14px">');
        StringHTML.AppendLine('Avanza Energía<br />');
        StringHTML.AppendLine('Ctra. Sanlúcar 8, Local A,<br />');
        StringHTML.AppendLine('11500 El Puerto de Santa María<br />');
        StringHTML.AppendLine('info@avanza-energia.com');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="right">');
        StringHTML.AppendLine('<a target="_blank" href="https://www.linkedin.com/company/avanza-energia/" style="text-decoration: none"><img src="https://avanza.solvethex.com/assets/mail/contrato/linkedin.jpg" alt="LinkedIn" width="26" /></a>');
        StringHTML.AppendLine('<a target="_blank" href="https://www.instagram.com/avanza_energia" style="text-decoration: none"><img src="https://avanza.solvethex.com/assets/mail/contrato/instagram.jpg" alt="Instagram" width="26" /></a>');
        StringHTML.AppendLine('<a target="_blank" href="https://www.facebook.com/avanzaenergia.facebook/" style="text-decoration: none"><img src="https://avanza.solvethex.com/assets/mail/contrato/facebook.jpg" alt="Facebook" width="26" /></a>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#A0224A" width="30">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#A0224A" width="590" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('</table>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#e9e9e9" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('</table>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('</tbody>');
        StringHTML.AppendLine('</table>');
        StringHTML.AppendLine('</body>');
        StringHTML.AppendLine('</html>');

        exit(StringHTML.ToText());
    end;

    local procedure HTMLToBTPContractAVA(CustomerName: Text): Text
    var
        StringHTML: TextBuilder;
    begin
        StringHTML.AppendLine('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">');
        StringHTML.AppendLine('<html xmlns="http://www.w3.org/1999/xhtml" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office">');
        StringHTML.AppendLine('<head>');
        StringHTML.AppendLine('<meta http-equiv="X-UA-Compatible" content="IE=edge" />');
        StringHTML.AppendLine('<meta name="viewport" content="width=device-width, initial-scale=1" />');
        StringHTML.AppendLine('<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />');
        StringHTML.AppendLine('<meta name="x-apple-disable-message-reformatting" />');
        StringHTML.AppendLine('<meta name="apple-mobile-web-app-capable" content="yes" />');
        StringHTML.AppendLine('<meta name="apple-mobile-web-app-status-bar-style" content="black" />');
        StringHTML.AppendLine('<meta name="format-detection" content="telephone=no" />');
        StringHTML.AppendLine('<title></title>');
        StringHTML.AppendLine('<style type="text/css">');
        StringHTML.AppendLine('table {');
        StringHTML.AppendLine('border-spacing: 0;');
        StringHTML.AppendLine('}');
        StringHTML.AppendLine('table td {');
        StringHTML.AppendLine('border-collapse: collapse;');
        StringHTML.AppendLine('}');
        StringHTML.AppendLine('</style>');
        StringHTML.AppendLine('</head>');
        StringHTML.AppendLine('<body style="background-color: #e9e9e9; margin: 0; padding: 0; font-family: Arial, sans-serif;">');
        StringHTML.AppendLine('<table border="0" align="center" width="100%" cellpadding="0" cellspacing="0" class="main-template" bgcolor="#e9e9e9">');
        StringHTML.AppendLine('<tbody>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" valign="top">');
        StringHTML.AppendLine('<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 590px">');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#e9e9e9" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td colspan="3" align="center" bgcolor="#ffffff">');
        StringHTML.AppendLine('<img src="https://avanza.solvethex.com/assets/mail/contrato/header.jpg" alt="Estás a un clic del ahorro" width="590" height="245" />');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="280">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="30">&nbsp;</td>');
        StringHTML.AppendLine('<td align="left" bgcolor="#ffffff" style="color: #333333">');
        StringHTML.AppendLine('<p style="font-size: 16px; margin: 0">¡Hola ' + CustomerName + '!</p>');
        StringHTML.AppendLine('<br />');
        StringHTML.AppendLine('<p style="font-size: 16px; margin: 0"><strong style="color: #a0224a">Tu contrato con Avanza Energía está listo. 🔥⚡</strong></p>');
        StringHTML.AppendLine('<br />');
        StringHTML.AppendLine('<p style="font-size: 16px; margin: 0">Agradecemos tu confianza. Aceptar nuestra propuesta significa que <strong>podrás disfrutar de un precio de energía estable en los próximos años.</strong></p>');
        StringHTML.AppendLine('<br />');
        StringHTML.AppendLine('<p style="font-size: 16px; margin: 0">Firma ahora tu contrato y podrás aprovechar todas las ventajas que Avanza Energía tiene para ti:</p>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="30">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="50">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="30">&nbsp;</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="522" style="color: #333333">');
        StringHTML.AppendLine('<a href="{URL}"><img src="https://avanza.solvethex.com/assets/mail/contrato/firmar-contrato.jpg" alt="firmar" width="196" height="39" /></a>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="30">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="30">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="666">');
        StringHTML.AppendLine('<td colspan="3" align="center" bgcolor="#ffffff">');
        StringHTML.AppendLine('<img src="https://avanza.solvethex.com/assets/mail/contrato/offer.jpg" alt="¿Qué incluye nuestra oferta?" width="590" height="666" style="display: block" />');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr height="80">');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('<td align="left" bgcolor="#ffffff" style="color: #333333">');
        StringHTML.AppendLine('<p style="font-size: 15px">Atentamente,</p>');
        StringHTML.AppendLine('<p style="font-size: 15px">Avanza Energía</p>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" width="34">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#ffffff" colspan="3">');
        StringHTML.AppendLine('<table align="center" border="0" cellpadding="0" cellspacing="0" width="590" bgcolor="#A0224A">');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#A0224A" width="590" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#A0224A" width="30">&nbsp;</td>');
        StringHTML.AppendLine('<td align="left" bgcolor="#A0224A" style="color: #ffffff; font-size: 14px">');
        StringHTML.AppendLine('Avanza Energía<br />');
        StringHTML.AppendLine('Ctra. Sanlúcar 8, Local A,<br />');
        StringHTML.AppendLine('11500 El Puerto de Santa María<br />');
        StringHTML.AppendLine('info@avanza-energia.com');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="right">');
        StringHTML.AppendLine('<a target="_blank" href="https://www.linkedin.com/company/avanza-energia/" style="text-decoration: none"><img src="https://avanza.solvethex.com/assets/mail/contrato/linkedin.jpg" alt="LinkedIn" width="26" /></a>');
        StringHTML.AppendLine('<a target="_blank" href="https://www.instagram.com/avanza_energia" style="text-decoration: none"><img src="https://avanza.solvethex.com/assets/mail/contrato/instagram.jpg" alt="Instagram" width="26" /></a>');
        StringHTML.AppendLine('<a target="_blank" href="https://www.facebook.com/avanzaenergia.facebook/" style="text-decoration: none"><img src="https://avanza.solvethex.com/assets/mail/contrato/facebook.jpg" alt="Facebook" width="26" /></a>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('<td align="center" bgcolor="#A0224A" width="30">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#A0224A" width="590" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('</table>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('<tr>');
        StringHTML.AppendLine('<td align="center" bgcolor="#e9e9e9" colspan="3">&nbsp;</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('</table>');
        StringHTML.AppendLine('</td>');
        StringHTML.AppendLine('</tr>');
        StringHTML.AppendLine('</tbody>');
        StringHTML.AppendLine('</table>');
        StringHTML.AppendLine('</body>');
        StringHTML.AppendLine('</html>');

        exit(StringHTML.ToText());
    end;

    procedure GetCUPSInfoFromSIPS(DocumentType: Enum "SUC Omip Document Type"; DocumentNo: Code[20]; CUPS: Text[25]): Boolean
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
        SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
        SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
        ArrayPotence: array[6] of Decimal;
        ArraykWhAnual: array[6] of Decimal;
        RateNo: Text;
        CustomerNo: Code[20];
    begin
        case DocumentType of
            DocumentType::Proposal:
                begin
                    SUCOmipProposals.Get(DocumentNo);
                    CustomerNo := SUCOmipProposals."Customer No.";
                    SUCOmipProposals.TestField(Status, SUCOmipProposals.Status::"Pending Acceptance");
                end;
            DocumentType::Contract:
                begin
                    SUCOmipEnergyContracts.Get(DocumentNo);
                    CustomerNo := SUCOmipEnergyContracts."Customer No.";
                    SUCOmipEnergyContracts.TestField(Status, SUCOmipEnergyContracts.Status::"Pending Acceptance");
                end;
        end;
        if SUCOmipCustomerCUPS.Get(CustomerNo, CUPS) then
            if GetDataSIPS(CUPS, ArrayPotence, ArraykWhAnual, RateNo) then begin
                if not SUCOmipContractedPower.Get(DocumentType, DocumentNo, CUPS) then begin
                    SUCOmipContractedPower.Init();
                    SUCOmipContractedPower."Document Type" := DocumentType;
                    SUCOmipContractedPower."Document No." := DocumentNo;
                    SUCOmipContractedPower.CUPS := CUPS;
                    SUCOmipContractedPower.Validate("Rate No.", RateNo);
                    SUCOmipContractedPower.Insert();
                end;
                SUCOmipContractedPower.Validate(P1, ArrayPotence[1]);
                if ArrayPotence[1] <> 0 then
                    SUCOmipContractedPower."P1 From SIPS" := true;
                SUCOmipContractedPower.Validate(P2, ArrayPotence[2]);
                if ArrayPotence[2] <> 0 then
                    SUCOmipContractedPower."P2 From SIPS" := true;
                SUCOmipContractedPower.Validate(P3, ArrayPotence[3]);
                if ArrayPotence[3] <> 0 then
                    SUCOmipContractedPower."P3 From SIPS" := true;
                SUCOmipContractedPower.Validate(P4, ArrayPotence[4]);
                if ArrayPotence[4] <> 0 then
                    SUCOmipContractedPower."P4 From SIPS" := true;
                SUCOmipContractedPower.Validate(P5, ArrayPotence[5]);
                if ArrayPotence[5] <> 0 then
                    SUCOmipContractedPower."P5 From SIPS" := true;
                SUCOmipContractedPower.Validate(P6, ArrayPotence[6]);
                if ArrayPotence[6] <> 0 then
                    SUCOmipContractedPower."P6 From SIPS" := true;

                if (ArrayPotence[1] <> 0) or (ArrayPotence[2] <> 0) or (ArrayPotence[3] <> 0) or (ArrayPotence[4] <> 0) or (ArrayPotence[5] <> 0) or (ArrayPotence[6] <> 0) then
                    SUCOmipContractedPower.Validate("SIPS Information", true)
                else
                    SUCOmipContractedPower.Validate("SIPS Information", false);

                //* Commisions
                SUCOmipContractedPower.CalculateCommision();
                //* End Commisions

                SUCOmipContractedPower.Modify();

                if not SUCOmipConsumptionDeclared.Get(DocumentType, DocumentNo, CUPS) then begin
                    SUCOmipConsumptionDeclared.Init();
                    SUCOmipConsumptionDeclared."Document Type" := DocumentType;
                    SUCOmipConsumptionDeclared."Document No." := DocumentNo;
                    SUCOmipConsumptionDeclared.CUPS := CUPS;
                    SUCOmipConsumptionDeclared.Validate("Rate No.", RateNo);
                    SUCOmipConsumptionDeclared.Insert();
                end;
                SUCOmipConsumptionDeclared.Validate(P1, ArraykWhAnual[1]);
                if ArraykWhAnual[1] <> 0 then
                    SUCOmipConsumptionDeclared."P1 From SIPS" := true;
                SUCOmipConsumptionDeclared.Validate(P2, ArraykWhAnual[2]);
                if ArraykWhAnual[2] <> 0 then
                    SUCOmipConsumptionDeclared."P2 From SIPS" := true;
                SUCOmipConsumptionDeclared.Validate(P3, ArraykWhAnual[3]);
                if ArraykWhAnual[3] <> 0 then
                    SUCOmipConsumptionDeclared."P3 From SIPS" := true;
                SUCOmipConsumptionDeclared.Validate(P4, ArraykWhAnual[4]);
                if ArraykWhAnual[4] <> 0 then
                    SUCOmipConsumptionDeclared."P4 From SIPS" := true;
                SUCOmipConsumptionDeclared.Validate(P5, ArraykWhAnual[5]);
                if ArraykWhAnual[5] <> 0 then
                    SUCOmipConsumptionDeclared."P5 From SIPS" := true;
                SUCOmipConsumptionDeclared.Validate(P6, ArraykWhAnual[6]);
                if ArraykWhAnual[6] <> 0 then
                    SUCOmipConsumptionDeclared."P6 From SIPS" := true;

                if (ArraykWhAnual[1] <> 0) or (ArraykWhAnual[2] <> 0) or (ArraykWhAnual[3] <> 0) or (ArraykWhAnual[4] <> 0) or (ArraykWhAnual[5] <> 0) or (ArraykWhAnual[6] <> 0) then
                    SUCOmipConsumptionDeclared.Validate("SIPS Information", true)
                else
                    SUCOmipConsumptionDeclared.Validate("SIPS Information", false);

                SUCOmipConsumptionDeclared.Modify();
                exit(true);
            end else
                exit(false)
        else
            exit(false);
    end;

    local procedure SetPowerEntryFromJson(JsonResponse: Text; var ArrayPotenceOut: array[6] of Decimal; var ArraykWhAnual: array[6] of Decimal; var RateNoOut: Text)
    var
        JsonObject: JsonObject;
        JsonObject2: JsonObject;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
    begin
        if JsonObject.ReadFrom(JsonResponse) then begin
            JsonObject.Get('suministros', JsonToken);
            JsonArray := JsonToken.AsArray();
            foreach JsonToken in JsonArray do begin
                JsonObject2 := JsonToken.AsObject();

                if JsonObject2.Get('Pot_Cont_P1', JsonToken) then
                    ArrayPotenceOut[1] := JsonToken.AsValue().AsDecimal();
                if JsonObject2.Get('Pot_Cont_P2', JsonToken) then
                    ArrayPotenceOut[2] := JsonToken.AsValue().AsDecimal();
                if JsonObject2.Get('Pot_Cont_P3', JsonToken) then
                    ArrayPotenceOut[3] := JsonToken.AsValue().AsDecimal();
                if JsonObject2.Get('Pot_Cont_P4', JsonToken) then
                    ArrayPotenceOut[4] := JsonToken.AsValue().AsDecimal();
                if JsonObject2.Get('Pot_Cont_P5', JsonToken) then
                    ArrayPotenceOut[5] := JsonToken.AsValue().AsDecimal();
                if JsonObject2.Get('Pot_Cont_P6', JsonToken) then
                    ArrayPotenceOut[6] := JsonToken.AsValue().AsDecimal();

                if JsonObject2.Get('kWhAnual_p1', JsonToken) then
                    ArraykWhAnual[1] := JsonToken.AsValue().AsDecimal();
                if JsonObject2.Get('kWhAnual_p2', JsonToken) then
                    ArraykWhAnual[2] := JsonToken.AsValue().AsDecimal();
                if JsonObject2.Get('kWhAnual_p3', JsonToken) then
                    ArraykWhAnual[3] := JsonToken.AsValue().AsDecimal();
                if JsonObject2.Get('kWhAnual_p4', JsonToken) then
                    ArraykWhAnual[4] := JsonToken.AsValue().AsDecimal();
                if JsonObject2.Get('kWhAnual_p5', JsonToken) then
                    ArraykWhAnual[5] := JsonToken.AsValue().AsDecimal();
                if JsonObject2.Get('kWhAnual_p6', JsonToken) then
                    ArraykWhAnual[6] := JsonToken.AsValue().AsDecimal();

                if JsonObject2.Get('Tarifa', JsonToken) then
                    RateNoOut := JsonToken.AsValue().AsText();
            end;
        end;
    end;

    local procedure SendEmailPricesConfirm()
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipImportEntries: Record "SUC Omip Import Entries";
        TempBlob: Codeunit "Temp Blob";
        Base64Convert: Codeunit "Base64 Convert";
        EmailScenario: Enum "Email Scenario";
        FileName: Text[250];
        OmipFileDoc: Text;
        BodyEmail: Text;
        InStream: InStream;
        InStream1: InStream;
        OutStream: OutStream;
        SubjectLbl: Label 'E-PRO importación de precios de %1';
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Email Prices Confirmation");

        SUCOmipImportEntries.Reset();
        if SUCOmipImportEntries.FindLast() then begin
            if SUCOmipImportEntries."Omip File".HasValue then begin
                SUCOmipImportEntries.CalcFields("Omip File");
                FileName := SUCOmipImportEntries."Omip File Name";
                SUCOmipImportEntries."Omip File".CreateInStream(InStream, TextEncoding::UTF8);
                while not (InStream.EOS) do
                    InStream.Read(OmipFileDoc);
                TempBlob.CreateOutStream(OutStream);
                Base64Convert.FromBase64(OmipFileDoc, OutStream);
                TempBlob.CreateInStream(InStream1);
            end;
            BodyEmail := '<p><strong>E-PRO IMPORTACIÓN DE PRECIOS</strong></p> ' +
                         '<p><strong>Fecha de actualización: </strong>' + Format(CurrentDateTime) + '&nbsp;</p>' +
                         '<p>&nbsp;</p>' +
                         '<p>Se ha importado correctamente el fichero de precios de OMIP.&nbsp;</p>';

            SendEMailMessage(SUCOmipSetup."Email Prices Confirmation", StrSubstNo(SubjectLbl, Format(Today, 0, '<Day,2>/<Month,2>/<Year4>')), BodyEmail, true, FileName, '.xls', InStream1, EmailScenario::Default);
        end;
    end;

    procedure DuplicateProposal(SUCOmipProposalsIn: Record "SUC Omip Proposals"): Code[20]
    var
        SUCOmipProposals2: Record "SUC Omip Proposals";
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
        SUCOmipContractedPower2: Record "SUC Omip Contracted Power";
        SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
        SUCOmipConsumptionDeclared2: Record "SUC Omip Consumption Declared";
        SUCOmipProposalMulticups: Record "SUC Omip Proposal Multicups";
        SUCOmipProposalMulticups2: Record "SUC Omip Proposal Multicups";
        SUCOmipTrackingBTP: Record "SUC Omip Tracking BTP";
        SUCOmipDocumentTypeLoc: Enum "SUC Omip Document Type";
        NewProposalNo: Code[20];
        SucessLbl: Label 'Duplicate proposal successfully, proposal %1 was created.';
    begin
        SUCOmipProposals2.Get(SUCOmipProposalsIn."No.");
        if SUCOmipProposals2.Status = SUCOmipProposals2.Status::"Out of Time" then begin
            case SUCOmipProposalsIn."Product Type" of
                SUCOmipProposalsIn."Product Type"::Omip:
                    begin
                        NewProposalNo := GenerateProposal3(SUCOmipProposals2."Marketer No.", SUCOmipProposals2."Rate No.", SUCOmipProposals2.Type, SUCOmipProposals2.Times,
                                                           SUCOmipProposals2."Energy Origen", SUCOmipProposals2.Multicups, SUCOmipProposals2.IBAN, SUCOmipProposals2."Agent No.",
                                                           SUCOmipProposals2."FEE Group Id.");
                        SUCOmipProposals.Get(NewProposalNo);
                        SUCOmipProposals."Customer No." := SUCOmipProposals2."Customer No.";
                        SUCOmipProposals."Customer CUPS" := SUCOmipProposals2."Customer CUPS";
                        SUCOmipProposals."Marketer No." := SUCOmipProposals2."Marketer No.";
                        SUCOmipProposals."Energy Origen" := SUCOmipProposals2."Energy Origen";
                        SUCOmipProposals.Volume := SUCOmipProposals2.Volume;
                        SUCOmipProposals."Receive invoice electronically" := SUCOmipProposals2."Receive invoice electronically";
                        SUCOmipProposals."Sending Communications" := SUCOmipProposals2."Sending Communications";
                        SUCOmipProposals."Acceptance Method" := SUCOmipProposals2."Acceptance Method";
                        SUCOmipProposals."Acceptance Send" := SUCOmipProposals2."Acceptance Send";
                        SUCOmipProposals.Multicups := SUCOmipProposals2.Multicups;
                        SUCOmipProposals."Contract No." := '';
                        SUCOmipProposals.Modify();

                        SUCOmipContractedPower.Reset();
                        SUCOmipContractedPower.SetRange("Document Type", SUCOmipContractedPower."Document Type"::Proposal);
                        SUCOmipContractedPower.SetRange("Document No.", SUCOmipProposals2."No.");
                        if SUCOmipContractedPower.FindSet() then
                            repeat
                                SUCOmipContractedPower2.Init();
                                SUCOmipContractedPower2.TransferFields(SUCOmipContractedPower);
                                SUCOmipContractedPower2."Document Type" := SUCOmipContractedPower2."Document Type"::Proposal;
                                SUCOmipContractedPower2."Document No." := NewProposalNo;
                                SUCOmipContractedPower2.CUPS := SUCOmipContractedPower.CUPS;
                                SUCOmipContractedPower2.Insert();
                            // SUCOmipContractedPower2.P1 := SUCOmipContractedPower.P1;
                            // SUCOmipContractedPower2.P2 := SUCOmipContractedPower.P2;
                            // SUCOmipContractedPower2.P3 := SUCOmipContractedPower.P3;
                            // SUCOmipContractedPower2.P4 := SUCOmipContractedPower.P4;
                            // SUCOmipContractedPower2.P5 := SUCOmipContractedPower.P5;
                            // SUCOmipContractedPower2.P6 := SUCOmipContractedPower.P6;
                            until SUCOmipContractedPower.Next() = 0;

                        SUCOmipConsumptionDeclared.Reset();
                        SUCOmipConsumptionDeclared.SetRange("Document Type", SUCOmipConsumptionDeclared."Document Type"::Proposal);
                        SUCOmipConsumptionDeclared.SetRange("Document No.", SUCOmipProposals2."No.");
                        if SUCOmipConsumptionDeclared.FindSet() then
                            repeat
                                SUCOmipConsumptionDeclared2.Init();
                                SUCOmipConsumptionDeclared2.TransferFields(SUCOmipConsumptionDeclared);
                                SUCOmipConsumptionDeclared2."Document Type" := SUCOmipConsumptionDeclared2."Document Type"::Proposal;
                                SUCOmipConsumptionDeclared2."Document No." := NewProposalNo;
                                SUCOmipConsumptionDeclared2.CUPS := SUCOmipConsumptionDeclared.CUPS;
                                SUCOmipConsumptionDeclared2.Insert();
                            // SUCOmipConsumptionDeclared2."Rate No." := SUCOmipConsumptionDeclared."Rate No.";
                            // SUCOmipConsumptionDeclared2.P1 := SUCOmipConsumptionDeclared.P1;
                            // SUCOmipConsumptionDeclared2.P2 := SUCOmipConsumptionDeclared.P2;
                            // SUCOmipConsumptionDeclared2.P3 := SUCOmipConsumptionDeclared.P3;
                            // SUCOmipConsumptionDeclared2.P4 := SUCOmipConsumptionDeclared.P4;
                            // SUCOmipConsumptionDeclared2.P5 := SUCOmipConsumptionDeclared.P5;
                            // SUCOmipConsumptionDeclared2.P6 := SUCOmipConsumptionDeclared.P6;
                            until SUCOmipConsumptionDeclared.Next() = 0;

                        if SUCOmipProposals2.Multicups then begin
                            SUCOmipProposalMulticups.Reset();
                            SUCOmipProposalMulticups.SetRange("Proposal No.", SUCOmipProposals2."No.");
                            if SUCOmipProposalMulticups.FindSet() then
                                repeat
                                    SUCOmipProposalMulticups2.Init();
                                    SUCOmipProposalMulticups2.TransferFields(SUCOmipProposalMulticups);
                                    SUCOmipProposalMulticups2.Validate("Proposal No.", NewProposalNo);
                                    SUCOmipProposalMulticups2.Validate("Customer CUPS", SUCOmipProposalMulticups."Customer CUPS");
                                    SUCOmipProposalMulticups2.Insert();
                                // SUCOmipProposalMulticups2.Validate("Rate No.", SUCOmipProposalMulticups."Rate No.");
                                // SUCOmipProposalMulticups2."SUC Supply Point Address" := SUCOmipProposalMulticups."SUC Supply Point Address";
                                // SUCOmipProposalMulticups2."SUC Supply Point Post Code" := SUCOmipProposalMulticups."SUC Supply Point Post Code";
                                // SUCOmipProposalMulticups2."SUC Supply Point City" := SUCOmipProposalMulticups."SUC Supply Point City";
                                // SUCOmipProposalMulticups2."SUC Supply Point County" := SUCOmipProposalMulticups."SUC Supply Point County";
                                // SUCOmipProposalMulticups2."SUC Supply Point Country" := SUCOmipProposalMulticups."SUC Supply Point Country";
                                // SUCOmipProposalMulticups2.P1 := SUCOmipProposalMulticups.P1;
                                // SUCOmipProposalMulticups2.P2 := SUCOmipProposalMulticups.P2;
                                // SUCOmipProposalMulticups2.P3 := SUCOmipProposalMulticups.P3;
                                // SUCOmipProposalMulticups2.P4 := SUCOmipProposalMulticups.P4;
                                // SUCOmipProposalMulticups2.P5 := SUCOmipProposalMulticups.P5;
                                // SUCOmipProposalMulticups2.P6 := SUCOmipProposalMulticups.P6;
                                // SUCOmipProposalMulticups2."Activation Date" := SUCOmipProposalMulticups."Activation Date";
                                // SUCOmipProposalMulticups2.Volume := SUCOmipProposalMulticups.Volume;
                                // SUCOmipProposalMulticups2.Modify();
                                until SUCOmipProposalMulticups.Next() = 0;
                        end;

                        NewTrackingBTP2(SUCOmipDocumentTypeLoc::Proposal, NewProposalNo, CurrentDateTime, '', '', '', SUCOmipAcceptanceMethod::" ", '',
                                               SUCOmipActionTrackingBTP::" ",
                                               '', '', 0, '', '', 0DT, true, SUCOmipProposalsIn."No.");

                        SUCOmipTrackingBTP.Reset();
                        SUCOmipTrackingBTP.SetRange("Document Type", SUCOmipDocumentTypeLoc::Proposal);
                        SUCOmipTrackingBTP.SetRange("Document No.", SUCOmipProposalsIn."No.");
                        SUCOmipTrackingBTP.SetRange("Duplicate Document", true);
                        if SUCOmipTrackingBTP.FindSet() then
                            repeat
                                NewTrackingBTP2(SUCOmipDocumentTypeLoc::Proposal, NewProposalNo, SUCOmipTrackingBTP."Execution Date", '', '', '', SUCOmipAcceptanceMethod::" ", '',
                                                   SUCOmipActionTrackingBTP::" ",
                                                   '', '', 0, '', '', 0DT, true, SUCOmipTrackingBTP."Duplicate Document No.");
                            until SUCOmipTrackingBTP.Next() = 0;

                        Message(SucessLbl, NewProposalNo);
                    end;
                SUCOmipProposalsIn."Product Type"::Prosegur:
                    begin
                        NewProposalNo := GenerateProposalProsegur(SUCOmipProposals2."Prosegur Type Use", SUCOmipProposals2."Prosegur Type Alarm", SUCOmipProposals2."Agent No.");
                        SUCOmipProposals.Get(NewProposalNo);
                        SUCOmipProposals."Customer No." := SUCOmipProposals2."Customer No.";
                        SUCOmipProposals."Prosegur Type Road" := SUCOmipProposals2."Prosegur Type Road";
                        SUCOmipProposals."Prosegur Name Road" := SUCOmipProposals2."Prosegur Name Road";
                        SUCOmipProposals."Prosegur Number Road" := SUCOmipProposals2."Prosegur Number Road";
                        SUCOmipProposals."Prosegur Floor" := SUCOmipProposals2."Prosegur Floor";
                        SUCOmipProposals."Prosegur County" := SUCOmipProposals2."Prosegur County";
                        SUCOmipProposals."Prosegur Country" := SUCOmipProposals2."Prosegur Country";
                        SUCOmipProposals."Prosegur Post Code" := SUCOmipProposals2."Prosegur Post Code";
                        SUCOmipProposals."Prosegur City" := SUCOmipProposals2."Prosegur City";
                        SUCOmipProposals."Prosegur Account Holder" := SUCOmipProposals2."Prosegur Account Holder";
                        SUCOmipProposals."Prosegur IBAN" := SUCOmipProposals2."Prosegur IBAN";
                        SUCOmipProposals."Prosegur Entity" := SUCOmipProposals2."Prosegur Entity";
                        SUCOmipProposals."Prosegur Office" := SUCOmipProposals2."Prosegur Office";
                        SUCOmipProposals."Prosegur D.C." := SUCOmipProposals2."Prosegur D.C.";
                        SUCOmipProposals."Prosegur Account No." := SUCOmipProposals2."Prosegur Account No.";
                        SUCOmipProposals."Prosegur Contact Person" := SUCOmipProposals2."Prosegur Contact Person";
                        SUCOmipProposals."Prosegur Contact Phone" := SUCOmipProposals2."Prosegur Contact Phone";
                        SUCOmipProposals."Prosegur Contact Relation" := SUCOmipProposals2."Prosegur Contact Relation";
                        SUCOmipProposals."Prosegur Contact Person 2" := SUCOmipProposals2."Prosegur Contact Person 2";
                        SUCOmipProposals."Prosegur Contact Phone 2" := SUCOmipProposals2."Prosegur Contact Phone 2";
                        SUCOmipProposals."Prosegur Contact Relation 2" := SUCOmipProposals2."Prosegur Contact Relation 2";
                        SUCOmipProposals.Modify()
                    end;
            end;
            exit(NewProposalNo);
        end else
            SUCOmipProposalsIn.TestField(Status, SUCOmipProposalsIn.Status::"Out of Time");
    end;

    procedure PrintProposal(SUCOmipProposalsIn: Record "SUC Omip Proposals")
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        ReportID: Integer;
    begin
        case SUCOmipProposalsIn."Product Type" of
            SUCOmipProposalsIn."Product Type"::Omip:
                begin
                    // Initial validation
                    SUCOmipProposalsIn.TestField("Marketer No.");

                    // Prepare proposal filters
                    SUCOmipProposals.Reset();
                    SUCOmipProposals.Copy(SUCOmipProposalsIn);
                    SUCOmipProposals.SetRange("No.", SUCOmipProposalsIn."No.");

                    // Get the correct report ID using the centralized logic
                    ReportID := GetProposalReportID(SUCOmipProposals);

                    // Run the report
                    Report.RunModal(ReportID, true, true, SUCOmipProposals);
                end;
        end;
    end;


    internal procedure UpdateOrderTEDResolution(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Order TED Addendum");
        SUCOmipSetup.TestField("Resolution Addendum");
        SUCOmipEnergyContracts.Get(SUCOmipEnergyContractsIn."No.");
        SUCOmipEnergyContracts.Validate("Order TED Addendum", SUCOmipSetup."Order TED Addendum");
        SUCOmipEnergyContracts.Validate("Resolution Addendum", SUCOmipSetup."Resolution Addendum");
        SUCOmipEnergyContracts.Modify();
    end;

    internal procedure UpdateDataFromProposal(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    begin
        //UpdateFieldsContract(SUCOmipEnergyContractsIn);
        // UpdatePowerEntryContracts(SUCOmipEnergyContractsIn);
        // UpdateEnergyEntryContract(SUCOmipEnergyContractsIn);
        // UpdateContractedPower(SUCOmipEnergyContractsIn);
        // UpdateConsumptionDeclared(SUCOmipEnergyContractsIn);
        // UpdateProposalData(SUCOmipEnergyContractsIn);
        // UpdateDefaultDataContract(SUCOmipEnergyContractsIn);
        // UpdateCustomerSupplyInfo();
        // UpdateCustomerDocs();
        UpdateOmipContract(SUCOmipEnergyContractsIn);
    end;

    // local procedure UpdateFieldsContract(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    // var
    //     SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    // begin
    //     SUCOmipEnergyContracts.Get(SUCOmipEnergyContractsIn."No.");
    //     SUCOmipEnergyContracts."Omip Contract" := true;
    //     SUCOmipEnergyContracts.Modify();
    // end;

    // local procedure UpdatePowerEntryContracts(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    // var
    //     SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    //     SUCOmipPowerEntry: Record "SUC Omip Power Entry";
    //     SUCOmipPowerEntryContract: Record "SUC Omip Power Entry Contract";
    // begin
    //     SUCOmipEnergyContracts.Get(SUCOmipEnergyContractsIn."No.");
    //     if SUCOmipEnergyContracts."Proposal No." <> '' then begin
    //         SUCOmipPowerEntry.Reset();
    //         SUCOmipPowerEntry.SetRange("Proposal No.", SUCOmipEnergyContracts."Proposal No.");
    //         if SUCOmipPowerEntry.FindSet() then
    //             repeat
    //                 SUCOmipPowerEntryContract.Reset();
    //                 SUCOmipPowerEntryContract.SetRange("Contract No.", SUCOmipEnergyContracts."No.");
    //                 SUCOmipPowerEntryContract.SetRange("Rate No.", SUCOmipPowerEntry."Rate No.");
    //                 if not SUCOmipPowerEntryContract.FindLast() then begin
    //                     SUCOmipPowerEntryContract.Init();
    //                     SUCOmipPowerEntryContract."Contract No." := SUCOmipEnergyContracts."No.";
    //                     SUCOmipPowerEntryContract."Rate No." := SUCOmipPowerEntry."Rate No.";
    //                     SUCOmipPowerEntryContract.P1 := SUCOmipPowerEntry.P1;
    //                     SUCOmipPowerEntryContract.P2 := SUCOmipPowerEntry.P2;
    //                     SUCOmipPowerEntryContract.P3 := SUCOmipPowerEntry.P3;
    //                     SUCOmipPowerEntryContract.P4 := SUCOmipPowerEntry.P4;
    //                     SUCOmipPowerEntryContract.P5 := SUCOmipPowerEntry.P5;
    //                     SUCOmipPowerEntryContract.P6 := SUCOmipPowerEntry.P6;
    //                     SUCOmipPowerEntryContract."Contract Id" := SUCOmipEnergyContracts.SystemId;
    //                     SUCOmipPowerEntryContract.Insert();
    //                 end;
    //             until SUCOmipPowerEntry.Next() = 0;
    //     end
    // end;

    // local procedure UpdateEnergyEntryContract(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    // var
    //     SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    //     SUCOmipEnergyEntry: Record "SUC Omip Energy Entry";
    //     SUCOmipEnergyEntryContract: Record "SUC Omip Energy Entry Contract";
    // begin
    //     SUCOmipEnergyContracts.Get(SUCOmipEnergyContractsIn."No.");
    //     if SUCOmipEnergyContracts."Proposal No." <> '' then begin
    //         SUCOmipEnergyEntry.Reset();
    //         SUCOmipEnergyEntry.SetRange("Proposal No.", SUCOmipEnergyContracts."Proposal No.");
    //         if SUCOmipEnergyEntry.FindSet() then
    //             repeat
    //                 SUCOmipEnergyEntryContract.Reset();
    //                 SUCOmipEnergyEntryContract.SetRange("Contract No.", SUCOmipEnergyContracts."No.");
    //                 SUCOmipEnergyEntryContract.SetRange("Rate No.", SUCOmipEnergyEntry."Rate No.");
    //                 SUCOmipEnergyEntryContract.SetRange(Times, SUCOmipEnergyEntry.Times);
    //                 SUCOmipEnergyEntryContract.SetRange(Type, SUCOmipEnergyEntry.Type);
    //                 if not SUCOmipEnergyEntryContract.FindLast() then begin
    //                     SUCOmipEnergyEntryContract.Init();
    //                     SUCOmipEnergyEntryContract."Contract No." := SUCOmipEnergyContracts."No.";
    //                     SUCOmipEnergyEntryContract."Rate No." := SUCOmipEnergyEntry."Rate No.";
    //                     SUCOmipEnergyEntryContract.Type := SUCOmipEnergyEntry.Type;
    //                     SUCOmipEnergyEntryContract.Times := SUCOmipEnergyEntry.Times;
    //                     SUCOmipEnergyEntryContract."Times Text" := SUCOmipEnergyEntry."Times Text";
    //                     SUCOmipEnergyEntryContract."Omip price" := SUCOmipEnergyEntry."Omip price";
    //                     SUCOmipEnergyEntryContract."Contract Id" := SUCOmipEnergyContracts.SystemId;
    //                     SUCOmipEnergyEntryContract.Enabled := SUCOmipEnergyEntry.Enabled;
    //                     SUCOmipEnergyEntryContract.P1 := SUCOmipEnergyEntry.P1;
    //                     SUCOmipEnergyEntryContract.P2 := SUCOmipEnergyEntry.P2;
    //                     SUCOmipEnergyEntryContract.P3 := SUCOmipEnergyEntry.P3;
    //                     SUCOmipEnergyEntryContract.P4 := SUCOmipEnergyEntry.P4;
    //                     SUCOmipEnergyEntryContract.P5 := SUCOmipEnergyEntry.P5;
    //                     SUCOmipEnergyEntryContract.P6 := SUCOmipEnergyEntry.P6;
    //                     SUCOmipEnergyEntryContract.Insert();
    //                 end;
    //             until SUCOmipEnergyEntry.Next() = 0;
    //     end
    // end;

    // local procedure UpdateContractedPower(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    // var
    //     SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    //     SUCOmipContractedPower: Record "SUC Omip Contracted Power";
    //     SUCOmipContractedPower2: Record "SUC Omip Contracted Power";
    // begin
    //     SUCOmipEnergyContracts.Get(SUCOmipEnergyContractsIn."No.");
    //     if SUCOmipEnergyContracts."Proposal No." <> '' then begin
    //         SUCOmipContractedPower.Reset();
    //         SUCOmipContractedPower.SetRange("Document Type", SUCOmipContractedPower."Document Type"::Proposal);
    //         SUCOmipContractedPower.SetRange("Document No.", SUCOmipEnergyContracts."Proposal No.");
    //         if SUCOmipContractedPower.FindSet() then
    //             repeat
    //                 SUCOmipContractedPower2.Reset();
    //                 SUCOmipContractedPower2.SetRange("Document Type", SUCOmipContractedPower2."Document Type"::Contract);
    //                 SUCOmipContractedPower2.SetRange("Document No.", SUCOmipEnergyContracts."No.");
    //                 SUCOmipContractedPower2.SetRange("CUPS", SUCOmipContractedPower.CUPS);
    //                 if not SUCOmipContractedPower2.FindLast() then begin
    //                     SUCOmipContractedPower2.Init();
    //                     SUCOmipContractedPower2."Document Type" := SUCOmipContractedPower."Document Type"::Contract;
    //                     SUCOmipContractedPower2."Document No." := SUCOmipEnergyContracts."No.";
    //                     SUCOmipContractedPower2.CUPS := SUCOmipContractedPower.CUPS;
    //                     SUCOmipContractedPower2.P1 := SUCOmipContractedPower.P1;
    //                     SUCOmipContractedPower2.P2 := SUCOmipContractedPower.P2;
    //                     SUCOmipContractedPower2.P3 := SUCOmipContractedPower.P3;
    //                     SUCOmipContractedPower2.P4 := SUCOmipContractedPower.P4;
    //                     SUCOmipContractedPower2.P5 := SUCOmipContractedPower.P5;
    //                     SUCOmipContractedPower2.P6 := SUCOmipContractedPower.P6;
    //                     SUCOmipContractedPower2.Insert();
    //                 end;
    //             until SUCOmipContractedPower.Next() = 0;
    //     end;
    // end;

    // local procedure UpdateConsumptionDeclared(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    // var
    //     SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    //     SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
    //     SUCOmipConsumptionDeclared2: Record "SUC Omip Consumption Declared";
    // begin
    //     SUCOmipEnergyContracts.Get(SUCOmipEnergyContractsIn."No.");
    //     if SUCOmipEnergyContracts."Proposal No." <> '' then begin
    //         SUCOmipConsumptionDeclared.Reset();
    //         SUCOmipConsumptionDeclared.SetRange("Document Type", SUCOmipConsumptionDeclared."Document Type"::Proposal);
    //         SUCOmipConsumptionDeclared.SetRange("Document No.", SUCOmipEnergyContracts."Proposal No.");
    //         if SUCOmipConsumptionDeclared.FindSet() then
    //             repeat
    //                 SUCOmipConsumptionDeclared2.Reset();
    //                 SUCOmipConsumptionDeclared2.SetRange("Document Type", SUCOmipConsumptionDeclared2."Document Type"::Contract);
    //                 SUCOmipConsumptionDeclared2.SetRange("Document No.", SUCOmipEnergyContracts."No.");
    //                 SUCOmipConsumptionDeclared2.SetRange("CUPS", SUCOmipConsumptionDeclared.CUPS);
    //                 if not SUCOmipConsumptionDeclared2.FindLast() then begin
    //                     SUCOmipConsumptionDeclared2.Init();
    //                     SUCOmipConsumptionDeclared2."Document Type" := SUCOmipConsumptionDeclared."Document Type"::Contract;
    //                     SUCOmipConsumptionDeclared2."Document No." := SUCOmipEnergyContracts."No.";
    //                     SUCOmipConsumptionDeclared2.CUPS := SUCOmipConsumptionDeclared.CUPS;
    //                     SUCOmipConsumptionDeclared2.P1 := SUCOmipConsumptionDeclared.P1;
    //                     SUCOmipConsumptionDeclared2.P2 := SUCOmipConsumptionDeclared.P2;
    //                     SUCOmipConsumptionDeclared2.P3 := SUCOmipConsumptionDeclared.P3;
    //                     SUCOmipConsumptionDeclared2.P4 := SUCOmipConsumptionDeclared.P4;
    //                     SUCOmipConsumptionDeclared2.P5 := SUCOmipConsumptionDeclared.P5;
    //                     SUCOmipConsumptionDeclared2.P6 := SUCOmipConsumptionDeclared.P6;
    //                     SUCOmipConsumptionDeclared2.Insert();
    //                 end;
    //             until SUCOmipConsumptionDeclared.Next() = 0;
    //     end;
    // end;

    // local procedure UpdateProposalData(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    // var
    //     SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    //     SUCOmipProposals: Record "SUC Omip Proposals";
    //     Customer: Record Customer;
    //     CustomerBankAccount: Record "Customer Bank Account";
    // begin
    //     SUCOmipEnergyContracts.Get(SUCOmipEnergyContractsIn."No.");
    //     // SUCOmipEnergyContracts."FEE Potency" := SUCOmipProposals."FEE Potency";
    //     // SUCOmipEnergyContracts."FEE Energy" := SUCOmipProposals."FEE Energy";
    //     // SUCOmipEnergyContracts."Energy Origen" := SUCOmipProposals."Energy Origen";
    //     // SUCOmipEnergyContracts."Agent No." := SUCOmipProposals."Agent No.";
    //     // SUCOmipEnergyContracts."Agent Code" := SUCOmipProposals."Agent No.";
    //     // SUCOmipEnergyContracts.Volume := SUCOmipProposals.Volume;
    //     if SUCOmipEnergyContracts."Customer No." <> '' then begin
    //         Customer.Get(SUCOmipEnergyContracts."Customer No.");

    //         if Customer."Preferred Bank Account Code" <> '' then begin
    //             CustomerBankAccount.Get(Customer."No.", Customer."Preferred Bank Account Code");
    //             if SUCOmipEnergyContracts."Proposal No." <> '' then begin
    //                 SUCOmipProposals.Get(SUCOmipEnergyContracts."Proposal No.");
    //                 SUCOmipProposals.IBAN := CustomerBankAccount.IBAN;
    //                 SUCOmipProposals.Modify();
    //             end;
    //             SUCOmipEnergyContracts.IBAN := CustomerBankAccount.IBAN;
    //             SUCOmipEnergyContracts.Modify();
    //         end;
    //         // if SUCOmipEnergyContracts."Cust. Payment Method Code" = '' then
    //         //     SUCOmipEnergyContracts."Cust. Payment Method Code" := Customer."Payment Method Code";
    //         // if SUCOmipEnergyContracts."Cust. Payment Terms Code" = '' then
    //         //     SUCOmipEnergyContracts."Cust. Payment Terms Code" := Customer."Payment Terms Code";

    //         // if Customer."SUC Customer Type" = Customer."SUC Customer Type"::Particular then
    //         //     SUCOmipEnergyContracts."SUC Customer Manager Position" := 'TITULAR'
    //         // else
    //         //     SUCOmipEnergyContracts."SUC Customer Manager Position" := Customer."SUC Manager Position";
    //     end;
    // end;

    // local procedure UpdateDefaultDataContract(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    // var
    //     SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    //     SUCOmipSetup: Record "SUC Omip Setup";
    //     SUCDefaultModalityByTime: Record "SUC Default Modality By Time";
    // begin
    //     SUCOmipEnergyContracts.Get(SUCOmipEnergyContractsIn."No.");
    //     SUCOmipSetup.Get();
    //     SUCOmipSetup.TestField("Default Reference Contract");

    //     SUCDefaultModalityByTime.Get(SUCOmipEnergyContractsIn.Times);

    //     SUCOmipEnergyContracts."Reference Contract" := SUCOmipSetup."Default Reference Contract";
    //     SUCOmipEnergyContracts."Contract Modality" := SUCDefaultModalityByTime."Default Contract Modality";
    //     SUCOmipEnergyContracts.Modify();
    // end;

    // local procedure UpdateCustomerSupplyInfo()
    // var
    //     Customer: Record Customer;
    //     SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
    // begin
    //     SUCOmipCustomerCUPS.Reset();
    //     SUCOmipCustomerCUPS.SetFilter("SUC Supply Point Address", '=%1', '');
    //     if SUCOmipCustomerCUPS.FindSet() then
    //         repeat
    //             Customer.Get(SUCOmipCustomerCUPS."Customer No.");
    //             SUCOmipCustomerCUPS.Validate("SUC Supply Point Address", Customer."SUC Supply Point Address");
    //             SUCOmipCustomerCUPS.Validate("SUC Supply Point Post Code", Customer."SUC Supply Point Post Code");
    //             SUCOmipCustomerCUPS.Validate("SUC Supply Point City", Customer."SUC Supply Point City");
    //             SUCOmipCustomerCUPS.Validate("SUC Supply Point County", Customer."SUC Supply Point County");
    //             SUCOmipCustomerCUPS.Validate("SUC Supply Point Country", Customer."SUC Supply Point Country");
    //             SUCOmipCustomerCUPS.Modify();
    //         until SUCOmipCustomerCUPS.Next() = 0;
    // end;

    // local procedure UpdateCustomerDocs()
    // var
    //     SUCOmipProposals: Record "SUC Omip Proposals";
    //     SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    // begin
    //     SUCOmipEnergyContracts.Get(SUCOmipEnergyContractsIn."No.");
    //     if SUCOmipEnergyContracts."Omip Contract" then
    //         SUCOmipEnergyContracts."Product Type" := SUCOmipEnergyContracts."Product Type"::Omip
    //     else
    //         SUCOmipEnergyContracts."Product Type" := SUCOmipEnergyContracts."Product Type"::"Energy (Light - Gas)";
    //     SUCOmipEnergyContracts.Modify();
    // end;
    local procedure UpdateOmipContract(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    begin
        SUCOmipEnergyContracts.Get(SUCOmipEnergyContractsIn."No.");
        if SUCOmipEnergyContracts."Omip Contract" then
            SUCOmipEnergyContracts."Product Type" := SUCOmipEnergyContracts."Product Type"::Omip
        else
            SUCOmipEnergyContracts."Product Type" := SUCOmipEnergyContracts."Product Type"::"Energy (Light - Gas)";
        SUCOmipEnergyContracts.Modify();
    end;

    [Obsolete('Replaced by GenerateContractInd2', '25.02')]
    procedure GenerateContractInd(OmipContractIn: Boolean; MarketerNoIn: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types";
                                        TimeIn: Enum "SUC Omip Times"; FEEPotencyIn: Decimal; FEEEnergyIn: Decimal; EnergyOrigen: Enum "SUC Omip Energy Origen";
                                        multicups: Boolean; EnergyType: Enum "SUC Energy Type"; ContratationType: Enum "SUC Contratation Type";
                                        RateType: Enum "SUC Rate Type Contract"; ContractModality: Text[100]; ControlPricesEnergyId: Integer): Code[20]
    begin
    end;

    [Obsolete('Replaced by GenerateContractInd3', '25.08')]
    procedure GenerateContractInd2(OmipContractIn: Boolean; MarketerNoIn: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types";
                                    TimeIn: Enum "SUC Omip Times"; EnergyOrigen: Enum "SUC Omip Energy Origen";
                                    multicups: Boolean; EnergyType: Enum "SUC Energy Type"; ContratationType: Enum "SUC Contratation Type";
                                    RateType: Enum "SUC Rate Type Contract"; ContractModality: Text[100]; ControlPricesEnergyId: Integer; agentNo: Code[100]): Code[20]
    begin
    end;

    procedure GenerateContractInd3(SUCProductType: Enum "SUC Product Type"; MarketerNoIn: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types";
                                    TimeIn: Enum "SUC Omip Times"; EnergyOrigen: Enum "SUC Omip Energy Origen";
                                    multicups: Boolean; EnergyType: Enum "SUC Energy Type"; ContratationType: Enum "SUC Contratation Type";
                                    RateType: Enum "SUC Rate Type Contract"; ContractModality: Text[100]; ControlPricesEnergyId: Integer; agentNo: Code[100]): Code[20]
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipSetup: Record "SUC Omip Setup";
        // SUCOmipTypes: Record "SUC Omip Types";
        SUCDefaultModalityByTime: Record "SUC Default Modality By Time";
        SUCControlPricesEnergy: Record "SUC Control Prices Energy";
        SUCContractModalities: Record "SUC Contract Modalities";
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        NoSeries: Codeunit "No. Series";
        DocNo: Code[20];
        TittleAppConditions: Text[250];
        ApplicablesCondittions: Text;
    begin
        Clear(ApplicablesCondittions);
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Contract Nos.");
        SUCOmipSetup.TestField("Default Reference Contract");

        DocNo := NoSeries.GetNextNo(SUCOmipSetup."Contract Nos.");
        SUCOmipEnergyContracts.Init();
        SUCOmipEnergyContracts."No." := DocNo;
        SUCOmipEnergyContracts.Validate("Product Type", SUCProductType);
        SUCOmipEnergyContracts.Insert();
        SUCOmipEnergyContracts.Validate("Date Created", WorkDate());
        SUCOmipEnergyContracts."Marketer No." := MarketerNoIn;
        // SUCOmipEnergyContracts.Validate("Omip Contract", OmipContractIn);
        SUCOmipEnergyContracts.Validate(Multicups, multicups);
        SUCOmipEnergyContracts."Rate No." := RateNoIn;
        case SUCProductType of
            SUCProductType::Omip:
                begin
                    SUCDefaultModalityByTime.Get(TimeIn);
                    SUCOmipEnergyContracts.Validate(Times, TimeIn);
                end;
            else
                SUCOmipEnergyContracts.Times := SUCOmipEnergyContracts.Times::"12M";
        end;
        SUCOmipEnergyContracts."Energy Origen" := EnergyOrigen;
        case SUCProductType of
            SUCProductType::Omip:
                begin
                    SUCOmipEnergyContracts.Type := TypeIn;
                    SUCOmipEnergyContracts."Reference Contract" := SUCOmipSetup."Default Reference Contract";
                    SUCOmipEnergyContracts."Contract Modality" := SUCDefaultModalityByTime."Default Contract Modality";
                end;
            else begin
                SUCOmipEnergyContracts.Type := SUCOmipEnergyContracts.Type::"Type 1";
                // if SUCOmipTypes.Get(SUCOmipEnergyContracts.Type) then begin
                //     SUCOmipTypes.TestField("Start Date Contract");
                //     SUCOmipEnergyContracts."Supply Start Date" := CalcDate('<-CM>', CalcDate(SUCOmipTypes."Start Date Contract", SUCOmipEnergyContracts."Date Created"));
                // end else
                SUCOmipEnergyContracts."Supply Start Date" := 0D;
            end;
        end;
        // SUCOmipEnergyContracts."Agent No." := agentNo;
        SUCOmipEnergyContracts.Validate("Agent No.", agentNo);
        if SUCOmipExternalUsers.Get(SUCOmipEnergyContracts."Agent No.") then
            SUCOmipEnergyContracts."Agent Code" := SUCOmipExternalUsers."Agent Code"
        else
            SUCOmipEnergyContracts."Agent Code" := '';
        SUCOmipEnergyContracts.Validate("Customer No.", '');
        SUCOmipEnergyContracts.Validate("Date Created", Today);
        SUCOmipEnergyContracts.Validate("DateTime Created", CurrentDateTime);
        SUCOmipEnergyContracts."Energy Type" := EnergyType;
        SUCOmipEnergyContracts."Contratation Type" := ContratationType;
        SUCOmipEnergyContracts."Rate Type Contract" := RateType;
        case SUCProductType of
            SUCProductType::"Energy (Light - Gas)":
                begin
                    // Find control prices energy record by ID
                    SUCControlPricesEnergy.Reset();
                    SUCControlPricesEnergy.SetRange("Id.", ControlPricesEnergyId);
                    if not SUCControlPricesEnergy.IsEmpty() then begin
                        SUCOmipEnergyContracts.Validate("Contract Id. Modality", ControlPricesEnergyId);
                        SUCOmipEnergyContracts.Validate("Contract Modality", ContractModality);
                    end;
                    if SUCContractModalities.Get(MarketerNoIn, EnergyType, ContractModality) then begin
                        if SUCContractModalities.Tittle <> '' then
                            SUCOmipEnergyContracts."Tittle Applicable Conditions" := StrSubstNo(SUCContractModalities.Tittle, SUCContractModalities."Tittle Complement 1", SUCContractModalities."Tittle Complement 2", SUCContractModalities."Tittle Complement 3");
                        ApplicablesCondittions := SUCContractModalities.GetDataValueBlob(SUCContractModalities.FieldNo("Body Applicable Conditions"));
                        ApplicablesCondittions := StrSubstNo(ApplicablesCondittions, SUCContractModalities."Body Complement 1", SUCContractModalities."Body Complement 2", SUCContractModalities."Body Complement 3", SUCContractModalities."Body Complement 4", SUCContractModalities."Body Complement 5");
                    end;
                end;
            else begin
                GetContractApplicableConditions2(SUCOmipEnergyContracts."Product Type", SUCOmipEnergyContracts."Marketer No.", SUCOmipEnergyContracts.Times, SUCOmipEnergyContracts.Multicups, SUCOmipEnergyContracts."Supply Start Date", TittleAppConditions, ApplicablesCondittions);
                SUCOmipEnergyContracts."Tittle Applicable Conditions" := TittleAppConditions;
            end;
        end;
        SUCOmipEnergyContracts.Modify();


        if ApplicablesCondittions <> '' then
            SUCOmipEnergyContracts.SetDataBlob(SUCOmipEnergyContracts.FieldNo("Body Applicable Conditions"), ApplicablesCondittions);

        case SUCProductType of
            SUCProductType::Omip:
                CalculateEnergyContract2(SUCOmipEnergyContracts, RateNoIn, TypeIn, TimeIn);
            else
                CalculateControlPricesContract(SUCOmipEnergyContracts, RateNoIn);
        end;

        exit(DocNo);
    end;

    [Obsolete('Replaced by CalculateEnergyContract2', '25.02')]
    procedure CalculateEnergyContract(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts"; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times"; FEEPotency: Decimal)
    begin
    end;

    procedure CalculateEnergyContract2(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts"; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times")
    begin
        CalculatePowerEntryContract(SUCOmipEnergyContractsIn, RateNoIn);
        CalculateEnergyEntryContract(SUCOmipEnergyContractsIn, RateNoIn, TypeIn, TimeIn);
    end;

    local procedure CalculatePowerEntryContract(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts"; RateNoIn: Code[20])
    var
        SUCOmipEnergyContracts: Record "SUC Omip Power Entry Contract";
        // SUCOmipPowerCalculation2: Record "SUC Omip Power Calculation 2"; //*Calculo de potencia
        SUCOmipRegPricePower2: Record "SUC Omip Reg. Price Power 2"; //*Precios regulados de potencia
    begin
        if SUCOmipEnergyContractsIn.Multicups then begin
            SUCOmipEnergyContracts.Reset();
            SUCOmipEnergyContracts.SetRange("Contract No.", SUCOmipEnergyContractsIn."No.");
            SUCOmipEnergyContracts.SetRange("Rate No.", RateNoIn);
            SUCOmipEnergyContracts.DeleteAll();

            if RateNoIn <> '' then begin //*When incoming from ODATA the RateNo is null
                // SUCOmipPowerCalculation2.Reset();
                // SUCOmipPowerCalculation2.SetRange("Marketer No.", SUCOmipEnergyContractsIn."Marketer No.");
                // SUCOmipPowerCalculation2.SetRange("Rate No.", RateNoIn);
                // SUCOmipPowerCalculation2.FindLast();

                SUCOmipRegPricePower2.Reset();
                SUCOmipRegPricePower2.SetRange("Marketer No.", SUCOmipEnergyContractsIn."Marketer No.");
                SUCOmipRegPricePower2.SetRange("Rate No.", RateNoIn);
                SUCOmipRegPricePower2.FindLast();

                // InsertPowerEntryContract(SUCOmipEnergyContractsIn, RateNoIn, SUCOmipPowerCalculation2, SUCOmipRegPricePower2, FEEPotency);
                InsertPowerEntryContract(SUCOmipEnergyContractsIn, RateNoIn, SUCOmipRegPricePower2);
            end;
        end else begin
            SUCOmipEnergyContracts.Reset();
            SUCOmipEnergyContracts.SetRange("Contract No.", SUCOmipEnergyContractsIn."No.");
            SUCOmipEnergyContracts.DeleteAll();

            // SUCOmipPowerCalculation2.Reset();
            // SUCOmipPowerCalculation2.SetRange("Marketer No.", SUCOmipEnergyContractsIn."Marketer No.");
            // SUCOmipPowerCalculation2.SetRange("Rate No.", SUCOmipEnergyContractsIn."Rate No.");
            // SUCOmipPowerCalculation2.FindLast();

            SUCOmipRegPricePower2.Reset();
            SUCOmipRegPricePower2.SetRange("Marketer No.", SUCOmipEnergyContractsIn."Marketer No.");
            SUCOmipRegPricePower2.SetRange("Rate No.", SUCOmipEnergyContractsIn."Rate No.");
            SUCOmipRegPricePower2.FindLast();

            // InsertPowerEntryContract(SUCOmipEnergyContractsIn, RateNoIn, SUCOmipPowerCalculation2, SUCOmipRegPricePower2, FEEPotency);
            InsertPowerEntryContract(SUCOmipEnergyContractsIn, RateNoIn, SUCOmipRegPricePower2);
        end;
    end;

    //local procedure InsertPowerEntryContract(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts"; RateNoIn: Code[20]; SUCOmipPowerCalculation2In: Record "SUC Omip Power Calculation 2"; SUCOmipRegPricePower2In: Record "SUC Omip Reg. Price Power 2"; FEEPotency: Decimal)
    local procedure InsertPowerEntryContract(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts"; RateNoIn: Code[20]; SUCOmipRegPricePower2In: Record "SUC Omip Reg. Price Power 2")
    var
        SUCOmipPowerEntryContract: Record "SUC Omip Power Entry Contract";
        SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
    begin
        if RateNoIn <> '' then
            if not SUCOmipPowerEntryContract.Get(SUCOmipEnergyContractsIn."No.", RateNoIn) then begin
                SUCOmipEnergyContractsIn.TestField("Marketer No.");
                SUCOmipFEEPowerDocument.Get(SUCOmipFEEPowerDocument."Document Type"::Contract, SUCOmipEnergyContractsIn."No.", SUCOmipEnergyContractsIn."Marketer No.", RateNoIn);
                SUCOmipPowerEntryContract.Init();
                SUCOmipPowerEntryContract."Contract No." := SUCOmipEnergyContractsIn."No.";
                SUCOmipPowerEntryContract.Validate("Rate No.", RateNoIn);
                SUCOmipPowerEntryContract.Validate(P1, SUCOmipRegPricePower2In.P1 + SUCOmipFEEPowerDocument.P1);
                SUCOmipPowerEntryContract.Validate(P2, SUCOmipRegPricePower2In.P2 + SUCOmipFEEPowerDocument.P2);
                SUCOmipPowerEntryContract.Validate(P3, SUCOmipRegPricePower2In.P3 + SUCOmipFEEPowerDocument.P3);
                SUCOmipPowerEntryContract.Validate(P4, SUCOmipRegPricePower2In.P4 + SUCOmipFEEPowerDocument.P4);
                SUCOmipPowerEntryContract.Validate(P5, SUCOmipRegPricePower2In.P5 + SUCOmipFEEPowerDocument.P5);
                SUCOmipPowerEntryContract.Validate(P6, SUCOmipRegPricePower2In.P6 + SUCOmipFEEPowerDocument.P6);
                // SUCOmipPowerEntryContract.Validate(P1, SUCOmipRegPricePower2In.P1 + (SUCOmipPowerCalculation2In.P1 * FEEPotency));
                // SUCOmipPowerEntryContract.Validate(P2, SUCOmipRegPricePower2In.P2 + (SUCOmipPowerCalculation2In.P2 * FEEPotency));
                // SUCOmipPowerEntryContract.Validate(P3, SUCOmipRegPricePower2In.P3 + (SUCOmipPowerCalculation2In.P3 * FEEPotency));
                // SUCOmipPowerEntryContract.Validate(P4, SUCOmipRegPricePower2In.P4 + (SUCOmipPowerCalculation2In.P4 * FEEPotency));
                // SUCOmipPowerEntryContract.Validate(P5, SUCOmipRegPricePower2In.P5 + (SUCOmipPowerCalculation2In.P5 * FEEPotency));
                // SUCOmipPowerEntryContract.Validate(P6, SUCOmipRegPricePower2In.P6 + (SUCOmipPowerCalculation2In.P6 * FEEPotency));
                SUCOmipPowerEntryContract.Validate("Contract Id", SUCOmipEnergyContractsIn.SystemId);
                SUCOmipPowerEntryContract.Insert();
            end;
    end;

    local procedure CalculateEnergyEntryContract(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts"; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times")
    var
        SUCOmipEnergyEntryContract: Record "SUC Omip Energy Entry Contract";
    begin
        if SUCOmipEnergyContractsIn.Multicups then begin
            SUCOmipEnergyEntryContract.Reset();
            SUCOmipEnergyEntryContract.SetRange("Contract No.", SUCOmipEnergyContractsIn."No.");
            SUCOmipEnergyEntryContract.SetRange("Rate No.", RateNoIn);
            SUCOmipEnergyEntryContract.DeleteAll();

            InsertEnergyEntryContract(SUCOmipEnergyContractsIn, RateNoIn, TypeIn, TimeIn);
            UpdateEnergyEntryPricesContract(SUCOmipEnergyContractsIn, RateNoIn, TimeIn);
        end else begin
            SUCOmipEnergyEntryContract.Reset();
            SUCOmipEnergyEntryContract.SetRange("Contract No.", SUCOmipEnergyContractsIn."No.");
            SUCOmipEnergyEntryContract.DeleteAll();

            InsertEnergyEntryContract(SUCOmipEnergyContractsIn, RateNoIn, TypeIn, TimeIn);
            UpdateEnergyEntryPricesContract(SUCOmipEnergyContractsIn, RateNoIn, TimeIn);
        end;
    end;

    local procedure InsertEnergyEntryContract(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts"; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times")
    var
        SUCOmipEnergyEntryContract: Record "SUC Omip Energy Entry Contract";
        i: Integer;
    begin
        SUCOmipEnergyEntryContract.Reset();
        SUCOmipEnergyEntryContract.SetRange("Contract No.", SUCOmipEnergyContractsIn."No.");
        SUCOmipEnergyEntryContract.SetRange("Rate No.", RateNoIn);
        SUCOmipEnergyEntryContract.SetRange(Times, TimeIn);
        SUCOmipEnergyEntryContract.SetRange(Type, TypeIn);
        if not SUCOmipEnergyEntryContract.FindSet() then begin
            SUCOmipEnergyEntryContract.Init();
            for i := 1 to 5 do begin
                SUCOmipEnergyEntryContract."Contract No." := SUCOmipEnergyContractsIn."No.";
                SUCOmipEnergyEntryContract.Validate("Rate No.", RateNoIn);
                SUCOmipEnergyEntryContract.Validate(Times, Enum::"SUC Omip Times".FromInteger(i));
                SUCOmipEnergyEntryContract.Validate(Type, TypeIn);
                SUCOmipEnergyEntryContract.Validate("Contract Id", SUCOmipEnergyContractsIn.SystemId);
                SUCOmipEnergyEntryContract.Validate(Enabled, false);
                SUCOmipEnergyEntryContract.Insert();
            end;
        end;
    end;

    local procedure UpdateEnergyEntryPricesContract(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts"; RateNoIn: Code[20]; TimeIn: Enum "SUC Omip Times")
    var
        SUCOmipEnergyEntryContract: Record "SUC Omip Energy Entry Contract";
        SUCOmipRatesEntry2: Record "SUC Omip Rates Entry 2";
    begin
        SUCOmipEnergyEntryContract.Reset();
        SUCOmipEnergyEntryContract.SetRange("Contract No.", SUCOmipEnergyContractsIn."No.");
        SUCOmipEnergyEntryContract.SetRange("Rate No.", RateNoIn);
        SUCOmipEnergyEntryContract.SetFilter(Times, '..%1', TimeIn);
        if SUCOmipEnergyEntryContract.FindSet() then
            repeat
                SUCOmipRatesEntry2.Reset();
                SUCOmipRatesEntry2.SetRange("Marketer No.", SUCOmipEnergyContractsIn."Marketer No.");
                SUCOmipRatesEntry2.SetRange("Rate No.", SUCOmipEnergyEntryContract."Rate No.");
                SUCOmipRatesEntry2.SetRange("Omip Times", SUCOmipEnergyEntryContract.Times);
                if SUCOmipRatesEntry2.FindSet() then
                    repeat
                        case SUCOmipRatesEntry2."Hired Potency" of
                            SUCOmipRatesEntry2."Hired Potency"::P1:
                                SUCOmipEnergyEntryContract.Validate(P1, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P2:
                                SUCOmipEnergyEntryContract.Validate(P2, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P3:
                                SUCOmipEnergyEntryContract.Validate(P3, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P4:
                                SUCOmipEnergyEntryContract.Validate(P4, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P5:
                                SUCOmipEnergyEntryContract.Validate(P5, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P6:
                                SUCOmipEnergyEntryContract.Validate(P6, SUCOmipRatesEntry2."Final + ATR");
                        end;
                        SUCOmipEnergyEntryContract.Validate("Omip price", SUCOmipRatesEntry2.Omip);
                        SUCOmipEnergyEntryContract.Validate(Enabled, true);
                        SUCOmipEnergyEntryContract.Modify();
                    until SUCOmipRatesEntry2.Next() = 0;
            until SUCOmipEnergyEntryContract.Next() = 0;
    end;

    procedure CalculateControlPricesContract(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"; RateNoIn: Code[20])
    var
        SUCControlPricesEnergy: Record "SUC Control Prices Energy";
        SUCOmipPowerEntryContract: Record "SUC Omip Power Entry Contract";
        SUCOmipEnergyEntryContract: Record "SUC Omip Energy Entry Contract";
    begin
        SUCOmipPowerEntryContract.Reset();
        SUCOmipPowerEntryContract.SetRange("Contract No.", SUCOmipEnergyContracts."No.");
        if SUCOmipPowerEntryContract.FindSet() then
            repeat
                SUCOmipPowerEntryContract.Delete();
            until SUCOmipPowerEntryContract.Next() = 0;

        SUCOmipEnergyEntryContract.Reset();
        SUCOmipEnergyEntryContract.SetRange("Contract No.", SUCOmipEnergyContracts."No.");
        if SUCOmipEnergyEntryContract.FindSet() then
            repeat
                SUCOmipEnergyEntryContract.Delete();
            until SUCOmipEnergyEntryContract.Next() = 0;

        SUCControlPricesEnergy.Reset();
        SUCControlPricesEnergy.SetRange("Marketer No.", SUCOmipEnergyContracts."Marketer No.");
        SUCControlPricesEnergy.SetRange("Energy Type", SUCOmipEnergyContracts."Energy Type");
        SUCControlPricesEnergy.SetRange("Rate No.", SUCOmipEnergyContracts."Rate No."); // Use Rate No. from Control Prices to match Rate No. from contract
        SUCControlPricesEnergy.SetRange("Rate Type Contract", SUCOmipEnergyContracts."Rate Type Contract");
        SUCControlPricesEnergy.SetRange(Modality, SUCOmipEnergyContracts."Contract Modality");
        // SUCControlPricesEnergy.SetRange("Id.", SUCOmipEnergyContracts."Contract Id. Modality");
        if SUCControlPricesEnergy.FindSet() then
            repeat
                if not SUCOmipPowerEntryContract.Get(SUCOmipEnergyContracts."No.", SUCControlPricesEnergy."Rate No.") then begin
                    SUCOmipPowerEntryContract.Init();
                    SUCOmipPowerEntryContract."Contract No." := SUCOmipEnergyContracts."No.";
                    SUCOmipPowerEntryContract."Rate No." := SUCControlPricesEnergy."Rate No.";
                    SUCOmipPowerEntryContract.P1 := SUCControlPricesEnergy.P1;
                    SUCOmipPowerEntryContract.P2 := SUCControlPricesEnergy.P2;
                    SUCOmipPowerEntryContract.P3 := SUCControlPricesEnergy.P3;
                    SUCOmipPowerEntryContract.P4 := SUCControlPricesEnergy.P4;
                    SUCOmipPowerEntryContract.P5 := SUCControlPricesEnergy.P5;
                    SUCOmipPowerEntryContract.P6 := SUCControlPricesEnergy.P6;
                    SUCOmipPowerEntryContract."Contract Id" := SUCOmipEnergyContracts.SystemId;
                    SUCOmipPowerEntryContract.Insert();
                end else begin
                    SUCOmipPowerEntryContract.P1 := SUCControlPricesEnergy.P1;
                    SUCOmipPowerEntryContract.P2 := SUCControlPricesEnergy.P2;
                    SUCOmipPowerEntryContract.P3 := SUCControlPricesEnergy.P3;
                    SUCOmipPowerEntryContract.P4 := SUCControlPricesEnergy.P4;
                    SUCOmipPowerEntryContract.P5 := SUCControlPricesEnergy.P5;
                    SUCOmipPowerEntryContract.P6 := SUCControlPricesEnergy.P6;
                    SUCOmipPowerEntryContract.Modify();
                end;
                ValidatePowerEntryContractTaxes(SUCOmipEnergyContracts, SUCOmipPowerEntryContract);

                if not SUCOmipEnergyEntryContract.Get(SUCOmipEnergyContracts."No.", SUCControlPricesEnergy."Rate No.", SUCOmipEnergyContracts.Times, SUCOmipEnergyContracts.Type) then begin
                    SUCOmipEnergyEntryContract.Init();
                    SUCOmipEnergyEntryContract."Contract No." := SUCOmipEnergyContracts."No.";
                    SUCOmipEnergyEntryContract."Rate No." := SUCControlPricesEnergy."Rate No.";
                    SUCOmipEnergyEntryContract.Type := SUCOmipEnergyContracts.Type;
                    SUCOmipEnergyEntryContract.Times := SUCOmipEnergyContracts.Times;
                    SUCOmipEnergyEntryContract."Times Text" := SUCOmipEnergyContracts."Rate No.";
                    SUCOmipEnergyEntryContract."Contract Id" := SUCOmipEnergyContracts.SystemId;
                    SUCOmipEnergyEntryContract.Enabled := true;
                    SUCOmipEnergyEntryContract.P1 := SUCControlPricesEnergy.E1;
                    SUCOmipEnergyEntryContract.P2 := SUCControlPricesEnergy.E2;
                    SUCOmipEnergyEntryContract.P3 := SUCControlPricesEnergy.E3;
                    SUCOmipEnergyEntryContract.P4 := SUCControlPricesEnergy.E4;
                    SUCOmipEnergyEntryContract.P5 := SUCControlPricesEnergy.E5;
                    SUCOmipEnergyEntryContract.P6 := SUCControlPricesEnergy.E6;
                    SUCOmipEnergyEntryContract.Discount := SUCControlPricesEnergy.Discount;
                    SUCOmipEnergyEntryContract.Insert();
                end else begin
                    SUCOmipEnergyEntryContract.P1 := SUCControlPricesEnergy.E1;
                    SUCOmipEnergyEntryContract.P2 := SUCControlPricesEnergy.E2;
                    SUCOmipEnergyEntryContract.P3 := SUCControlPricesEnergy.E3;
                    SUCOmipEnergyEntryContract.P4 := SUCControlPricesEnergy.E4;
                    SUCOmipEnergyEntryContract.P5 := SUCControlPricesEnergy.E5;
                    SUCOmipEnergyEntryContract.P6 := SUCControlPricesEnergy.E6;
                    SUCOmipEnergyEntryContract.Discount := SUCControlPricesEnergy.Discount;
                    SUCOmipEnergyEntryContract.Modify();
                end;
                ValidateEnergyEntryContractTaxes(SUCOmipEnergyContracts, SUCOmipEnergyEntryContract);

            until SUCControlPricesEnergy.Next() = 0;
    end;

    [Obsolete('Replaced by CalculateEnergyPreview2', '25.02')]
    procedure CalculateEnergyPreview(SUCOmipProposalPreviewIn: Record "SUC Omip Proposal Preview"; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times"; FEEPotency: Decimal)
    begin
    end;

    procedure CalculateEnergyPreview2(SUCOmipProposalPreviewIn: Record "SUC Omip Proposal Preview"; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times")
    begin
        CalculatePowerEntryPreview(SUCOmipProposalPreviewIn, RateNoIn);
        CalculateEnergyEntryPreview(SUCOmipProposalPreviewIn, RateNoIn, TypeIn, TimeIn);
    end;

    local procedure CalculatePowerEntryPreview(SUCOmipProposalPreviewIn: Record "SUC Omip Proposal Preview"; RateNoIn: Code[20])
    var
        SUCOmipPowerEntryPreview: Record "SUC Omip Power Entry Preview";
        SUCOmipRegPricePower2: Record "SUC Omip Reg. Price Power 2";
    begin
        SUCOmipPowerEntryPreview.Reset();
        SUCOmipPowerEntryPreview.SetRange("Proposal No.", SUCOmipProposalPreviewIn."No.");
        SUCOmipPowerEntryPreview.DeleteAll();

        SUCOmipRegPricePower2.Reset();
        SUCOmipRegPricePower2.SetRange("Marketer No.", SUCOmipProposalPreviewIn."Marketer No.");
        SUCOmipRegPricePower2.SetRange("Rate No.", SUCOmipProposalPreviewIn."Rate No.");
        if SUCOmipRegPricePower2.FindLast() then
            InsertPowerEntryPreview(SUCOmipProposalPreviewIn, RateNoIn, SUCOmipRegPricePower2);
    end;

    local procedure InsertPowerEntryPreview(SUCOmipProposalPreviewIn: Record "SUC Omip Proposal Preview"; RateNoIn: Code[20]; SUCOmipRegPricePower2In: Record "SUC Omip Reg. Price Power 2")
    var
        SUCOmipPowerEntryPreview: Record "SUC Omip Power Entry Preview";
        SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
    begin
        if RateNoIn <> '' then
            if not SUCOmipPowerEntryPreview.Get(SUCOmipProposalPreviewIn."No.", RateNoIn) then begin
                SUCOmipProposalPreviewIn.TestField("Marketer No.");
                SUCOmipFEEPowerDocument.Get(SUCOmipFEEPowerDocument."Document Type"::"Proposal Preview", SUCOmipProposalPreviewIn."No.", SUCOmipProposalPreviewIn."Marketer No.", RateNoIn);

                SUCOmipPowerEntryPreview.Init();
                SUCOmipPowerEntryPreview."Proposal No." := SUCOmipProposalPreviewIn."No.";
                SUCOmipPowerEntryPreview.Validate("Rate No.", RateNoIn);
                SUCOmipPowerEntryPreview.Validate(P1, SUCOmipRegPricePower2In.P1 + SUCOmipFEEPowerDocument.P1);
                SUCOmipPowerEntryPreview.Validate(P2, SUCOmipRegPricePower2In.P2 + SUCOmipFEEPowerDocument.P2);
                SUCOmipPowerEntryPreview.Validate(P3, SUCOmipRegPricePower2In.P3 + SUCOmipFEEPowerDocument.P3);
                SUCOmipPowerEntryPreview.Validate(P4, SUCOmipRegPricePower2In.P4 + SUCOmipFEEPowerDocument.P4);
                SUCOmipPowerEntryPreview.Validate(P5, SUCOmipRegPricePower2In.P5 + SUCOmipFEEPowerDocument.P5);
                SUCOmipPowerEntryPreview.Validate(P6, SUCOmipRegPricePower2In.P6 + SUCOmipFEEPowerDocument.P6);
                SUCOmipPowerEntryPreview.Validate("Proposal Id", SUCOmipProposalPreviewIn.SystemId);
                SUCOmipPowerEntryPreview.Insert();
            end;
    end;

    local procedure CalculateEnergyEntryPreview(SUCOmipProposalPreviewIn: Record "SUC Omip Proposal Preview"; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times")
    var
        SUCOmipEnergyEntryPreview: Record "SUC Omip Energy Entry Preview";
    begin
        SUCOmipEnergyEntryPreview.Reset();
        SUCOmipEnergyEntryPreview.SetRange("Proposal No.", SUCOmipProposalPreviewIn."No.");
        SUCOmipEnergyEntryPreview.DeleteAll();

        InsertEnergyEntryPreview(SUCOmipProposalPreviewIn, RateNoIn, TypeIn, TimeIn);
        UpdateEnergyEntryPricesPreview(SUCOmipProposalPreviewIn, RateNoIn, TimeIn);
    end;

    local procedure InsertEnergyEntryPreview(SUCOmipProposalPreviewIn: Record "SUC Omip Proposal Preview"; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times")
    var
        SUCOmipEnergyEntryPreview: Record "SUC Omip Energy Entry Preview";
        i: Integer;
    begin
        SUCOmipEnergyEntryPreview.Reset();
        SUCOmipEnergyEntryPreview.SetRange("Proposal No.", SUCOmipProposalPreviewIn."No.");
        SUCOmipEnergyEntryPreview.SetRange("Rate No.", RateNoIn);
        SUCOmipEnergyEntryPreview.SetRange(Times, TimeIn);
        SUCOmipEnergyEntryPreview.SetRange(Type, TypeIn);
        if not SUCOmipEnergyEntryPreview.FindSet() then begin
            SUCOmipEnergyEntryPreview.Init();
            for i := 1 to 5 do begin
                SUCOmipEnergyEntryPreview."Proposal No." := SUCOmipProposalPreviewIn."No.";
                SUCOmipEnergyEntryPreview.Validate("Rate No.", RateNoIn);
                SUCOmipEnergyEntryPreview.Validate(Times, Enum::"SUC Omip Times".FromInteger(i));
                SUCOmipEnergyEntryPreview.Validate(Type, TypeIn);
                SUCOmipEnergyEntryPreview.Validate("Proposal Id", SUCOmipProposalPreviewIn.SystemId);
                SUCOmipEnergyEntryPreview.Validate(Enabled, false);
                SUCOmipEnergyEntryPreview.Insert();
            end;
        end;
    end;

    local procedure UpdateEnergyEntryPricesPreview(SUCOmipProposalPreviewIn: Record "SUC Omip Proposal Preview"; RateNoIn: Code[20]; TimeIn: Enum "SUC Omip Times")
    var
        SUCOmipEnergyEntryPreview: Record "SUC Omip Energy Entry Preview";
        SUCOmipRatesEntry2: Record "SUC Omip Rates Entry 2";
    begin
        SUCOmipEnergyEntryPreview.Reset();
        SUCOmipEnergyEntryPreview.SetRange("Proposal No.", SUCOmipProposalPreviewIn."No.");
        SUCOmipEnergyEntryPreview.SetRange("Rate No.", RateNoIn);
        SUCOmipEnergyEntryPreview.SetFilter(Times, '..%1', TimeIn);
        if SUCOmipEnergyEntryPreview.FindSet() then
            repeat
                SUCOmipRatesEntry2.Reset();
                SUCOmipRatesEntry2.SetRange("Marketer No.", SUCOmipProposalPreviewIn."Marketer No.");
                SUCOmipRatesEntry2.SetRange("Rate No.", SUCOmipEnergyEntryPreview."Rate No.");
                SUCOmipRatesEntry2.SetRange("Omip Times", SUCOmipEnergyEntryPreview.Times);
                if SUCOmipRatesEntry2.FindSet() then
                    repeat
                        case SUCOmipRatesEntry2."Hired Potency" of
                            SUCOmipRatesEntry2."Hired Potency"::P1:
                                SUCOmipEnergyEntryPreview.Validate(P1, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P2:
                                SUCOmipEnergyEntryPreview.Validate(P2, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P3:
                                SUCOmipEnergyEntryPreview.Validate(P3, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P4:
                                SUCOmipEnergyEntryPreview.Validate(P4, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P5:
                                SUCOmipEnergyEntryPreview.Validate(P5, SUCOmipRatesEntry2."Final + ATR");
                            SUCOmipRatesEntry2."Hired Potency"::P6:
                                SUCOmipEnergyEntryPreview.Validate(P6, SUCOmipRatesEntry2."Final + ATR");
                        end;
                        SUCOmipEnergyEntryPreview.Validate("Omip price", SUCOmipRatesEntry2.Omip);
                        SUCOmipEnergyEntryPreview.Validate(Enabled, true);
                        SUCOmipEnergyEntryPreview.Modify();
                    until SUCOmipRatesEntry2.Next() = 0;
            until SUCOmipEnergyEntryPreview.Next() = 0;
    end;

    [Obsolete('Replaced by GenerateProposalPreview2', '25.02')]
    procedure GenerateProposalPreview(MarketerNoIn: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times"; FEEPotencyIn: Decimal; FEEEnergyIn: Decimal; EnergyOrigen: Enum "SUC Omip Energy Origen"): Code[20]
    begin
    end;

    [Obsolete('Replaced by GenerateProposalPreview3', '25.02')]
    procedure GenerateProposalPreview2(MarketerNoIn: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times"; EnergyOrigen: Enum "SUC Omip Energy Origen"; AgentNo: Code[100]): Code[20]
    begin
    end;

    procedure GenerateProposalPreview3(MarketerNoIn: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times";
    EnergyOrigen: Enum "SUC Omip Energy Origen"; AgentNo: Code[100]; CustomerNo: Code[20]; CustomerCUPS: Text[25]; FEEGroupID: Code[20]): Code[20]
    var
        SUCOmipProposalPreview: Record "SUC Omip Proposal Preview";
        SUCOmipSetup: Record "SUC Omip Setup";
        NoSeries: Codeunit "No. Series";
        DocNo: Code[20];
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Preview Proposal Nos.");
        DocNo := NoSeries.GetNextNo(SUCOmipSetup."Preview Proposal Nos.");
        SUCOmipProposalPreview.Init();
        SUCOmipProposalPreview."No." := DocNo;
        SUCOmipProposalPreview.Validate("Date Created", Today);
        SUCOmipProposalPreview.Validate("DateTime Created", CurrentDateTime);
        SUCOmipProposalPreview.Validate("Date Proposal", Today);
        SUCOmipProposalPreview.Insert();
        SUCOmipProposalPreview.Validate("Marketer No.", MarketerNoIn);
        SUCOmipProposalPreview.Validate("Agent No.", AgentNo);
        SUCOmipProposalPreview.Validate("Rate No.", RateNoIn);
        SUCOmipProposalPreview.Validate(Times, TimeIn);
        SUCOmipProposalPreview.Validate(Type, TypeIn);
        SUCOmipProposalPreview.Validate("Energy Origen", EnergyOrigen);
        SUCOmipProposalPreview.Validate("Customer No.", CustomerNo);
        SUCOmipProposalPreview.Validate("Customer CUPS", CustomerCUPS);
        SUCOmipProposalPreview.Validate("FEE Group Id.", FEEGroupID);
        SUCOmipProposalPreview.Modify();

        exit(DocNo);
    end;

    [Obsolete('Replaced by UpdateProposalPreview2', '25.02')]
    procedure UpdateProposalPreview(ProposalNo: Code[20]; MarketerNoIn: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types";
                                            TimeIn: Enum "SUC Omip Times"; FEEPotencyIn: Decimal; FEEEnergyIn: Decimal; EnergyOrigen: Enum "SUC Omip Energy Origen"): Code[20]
    begin
    end;

    [Obsolete('Replaced by UpdateProposalPreview3', '25.02')]
    procedure UpdateProposalPreview2(ProposalNo: Code[20]; MarketerNoIn: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types";
                                        TimeIn: Enum "SUC Omip Times"; EnergyOrigen: Enum "SUC Omip Energy Origen"; AgentNo: Code[100]): Code[20]
    begin
    end;

    procedure UpdateProposalPreview3(ProposalNo: Code[20]; MarketerNoIn: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types";
                                    TimeIn: Enum "SUC Omip Times"; EnergyOrigen: Enum "SUC Omip Energy Origen"; AgentNo: Code[100];
                                    CustomerNo: Code[20]; CustomerCUPS: Text[25]; FEEGroupID: Code[20]): Code[20]
    var
        SUCOmipProposalPreview: Record "SUC Omip Proposal Preview";
    begin
        SUCOmipProposalPreview.Get(ProposalNo);
        SUCOmipProposalPreview.Validate("Marketer No.", MarketerNoIn);
        SUCOmipProposalPreview.Validate("Agent No.", AgentNo);
        SUCOmipProposalPreview.Validate("Rate No.", RateNoIn);
        SUCOmipProposalPreview.Validate(Times, TimeIn);
        SUCOmipProposalPreview.Validate(Type, TypeIn);
        SUCOmipProposalPreview.Validate("Date Proposal", WorkDate());
        SUCOmipProposalPreview.Validate("Energy Origen", EnergyOrigen);
        SUCOmipProposalPreview.Validate("Customer No.", CustomerNo);
        SUCOmipProposalPreview.Validate("Customer CUPS", CustomerCUPS);
        SUCOmipProposalPreview.Validate("FEE Group Id.", FEEGroupID);
        SUCOmipProposalPreview.Modify();

        exit(SUCOmipProposalPreview."No.");
    end;

    procedure GetDataFromTime(TimeIn: Enum "SUC Omip Times"; StartDate: Date; var ContractPeriodOut: Text; var EndDateOut: Date)
    var
        YearLbl: Label 'Year';
        YearsLbl: Label 'Years';
    begin
        if StartDate <> 0D then
            case TimeIn of
                TimeIn::"12M":
                    begin
                        ContractPeriodOut := '1' + ' ' + YearLbl;
                        EndDateOut := CalcDate('<+1Y-1D>', StartDate);
                    end;
                TimeIn::"24M":
                    begin
                        ContractPeriodOut := '2' + ' ' + YearsLbl;
                        EndDateOut := CalcDate('<+2Y-1D>', StartDate);
                    end;
                TimeIn::"36M":
                    begin
                        ContractPeriodOut := '3' + ' ' + YearsLbl;
                        EndDateOut := CalcDate('<+3Y-1D>', StartDate);
                    end;
                TimeIn::"48M":
                    begin
                        ContractPeriodOut := '4' + ' ' + YearsLbl;
                        EndDateOut := CalcDate('<+4Y-1D>', StartDate);
                    end;
                TimeIn::"60M":
                    begin
                        ContractPeriodOut := '5' + ' ' + YearsLbl;
                        EndDateOut := CalcDate('<+5Y-1D>', StartDate);
                    end;
            end;
    end;

    procedure GetComercialFEEEnergyAgent(AgentNo: Code[100]; MarketerNo: Code[20]; RateNo: Code[20]; var ComercialFEE: array[6] of Decimal)
    var
        SUCOmipFEEEnergyAgent: Record "SUC Omip FEE Energy Agent";
    begin
        if SUCOmipFEEEnergyAgent.Get(AgentNo, MarketerNo, RateNo) then begin
            ComercialFEE[1] := SUCOmipFEEEnergyAgent.P1;
            ComercialFEE[2] := SUCOmipFEEEnergyAgent.P2;
            ComercialFEE[3] := SUCOmipFEEEnergyAgent.P3;
            ComercialFEE[4] := SUCOmipFEEEnergyAgent.P4;
            ComercialFEE[5] := SUCOmipFEEEnergyAgent.P5;
            ComercialFEE[6] := SUCOmipFEEEnergyAgent.P6;
        end;
    end;

    procedure GetComercialFEESetup(MarketerNo: Code[20]; var ComercialFEE: array[6] of Decimal)
    var
        SUCOmipRatesEntrySetup: Record "SUC Omip Rates Entry Setup";
    begin
        SUCOmipRatesEntrySetup.Get(MarketerNo);
        ComercialFEE[1] := SUCOmipRatesEntrySetup."Min. FEE Energy";
        ComercialFEE[2] := SUCOmipRatesEntrySetup."Min. FEE Energy";
        ComercialFEE[3] := SUCOmipRatesEntrySetup."Min. FEE Energy";
        ComercialFEE[4] := SUCOmipRatesEntrySetup."Min. FEE Energy";
        ComercialFEE[5] := SUCOmipRatesEntrySetup."Min. FEE Energy";
        ComercialFEE[6] := SUCOmipRatesEntrySetup."Min. FEE Energy";
    end;

    procedure GetComercialFEEEnergyDocument(DocumentType: Enum "SUC Omip Document Type"; DocumentNo: Code[20]; MarketerNo: Code[20]; RateNo: Code[20]; var ComercialFEE: array[6] of Decimal)
    var
        SUCOmipFEEEnergyDocument: Record "SUC Omip FEE Energy Document";
    begin
        SUCOmipFEEEnergyDocument.Get(DocumentType, DocumentNo, MarketerNo, RateNo);
        ComercialFEE[1] := SUCOmipFEEEnergyDocument.P1;
        ComercialFEE[2] := SUCOmipFEEEnergyDocument.P2;
        ComercialFEE[3] := SUCOmipFEEEnergyDocument.P3;
        ComercialFEE[4] := SUCOmipFEEEnergyDocument.P4;
        ComercialFEE[5] := SUCOmipFEEEnergyDocument.P5;
        ComercialFEE[6] := SUCOmipFEEEnergyDocument.P6;
    end;

    procedure SetPowerFEEAgentDoc(DocType: Enum "SUC Omip Document Type"; DocNo: Code[20]; MarketerNo: Code[20]; RateNo: Code[20]; AgentNo: Code[100]; FEEGroupId: Code[20])
    var
        SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
        SUCOmipFEEPowerAgent: Record "SUC Omip FEE Power Agent";
        SUCOmipExtUsersGroupsFEE: Record "SUC Omip Ext. Users Groups FEE";
    begin
        if AgentNo <> '' then begin
            ClearPowerFEEDocument(DocType, DocNo, RateNo);

            SUCOmipExtUsersGroupsFEE.Reset();
            SUCOmipExtUsersGroupsFEE.SetRange("User Name", AgentNo);
            if FEEGroupId <> '' then
                SUCOmipExtUsersGroupsFEE.SetRange("Group Id.", FEEGroupId)
            else
                SUCOmipExtUsersGroupsFEE.SetRange(Default, true);
            SUCOmipExtUsersGroupsFEE.FindLast();

            if SUCOmipFEEPowerAgent.Get(AgentNo, SUCOmipExtUsersGroupsFEE."Group Id.", MarketerNo, RateNo) then
                if not SUCOmipFEEPowerDocument.Get(DocType, DocNo, MarketerNo, RateNo) then begin
                    SUCOmipFEEPowerDocument.Init();
                    SUCOmipFEEPowerDocument.Validate("Document Type", DocType);
                    SUCOmipFEEPowerDocument.Validate("Document No.", DocNo);
                    SUCOmipFEEPowerDocument.Validate("Marketer No.", MarketerNo);
                    SUCOmipFEEPowerDocument.Validate("Rate No.", RateNo);
                    SUCOmipFEEPowerDocument.Validate(P1, SUCOmipFEEPowerAgent.P1);
                    SUCOmipFEEPowerDocument.Validate(P2, SUCOmipFEEPowerAgent.P2);
                    SUCOmipFEEPowerDocument.Validate(P3, SUCOmipFEEPowerAgent.P3);
                    SUCOmipFEEPowerDocument.Validate(P4, SUCOmipFEEPowerAgent.P4);
                    SUCOmipFEEPowerDocument.Validate(P5, SUCOmipFEEPowerAgent.P5);
                    SUCOmipFEEPowerDocument.Validate(P6, SUCOmipFEEPowerAgent.P6);
                    SUCOmipFEEPowerDocument.Validate("P1 %", SUCOmipFEEPowerAgent."P1 %");
                    SUCOmipFEEPowerDocument.Validate("P2 %", SUCOmipFEEPowerAgent."P2 %");
                    SUCOmipFEEPowerDocument.Validate("P3 %", SUCOmipFEEPowerAgent."P3 %");
                    SUCOmipFEEPowerDocument.Validate("P4 %", SUCOmipFEEPowerAgent."P4 %");
                    SUCOmipFEEPowerDocument.Validate("P5 %", SUCOmipFEEPowerAgent."P5 %");
                    SUCOmipFEEPowerDocument.Validate("P6 %", SUCOmipFEEPowerAgent."P6 %");
                    SUCOmipFEEPowerDocument.Insert();
                end;
        end;
    end;

    procedure SetEnergyFEEAgentDoc(DocType: Enum "SUC Omip Document Type"; DocNo: Code[20]; MarketerNo: Code[20]; RateNo: Code[20]; AgentNo: Code[100]; FEEGroupId: Code[20])
    var
        SUCOmipFEEEnergyDocument: Record "SUC Omip FEE Energy Document";
        SUCOmipFEEEnergyAgent: Record "SUC Omip FEE Energy Agent";
        SUCOmipExtUsersGroupsFEE: Record "SUC Omip Ext. Users Groups FEE";
    begin
        if AgentNo <> '' then begin
            ClearEnergyFEEDocument(DocType, DocNo, RateNo);

            SUCOmipExtUsersGroupsFEE.Reset();
            SUCOmipExtUsersGroupsFEE.SetRange("User Name", AgentNo);
            if FEEGroupId <> '' then
                SUCOmipExtUsersGroupsFEE.SetRange("Group Id.", FEEGroupId)
            else
                SUCOmipExtUsersGroupsFEE.SetRange(Default, true);
            SUCOmipExtUsersGroupsFEE.FindLast();

            if SUCOmipFEEEnergyAgent.Get(AgentNo, SUCOmipExtUsersGroupsFEE."Group Id.", MarketerNo, RateNo) then
                if not SUCOmipFEEEnergyDocument.Get(DocType, DocNo, MarketerNo, RateNo) then begin
                    SUCOmipFEEEnergyDocument.Init();
                    SUCOmipFEEEnergyDocument.Validate("Document Type", DocType);
                    SUCOmipFEEEnergyDocument.Validate("Document No.", DocNo);
                    SUCOmipFEEEnergyDocument.Validate("Marketer No.", MarketerNo);
                    SUCOmipFEEEnergyDocument.Validate("Rate No.", RateNo);
                    SUCOmipFEEEnergyDocument.Validate(P1, SUCOmipFEEEnergyAgent.P1);
                    SUCOmipFEEEnergyDocument.Validate(P2, SUCOmipFEEEnergyAgent.P2);
                    SUCOmipFEEEnergyDocument.Validate(P3, SUCOmipFEEEnergyAgent.P3);
                    SUCOmipFEEEnergyDocument.Validate(P4, SUCOmipFEEEnergyAgent.P4);
                    SUCOmipFEEEnergyDocument.Validate(P5, SUCOmipFEEEnergyAgent.P5);
                    SUCOmipFEEEnergyDocument.Validate(P6, SUCOmipFEEEnergyAgent.P6);
                    SUCOmipFEEEnergyDocument.Insert();
                end;
        end;
    end;

    local procedure ClearPowerFEEDocument(DocType: Enum "SUC Omip Document Type"; DocNo: Code[20]; RateNo: Code[20])
    var
        SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
    begin
        SUCOmipFEEPowerDocument.Reset();
        SUCOmipFEEPowerDocument.SetRange("Document Type", DocType);
        SUCOmipFEEPowerDocument.SetRange("Document No.", DocNo);
        SUCOmipFEEPowerDocument.SetRange("Rate No.", RateNo);
        SUCOmipFEEPowerDocument.DeleteAll();
    end;

    local procedure ClearEnergyFEEDocument(DocType: Enum "SUC Omip Document Type"; DocNo: Code[20]; RateNo: Code[20])
    var
        SUCOmipFEEEnergyDocument: Record "SUC Omip FEE Energy Document";
    begin
        SUCOmipFEEEnergyDocument.Reset();
        SUCOmipFEEEnergyDocument.SetRange("Document Type", DocType);
        SUCOmipFEEEnergyDocument.SetRange("Document No.", DocNo);
        SUCOmipFEEEnergyDocument.SetRange("Rate No.", RateNo);
        SUCOmipFEEEnergyDocument.DeleteAll();
    end;

    [Obsolete('Pending removal use IsCustomerDuplicate2', '25.3')]
    procedure IsCustomerDuplicate(email: Text[80]; phoneNo: Text[30]; vatRegistrationNo: Text[20]): Boolean
    begin
    end;

    procedure IsCustomerDuplicate2(customerNo: Code[20]; email: Text[80]; phoneNo: Text[30]; vatRegistrationNo: Text[20]): Boolean
    var
        Customer: Record Customer;
    begin
        Customer.Reset();
        Customer.SetRange("E-Mail", email);
        Customer.SetFilter("No.", '<>%1', customerNo);
        if not Customer.IsEmpty then
            exit(true);

        if phoneNo <> '' then begin
            Customer.Reset();
            Customer.SetRange("Phone No.", phoneNo);
            Customer.SetFilter("No.", '<>%1', customerNo);
            if not Customer.IsEmpty then
                exit(true);
        end;

        if vatRegistrationNo <> '' then begin
            Customer.Reset();
            Customer.SetRange("VAT Registration No.", vatRegistrationNo);
            Customer.SetFilter("No.", '<>%1', customerNo);
            if not Customer.IsEmpty then
                exit(true);
        end;

        exit(false);
    end;

    procedure SendDuplicateCustomerConfirmation(CustomerIn: Record Customer)
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        SUCOmipSetup: Record "SUC Omip Setup";
        EmailScenario: Enum "Email Scenario";
        BodyEmail: Text;
        RecipientsMail: Text;
        SubjectLbl: Label 'Confirmation of duplicate clients';
        instream: InStream;
    begin
        SUCOmipSetup.Get();
        CustomerIn.TestField("Agent No.");
        SUCOmipExternalUsers.Get(CustomerIn."Agent No.");
        SUCOmipExternalUsers.TestField("Contact Email");
        BodyEmail := '<p><strong>CONFIRMACIÓN DE CLIENTE DUPLICADO</strong></p> ' +
                         '<p><strong>Se ha confirmado el cliente: </strong>' + CustomerIn."No." + '&nbsp;</p>' +
                         '<p><strong>Email: </strong>' + CustomerIn."E-Mail" + '&nbsp;</p>' +
                         '<p><strong>Teléfono: </strong>' + CustomerIn."Phone No." + '&nbsp;</p>' +
                         '<p><strong>Número de identificación: </strong>' + CustomerIn."VAT Registration No." + '&nbsp;</p>' +
                         '<p>Ya puedes realizar documentos desde E-PRO.&nbsp;</p>';

        RecipientsMail := SUCOmipExternalUsers."Contact Email";
        if SUCOmipSetup."Email Duplicate Customers" <> '' then
            RecipientsMail += ';' + SUCOmipSetup."Email Duplicate Customers";

        SendEMailMessage(RecipientsMail, SubjectLbl, BodyEmail, false, '', '', instream, EmailScenario::"Omip Duplicate Customer");
    end;

    procedure GetDataSIPS(CUPS: Text[25]; var ArrayPotence: array[6] of Decimal; var ArraykWhAnual: array[6] of Decimal; var RateNo: Text): Boolean
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        HttpVarHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        JsonObject: JsonObject;
        Url: Text;
        ResponseText: Text;
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("URL SIPS");
        Clear(ArrayPotence);
        Clear(ArraykWhAnual);
        if CUPS <> '' then begin
            Url := SUCOmipSetup."URL SIPS";
            Url := Url.Replace('{CUPS}', CUPS);

            HttpVarHeaders.Clear();
            HttpRequestMessage.GetHeaders(HttpVarHeaders);
            HttpVarHeaders.Add('User-Agent', 'PostmanRuntime/7.42.0');
            HttpRequestMessage.Method('GET');
            HttpRequestMessage.SetRequestUri(Url);
            Clear(JsonObject);
            if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
                HttpResponseMessage.Content().ReadAs(ResponseText);
                if JsonObject.ReadFrom(ResponseText) then begin
                    SetPowerEntryFromJson(ResponseText, ArrayPotence, ArraykWhAnual, RateNo);
                    exit(true);
                end else
                    exit(false);
            end else
                exit(false);
        end else
            exit(false);
    end;

    procedure SetDefaultsFEEExternalUsers(SUCOmipExternalUsersIn: Record "SUC Omip External Users")
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        SUCOmipRatesEntrySetup: Record "SUC Omip Rates Entry Setup";
    begin
        SUCOmipExternalUsers.Get(SUCOmipExternalUsersIn."User Name");

        ClearFEEsAgent(SUCOmipExternalUsers."User Name");

        SUCOmipRatesEntrySetup.Reset();
        if SUCOmipExternalUsers."Filter Marketer" then
            SUCOmipRatesEntrySetup.SetFilter("Marketer No.", SUCOmipExternalUsers."Marketer No.");
        if SUCOmipRatesEntrySetup.FindSet() then
            repeat
                SetOmipFEEPowerAgentDefault(SUCOmipExternalUsers."User Name", SUCOmipRatesEntrySetup, true, '');
                SetOmipFEEEnergyAgentDefault(SUCOmipExternalUsers."User Name", SUCOmipRatesEntrySetup, true, '');
            until SUCOmipRatesEntrySetup.Next() = 0;
    end;

    procedure ValidateFEEExternalUsers(SUCOmipExternalUsersIn: Record "SUC Omip External Users"; ByAssignGroups: Boolean; GroupId: Code[20])
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        SUCOmipRatesEntrySetup: Record "SUC Omip Rates Entry Setup";
    begin
        SUCOmipExternalUsers.Get(SUCOmipExternalUsersIn."User Name");

        SUCOmipRatesEntrySetup.Reset();
        if SUCOmipExternalUsers."Filter Marketer" then
            SUCOmipRatesEntrySetup.SetFilter("Marketer No.", SUCOmipExternalUsers."Marketer No.");
        if SUCOmipRatesEntrySetup.FindSet() then
            repeat
                SetOmipFEEPowerAgentDefault(SUCOmipExternalUsers."User Name", SUCOmipRatesEntrySetup, ByAssignGroups, GroupId);
                SetOmipFEEEnergyAgentDefault(SUCOmipExternalUsers."User Name", SUCOmipRatesEntrySetup, ByAssignGroups, GroupId);
            until SUCOmipRatesEntrySetup.Next() = 0;
    end;

    procedure ValidateFEEExternalUsersByMarketer(UserName: Code[100]; FilterMarketer: Boolean; MarketerNo: Code[100]; ByAssignGroups: Boolean; GroupId: Code[20])
    var
        SUCOmipRatesEntrySetup: Record "SUC Omip Rates Entry Setup";
    begin
        SUCOmipRatesEntrySetup.Reset();
        if FilterMarketer then begin
            ClearFEEsAgentOtherMarketers(UserName, MarketerNo);
            if MarketerNo <> '' then
                SUCOmipRatesEntrySetup.SetFilter("Marketer No.", MarketerNo)
            else
                SUCOmipRatesEntrySetup.SetRange("Marketer No.", MarketerNo);
        end;
        if SUCOmipRatesEntrySetup.FindSet() then
            repeat
                SetOmipFEEPowerAgentDefault(UserName, SUCOmipRatesEntrySetup, ByAssignGroups, GroupId);
                SetOmipFEEEnergyAgentDefault(UserName, SUCOmipRatesEntrySetup, ByAssignGroups, GroupId);
            until SUCOmipRatesEntrySetup.Next() = 0;
    end;

    local procedure SetOmipFEEPowerAgentDefault(UserName: Code[100]; SUCOmipRatesEntrySetupIn: Record "SUC Omip Rates Entry Setup"; ByAssignGroups: Boolean; GroupId: Code[20])
    var
        SUCOmipRates: Record "SUC Omip Rates";
        SUCOmipExtUsersGroupsFEE: Record "SUC Omip Ext. Users Groups FEE";
    begin
        SUCOmipRates.Reset();
        SUCOmipRates.SetFilter(Code, '%1|%2|%3|%4|%5|%6', '2.0TD', '3.0TD', '6.1TD', '6.2TD', '6.3TD', '6.4TD');
        if SUCOmipRates.FindSet() then
            repeat
                if ByAssignGroups then begin
                    SUCOmipExtUsersGroupsFEE.Reset();
                    SUCOmipExtUsersGroupsFEE.SetRange("User Name", UserName);
                    if SUCOmipExtUsersGroupsFEE.FindSet() then
                        repeat
                            SetNewOmipFEEPowerAgent(SUCOmipRatesEntrySetupIn, UserName, SUCOmipExtUsersGroupsFEE."Group Id.", SUCOmipRates.Code, SUCOmipRates."No. Potency");
                        until SUCOmipExtUsersGroupsFEE.Next() = 0;
                end else
                    SetNewOmipFEEPowerAgent(SUCOmipRatesEntrySetupIn, UserName, GroupId, SUCOmipRates.Code, SUCOmipRates."No. Potency");
            until SUCOmipRates.Next() = 0;
    end;

    local procedure SetNewOmipFEEPowerAgent(SUCOmipRatesEntrySetupIn: Record "SUC Omip Rates Entry Setup"; AgentNo: Code[100]; GroupId: Code[20]; RateNo: Code[20]; SUCOmipHiredPotency: Enum "SUC Omip Hired Potency")
    var
        SUCOmipFEEPowerAgent: Record "SUC Omip FEE Power Agent";
    begin
        if not SUCOmipFEEPowerAgent.Get(AgentNo, GroupId, SUCOmipRatesEntrySetupIn."Marketer No.", RateNo) then begin
            SUCOmipFEEPowerAgent.Init();
            SUCOmipFEEPowerAgent.Validate("Agent No.", AgentNo);
            SUCOmipFEEPowerAgent.Validate("FEE Group Id.", GroupId);
            SUCOmipFEEPowerAgent.Validate("Marketer No.", SUCOmipRatesEntrySetupIn."Marketer No.");
            SUCOmipFEEPowerAgent.Validate("Rate No.", RateNo);
            SUCOmipFEEPowerAgent.Insert();
            case SUCOmipHiredPotency of
                SUCOmipHiredPotency::P1:
                    SUCOmipFEEPowerAgent.Validate(P1, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                SUCOmipHiredPotency::P2:
                    begin
                        SUCOmipFEEPowerAgent.Validate(P1, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P2, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                    end;
                SUCOmipHiredPotency::P3:
                    begin
                        SUCOmipFEEPowerAgent.Validate(P1, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P2, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P3, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                    end;
                SUCOmipHiredPotency::P4:
                    begin
                        SUCOmipFEEPowerAgent.Validate(P1, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P2, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P3, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P4, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                    end;
                SUCOmipHiredPotency::P5:
                    begin
                        SUCOmipFEEPowerAgent.Validate(P1, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P2, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P3, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P4, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P5, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                    end;
                SUCOmipHiredPotency::P6:
                    begin
                        SUCOmipFEEPowerAgent.Validate(P1, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P2, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P3, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P4, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P5, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                        SUCOmipFEEPowerAgent.Validate(P6, SUCOmipRatesEntrySetupIn."Min. FEE Potency");
                    end;
            end;
            SUCOmipFEEPowerAgent.Modify();
        end;
    end;

    local procedure SetOmipFEEEnergyAgentDefault(UserName: Code[100]; SUCOmipRatesEntrySetupIn: Record "SUC Omip Rates Entry Setup"; ByAssignGroups: Boolean; GroupId: Code[20])
    var
        SUCOmipRates: Record "SUC Omip Rates";
        SUCOmipExtUsersGroupsFEE: Record "SUC Omip Ext. Users Groups FEE";
    begin
        SUCOmipRates.Reset();
        SUCOmipRates.SetFilter(Code, '%1|%2|%3|%4|%5|%6', '2.0TD', '3.0TD', '6.1TD', '6.2TD', '6.3TD', '6.4TD');
        if SUCOmipRates.FindSet() then
            repeat
                if ByAssignGroups then begin
                    SUCOmipExtUsersGroupsFEE.Reset();
                    SUCOmipExtUsersGroupsFEE.SetRange("User Name", UserName);
                    if SUCOmipExtUsersGroupsFEE.FindSet() then
                        repeat
                            SetNewOmipFEEEnergyAgent(SUCOmipRatesEntrySetupIn, UserName, SUCOmipExtUsersGroupsFEE."Group Id.", SUCOmipRates.Code, SUCOmipRates."No. Consumption");
                        until SUCOmipExtUsersGroupsFEE.Next() = 0;
                end else
                    SetNewOmipFEEEnergyAgent(SUCOmipRatesEntrySetupIn, UserName, GroupId, SUCOmipRates.Code, SUCOmipRates."No. Consumption");
            until SUCOmipRates.Next() = 0;
    end;

    local procedure SetNewOmipFEEEnergyAgent(SUCOmipRatesEntrySetupIn: Record "SUC Omip Rates Entry Setup"; AgentNo: Code[100]; GroupId: Code[20]; RateNo: Code[20]; SUCOmipHiredPotency: Enum "SUC Omip Hired Potency")
    var
        SUCOmipFEEEnergyAgent: Record "SUC Omip FEE Energy Agent";
    begin
        if not SUCOmipFEEEnergyAgent.Get(AgentNo, GroupId, SUCOmipRatesEntrySetupIn."Marketer No.", RateNo) then begin
            SUCOmipFEEEnergyAgent.Init();
            SUCOmipFEEEnergyAgent.Validate("Agent No.", AgentNo);
            SUCOmipFEEEnergyAgent.Validate("FEE Group Id.", GroupId);
            SUCOmipFEEEnergyAgent.Validate("Marketer No.", SUCOmipRatesEntrySetupIn."Marketer No.");
            SUCOmipFEEEnergyAgent.Validate("Rate No.", RateNo);
            SUCOmipFEEEnergyAgent.Insert();
            case SUCOmipHiredPotency of
                SUCOmipHiredPotency::P1:
                    SUCOmipFEEEnergyAgent.Validate(P1, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                SUCOmipHiredPotency::P2:
                    begin
                        SUCOmipFEEEnergyAgent.Validate(P1, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P2, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                    end;
                SUCOmipHiredPotency::P3:
                    begin
                        SUCOmipFEEEnergyAgent.Validate(P1, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P2, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P3, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                    end;
                SUCOmipHiredPotency::P4:
                    begin
                        SUCOmipFEEEnergyAgent.Validate(P1, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P2, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P3, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P4, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                    end;
                SUCOmipHiredPotency::P5:
                    begin
                        SUCOmipFEEEnergyAgent.Validate(P1, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P2, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P3, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P4, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P5, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                    end;
                SUCOmipHiredPotency::P6:
                    begin
                        SUCOmipFEEEnergyAgent.Validate(P1, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P2, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P3, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P4, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P5, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                        SUCOmipFEEEnergyAgent.Validate(P6, SUCOmipRatesEntrySetupIn."Min. FEE Energy");
                    end;
            end;
            SUCOmipFEEEnergyAgent.Modify();
        end;
    end;

    procedure CalculateRealFEEEnergy(DocumentType: Enum "SUC Omip Document Type"; DocumentNo: Code[20])
    var
        SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
    begin
        SUCOmipConsumptionDeclared.Reset();
        SUCOmipConsumptionDeclared.SetRange("Document Type", DocumentType);
        SUCOmipConsumptionDeclared.SetRange("Document No.", DocumentNo);
        if SUCOmipConsumptionDeclared.FindSet() then
            repeat
                SUCOmipConsumptionDeclared.CalculateRealFEE();
                SUCOmipConsumptionDeclared."From Update Prices" := true;
                SUCOmipConsumptionDeclared.Modify();
            until SUCOmipConsumptionDeclared.Next() = 0;
    end;

    procedure ValidateWithSIPSInformation(DocumentType: Enum "SUC Omip Document Type"; DocumentNo: Code[20]; RateNo: Code[20]; var WithSIPSInfo: Boolean; var EnergyCalculationMatrix: array[6] of Decimal; var RealFEE: array[6] of Decimal)
    var
        SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
        NumRows: Integer;
    begin
        Clear(EnergyCalculationMatrix);
        Clear(RealFEE);
        Clear(NumRows);
        WithSIPSInfo := false;
        SUCOmipConsumptionDeclared.Reset();
        SUCOmipConsumptionDeclared.SetRange("Document Type", DocumentType);
        SUCOmipConsumptionDeclared.SetRange("Document No.", DocumentNo);
        SUCOmipConsumptionDeclared.SetRange("Rate No.", RateNo);
        if SUCOmipConsumptionDeclared.FindSet() then
            repeat
                EnergyCalculationMatrix[1] += SUCOmipConsumptionDeclared."P1 %";
                EnergyCalculationMatrix[2] += SUCOmipConsumptionDeclared."P2 %";
                EnergyCalculationMatrix[3] += SUCOmipConsumptionDeclared."P3 %";
                EnergyCalculationMatrix[4] += SUCOmipConsumptionDeclared."P4 %";
                EnergyCalculationMatrix[5] += SUCOmipConsumptionDeclared."P5 %";
                EnergyCalculationMatrix[6] += SUCOmipConsumptionDeclared."P6 %";

                RealFEE[1] += SUCOmipConsumptionDeclared."Real FEE P1";
                RealFEE[2] += SUCOmipConsumptionDeclared."Real FEE P2";
                RealFEE[3] += SUCOmipConsumptionDeclared."Real FEE P3";
                RealFEE[4] += SUCOmipConsumptionDeclared."Real FEE P4";
                RealFEE[5] += SUCOmipConsumptionDeclared."Real FEE P5";
                RealFEE[6] += SUCOmipConsumptionDeclared."Real FEE P6";

                if SUCOmipConsumptionDeclared."SIPS Information" then
                    WithSIPSInfo := true;
                NumRows += 1;
            until SUCOmipConsumptionDeclared.Next() = 0;
        if NumRows > 0 then begin
            EnergyCalculationMatrix[1] := EnergyCalculationMatrix[1] / NumRows;
            EnergyCalculationMatrix[2] := EnergyCalculationMatrix[2] / NumRows;
            EnergyCalculationMatrix[3] := EnergyCalculationMatrix[3] / NumRows;
            EnergyCalculationMatrix[4] := EnergyCalculationMatrix[4] / NumRows;
            EnergyCalculationMatrix[5] := EnergyCalculationMatrix[5] / NumRows;
            EnergyCalculationMatrix[6] := EnergyCalculationMatrix[6] / NumRows;

            RealFEE[1] := RealFEE[1] / NumRows;
            RealFEE[2] := RealFEE[2] / NumRows;
            RealFEE[3] := RealFEE[3] / NumRows;
            RealFEE[4] := RealFEE[4] / NumRows;
            RealFEE[5] := RealFEE[5] / NumRows;
            RealFEE[6] := RealFEE[6] / NumRows;
        end;
    end;

    [Obsolete('Replaced by GetContractApplicableConditions2', '25.08')]
    procedure GetContractApplicableConditions(OmipContractIn: Boolean; MarketerNoIn: Code[20]; TimeIn: Enum "SUC Omip Times"; MulticupsIn: Boolean; SupplyStartDate: Date; var TittleAppConditionsOut: Text[250]; var AppConditionsOut: Text)
    begin
    end;

    procedure GetContractApplicableConditions2(SUCProductType: Enum "SUC Product Type"; MarketerNoIn: Code[20]; TimeIn: Enum "SUC Omip Times"; MulticupsIn: Boolean; SupplyStartDate: Date; var TittleAppConditionsOut: Text[250]; var AppConditionsOut: Text)
    var
        SUCOmipRatesEntrySetup: Record "SUC Omip Rates Entry Setup";
        ApplicableConditions: Text;
        ContractPeriod: Text;
        EndDate: Date;
    // ErrorNotFoundTimeLbl: Label 'Not found time set contract applicable conditions';
    begin
        case SUCProductType of
            SUCProductType::Omip, SUCProductType::"Energy (Light - Gas)":
                begin
                    SUCOmipRatesEntrySetup.Get(MarketerNoIn);
                    SUCOmipRatesEntrySetup.TestField("Tittle Applicable Conditions");

                    Clear(ApplicableConditions);
                    case TimeIn of
                        TimeIn::" ":
                            ApplicableConditions := '';
                        TimeIn::"12M":
                            if MulticupsIn then begin
                                SUCOmipRatesEntrySetup.TestField("Body App. Conditions 12MC");
                                ApplicableConditions := SUCOmipRatesEntrySetup.GetDataValueBlob(SUCOmipRatesEntrySetup.FieldNo("Body App. Conditions 12MC"));
                            end else begin
                                SUCOmipRatesEntrySetup.TestField("Body App. Conditions 12M");
                                ApplicableConditions := SUCOmipRatesEntrySetup.GetDataValueBlob(SUCOmipRatesEntrySetup.FieldNo("Body App. Conditions 12M"));
                            end;
                        else
                            if MulticupsIn then begin
                                SUCOmipRatesEntrySetup.TestField("Body App. Conditions +12MC");
                                ApplicableConditions := SUCOmipRatesEntrySetup.GetDataValueBlob(SUCOmipRatesEntrySetup.FieldNo("Body App. Conditions +12MC"));
                            end else begin
                                SUCOmipRatesEntrySetup.TestField("Body App. Conditions +12M");
                                ApplicableConditions := SUCOmipRatesEntrySetup.GetDataValueBlob(SUCOmipRatesEntrySetup.FieldNo("Body App. Conditions +12M"));
                            end;
                    end;

                    GetDataFromTime(TimeIn, SupplyStartDate, ContractPeriod, EndDate);

                    ApplicableConditions := ApplicableConditions.Replace('{ContractPeriod}', ContractPeriod);
                    ApplicableConditions := ApplicableConditions.Replace('{SupplyStartDate}', Format(SupplyStartDate, 0, '<Day> de <Month Text> de <Year4>'));
                    ApplicableConditions := ApplicableConditions.Replace('{EndDate}', Format(EndDate, 0, '<Day> de <Month Text> de <Year4>'));

                    TittleAppConditionsOut := SUCOmipRatesEntrySetup."Tittle Applicable Conditions";
                    AppConditionsOut := ApplicableConditions;
                end;
        end;
    end;

    procedure SetContractApplicableConditions(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        TittleAppConditions: Text[250];
        AppConditions: Text;
    begin
        SUCOmipEnergyContracts.Get(SUCOmipEnergyContractsIn."No.");
        GetContractApplicableConditions2(SUCOmipEnergyContracts."Product Type", SUCOmipEnergyContracts."Marketer No.", SUCOmipEnergyContracts.Times, SUCOmipEnergyContracts.Multicups, SUCOmipEnergyContracts."Supply Start Date", TittleAppConditions, AppConditions);
        SUCOmipEnergyContracts."Tittle Applicable Conditions" := TittleAppConditions;
        SUCOmipEnergyContracts.SetDataBlob(SUCOmipEnergyContracts.FieldNo("Body Applicable Conditions"), AppConditions);
    end;

    procedure SendContractPlenitude(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        Customer: Record Customer;
        PostCode: Record "Post Code";
        SUCOmipRates: Record "SUC Omip Rates";
        SUCOmipLanguages: Record "SUC Omip Languages";
        CountryRegion: Record "Country/Region";
        idDistributorLogin: Text[20];
        token: Text[100];
        ContractedPower: array[6] of Decimal;
        IdContratationType: Integer;
        AnualConsumption: Decimal;
        RateNo: Text[20];
        nameProvince: Text[50];
        nameLocality: Text[50];
        nameDistributor: Text[50];
        Hireable: Boolean;
        idDistributorCRM: Integer;
        idRateAccessCRM: Integer;
        idProvince: Integer;
        idLocality: Integer;
        // idDistributor: Integer;
        SIPSNullData: Boolean;
    begin
        SUCOmipEnergyContracts.Get(SUCOmipEnergyContractsIn."No.");
        SUCOmipEnergyContracts.TestField("Agent No.");
        SUCOmipEnergyContracts.TestField("Customer No.");
        SUCOmipEnergyContracts.TestField("Customer CUPS");
        SUCOmipEnergyContracts.TestField("SUC Supply Point Post Code");
        SUCOmipEnergyContracts.TestField("Rate No.");
        SUCOmipEnergyContracts.TestField("Language Code");

        SUCOmipExternalUsers.Get(SUCOmipEnergyContracts."Agent No.");
        SUCOmipExternalUsers.TestField("Id. Commercial Plenitude");

        Customer.Get(SUCOmipEnergyContracts."Customer No.");
        Customer.TestField("Country/Region Code");

        SUCOmipLanguages.Get(SUCOmipEnergyContracts."SUC Supply Point Country", SUCOmipEnergyContracts."Language Code");
        SUCOmipLanguages.TestField("Id. Plenitude");

        CountryRegion.Get(SUCOmipEnergyContracts."SUC Supply Point Country");
        CountryRegion.TestField("SUC Id. Country Plenitude");

        case SUCOmipEnergyContracts."Energy Type" of
            SUCOmipEnergyContracts."Energy Type"::Electricity:
                IdContratationType := 1;
            SUCOmipEnergyContracts."Energy Type"::Gas:
                IdContratationType := 2;
        end;

        SUCOmipRates.Get(SUCOmipEnergyContracts."Rate No.");

        GetLoginPlenitude(token, idDistributorLogin);

        GetDataSIPSPlenitude(token, SUCOmipEnergyContracts."Customer CUPS", Customer."Country/Region Code", IdContratationType, ContractedPower, AnualConsumption, RateNo, Hireable, idDistributorCRM, idRateAccessCRM, SIPSNullData);

        PostCode.Reset();
        PostCode.SetRange(Code, SUCOmipEnergyContracts."SUC Supply Point Post Code");
        PostCode.FindLast();
        if PostCode."SUC Id. Province Plenitude" = 0 then begin
            GetProvincePlenitude(token, SUCOmipEnergyContracts."SUC Supply Point Post Code", Customer."Country/Region Code", idProvince, nameProvince);
            SetProvincePlenitude(SUCOmipEnergyContracts."SUC Supply Point Post Code", idProvince);
        end else
            idProvince := PostCode."SUC Id. Province Plenitude";

        if PostCode."SUC Id. Locality Plenitude" = 0 then begin
            GetLocalityPlenitude(token, SUCOmipEnergyContracts."SUC Supply Point Post Code", Customer."Country/Region Code", idLocality, nameLocality);
            SetLocalityPlenitude(SUCOmipEnergyContracts."SUC Supply Point Post Code", idLocality);
        end else
            idLocality := PostCode."SUC Id. Locality Plenitude";

        if SIPSNullData then
            GetDistributorPlenitude(token, SUCOmipEnergyContracts."Customer CUPS", idProvince, IdContratationType, Customer."Country/Region Code", idDistributorCRM, nameDistributor);

        if (SUCOmipRates."Id. Plenitude" = 0) and (idRateAccessCRM = 0) then
            GetRatePlenitude(SUCOmipEnergyContracts."Rate No.", token, Customer."Customer Type Plenitude".AsInteger(), IdContratationType, idDistributorLogin, Customer."Country/Region Code", idRateAccessCRM);

        SetSuppyContractValidatePlenitude(token, Customer."Customer Type Plenitude".AsInteger(), SUCOmipEnergyContracts."Energy Use", SUCOmipLanguages."Id. Plenitude", SUCOmipExternalUsers."Id. Commercial Plenitude", idRateAccessCRM, SUCOmipEnergyContracts."Customer CUPS", SUCOmipEnergyContracts."SUC Supply Point Address",
                                          idProvince, SUCOmipEnergyContracts."SUC Supply Point Post Code", idLocality, ContractedPower, AnualConsumption, idDistributorCRM, IdContratationType, Customer,
                                          CountryRegion."SUC Id. Country Plenitude");
    end;

    local procedure GetLoginPlenitude(var token: Text[100]; var idDistributor: Text[20])
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        JsonToken2: JsonToken;
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        HttpContent: HttpContent;
        jsonRequest: Text;
        ResponseText: Text;
        ErrorDataLoginLbl: Label 'Error: "Data" object not found in the response "GetLoginPlenitude".';
        ErrorInvalidJsonLbl: Label 'Error: Invalid JSON response from the method "GetLoginPlenitude".';
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("URL Plenitude");
        SUCOmipSetup.TestField("User Plenitude");
        SUCOmipSetup.TestField("Password Plenitude");
        SUCOmipSetup.TestField("Version Plenitude");

        Clear(JsonObject);
        JsonObject.Add('usuario', SUCOmipSetup."User Plenitude");
        JsonObject.Add('pass', SUCOmipSetup."Password Plenitude");
        JsonObject.Add('version', SUCOmipSetup."Version Plenitude");


        JsonObject.WriteTo(jsonRequest);

        HttpContent.WriteFrom(jsonRequest);
        HttpContent.GetHeaders(Headers);
        Headers.Remove('Content-type');
        Headers.Add('Content-type', 'application/json');

        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.SetRequestUri(SUCOmipSetup."URL Plenitude" + '/login');
        HttpRequestMessage.Method := 'POST';

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(ResponseText);

        if JsonObject.ReadFrom(ResponseText) then begin
            if JsonObject.Get('Data', JsonToken) then begin
                if JsonToken.AsObject().Get('token', JsonToken2) then
                    token := CopyStr(JsonToken2.AsValue().AsText(), 1, 100);

                if JsonToken.AsObject().Get('id_distribuidor', JsonToken2) then
                    idDistributor := CopyStr(JsonToken2.AsValue().AsText(), 1, 20);
            end else
                Error(ErrorDataLoginLbl);
        end else
            Error(ErrorInvalidJsonLbl);
    end;

    procedure GetCommercialsPlenitude()
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCCommercialsPlenitude: Record "SUC Commercials Plenitude";
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        JsonCommercial: JsonObject;
        jsonRequest: Text;
        token: Text[100];
        idDistributor: Text[20];
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        HttpContent: HttpContent;
        ResponseText: Text;
        id: Text[20];
        user: Text[50];
        ErrorNotFoundLbl: Label 'Error: "Comerciales" array not found in the response "GetCommercialsPlenitude".';
        ErrorInvalidJsonLbl: Label 'Error: Invalid JSON response from the method "GetCommercialsPlenitude".';
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("URL Plenitude");
        SUCOmipSetup.TestField("User Plenitude");
        SUCOmipSetup.TestField("Password Plenitude");
        SUCOmipSetup.TestField("Version Plenitude");

        GetLoginPlenitude(token, idDistributor);

        Clear(JsonObject);
        JsonObject.Add('id_distribuidor', idDistributor);
        JsonObject.Add('accessToken', token);
        JsonObject.Add('version', SUCOmipSetup."Version Plenitude");

        JsonObject.WriteTo(jsonRequest);

        HttpContent.WriteFrom(jsonRequest);
        HttpContent.GetHeaders(Headers);
        Headers.Remove('Content-type');
        Headers.Add('Content-type', 'application/json');

        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.SetRequestUri(SUCOmipSetup."URL Plenitude" + '/traer/comerciales/distribuidor');
        HttpRequestMessage.Method := 'POST';

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(ResponseText);

        if JsonObject.ReadFrom(ResponseText) then begin
            if JsonObject.Get('Comerciales', JsonToken) then begin
                JsonArray := JsonToken.AsArray();
                foreach JsonToken in JsonArray do begin
                    JsonCommercial := JsonToken.AsObject();
                    if JsonCommercial.Get('id', JsonToken) then
                        id := CopyStr(JsonToken.AsValue().AsText(), 1, 20);
                    if JsonCommercial.Get('usuario', JsonToken) then
                        user := CopyStr(JsonToken.AsValue().AsText(), 1, 50);

                    if not SUCCommercialsPlenitude.Get(id) then begin
                        SUCCommercialsPlenitude.Init();
                        SUCCommercialsPlenitude.Validate("Id.", id);
                        SUCCommercialsPlenitude.Validate(user, user);
                        SUCCommercialsPlenitude.Insert();
                    end;
                end;
            end else
                Error(ErrorNotFoundLbl);
        end else
            Error(ErrorInvalidJsonLbl);
    end;

    local procedure GetDataSIPSPlenitude(token: Text[100]; CUPS: Text[25]; CustomerCountry: Text[10]; IdContratationType: Integer; var contractedPower: array[6] of Decimal; var anualConsumption: Decimal; var rateNo: Text[20]; var hireable: Boolean; var idDistributorCRM: Integer; var idRateAccessCRM: Integer; var isNullData: Boolean)
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        JsonToken2: JsonToken;
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        HttpContent: HttpContent;
        jsonRequest: Text;
        ResponseText: Text;
        HireableTxt: Text;
        ResponseError: Text;
        ErrorInvalidJsonLbl: Label 'Error: Invalid JSON response from the method "GetDataSIPSPlenitude".';
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("URL Plenitude");
        SUCOmipSetup.TestField("User Plenitude");
        SUCOmipSetup.TestField("Password Plenitude");
        SUCOmipSetup.TestField("Version Plenitude");

        Clear(contractedPower);
        Clear(rateNo);
        Clear(HireableTxt);
        Clear(JsonObject);
        JsonObject.Add('accessToken', token);
        JsonObject.Add('version', SUCOmipSetup."Version Plenitude");
        JsonObject.Add('cups', CUPS);
        JsonObject.Add('pais', LowerCase(CustomerCountry));
        JsonObject.Add('idTipoContratacion', IdContratationType);

        JsonObject.WriteTo(jsonRequest);

        HttpContent.WriteFrom(jsonRequest);
        HttpContent.GetHeaders(Headers);
        Headers.Remove('Content-type');
        Headers.Add('Content-type', 'application/json');

        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.SetRequestUri(SUCOmipSetup."URL Plenitude" + '/consultar/datos/sips');
        HttpRequestMessage.Method := 'POST';

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(ResponseText);

        if JsonObject.ReadFrom(ResponseText) then begin
            if JsonObject.Get('Error', JsonToken) then begin
                ResponseError := JsonToken.AsValue().AsText();
                Error('GetDataSIPSPlenitude: %1', ResponseError);
            end else
                if JsonObject.Get('Data', JsonToken) then begin
                    if JsonToken.AsObject().Get('potcontratada_p1', JsonToken2) then
                        if not JsonToken2.AsValue().IsNull then
                            contractedPower[1] := JsonToken2.AsValue().AsDecimal()
                        else
                            contractedPower[1] := 0;
                    if JsonToken.AsObject().Get('potcontratada_p2', JsonToken2) then
                        if not JsonToken2.AsValue().IsNull then
                            contractedPower[2] := JsonToken2.AsValue().AsDecimal()
                        else
                            contractedPower[2] := 0;
                    if JsonToken.AsObject().Get('potcontratada_p3', JsonToken2) then
                        if not JsonToken2.AsValue().IsNull then
                            contractedPower[3] := JsonToken2.AsValue().AsDecimal()
                        else
                            contractedPower[3] := 0;
                    if JsonToken.AsObject().Get('potcontratada_p4', JsonToken2) then
                        if not JsonToken2.AsValue().IsNull then
                            contractedPower[4] := JsonToken2.AsValue().AsDecimal()
                        else
                            contractedPower[4] := 0;
                    if JsonToken.AsObject().Get('potcontratada_p5', JsonToken2) then
                        if not JsonToken2.AsValue().IsNull then
                            contractedPower[5] := JsonToken2.AsValue().AsDecimal()
                        else
                            contractedPower[5] := 0;
                    if JsonToken.AsObject().Get('potcontratada_p6', JsonToken2) then
                        if not JsonToken2.AsValue().IsNull then
                            contractedPower[6] := JsonToken2.AsValue().AsDecimal()
                        else
                            contractedPower[6] := 0;

                    if JsonToken.AsObject().Get('ConsumoAnual', JsonToken2) then
                        if not JsonToken2.AsValue().IsNull then
                            anualConsumption := JsonToken2.AsValue().AsDecimal()
                        else
                            anualConsumption := 0;

                    if JsonToken.AsObject().Get('tarifa_atr', JsonToken2) then
                        if not JsonToken2.AsValue().IsNull then
                            rateNo := CopyStr(JsonToken2.AsValue().AsText(), 1, 20);

                    if JsonToken.AsObject().Get('contratable', JsonToken2) then
                        if not JsonToken2.AsValue().IsNull then
                            HireableTxt := JsonToken2.AsValue().AsText();

                    case HireableTxt of
                        'Si':
                            hireable := true;
                        else
                            hireable := false;
                    end;

                    if JsonToken.AsObject().Get('id_distribuidora_crm', JsonToken2) then
                        if not JsonToken2.AsValue().IsNull then
                            idDistributorCRM := JsonToken2.AsValue().AsInteger()
                        else
                            isNullData := true;

                    if JsonToken.AsObject().Get('id_tarifa_acceso_crm', JsonToken2) then
                        if not JsonToken2.AsValue().IsNull then
                            idRateAccessCRM := JsonToken2.AsValue().AsInteger()
                        else
                            isNullData := true;

                end else
                    Error(ResponseText);
        end else
            Error(ErrorInvalidJsonLbl);
    end;

    local procedure GetProvincePlenitude(token: Text[100]; PostalCode: Code[20]; CustomerCountry: Text[10]; var idProvince: Integer; var nameProvince: Text[50])
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        JsonCommercial: JsonObject;
        jsonRequest: Text;
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        HttpContent: HttpContent;
        ResponseText: Text;
        ErrorInvalidJsonLbl: Label 'Error: Invalid JSON response from the method "GetProvincePlenitude".';
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("URL Plenitude");
        SUCOmipSetup.TestField("User Plenitude");
        SUCOmipSetup.TestField("Password Plenitude");
        SUCOmipSetup.TestField("Version Plenitude");

        Clear(JsonObject);
        JsonObject.Add('provincia', PostalCode);
        JsonObject.Add('pais', LowerCase(CustomerCountry));
        JsonObject.Add('version', SUCOmipSetup."Version Plenitude");
        JsonObject.Add('accessToken', token);

        JsonObject.WriteTo(jsonRequest);

        HttpContent.WriteFrom(jsonRequest);
        HttpContent.GetHeaders(Headers);
        Headers.Remove('Content-type');
        Headers.Add('Content-type', 'application/json');

        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.SetRequestUri(SUCOmipSetup."URL Plenitude" + '/consultar/provincia');
        HttpRequestMessage.Method := 'POST';

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(ResponseText);

        if JsonObject.ReadFrom(ResponseText) then begin
            if JsonObject.Get('Data', JsonToken) then begin
                JsonArray := JsonToken.AsArray();
                foreach JsonToken in JsonArray do begin
                    JsonCommercial := JsonToken.AsObject();
                    if JsonCommercial.Get('id', JsonToken) then
                        idProvince := JsonToken.AsValue().AsInteger();
                    if JsonCommercial.Get('nombre', JsonToken) then
                        nameProvince := CopyStr(JsonToken.AsValue().AsText(), 1, 50);
                end;
            end else
                Error(ResponseText);
        end else
            Error(ErrorInvalidJsonLbl);
    end;

    local procedure SetProvincePlenitude(PostalCode: Code[20]; idProvince: Integer)
    var
        PostCode: Record "Post Code";
    begin
        PostCode.Reset();
        PostCode.SetRange(Code, PostalCode);
        PostCode.SetRange("SUC Id. Province Plenitude", 0);
        if PostCode.FindSet() then
            repeat
                PostCode."SUC Id. Province Plenitude" := idProvince;
                PostCode.Modify();
            until PostCode.Next() = 0;
    end;

    local procedure GetDistributorPlenitude(token: Text[100]; CUPS: Text[25]; IdProvince: Integer; IdContratationType: Integer; CustomerCountry: Text[10]; var idDistributor: Integer; var nameDistributor: Text[50])
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        JsonToken2: JsonToken;
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        HttpContent: HttpContent;
        jsonRequest: Text;
        ResponseText: Text;
        ResponseError: Text;
        ErrorInvalidJsonLbl: Label 'Error: Invalid JSON response from the method "GetLoginPlenitude".';
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("URL Plenitude");
        SUCOmipSetup.TestField("User Plenitude");
        SUCOmipSetup.TestField("Password Plenitude");
        SUCOmipSetup.TestField("Version Plenitude");

        Clear(JsonObject);
        JsonObject.Add('cups', CUPS);
        JsonObject.Add('provincia', IdProvince);
        JsonObject.Add('idTipoContratacion', IdContratationType);
        JsonObject.Add('pais', LowerCase(CustomerCountry));
        JsonObject.Add('version', SUCOmipSetup."Version Plenitude");
        JsonObject.Add('accessToken', token);

        JsonObject.WriteTo(jsonRequest);

        HttpContent.WriteFrom(jsonRequest);
        HttpContent.GetHeaders(Headers);
        Headers.Remove('Content-type');
        Headers.Add('Content-type', 'application/json');

        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.SetRequestUri(SUCOmipSetup."URL Plenitude" + '/consultar/distribuidora');
        HttpRequestMessage.Method := 'POST';

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(ResponseText);

        if JsonObject.ReadFrom(ResponseText) then begin
            if JsonObject.Get('Error', JsonToken) then begin
                ResponseError := JsonToken.AsValue().AsText();
                Error('GetDistributor: %1', ResponseError);
            end else
                if JsonObject.Get('Data', JsonToken) then begin
                    if JsonToken.AsObject().Get('id', JsonToken2) then
                        idDistributor := JsonToken2.AsValue().AsInteger();

                    if JsonToken.AsObject().Get('nombre', JsonToken2) then
                        nameDistributor := CopyStr(JsonToken2.AsValue().AsText(), 1, 50);
                end else
                    Error(ResponseText);
        end else
            Error(ErrorInvalidJsonLbl);
    end;

    local procedure GetRatePlenitude(RateNo: Code[20]; token: Text[100]; CustomerTypePlenitude: Integer; IdContratationType: Integer; idDistributorLogin: Text[20]; CustomerCountry: Text[10]; var idRatePlenitudeOut: Integer)
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipRates: Record "SUC Omip Rates";
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonArray2: JsonArray;
        JsonToken: JsonToken;
        JsonToken2: JsonToken;
        JsonRates: JsonObject;
        jsonRequest: Text;
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        HttpContent: HttpContent;
        ResponseText: Text;
        NameRatePlenitude: Text[20];
        NewIdRatePlenitude: Integer;
        ErrorInvalidJsonLbl: Label 'Error: Invalid JSON response from the method "GetCommercialsPlenitude".';
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("URL Plenitude");
        SUCOmipSetup.TestField("User Plenitude");
        SUCOmipSetup.TestField("Password Plenitude");
        SUCOmipSetup.TestField("Version Plenitude");

        Clear(JsonObject);
        JsonObject.Add('idTipoCliente', CustomerTypePlenitude);
        JsonObject.Add('idTipoContratacion', IdContratationType);
        JsonObject.Add('idDistribuidor', idDistributorLogin);
        JsonObject.Add('pais', LowerCase(CustomerCountry));
        JsonObject.Add('version', SUCOmipSetup."Version Plenitude");
        JsonObject.Add('accessToken', token);

        JsonObject.WriteTo(jsonRequest);

        HttpContent.WriteFrom(jsonRequest);
        HttpContent.GetHeaders(Headers);
        Headers.Remove('Content-type');
        Headers.Add('Content-type', 'application/json');

        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.SetRequestUri(SUCOmipSetup."URL Plenitude" + '/listado/tarifas/acceso');
        HttpRequestMessage.Method := 'POST';

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(ResponseText);

        if JsonObject.ReadFrom(ResponseText) then begin
            if JsonObject.Get('Data', JsonToken) then
                if JsonToken.AsObject().Get('tarifas', JsonToken2) then begin
                    JsonArray := JsonToken2.AsArray();
                    foreach JsonToken2 in JsonArray do begin
                        JsonArray2 := JsonToken2.AsArray();
                        foreach JsonToken2 in JsonArray2 do begin
                            JsonRates := JsonToken2.AsObject();

                            if JsonRates.Get('id', JsonToken2) then
                                NewIdRatePlenitude := JsonToken2.AsValue().AsInteger();
                            if JsonRates.Get('nombre', JsonToken2) then begin
                                NameRatePlenitude := CopyStr(JsonToken2.AsValue().AsText(), 1, 20);
                                if NameRatePlenitude = RateNo then
                                    idRatePlenitudeOut := NewIdRatePlenitude;
                            end;

                            if SUCOmipRates.Get(NameRatePlenitude) then begin
                                SUCOmipRates."Id. Plenitude" := NewIdRatePlenitude;
                                SUCOmipRates.Modify();
                            end;
                        end;
                    end;
                end else
                    Error(ResponseText);
        end else
            Error(ErrorInvalidJsonLbl);
    end;

    local procedure GetLocalityPlenitude(token: Text[100]; PostalCode: Code[20]; CustomerCountry: Text[10]; var idLocality: Integer; var nameLocality: Text[50])
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        JsonToken2: JsonToken;
        JsonLocalities: JsonObject;
        jsonRequest: Text;
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        HttpContent: HttpContent;
        ResponseText: Text;
        ErrorInvalidJsonLbl: Label 'Error: Invalid JSON response from the method "GetLocalityPlenitude".';
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("URL Plenitude");
        SUCOmipSetup.TestField("User Plenitude");
        SUCOmipSetup.TestField("Password Plenitude");
        SUCOmipSetup.TestField("Version Plenitude");

        Clear(JsonObject);
        JsonObject.Add('codigoPostal', PostalCode);
        JsonObject.Add('pais', LowerCase(CustomerCountry));
        JsonObject.Add('version', SUCOmipSetup."Version Plenitude");
        JsonObject.Add('accessToken', token);

        JsonObject.WriteTo(jsonRequest);

        HttpContent.WriteFrom(jsonRequest);
        HttpContent.GetHeaders(Headers);
        Headers.Remove('Content-type');
        Headers.Add('Content-type', 'application/json');

        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.SetRequestUri(SUCOmipSetup."URL Plenitude" + '/consultar/localidades');
        HttpRequestMessage.Method := 'POST';

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(ResponseText);

        if JsonObject.ReadFrom(ResponseText) then begin
            if JsonObject.Get('Data', JsonToken) then
                if JsonToken.AsObject().Get('localidades', JsonToken2) then begin
                    JsonArray := JsonToken2.AsArray();
                    foreach JsonToken2 in JsonArray do begin
                        JsonLocalities := JsonToken2.AsObject();
                        if JsonLocalities.Get('id', JsonToken2) then
                            idLocality := JsonToken2.AsValue().AsInteger();
                        if JsonLocalities.Get('nombre', JsonToken2) then
                            nameLocality := CopyStr(JsonToken2.AsValue().AsText(), 1, 50);
                    end;
                end else
                    Error(ResponseText);
        end else
            Error(ErrorInvalidJsonLbl);
    end;

    local procedure SetLocalityPlenitude(PostalCode: Code[20]; idLocality: Integer)
    var
        PostCode: Record "Post Code";
    begin
        PostCode.Reset();
        PostCode.SetRange(Code, PostalCode);
        PostCode.SetRange("SUC Id. Locality Plenitude", 0);
        if PostCode.FindSet() then
            repeat
                PostCode."SUC Id. Locality Plenitude" := idLocality;
                PostCode.Modify();
            until PostCode.Next() = 0;
    end;

    procedure GetCountriesPlenitude()
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        CountryRegion: Record "Country/Region";
        JsonObject: JsonObject;
        JsonArray: JsonArray;
        JsonToken: JsonToken;
        JsonToken2: JsonToken;
        JsonCountries: JsonObject;
        jsonRequest: Text;
        token: Text[100];
        idDistributor: Text[20];
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        HttpContent: HttpContent;
        ResponseText: Text;
        Id: Integer;
        Country: Code[10];
        ErrorInvalidJsonLbl: Label 'Error: Invalid JSON response from the method "GetCommercialsPlenitude".';
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("URL Plenitude");
        SUCOmipSetup.TestField("User Plenitude");
        SUCOmipSetup.TestField("Password Plenitude");
        SUCOmipSetup.TestField("Version Plenitude");

        GetLoginPlenitude(token, idDistributor);

        Clear(JsonObject);
        JsonObject.Add('pais', 'es');
        JsonObject.Add('version', SUCOmipSetup."Version Plenitude");
        JsonObject.Add('accessToken', token);

        JsonObject.WriteTo(jsonRequest);

        HttpContent.WriteFrom(jsonRequest);
        HttpContent.GetHeaders(Headers);
        Headers.Remove('Content-type');
        Headers.Add('Content-type', 'application/json');

        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.SetRequestUri(SUCOmipSetup."URL Plenitude" + '/consultar/paises');
        HttpRequestMessage.Method := 'POST';

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(ResponseText);

        if JsonObject.ReadFrom(ResponseText) then begin
            if JsonObject.Get('Data', JsonToken) then
                if JsonToken.AsObject().Get('paises', JsonToken2) then begin
                    JsonArray := JsonToken2.AsArray();
                    foreach JsonToken2 in JsonArray do begin
                        JsonCountries := JsonToken2.AsObject();
                        if JsonCountries.Get('id', JsonToken2) then
                            Id := JsonToken2.AsValue().AsInteger();
                        if JsonCountries.Get('pais', JsonToken2) then
                            Country := CopyStr(JsonToken2.AsValue().AsText(), 1, 10);

                        CountryRegion.Reset();
                        CountryRegion.SetRange(Name, Country);
                        if CountryRegion.FindLast() then begin
                            CountryRegion."SUC Id. Country Plenitude" := Id;
                            CountryRegion.Modify();
                        end;
                    end;
                end else
                    Error(ResponseText);
        end else
            Error(ErrorInvalidJsonLbl);
    end;

    local procedure SetSuppyContractValidatePlenitude(token: Text[100]; CustomerTypePlenitude: Integer; EnergyUse: Enum "SUC Omip Energy Use"; Language: Integer; IdCommercial: Code[10]; IdRateAccessCRM: Integer; CUPS: Text[25]; CustomerAddress: Text[200];
                                                      IdProvince: Integer; PostalCode: Code[20]; IdLocality: Integer; ContractedPower: array[6] of Decimal; AnualConsumption: Decimal; IdDistributor: Integer; IdContratationType: Integer; Customer: Record Customer;
                                                      IdCountryPlenitude: Integer)
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        CustomerBankAccount: Record "Customer Bank Account";
        JsonObjectHeader: JsonObject;
        JsonSupplies: JsonObject;
        ArraySupplies: JsonArray;
        ErrorsArray: JsonArray;
        JsonDirection: JsonObject;
        JsonCustomer: JsonObject;
        JsonSEPAData: JsonObject;
        JsonResponse: JsonObject;
        JsonToken: JsonToken;
        JsonToken2: JsonToken;
        jsonRequest: Text;
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        HttpContent: HttpContent;
        ResponseText: Text;
        ErrorTxt: Text;
        ErrorsLbl: Label 'Errors: %1\\';
        ErrorInvalidJsonLbl: Label 'Error: Invalid JSON response from the method "SetSuppyContractValidatePlenitude".';
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("URL Plenitude");
        SUCOmipSetup.TestField("User Plenitude");
        SUCOmipSetup.TestField("Password Plenitude");
        SUCOmipSetup.TestField("Version Plenitude");

        Clear(JsonObjectHeader);
        JsonObjectHeader.Add('accessToken', token);
        JsonObjectHeader.Add('version', SUCOmipSetup."Version Plenitude");
        JsonObjectHeader.Add('tipoCliente', CustomerTypePlenitude);
        JsonObjectHeader.Add('cnae', '9820');
        JsonObjectHeader.Add('viviendaHabitual', '1');
        JsonObjectHeader.Add('pais', LowerCase(Customer."Country/Region Code"));

        case EnergyUse of
            EnergyUse::" ":
                JsonObjectHeader.Add('usoEnergia', '1');
            else
                JsonObjectHeader.Add('usoEnergia', EnergyUse.AsInteger());
        end;

        JsonObjectHeader.Add('idioma', Language);
        JsonObjectHeader.Add('zonaImpuestos', '1');
        JsonObjectHeader.Add('facturaPapel', '0');
        JsonObjectHeader.Add('firmaB2B', '1');

        Clear(JsonSupplies);
        JsonSupplies.Add('idUsuario', IdCommercial);
        JsonSupplies.Add('idGrupoElectricidad', IdRateAccessCRM);
        JsonSupplies.Add('idNombreTarifa', '11839');
        JsonSupplies.Add('cups', CUPS);
        JsonSupplies.Add('idFormaPago', '1');
        JsonSupplies.Add('idZona', '1');

        Clear(JsonDirection);
        JsonDirection.Add('tipoVia', '0');
        JsonDirection.Add('direccion', CustomerAddress);
        JsonDirection.Add('provincia', IdProvince);
        JsonDirection.Add('cp', PostalCode);
        JsonDirection.Add('idLocalidad', IdLocality);
        JsonSupplies.Add('arrayDireccion', JsonDirection);

        JsonSupplies.Add('potenciaP1', ContractedPower[1]);
        JsonSupplies.Add('potenciaP2', ContractedPower[2]);
        JsonSupplies.Add('potenciaP3', ContractedPower[3]);
        JsonSupplies.Add('potenciaP4', ContractedPower[4]);
        JsonSupplies.Add('potenciaP5', ContractedPower[5]);
        JsonSupplies.Add('potenciaP6', ContractedPower[6]);
        JsonSupplies.Add('consumoSIPS', AnualConsumption);
        JsonSupplies.Add('comercializadora', '6');
        JsonSupplies.Add('distribuidora', IdDistributor);
        JsonSupplies.Add('origen', 'E');
        JsonSupplies.Add('idTipoActivacion', '1');
        JsonSupplies.Add('idTipoContratacion', IdContratationType);
        ArraySupplies.Add(JsonSupplies);
        JsonObjectHeader.Add('arraySuministros', ArraySupplies);

        Clear(JsonCustomer);
        JsonCustomer.Add('nombre', Customer.Name);
        JsonCustomer.Add('documento', Customer."VAT Registration No.");
        case Customer."SUC VAT Registration Type" of
            Customer."SUC VAT Registration Type"::CIF:
                JsonCustomer.Add('tipoDocumento', 'C');
            Customer."SUC VAT Registration Type"::NIF:
                JsonCustomer.Add('tipoDocumento', 'N');
        end;
        JsonCustomer.Add('telefono1', Customer."Phone No.");
        JsonCustomer.Add('email', Customer."E-Mail");
        JsonCustomer.Add('tratamiento', '1');
        JsonCustomer.Add('idioma', Language);
        JsonCustomer.Add('pais', IdCountryPlenitude);
        JsonCustomer.Add('arrayDireccion', JsonDirection);
        JsonObjectHeader.Add('arrayCliente', JsonCustomer);

        Clear(JsonSEPAData);
        JsonSEPAData.Add('nombre', Customer.Name);
        case Customer."SUC VAT Registration Type" of
            Customer."SUC VAT Registration Type"::CIF:
                JsonSEPAData.Add('tipoDocumento', 'C');
            Customer."SUC VAT Registration Type"::NIF:
                JsonSEPAData.Add('tipoDocumento', 'N');
        end;
        JsonSEPAData.Add('documentoTitular', Customer."VAT Registration No.");
        if Customer."Preferred Bank Account Code" <> '' then begin
            CustomerBankAccount.Get(Customer."No.", Customer."Preferred Bank Account Code");
            JsonSEPAData.Add('ibanInternacional', CustomerBankAccount.IBAN);
        end;
        JsonSEPAData.Add('pais_expedicion', IdCountryPlenitude);
        JsonSEPAData.Add('arrayDireccion', JsonDirection);
        JsonObjectHeader.Add('arrayDatosSepa', JsonSEPAData);

        JsonObjectHeader.WriteTo(jsonRequest);

        if SUCOmipSetup."Show Plenitude Request" then
            Message(jsonRequest);

        HttpContent.WriteFrom(jsonRequest);
        HttpContent.GetHeaders(Headers);
        Headers.Remove('Content-type');
        Headers.Add('Content-type', 'application/json');

        HttpRequestMessage.Content := HttpContent;

        HttpRequestMessage.SetRequestUri(SUCOmipSetup."URL Plenitude" + '/suministro/contrato/validar');
        HttpRequestMessage.Method := 'PUT';

        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);
        HttpResponseMessage.Content().ReadAs(ResponseText);

        if JsonResponse.ReadFrom(ResponseText) then begin
            if JsonResponse.Get('NumErrores', JsonToken) then begin
                ErrorTxt := StrSubstNo(ErrorsLbl, JsonToken.AsValue().AsInteger());
                if JsonResponse.Get('Errores', JsonToken) then begin
                    ErrorsArray := JsonToken.AsArray();
                    foreach JsonToken in ErrorsArray do
                        ErrorTxt += '- ' + JsonToken.AsValue().AsText() + '\';
                end;
                Error(ErrorTxt);
            end else
                if JsonResponse.Get('Data', JsonToken) then begin
                    if JsonToken.AsObject().Get('id', JsonToken2) then
                        idDistributor := JsonToken2.AsValue().AsInteger();

                end else
                    Error(ResponseText);
        end else
            Error(ErrorInvalidJsonLbl);
    end;

    local procedure ClearFEEsAgent(UserName: Code[100])
    var
        SUCOmipFEEPowerAgent: Record "SUC Omip FEE Power Agent";
        SUCOmipFEEEnergyAgent: Record "SUC Omip FEE Energy Agent";
    begin
        SUCOmipFEEPowerAgent.Reset();
        SUCOmipFEEPowerAgent.SetRange("Agent No.", UserName);
        SUCOmipFEEPowerAgent.DeleteAll();
        SUCOmipFEEEnergyAgent.Reset();
        SUCOmipFEEEnergyAgent.SetRange("Agent No.", UserName);
        SUCOmipFEEEnergyAgent.DeleteAll();
    end;

    local procedure ClearFEEsAgentOtherMarketers(UserName: Code[100]; MarketerNo: Code[100])
    var
        SUCOmipFEEPowerAgent: Record "SUC Omip FEE Power Agent";
        SUCOmipFEEEnergyAgent: Record "SUC Omip FEE Energy Agent";
        MarketerList: List of [Text];
    begin
        Clear(MarketerList);
        if MarketerNo <> '' then
            SplitTextToList(MarketerNo, '|', MarketerList);

        SUCOmipFEEPowerAgent.Reset();
        SUCOmipFEEPowerAgent.SetRange("Agent No.", UserName);
        if SUCOmipFEEPowerAgent.FindSet() then
            repeat
                if MarketerNo <> '' then begin
                    if MarketerList.Count() > 0 then
                        if not MarketerList.Contains(SUCOmipFEEPowerAgent."Marketer No.") then
                            SUCOmipFEEPowerAgent.Delete();
                end else
                    SUCOmipFEEPowerAgent.Delete();
            until SUCOmipFEEPowerAgent.Next() = 0;

        SUCOmipFEEEnergyAgent.Reset();
        SUCOmipFEEEnergyAgent.SetRange("Agent No.", UserName);
        if SUCOmipFEEEnergyAgent.FindSet() then
            repeat
                if MarketerNo <> '' then begin
                    if MarketerList.Count() > 0 then
                        if not MarketerList.Contains(SUCOmipFEEEnergyAgent."Marketer No.") then
                            SUCOmipFEEEnergyAgent.Delete();
                end else
                    SUCOmipFEEEnergyAgent.Delete();
            until SUCOmipFEEEnergyAgent.Next() = 0;
    end;

    local procedure SplitTextToList(InputText: Text; Separator: Text; var OutputList: List of [Text])
    var
        TempText: Text;
        Pos: Integer;
        Item: Text;
    begin
        Clear(OutputList);
        TempText := InputText;
        while StrLen(TempText) > 0 do begin
            Pos := StrPos(TempText, Separator);
            if Pos > 0 then begin
                Item := CopyStr(TempText, 1, Pos - 1);
                OutputList.Add(Item);
                TempText := CopyStr(TempText, Pos + 1, StrLen(TempText));
            end else begin
                OutputList.Add(TempText);
                break;
            end;
        end;
    end;

    procedure SetNewCustomerDocs(DocumentType: Enum "SUC Omip Document Type"; DocumentNo: Code[20]; CustomerNo: Code[20]; Status: Enum "SUC Omip Document Status";
                                 PostingDate: DateTime; AgentNo: Code[100])
    var
        SUCOmipCustomerDocs: Record "SUC Omip Customer Docs.";
    begin
        if not SUCOmipCustomerDocs.Get(DocumentType, DocumentNo, CustomerNo, PostingDate) then begin
            SUCOmipCustomerDocs.Init();
            SUCOmipCustomerDocs.Validate("Document Type", DocumentType);
            SUCOmipCustomerDocs.Validate("Document No.", DocumentNo);
            SUCOmipCustomerDocs.Validate("Customer No.", CustomerNo);
            SUCOmipCustomerDocs.Validate("Posting Date", PostingDate);
            SUCOmipCustomerDocs.Validate("Status", Status);
            SUCOmipCustomerDocs.Validate("Agent No.", AgentNo);
            SUCOmipCustomerDocs.Insert();
        end else begin
            SUCOmipCustomerDocs.Validate("Agent No.", AgentNo);
            SUCOmipCustomerDocs.Modify();
        end;
    end;

    procedure SetNewCUPSDefCustPrevProposals(CustomerNo: Code[20]; CUPS: Text[25])
    var
        SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
    begin
        SUCOmipCustomerCUPS.Init();
        SUCOmipCustomerCUPS.Validate("Customer No.", CustomerNo);
        SUCOmipCustomerCUPS.Validate("CUPS", CUPS);
        SUCOmipCustomerCUPS.Validate("SUC Supply Point Address", 'null');
        SUCOmipCustomerCUPS.Validate("SUC Supply Point Country", 'ES');
        SUCOmipCustomerCUPS.Validate("SUC Supply Point Post Code", '08001');
        SUCOmipCustomerCUPS.Insert();
    end;

    procedure SetPricesVarRatesEntry()
    var
        SUCOmipRatesEntryUpdate: Record "SUC Omip Rates Entry Update";
        SUCOmipRatesEntry2: Record "SUC Omip Rates Entry 2";
    begin
        SUCOmipRatesEntryUpdate.Reset();
        if SUCOmipRatesEntryUpdate.FindSet() then
            repeat
                SUCOmipRatesEntry2.Reset();
                SUCOmipRatesEntry2.SetRange("Marketer No.", SUCOmipRatesEntryUpdate."Marketer No.");
                SUCOmipRatesEntry2.SetRange("Rate No.", SUCOmipRatesEntryUpdate."Rate No.");
                SUCOmipRatesEntry2.SetRange("Omip Times", SUCOmipRatesEntryUpdate."Omip Times");
                if SUCOmipRatesEntry2.FindSet() then
                    repeat
                        SUCOmipRatesEntry2.Validate("SSCC", SUCOmipRatesEntryUpdate.SSCC);
                        SUCOmipRatesEntry2.Validate("Detours", SUCOmipRatesEntryUpdate.Detours);
                        SUCOmipRatesEntry2.Validate("AFNEE", SUCOmipRatesEntryUpdate.AFNEE);
                        SUCOmipRatesEntry2.Modify();
                    until SUCOmipRatesEntry2.Next() = 0;
            until SUCOmipRatesEntryUpdate.Next() = 0;
    end;

    procedure AssignFEEGroupsExternalUsers(SUCOmipExternalUsersIn: Record "SUC Omip External Users"; Groups: Code[250])
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        SUCOmipFEEGroups: Record "SUC Omip FEE Groups";
        SUCOmipExtUsersGroupsFEE: Record "SUC Omip Ext. Users Groups FEE";
        ErrorFEEGroupsLbl: Label 'You must select at least one group.';
    begin
        if Groups = '' then
            Error(ErrorFEEGroupsLbl);

        SUCOmipExternalUsers.Get(SUCOmipExternalUsersIn."User Name");
        SUCOmipFEEGroups.Reset();
        SUCOmipFEEGroups.SetFilter("Group Id.", Groups);
        if SUCOmipFEEGroups.FindSet() then
            repeat
                if not SUCOmipExtUsersGroupsFEE.Get(SUCOmipExternalUsers."User Name", SUCOmipFEEGroups."Group Id.") then begin
                    SUCOmipExtUsersGroupsFEE.Init();
                    SUCOmipExtUsersGroupsFEE.Validate("User Name", SUCOmipExternalUsers."User Name");
                    SUCOmipExtUsersGroupsFEE.Validate("Group Id.", SUCOmipFEEGroups."Group Id.");
                    SUCOmipExtUsersGroupsFEE.Validate(Default, SUCOmipFEEGroups.Default);
                    SUCOmipExtUsersGroupsFEE.Insert();
                end;
            until SUCOmipFEEGroups.Next() = 0;

        ValidateFEEExternalUsers(SUCOmipExternalUsers, true, '');
    end;

    procedure GetUserFEEGroupIdDefault(AgentNo: Code[100]): Code[20]
    var
        SUCOmipExtUsersGroupsFEE: Record "SUC Omip Ext. Users Groups FEE";
        ErrorFEEGroupLbl: Label 'You must select at least one group as default for the user %1.';
    begin
        SUCOmipExtUsersGroupsFEE.Reset();
        SUCOmipExtUsersGroupsFEE.SetRange("User Name", AgentNo);
        SUCOmipExtUsersGroupsFEE.SetRange(Default, true);
        if not SUCOmipExtUsersGroupsFEE.FindLast() then
            Error(ErrorFEEGroupLbl, AgentNo)
        else
            exit(SUCOmipExtUsersGroupsFEE."Group Id.");
    end;

    procedure UpdateCommisionsAfterModifyFEEs(documentType: Enum "SUC Omip Document Type"; documentNo: Code[20]; rateNo: Code[20])
    var
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
        SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
        TotalCommision: Decimal;
    begin
        ValidateStatusDocument(documentType, documentNo, Enum::"SUC Omip Document Status"::"Pending Acceptance");
        SUCOmipContractedPower.Reset();
        SUCOmipContractedPower.SetRange("Document Type", documentType);
        SUCOmipContractedPower.SetRange("Document No.", documentNo);
        SUCOmipContractedPower.SetRange("Rate No.", rateNo);
        if SUCOmipContractedPower.FindSet() then
            repeat
                SUCOmipFEEPowerDocument.Reset();
                SUCOmipFEEPowerDocument.SetRange("Document Type", documentType);
                SUCOmipFEEPowerDocument.SetRange("Document No.", documentNo);
                SUCOmipFEEPowerDocument.SetRange("Rate No.", rateNo);
                if SUCOmipFEEPowerDocument.FindFirst() then begin
                    SUCOmipContractedPower.Validate("Commission P1", SUCOmipFEEPowerDocument.P1 * SUCOmipContractedPower.P1);
                    SUCOmipContractedPower.Validate("Commission P2", SUCOmipFEEPowerDocument.P2 * SUCOmipContractedPower.P2);
                    SUCOmipContractedPower.Validate("Commission P3", SUCOmipFEEPowerDocument.P3 * SUCOmipContractedPower.P3);
                    SUCOmipContractedPower.Validate("Commission P4", SUCOmipFEEPowerDocument.P4 * SUCOmipContractedPower.P4);
                    SUCOmipContractedPower.Validate("Commission P5", SUCOmipFEEPowerDocument.P5 * SUCOmipContractedPower.P5);
                    SUCOmipContractedPower.Validate("Commission P6", SUCOmipFEEPowerDocument.P6 * SUCOmipContractedPower.P6);
                    TotalCommision := SUCOmipContractedPower."Commission P1" + SUCOmipContractedPower."Commission P2" + SUCOmipContractedPower."Commission P3" +
                                      SUCOmipContractedPower."Commission P4" + SUCOmipContractedPower."Commission P5" + SUCOmipContractedPower."Commission P6";
                    SUCOmipContractedPower.Validate("Total Commission", TotalCommision);
                    SUCOmipContractedPower.Modify();
                end;
            until SUCOmipContractedPower.Next() = 0;
    end;

    local procedure ValidateStatusDocument(DocumentType: Enum "SUC Omip Document Type"; DocumentNo: Code[20]; Status: Enum "SUC Omip Document Status")
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    begin
        case DocumentType of
            DocumentType::Proposal:
                begin
                    SUCOmipProposals.Get(DocumentNo);
                    SUCOmipProposals.TestField(Status, Status);
                end;
            DocumentType::Contract:
                begin
                    SUCOmipEnergyContracts.Get(DocumentNo);
                    SUCOmipEnergyContracts.TestField(Status, Status);
                end;
        end;
    end;

    procedure PrintContract(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        ReportID: Integer;
    begin
        // Initial validation
        SUCOmipEnergyContractsIn.TestField("Marketer No.");

        // Prepare contract filters
        SUCOmipEnergyContracts.Reset();
        SUCOmipEnergyContracts.Copy(SUCOmipEnergyContractsIn);
        SUCOmipEnergyContracts.SetRange("No.", SUCOmipEnergyContractsIn."No.");

        // Get the correct report ID using the centralized logic
        ReportID := GetContractReportID(SUCOmipEnergyContracts);

        // Run the report
        RunReport(ReportID, SUCOmipEnergyContracts);
    end;

    local procedure RunReport(ReportID: Integer; var SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts")
    begin
        Report.RunModal(ReportID, true, true, SUCOmipEnergyContracts);
    end;

    /// <summary>
    /// Prints a proposal and returns it as Base64 encoded PDF
    /// </summary>
    /// <param name="SUCOmipProposals">The proposal record</param>
    /// <returns>Base64 encoded PDF content</returns>
    procedure PrintProposalToPDF(SUCOmipProposals: Record "SUC Omip Proposals"): Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        RecordRef: RecordRef;
        InStream: InStream;
        OutStream: OutStream;
        ReportID: Integer;
    begin
        SUCOmipProposals.TestField("Marketer No.");

        // Ensure we're working with a specific record
        SUCOmipProposals.SetRecFilter();

        ReportID := GetProposalReportID(SUCOmipProposals);

        RecordRef.GetTable(SUCOmipProposals);
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecordRef);
        TempBlob.CreateInStream(InStream);

        exit(Base64Convert.ToBase64(InStream));
    end;

    /// <summary>
    /// Prints a contract and returns it as Base64 encoded PDF
    /// </summary>
    /// <param name="SUCOmipEnergyContracts">The contract record</param>
    /// <returns>Base64 encoded PDF content</returns>
    procedure PrintContractToPDF(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"): Text
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        RecordRef: RecordRef;
        InStream: InStream;
        OutStream: OutStream;
        ReportID: Integer;
    begin
        SUCOmipEnergyContracts.TestField("Marketer No.");

        // Ensure we're working with a specific record
        SUCOmipEnergyContracts.SetRecFilter();

        ReportID := GetContractReportID(SUCOmipEnergyContracts);

        RecordRef.GetTable(SUCOmipEnergyContracts);
        TempBlob.CreateOutStream(OutStream);
        Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecordRef);
        TempBlob.CreateInStream(InStream);

        exit(Base64Convert.ToBase64(InStream));
    end;

    /// <summary>
    /// Gets the report ID for a proposal for API use
    /// </summary>
    /// <param name="SUCOmipProposals">The proposal record</param>
    /// <returns>Report ID</returns>
    procedure GetProposalReportID(SUCOmipProposals: Record "SUC Omip Proposals"): Integer
    var
        SUCOmipMarketers: Record "SUC Omip Marketers";
    begin
        if SUCOmipMarketers.Get(SUCOmipProposals."Marketer No.") then
            case SUCOmipMarketers.Marketer of
                SUCOmipMarketers.Marketer::" ", SUCOmipMarketers.Marketer::Nabalia:
                    if SUCOmipProposals.Multicups then
                        exit(Report::"SUC Omip Proposal NAB MC")
                    else
                        exit(Report::"SUC Omip Proposal NAB");
                SUCOmipMarketers.Marketer::Acis:
                    if SUCOmipProposals.Multicups then
                        exit(Report::"SUC Omip Proposal ACIS MC")
                    else
                        exit(Report::"SUC Omip Proposal ACIS");
                SUCOmipMarketers.Marketer::Avanza:
                    if SUCOmipProposals.Multicups then
                        exit(Report::"SUC Omip Proposal AVA MC")
                    else
                        exit(Report::"SUC Omip Proposal AVA");
            end;

        // Default case
        exit(Report::"SUC Omip Proposal NAB");
    end;

    /// <summary>
    /// Gets the report ID for a contract for API use
    /// </summary>
    /// <param name="SUCOmipEnergyContracts">The contract record</param>
    /// <returns>Report ID</returns>
    procedure GetContractReportID(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"): Integer
    begin
        // Handle different product types
        case SUCOmipEnergyContracts."Product Type" of
            SUCOmipEnergyContracts."Product Type"::Omip:
                exit(GetOmipContractReportID(SUCOmipEnergyContracts));
            SUCOmipEnergyContracts."Product Type"::"Energy (Light - Gas)":
                exit(GetEnergyContractReportID(SUCOmipEnergyContracts));
        end;
    end;

    /// <summary>
    /// Gets the report ID for Omip contracts
    /// </summary>
    /// <param name="SUCOmipEnergyContracts">The contract record</param>
    /// <returns>Report ID</returns>
    local procedure GetOmipContractReportID(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"): Integer
    var
        SUCOmipMarketers: Record "SUC Omip Marketers";
    begin
        if SUCOmipMarketers.Get(SUCOmipEnergyContracts."Marketer No.") then
            case SUCOmipMarketers.Marketer of
                SUCOmipMarketers.Marketer::" ", SUCOmipMarketers.Marketer::Nabalia:
                    exit(GetNabaliaOmipReportID(SUCOmipEnergyContracts));
                SUCOmipMarketers.Marketer::Acis:
                    exit(GetAcisOmipReportID(SUCOmipEnergyContracts));
                SUCOmipMarketers.Marketer::Avanza:
                    exit(GetAvanzaOmipReportID(SUCOmipEnergyContracts));
            end;

        // Default to Nabalia
        exit(GetNabaliaOmipReportID(SUCOmipEnergyContracts));
    end;

    /// <summary>
    /// Gets the report ID for Energy contracts (Light/Gas)
    /// </summary>
    /// <param name="SUCOmipEnergyContracts">The contract record</param>
    /// <returns>Report ID</returns>
    local procedure GetEnergyContractReportID(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"): Integer
    begin
        case SUCOmipEnergyContracts."Energy Type" of
            SUCOmipEnergyContracts."Energy Type"::Electricity:
                exit(GetOmipContractReportID(SUCOmipEnergyContracts)); //* Default to Omip 12M for Electricity
            SUCOmipEnergyContracts."Energy Type"::Gas:
                exit(GetGasContractReportID(SUCOmipEnergyContracts));
        end;
    end;

    /// <summary>
    /// Gets the report ID for Gas contracts
    /// </summary>
    /// <param name="SUCOmipEnergyContracts">The contract record</param>
    /// <returns>Report ID</returns>
    local procedure GetGasContractReportID(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"): Integer
    var
        SUCOmipMarketers: Record "SUC Omip Marketers";
    begin
        if SUCOmipMarketers.Get(SUCOmipEnergyContracts."Marketer No.") then
            case SUCOmipMarketers.Marketer of
                SUCOmipMarketers.Marketer::" ", SUCOmipMarketers.Marketer::Nabalia:
                    exit(GetNabaliaGasReportID(SUCOmipEnergyContracts));
                SUCOmipMarketers.Marketer::Acis:
                    exit(GetAcisGasReportID(SUCOmipEnergyContracts));
                SUCOmipMarketers.Marketer::Avanza:
                    // TODO: Implement Avanza gas reports when available
                    exit(GetNabaliaGasReportID(SUCOmipEnergyContracts));
            end;

        // Default to Nabalia
        exit(GetNabaliaGasReportID(SUCOmipEnergyContracts));
    end;

    /// <summary>
    /// Gets the report ID for Nabalia gas contracts based on rate type
    /// </summary>
    /// <param name="SUCOmipEnergyContracts">The contract record</param>
    /// <returns>Report ID</returns>
    local procedure GetNabaliaGasReportID(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"): Integer
    begin
        case SUCOmipEnergyContracts."Rate Type Contract" of
            SUCOmipEnergyContracts."Rate Type Contract"::Fixed:
                exit(Report::"SUC Omip Contract 12M NAB GasF");
            SUCOmipEnergyContracts."Rate Type Contract"::Indexed:
                exit(Report::"SUC Omip Contract 12M NAB GasI");
        end;
    end;

    /// <summary>
    /// Gets the report ID for Acis gas contracts based on rate type
    /// </summary>
    /// <param name="SUCOmipEnergyContracts">The contract record</param>
    /// <returns>Report ID</returns>
    local procedure GetAcisGasReportID(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"): Integer
    begin
        case SUCOmipEnergyContracts."Rate Type Contract" of
            SUCOmipEnergyContracts."Rate Type Contract"::Fixed:
                exit(Report::"SUC Omip Contract 12MACIS GasF");
            SUCOmipEnergyContracts."Rate Type Contract"::Indexed:
                exit(Report::"SUC Omip Contract 12MACIS GasI");
        end;
    end;

    /// <summary>
    /// Gets the report ID for Nabalia Omip contracts
    /// </summary>
    /// <param name="SUCOmipEnergyContracts">The contract record</param>
    /// <returns>Report ID</returns>
    local procedure GetNabaliaOmipReportID(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"): Integer
    begin
        case SUCOmipEnergyContracts.Times of
            SUCOmipEnergyContracts.Times::"12M":
                if SUCOmipEnergyContracts.Multicups then
                    exit(Report::"SUC Omip Contract 12M MC NAB")
                else
                    exit(Report::"SUC Omip Contract 12M NAB");
            else
                if SUCOmipEnergyContracts.Multicups then
                    exit(Report::"SUC Omip Contract 12MMC NAB v2")
                else
                    exit(Report::"SUC Omip Contract 12M NAB v2");
        end;
    end;

    /// <summary>
    /// Gets the report ID for Acis Omip contracts
    /// </summary>
    /// <param name="SUCOmipEnergyContracts">The contract record</param>
    /// <returns>Report ID</returns>
    local procedure GetAcisOmipReportID(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"): Integer
    begin
        case SUCOmipEnergyContracts.Times of
            SUCOmipEnergyContracts.Times::"12M":
                if SUCOmipEnergyContracts.Multicups then
                    exit(Report::"SUC Omip Contract 12M MC ACIS")
                else
                    exit(Report::"SUC Omip Contract 12M ACIS");
            else
                if SUCOmipEnergyContracts.Multicups then
                    exit(Report::"SUC Omip Contract 12MMC ACISv2")
                else
                    exit(Report::"SUC Omip Contract 12M ACIS v2");
        end;
    end;

    /// <summary>
    /// Gets the report ID for Avanza Omip contracts
    /// </summary>
    /// <param name="SUCOmipEnergyContracts">The contract record</param>
    /// <returns>Report ID</returns>
    local procedure GetAvanzaOmipReportID(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"): Integer
    begin
        case SUCOmipEnergyContracts.Times of
            SUCOmipEnergyContracts.Times::"12M":
                if SUCOmipEnergyContracts.Multicups then
                    exit(Report::"SUC Omip Contract 12M MC AVA")
                else
                    exit(Report::"SUC Omip Contract 12M AVA");
            else
                if SUCOmipEnergyContracts.Multicups then
                    exit(Report::"SUC Omip Contract 12MMC AVA v2")
                else
                    exit(Report::"SUC Omip Contract 12M AVA v2");
        end;
    end;

    /// <summary>
    /// Validates and calculates VAT for power entry contract amounts based on supply point location
    /// </summary>
    /// <param name="SUCOmipEnergyContracts">Energy contract containing supply point information</param>
    /// <param name="SUCOmipPowerEntryContract">Power entry contract record to update with VAT calculations (passed by reference)</param>
    /// <remarks>
    /// This procedure:
    /// - Extracts the area code from the supply point postal code (first 2 digits)
    /// - Looks up the corresponding Area record for VAT posting group configuration
    /// - Applies VAT calculations to all power periods (P1-P6) if VAT posting groups are configured
    /// - Uses the CalcVATAmount function to calculate VAT-inclusive amounts
    /// </remarks>
    local procedure ValidatePowerEntryContractTaxes(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"; var SUCOmipPowerEntryContract: Record "SUC Omip Power Entry Contract")
    var
        "Area": Record "Area";
        AreaCode: Code[10];
    begin
        if SUCOmipEnergyContracts."SUC Supply Point Post Code" <> '' then begin
            AreaCode := CopyStr(SUCOmipEnergyContracts."SUC Supply Point Post Code", 1, 2);
            if "Area".Get(AreaCode) then
                if ("Area"."SUC VAT Bus. Posting Group" <> '') and ("Area"."SUC VAT Prod. Posting Group" <> '') then begin
                    SUCOmipPowerEntryContract."P1 Incl. VAT" := CalcVATAmount(SUCOmipPowerEntryContract.P1, "Area"."SUC VAT Bus. Posting Group", "Area"."SUC VAT Prod. Posting Group");
                    SUCOmipPowerEntryContract."P2 Incl. VAT" := CalcVATAmount(SUCOmipPowerEntryContract.P2, "Area"."SUC VAT Bus. Posting Group", "Area"."SUC VAT Prod. Posting Group");
                    SUCOmipPowerEntryContract."P3 Incl. VAT" := CalcVATAmount(SUCOmipPowerEntryContract.P3, "Area"."SUC VAT Bus. Posting Group", "Area"."SUC VAT Prod. Posting Group");
                    SUCOmipPowerEntryContract."P4 Incl. VAT" := CalcVATAmount(SUCOmipPowerEntryContract.P4, "Area"."SUC VAT Bus. Posting Group", "Area"."SUC VAT Prod. Posting Group");
                    SUCOmipPowerEntryContract."P5 Incl. VAT" := CalcVATAmount(SUCOmipPowerEntryContract.P5, "Area"."SUC VAT Bus. Posting Group", "Area"."SUC VAT Prod. Posting Group");
                    SUCOmipPowerEntryContract."P6 Incl. VAT" := CalcVATAmount(SUCOmipPowerEntryContract.P6, "Area"."SUC VAT Bus. Posting Group", "Area"."SUC VAT Prod. Posting Group");
                    SUCOmipPowerEntryContract.Modify();
                end;
        end;
    end;
    /// <summary>
    /// Validates and calculates VAT for energy entry contract amounts based on supply point location
    /// </summary>
    /// <param name="SUCOmipEnergyContracts">Energy contract containing supply point information</param>
    /// <param name="SUCOmipEnergyEntryContract">Energy entry contract record to update with VAT calculations (passed by reference)</param>
    /// <remarks>
    /// This procedure:
    /// - Extracts the area code from the supply point postal code (first 2 digits)
    /// - Looks up the corresponding Area record for VAT posting group configuration
    /// - Applies VAT calculations to all energy periods (P1-P6) if VAT posting groups are configured
    /// - Uses the CalcVATAmount function to calculate VAT-inclusive amounts
    /// </remarks>
    local procedure ValidateEnergyEntryContractTaxes(SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"; var SUCOmipEnergyEntryContract: Record "SUC Omip Energy Entry Contract")
    var
        "Area": Record "Area";
        AreaCode: Code[10];
    begin
        if SUCOmipEnergyContracts."SUC Supply Point Post Code" <> '' then begin
            AreaCode := CopyStr(SUCOmipEnergyContracts."SUC Supply Point Post Code", 1, 2);
            if "Area".Get(AreaCode) then
                if ("Area"."SUC VAT Bus. Posting Group" <> '') and ("Area"."SUC VAT Prod. Posting Group" <> '') then begin
                    SUCOmipEnergyEntryContract."P1 Incl. VAT" := CalcVATAmount(SUCOmipEnergyEntryContract.P1, "Area"."SUC VAT Bus. Posting Group", "Area"."SUC VAT Prod. Posting Group");
                    SUCOmipEnergyEntryContract."P2 Incl. VAT" := CalcVATAmount(SUCOmipEnergyEntryContract.P2, "Area"."SUC VAT Bus. Posting Group", "Area"."SUC VAT Prod. Posting Group");
                    SUCOmipEnergyEntryContract."P3 Incl. VAT" := CalcVATAmount(SUCOmipEnergyEntryContract.P3, "Area"."SUC VAT Bus. Posting Group", "Area"."SUC VAT Prod. Posting Group");
                    SUCOmipEnergyEntryContract."P4 Incl. VAT" := CalcVATAmount(SUCOmipEnergyEntryContract.P4, "Area"."SUC VAT Bus. Posting Group", "Area"."SUC VAT Prod. Posting Group");
                    SUCOmipEnergyEntryContract."P5 Incl. VAT" := CalcVATAmount(SUCOmipEnergyEntryContract.P5, "Area"."SUC VAT Bus. Posting Group", "Area"."SUC VAT Prod. Posting Group");
                    SUCOmipEnergyEntryContract."P6 Incl. VAT" := CalcVATAmount(SUCOmipEnergyEntryContract.P6, "Area"."SUC VAT Bus. Posting Group", "Area"."SUC VAT Prod. Posting Group");
                    SUCOmipEnergyEntryContract.Modify();
                end;
        end;
    end;
    /// <summary>
    /// Calculates the VAT amount for a given base amount using VAT posting groups
    /// </summary>
    /// <param name="BaseAmount">The base amount before VAT</param>
    /// <param name="VATBusPostingGroup">VAT Business Posting Group</param>
    /// <param name="VATProdPostingGroup">VAT Product Posting Group</param>
    /// <returns>Amount including VAT</returns>
    local procedure CalcVATAmount(BaseAmount: Decimal; VATBusPostingGroup: Code[20]; VATProdPostingGroup: Code[20]): Decimal
    var
        VATPostingSetup: Record "VAT Posting Setup";
        VATAmount: Decimal;
    begin
        if (VATBusPostingGroup = '') or (VATProdPostingGroup = '') then
            exit(BaseAmount);

        if VATPostingSetup.Get(VATBusPostingGroup, VATProdPostingGroup) then begin
            VATAmount := BaseAmount * VATPostingSetup."VAT %" / 100;
            exit(BaseAmount + VATAmount);
        end else
            exit(BaseAmount);
    end;
}