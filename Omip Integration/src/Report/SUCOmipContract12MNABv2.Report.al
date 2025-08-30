namespace Sucasuc.Omip.Contract;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Utilities;
using System.Globalization;
using Microsoft.Foundation.Address;
using Microsoft.Sales.Customer;
using Sucasuc.Omip.Contracts;
/// <summary>
/// Report SUC Omip Contract 12M (ID 50152).
/// </summary>
report 50152 "SUC Omip Contract 12M NAB v2"
{
    Caption = 'Omip Contract Comercial';
    WordLayout = './src/Report/Layouts/Contracts/Nabalia/SUCOmipContract12MNABv2.docx';
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
            column(CustomerName; "Ship-to Name" + ' ' + "Ship-to Name 2") { }
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
            column(CustomerAddress; Customer.Address + ' ' + Customer."Address 2") { }
            column(CustomerVatRegNo; Customer."VAT Registration No.") { }
            column(CustomerVATRegistrationType; Customer."SUC VAT Registration Type") { }
            column(ContractPeriod; ContractPeriod) { }
            column(EndDate; Format(EndDate, 0, '<Day> de <Month Text> de <Year4>')) { }
            column(CustomerPostCode; Customer."Post Code") { }
            column(CustomerManager; CustomerManager) { }
            column(CustomerManagerVatRegNo; Customer."SUC Manager VAT Reg. No") { }
            column(CustomerManagerPosition; CustomerManagerPosition) { }
            column(Paragraph1; Paragraph1) { }
            column(ConsumAnualLbl; ConsumAnualLbl) { }
            column(Volume; Format(Volume, 0, '<Sign><Integer>')) { }
            column(CountryRegionName; CountryRegion.Name) { }
            column(CustomerSupplyPointAddress; "SUC Supply Point Address") { }
            column(CustomerSupplyPointPostCode; "SUC Supply Point Post Code") { }
            column(CustomerSupplyPointCity; "SUC Supply Point City") { }
            column(CustomerSupplyPointCounty; "SUC Supply Point County") { }
            column(CheckInv; CheckInv) { }
            column(CheckCom; CheckCom) { }
            column(SupplyStartDate; Format("Supply Start Date", 0, '<Day> de <Month Text> de <Year4>')) { }
            column(SupplyStartDate2; Format("Supply Start Date", 0, '<Day,2> / <Month,2> / <Year4>')) { }
            column(OrderTEDAddendum; "Order TED Addendum") { }
            column(ResolutionAddendum; "Resolution Addendum") { }
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
                DataItemLink = "Contract No." = field("No."), "Rate No." = field("Rate No.");
                column(SUCOmipPowerEntryRate; "Rate No.") { }
                column(PP1; BlankZeroFormatted(Format(P1))) { }
                column(PP2; BlankZeroFormatted(Format(P2))) { }
                column(PP3; BlankZeroFormatted(Format(P3))) { }
                column(PP4; BlankZeroFormatted(Format(P4))) { }
                column(PP5; BlankZeroFormatted(Format(P5))) { }
                column(PP6; BlankZeroFormatted(Format(P6))) { }
            }
            dataitem(SUCOmipEnergyEntry; "SUC Omip Energy Entry Contract")
            {
                DataItemTableView = sorting("Rate No.", Times, Type);
                DataItemLink = "Contract No." = field("No."), "Rate No." = field("Rate No."), Type = field(Type);
                column(SUCOmipEnergyEntryRate; "Rate No.") { }
                column(PETimes; "Times Text") { }
                column(PE1; BlankZeroFormatted(Format(P1))) { }
                column(PE2; BlankZeroFormatted(Format(P2))) { }
                column(PE3; BlankZeroFormatted(Format(P3))) { }
                column(PE4; BlankZeroFormatted(Format(P4))) { }
                column(PE5; BlankZeroFormatted(Format(P5))) { }
                column(PE6; BlankZeroFormatted(Format(P6))) { }
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
                Clear(BusinessName);
                Clear(PersonName);
                Clear(CustomerManager);
                Clear(CustomerManagerPosition);
                Clear(SEPACustomerName);
                Clear(SEPAVatRegNo);
                case Customer."SUC Customer Type" of
                    Customer."SUC Customer Type"::Company:
                        begin
                            BusinessName := "Ship-to Name" + ' ' + "Ship-to Name 2";
                            PersonName := Customer."SUC Manager";
                            CustomerNIF := Customer."SUC Manager VAT Reg. No";
                            CustomerCIF := Customer."VAT Registration No.";
                            CustomerManager := Customer."SUC Manager";
                            CustomerManagerPosition := Customer."SUC Manager Position";
                            Paragraph1 := StrSubstNo(ParagraphCompany1Lbl, Customer."SUC Manager", Customer."SUC Manager VAT Reg. No", Customer."SUC Manager Position");
                            SEPACustomerName := "Ship-to Name" + ' ' + "Ship-to Name 2";
                            SEPAVatRegNo := "Ship-to VAT Registration No.";
                        end;
                    Customer."SUC Customer Type"::Particular:
                        begin
                            PersonName := "Ship-to Name" + ' ' + "Ship-to Name 2";
                            CustomerNIF := Customer."VAT Registration No.";
                            CustomerManager := PersonName;
                            Paragraph1 := ParagraphPerson1Lbl;
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
        Paragraph1: Text;
        BusinessName: Text;
        PersonName: Text;
        CustomerManager: Text;
        CustomerManagerPosition: Text;
        CustomerNIF: Text[20];
        CustomerCIF: Text[20];
        ParagraphCompany1Lbl: Label '– [El CLIENTE se halla representado para este acto por %1 con NIF %2, en virtud de %3. El CLIENTE interviene en su propio nombre y derecho.]';
        ParagraphPerson1Lbl: Label 'El CLIENTE interviene en su propio nombre y derecho.]';
        ConsumAnualLbl: Label 'Consumo anual declarado:';
        EndDate: Date;
        CheckInv: Text[1];
        CheckCom: Text[1];
        SEPACustomerName: Text;
        SEPAVatRegNo: Text;
        ApplicableConditions: Text;
}