namespace Sucasuc.Omip.Contract;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Utilities;
using System.Globalization;
using Sucasuc.Energy.Ledger;
using Microsoft.Foundation.Address;
using Microsoft.Sales.Customer;
using Sucasuc.Omip.Contracts;
/// <summary>
/// Report SUC Omip Contract 12M v3 (ID 50157).
/// </summary>
report 50177 "SUC Omip Contract 12MACIS GasF"
{
    Caption = 'Omip Contract Comercial';
    WordLayout = './src/Report/Layouts/Contracts/Acis/SUCOmipContract12MACIS_GasFixed.docx';
    DefaultLayout = Word;
    PreviewMode = PrintLayout;
    EnableHyperlinks = true;
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem(SUCOmipEnergyContracts; "SUC Omip Energy Contracts")
        {
            DataItemTableView = sorting("No.") order(ascending);
            RequestFilterFields = "No.";
            column(SUCOmipEnergyContracts_No_; "No.") { }
            column(Customer_Name; PersonName) { }
            column(SUCOmipEnergyContracts_CompanyName; BusinessName) { }
            column(SUCOmipEnergyContracts_Address; Customer.Address + ' ' + Customer."Address 2") { }
            column(Customer_NIF; CustomerNIF) { }
            column(Customer_CIF; CustomerCIF) { }
            column(SUCOmipEnergyContracts_CAE; CAE) { }
            column(SUCOmipEnergyContracts_PostCode; "SUC Supply Point Post Code") { }
            column(Customer_City; "Ship-to City") { }
            column(Customer_Email; Customer."E-Mail") { }
            column(Customer_County; "Ship-to County") { }
            column(SUCOmipEnergyContracts_Phone; "Phone No.") { }
            column(SUCOmipEnergyContracts_CellPhone; "Mobile Phone No.") { }
            column(SUCOmipProposals_AgentNo_; "Agent No.") { }
            column(SUCOmipEnergyContracts_Rate_No_; "Rate No.") { }
            column(SUCOmipEnergyContracts_Proposal_No_; "Proposal No.") { }
            column(Ship_to_Name; Format("Ship-to Name" + ' ' + "Ship-to Name 2")) { }
            column(Ship_to_Address; Format("Ship-to Address" + ' ' + "Ship-to Address 2")) { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_VAT_Registration; "Ship-to VAT Registration No.") { }
            column(Bank_Account; IBAN) { }
            column(CUPS; "Customer CUPS") { }
            column(Date_Created; Format("Date Created", 0, '<Day> de <Month Text> de <Year4>')) { }
            column(CountryRegionName; CountryRegion.Name) { }
            column(CustomerPostCode; "Ship-to Post Code") { }
            column(CustomerSupplyPointAddress; "SUC Supply Point Address") { }
            column(CustomerSupplyPointPostCode; "SUC Supply Point Post Code") { }
            column(CustomerSupplyPointCity; "SUC Supply Point City") { }
            column(CustomerSupplyPointCounty; "SUC Supply Point County") { }
            column(CustomerManager; CustomerManager) { }
            column(CustomerManagerVatRegNo; CustomerManagerPosition) { }
            column(CustomerManagerPosition; Customer."SUC Manager Position") { }
            column(Volume; Format(Volume, 0, '<Sign><Integer>')) { }
            column(ContractPeriod; ContractPeriod) { }
            column(EndDate; Format(EndDate, 0, '<Day> de <Month Text> de <Year4>')) { }
            column(CheckInv; CheckInv) { }
            column(CheckCom; CheckCom) { }
            column(SupplyStartDate; Format("Supply Start Date", 0, '<Day> de <Month Text> de <Year4>')) { }
            column(SupplyStartDate2; Format("Supply Start Date", 0, '<Day> / <Month> / <Year4>')) { }
            column(RefContract; "Reference Contract") { }
            column(Modality; "Contract Modality") { }
            column(CustPosition; "SUC Customer Manager Position") { }
            column(AgentCode; "Agent Code") { }
            column(SEPACustomerName; SEPACustomerName) { }
            column(SEPAVatRegNo; SEPAVatRegNo) { }
            column(TittleAppConditions; "Tittle Applicable Conditions") { }
            column(ApplicableConditions; ApplicableConditions) { }
            dataitem(SUCOmipPowerEntry; "SUC Omip Power Entry Contract")
            {
                DataItemTableView = sorting("Rate No.") order(ascending);
                DataItemLink = "Contract No." = field("No.");
                column(PERate; "Rate No.") { }
                column(PP1; BlankZeroFormatted(Format(P1))) { }
                column(PP2; BlankZeroFormatted(Format(P2))) { }
                column(PP3; BlankZeroFormatted(Format(P3))) { }
                column(PP4; BlankZeroFormatted(Format(P4))) { }
                column(PP5; BlankZeroFormatted(Format(P5))) { }
                column(PP6; BlankZeroFormatted(Format(P6))) { }
                column(PP1InclVAT; BlankZeroFormatted(Format("P1 Incl. VAT"))) { }
                column(PP2InclVAT; BlankZeroFormatted(Format("P2 Incl. VAT"))) { }
                column(PP3InclVAT; BlankZeroFormatted(Format("P3 Incl. VAT"))) { }
                column(PP4InclVAT; BlankZeroFormatted(Format("P4 Incl. VAT"))) { }
                column(PP5InclVAT; BlankZeroFormatted(Format("P5 Incl. VAT"))) { }
                column(PP6InclVAT; BlankZeroFormatted(Format("P6 Incl. VAT"))) { }
            }
            dataitem(SUCOmipEnergyEntry; "SUC Omip Energy Entry Contract")
            {
                DataItemTableView = sorting("Rate No.", Times, Type);
                DataItemLink = "Contract No." = field("No.");
                column(EERate; "Rate No.") { }
                column(PETimes; "Times Text") { }
                column(PE1; BlankZeroFormatted(Format(P1))) { }
                column(PE2; BlankZeroFormatted(Format(P2))) { }
                column(PE3; BlankZeroFormatted(Format(P3))) { }
                column(PE4; BlankZeroFormatted(Format(P4))) { }
                column(PE5; BlankZeroFormatted(Format(P5))) { }
                column(PE6; BlankZeroFormatted(Format(P6))) { }
                column(PE1InclVAT; BlankZeroFormatted(Format("P1 Incl. VAT"))) { }
                column(PE2InclVAT; BlankZeroFormatted(Format("P2 Incl. VAT"))) { }
                column(PE3InclVAT; BlankZeroFormatted(Format("P3 Incl. VAT"))) { }
                column(PE4InclVAT; BlankZeroFormatted(Format("P4 Incl. VAT"))) { }
                column(PE5InclVAT; BlankZeroFormatted(Format("P5 Incl. VAT"))) { }
                column(PE6InclVAT; BlankZeroFormatted(Format("P6 Incl. VAT"))) { }
                column(Discount; Discount) { }
                trigger OnAfterGetRecord()
                begin
                    if P1 = 0 then
                        CurrReport.Skip();
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Clear(CheckInv);
                Clear(CheckCom);
                if not Customer.Get("Customer No.") then
                    Clear(Customer);

                SUCOmipManagement.GetDataFromTime(Times, "Supply Start Date", ContractPeriod, EndDate);

                if not CountryRegion.Get(Customer."Country/Region Code") then
                    Clear(CountryRegion);

                Clear(CustomerNIF);
                Clear(CustomerCIF);
                case Customer."SUC VAT Registration Type" of
                    Customer."SUC VAT Registration Type"::NIF:
                        CustomerNIF := Customer."VAT Registration No.";
                    Customer."SUC VAT Registration Type"::CIF:
                        CustomerCIF := Customer."VAT Registration No.";
                end;

                Clear(CustomerNIF);
                Clear(CustomerCIF);
                Clear(BusinessName);
                Clear(PersonName);
                Clear(CustomerManager);
                Clear(CustomerManagerPosition);
                case Customer."SUC Customer Type" of
                    Customer."SUC Customer Type"::Company:
                        begin
                            BusinessName := "Ship-to Name" + ' ' + "Ship-to Name 2";
                            PersonName := Customer."SUC Manager";
                            CustomerNIF := Customer."SUC Manager VAT Reg. No";
                            CustomerCIF := Customer."VAT Registration No.";
                            CustomerManager := Customer."SUC Manager";
                            CustomerManagerPosition := Customer."SUC Manager Position";
                            SEPACustomerName := "Ship-to Name" + ' ' + "Ship-to Name 2";
                            SEPAVatRegNo := "Ship-to VAT Registration No.";
                        end;
                    Customer."SUC Customer Type"::Particular:
                        begin
                            PersonName := "Ship-to Name" + ' ' + "Ship-to Name 2";
                            CustomerNIF := Customer."VAT Registration No.";
                            CustomerManager := PersonName;
                            SEPACustomerName := Customer."SUC Manager";
                            SEPAVatRegNo := Customer."SUC Manager VAT Reg. No";
                        end;
                end;
                if "Receive invoice electronically" then
                    CheckInv := 'X';
                if "Sending Communications" then
                    CheckCom := 'X';

                Clear(ApplicableConditions);
                ApplicableConditions := GetDataValueBlob(FieldNo("Body Applicable Conditions"));
            end;
        }
    }

    labels
    {
        RateLbl = 'Rate';
        P1Lbl = 'P1';
        P2Lbl = 'P2';
        P3Lbl = 'P3';
        P4Lbl = 'P4';
        P5Lbl = 'P5';
        P6Lbl = 'P6';
    }

    local procedure BlankZeroFormatted(NumberFormatted: Text): Text
    var
        Number: Integer;
    begin
        if Evaluate(Number, NumberFormatted) and (Number = 0) then
            exit('')
        else
            exit(NumberFormatted);
    end;

    trigger OnPreReport()
    var
        Language: Codeunit Language;
    begin
        CurrReport.Language(Language.GetLanguageId('ESP'));
    end;

    var
        Customer: Record Customer;
        CountryRegion: Record "Country/Region";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        ContractPeriod: Text;
        CustomerNIF: Text[20];
        CustomerCIF: Text[20];
        BusinessName: Text;
        PersonName: Text;
        CustomerManager: Text;
        CustomerManagerPosition: Text;
        SEPACustomerName: Text;
        SEPAVatRegNo: Text;
        ApplicableConditions: Text;
        CheckInv: Text[1];
        CheckCom: Text[1];
        EndDate: Date;
}