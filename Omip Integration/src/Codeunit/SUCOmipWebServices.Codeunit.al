namespace Sucasuc.Omip.API;
using Sucasuc.Omip.Masters;
using Microsoft.Sales.Setup;
using Sucasuc.Omip.Utilities;
using Microsoft.CRM.Setup;
using Microsoft.CRM.Contact;
using Sucasuc.Omip.Auditing;
using System.Utilities;
using System.Text;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Contracts;
using Microsoft.Foundation.NoSeries;
using Sucasuc.Omip.Setup;
using System.Reflection;
using Sucasuc.Omip.User;
using Microsoft.Sales.Customer;
using Sucasuc.Omip.Contract;
using Sucasuc.Omip.Proposals;
/// <summary>
/// Codeunit SUC Omip Web Services (ID 50152).
/// </summary>
codeunit 50152 "SUC Omip Web Services"
{
    Permissions = tabledata "SUC Omip Average Prices Cont." = rimd,
                  tabledata "SUC Omip Proposals" = rimd;
    local procedure UpdateProposal(ProposalNo: Code[20]; RateNoIn: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimeIn: Enum "SUC Omip Times"; RateCategory: Code[20]; EnergyOrigenIn: Enum "SUC Omip Energy Origen";
                                     AgentNo: Code[100]; CustomerNo: Code[20]; CustomerCUPS: Text[25]; ContractStartDate: Date; AcceptanceMethod: Enum "SUC Omip Acceptance Method"; AcceptanceSend: Text[250]; MarketerNo: Code[20];
                                     receiveInvoiceElectronically: Boolean; sendingCommunications: Boolean; multicups: Boolean; feeGroupID: Code[20]): Code[20]
    var
        Customer: Record Customer;
        SUCExternalUsers: Record "SUC Omip External Users";
        SUCOmipProposals: Record "SUC Omip Proposals";
        CustomerLbl: Label 'Customer %1 does not exist';
        ExternalUserLbl: Label 'External User %1 does not exist';
        ContractStartDateLbl: Label 'Contract date is mandatory.';
    begin
        if not SUCExternalUsers.Get(AgentNo) then
            Error(ExternalUserLbl, AgentNo);

        if not Customer.Get(CustomerNo) then
            Error(CustomerLbl, CustomerNo);

        if ContractStartDate = 0D then
            Error(ContractStartDateLbl);

        SUCOmipProposals.Get(ProposalNo);
        SUCOmipProposals.Validate("Rate No.", RateNoIn);
        SUCOmipProposals.Validate(Times, TimeIn);
        if not multicups then
            SUCOmipProposals.Validate("Rate Category", RateCategory);
        // SUCOmipProposals."FEE Potency" := FEEPotencyIn;
        // SUCOmipProposals."FEE Energy" := FEEEnergy;
        SUCOmipProposals."Energy Origen" := EnergyOrigenIn;
        SUCOmipProposals.Validate(Type, TypeIn);
        SUCOmipProposals.Validate("Agent No.", AgentNo);
        if feeGroupID <> '' then
            SUCOmipProposals.Validate("FEE Group Id.", feeGroupID);
        SUCOmipProposals.Validate("Customer No.", CustomerNo);
        if not multicups then
            if not (CurrentClientType in [ClientType::OData, ClientType::ODataV4, ClientType::SOAP, ClientType::Api]) then //*EPRO creates the contracted power and the declared annual consumption independently
                SUCOmipProposals.Validate("Customer CUPS", CustomerCUPS)
            else
                // SUCOmipProposals."Customer CUPS" := CustomerCUPS;
                SUCOmipProposals.Validate("Customer CUPS", CustomerCUPS);
        SUCOmipProposals.Validate("Acceptance Method", AcceptanceMethod);
        SUCOmipProposals.Validate("Acceptance Send", AcceptanceSend);
        SUCOmipProposals.Validate("Marketer No.", MarketerNo);
        SUCOmipProposals.Validate("Receive invoice electronically", receiveInvoiceElectronically);
        SUCOmipProposals.Validate("Sending Communications", sendingCommunications);
        SUCOmipProposals.Validate(Multicups, multicups);
        SUCOmipProposals.Modify();

        exit(SUCOmipProposals."No.");
    end;

    local procedure GetNextCustBankAccNo(CustomerNo: Code[20]): Code[20]
    var
        CustomerBankAccount: Record "Customer Bank Account";
        IntDummy: Integer;
    begin
        CustomerBankAccount.Reset();
        CustomerBankAccount.SetRange("Customer No.", CustomerNo);
        if CustomerBankAccount.FindLast() then begin
            Evaluate(IntDummy, CustomerBankAccount.Code);
            exit(Format(IntDummy + 1))
        end;
        exit('1');
    end;

    [Obsolete('Pending removal use GenerateProposal2API', '25.1')]
    procedure GenerateProposalAPI(proposalNo: Code[20]; rateNo: Code[20]; rateType: Enum "SUC Omip Rate Entry Types"; omipTime: Enum "SUC Omip Times"; rateCategory: Code[20]; feePotency: Decimal;
                                     feeEnergy: Decimal; energyOrigen: Enum "SUC Omip Energy Origen"; agentNo: Code[100]; customerNo: Code[20]; customerCUPS: Text[25]; contractStartDate: Date; acceptanceMethod: Enum "SUC Omip Acceptance Method";
                                     acceptanceSend: Text[250]; marketerNo: Code[20]; receiveInvoiceElectronically: Boolean; sendingCommunications: Boolean): Code[20]
    begin
    end;

    [Obsolete('Pending removal use GenerateProposal3API', '25.02')]
    procedure GenerateProposal2API(proposalNo: Code[20]; rateNo: Code[20]; rateType: Enum "SUC Omip Rate Entry Types"; omipTime: Enum "SUC Omip Times"; rateCategory: Code[20]; feePotency: Decimal;
                                 feeEnergy: Decimal; energyOrigen: Enum "SUC Omip Energy Origen"; agentNo: Code[100]; customerNo: Code[20]; customerCUPS: Text[25]; contractStartDate: Date; acceptanceMethod: Enum "SUC Omip Acceptance Method";
                                 acceptanceSend: Text[250]; marketerNo: Code[20]; receiveInvoiceElectronically: Boolean; sendingCommunications: Boolean; multicups: Boolean): Code[20]
    begin
    end;

    procedure GenerateProposal3API(proposalNo: Code[20]; rateNo: Code[20]; rateType: Enum "SUC Omip Rate Entry Types"; omipTime: Enum "SUC Omip Times";
                                rateCategory: Code[20]; energyOrigen: Enum "SUC Omip Energy Origen"; agentNo: Code[100]; customerNo: Code[20]; customerCUPS: Text[25];
                                contractStartDate: Date; acceptanceMethod: Enum "SUC Omip Acceptance Method"; acceptanceSend: Text[250]; marketerNo: Code[20];
                                receiveInvoiceElectronically: Boolean; sendingCommunications: Boolean; multicups: Boolean; customerIBAN: Code[50]; feeGroupID: Code[20]): Code[20]
    var
        SUCOmipManagement: Codeunit "SUC Omip Management";
        NewProposalNo: Code[20];
        ComercialFEE: array[6] of Decimal;
        EnergyCalculationMatrix: array[6] of Decimal;
        RealFEE: array[6] of Decimal;
    begin
        if proposalNo = '' then begin
            SUCOmipManagement.GetComercialFEEEnergyAgent(agentNo, marketerNo, rateNo, ComercialFEE);
            SUCOmipManagement.SetPricesByTime(rateType, marketerNo, energyOrigen, false, ComercialFEE, false, EnergyCalculationMatrix, RealFEE);
        end;

        if proposalNo = '' then begin
            NewProposalNo := SUCOmipManagement.GenerateProposal3(marketerNo, rateNo, rateType, omipTime, energyOrigen, multicups, customerIBAN, agentNo, feeGroupID);
            UpdateProposal(NewProposalNo, rateNo, rateType, omipTime, rateCategory, energyOrigen, agentNo, customerNo, customerCUPS, contractStartDate, acceptanceMethod,
                           acceptanceSend, marketerNo, receiveInvoiceElectronically, sendingCommunications, multicups, feeGroupID);
            exit(NewProposalNo);
        end else
            exit(UpdateProposal(proposalNo, rateNo, rateType, omipTime, rateCategory, energyOrigen, agentNo, customerNo, customerCUPS, contractStartDate, acceptanceMethod,
                 acceptanceSend, marketerNo, receiveInvoiceElectronically, sendingCommunications, multicups, feeGroupID));
    end;

    /// <summary>
    /// PrintProposalAPI.
    /// </summary>
    /// <param name="proposalNo">Code[20].</param>
    /// <returns>Return value of type Text.</returns>
    procedure PrintProposalAPI(proposalNo: Code[20]): Text
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipManagement: Codeunit "SUC Omip Management";
    begin
        SUCOmipProposals.Reset();
        SUCOmipProposals.SetCurrentKey("No.");
        SUCOmipProposals.SetRange("No.", proposalNo);
        if SUCOmipProposals.FindFirst() then
            exit(SUCOmipManagement.PrintProposalToPDF(SUCOmipProposals));
    end;

    /// <summary>
    /// CreateContractAPI.
    /// </summary>
    /// <param name="DocNo">Code[20].</param>
    /// <returns>Return value of type Text.</returns>
    // procedure CreateContractAPI(DocNo: Code[20]): Text
    // var
    //     SUCOmipProposals: Record "SUC Omip Proposals";
    //     SUCOmipManagement: Codeunit "SUC Omip Management";
    //     Message: Text;
    // begin
    //     SUCOmipProposals.Reset();
    //     SUCOmipProposals.SetCurrentKey("No.");
    //     SUCOmipProposals.SetRange("No.", DocNo);
    //     if SUCOmipProposals.FindSet() then begin
    //         Message := SUCOmipManagement.GenerateContract(SUCOmipProposals);
    //         SUCOmipProposals.Modify();
    //         exit(Message);
    //     end;

    // end;

    /// <summary>
    /// ContactAPI.
    /// </summary>
    /// <param name="ContactName">Text[100].</param>
    /// <param name="ContactName2">Text[100].</param>
    /// <param name="ContactType">Integer.</param>
    /// <param name="ContactAddress">Text[100].</param>
    /// <param name="ContactAddress2">Text[100].</param>
    /// <param name="ContactCountry">Code[10].</param>
    /// <param name="ContactPostCode">Code[20].</param>
    /// <param name="ContactPhoneNo">Text[30].</param>
    /// <param name="ContactMobilePhoneNo">Text[30].</param>
    /// <param name="ContactEmail">Text[80].</param>
    /// <param name="ContactLanguage">Code[10].</param>
    /// <param name="ContactVatRegistrationNo">Text[20].</param>
    /// <returns>Return value of type Code[20].</returns>
    procedure ContactAPI(ContactName: Text[100]; ContactName2: Text[100]; ContactType: Integer; ContactAddress: Text[100]; ContactAddress2: Text[100]; ContactCountry: Code[10]; ContactPostCode: Code[20]; ContactPhoneNo: Text[30]; ContactMobilePhoneNo: Text[30]; ContactEmail: Text[80]; ContactLanguage: Code[10]; ContactVatRegistrationNo: Text[20]): Code[20]
    var
        Contact: Record Contact;
        MarketingSetup: Record "Marketing Setup";
        NoSeries: Codeunit "No. Series";
        ContactNo: Code[20];
    begin
        MarketingSetup.Get();
        MarketingSetup.TestField("Contact Nos.");
        ContactNo := NoSeries.GetNextNo(MarketingSetup."Contact Nos.", WorkDate(), true);
        Contact.Init();
        Contact.Validate("No.", ContactNo);
        Contact.Validate(Name, ContactName);
        Contact.Validate("Name 2", ContactName2);
        Contact.Validate(Type, Enum::"Contact Type".FromInteger(ContactType));
        Contact.Validate(Address, ContactAddress);
        Contact.Validate("Address 2", ContactAddress2);
        Contact.Validate("Country/Region Code", ContactCountry);
        Contact.Validate("Post Code", ContactPostCode);
        Contact.Validate("Phone No.", ContactPhoneNo);
        Contact.Validate("Mobile Phone No.", ContactMobilePhoneNo);
        Contact.Validate("E-Mail", ContactEmail);
        Contact.Validate("Language Code", ContactLanguage);
        Contact.Validate("VAT Registration No.", ContactVatRegistrationNo);
        Contact.Insert(true);
        exit(ContactNo);
    end;


    [Obsolete('Pending removal use CreateCustomer2API', '25.1')]
    procedure CreateCustomerAPI(name: Text[100]; name2: Text[100]; address: Text[100]; address2: Text[100]; country: Code[10]; postCode: Code[20]; city: Text[30];
                                    county: Text[30]; phoneNo: Text[30]; mobilePhoneNo: Text[30]; email: Text[80]; language: Code[10]; vatRegistrationType: Enum "SUC Omip VAT Registration Type";
                                    vatRegistrationNo: Text[20]; paymentTermsCode: Code[10]; genBusPostingGroup: Code[20]; vatBusPostingGroup: Code[20]; custPostingGroup: Code[20]; custBankAccName: Text[100];
                                    iban: Code[50]; manager: Text[250]; managerVATRegNo: Text[20]; managerPosition: Text[100]; supplyPointType: Enum "SUC Omip Customer Type"; supplyPointAddress: Text[200]; supplyPointPostalCode: Code[20];
                                    supplyPointCity: Text[30]; supplyPointCounty: Text[30]; supplyPointCountry: Code[10]; agentNo: Code[100]): Code[20]

    begin
    end;

    procedure CreateCustomer2API(name: Text[100]; name2: Text[100]; address: Text[100]; address2: Text[100]; country: Code[10]; postCode: Code[20]; city: Text[30];
                                county: Text[30]; phoneNo: Text[30]; mobilePhoneNo: Text[30]; email: Text[80]; language: Code[10]; vatRegistrationType: Enum "SUC Omip VAT Registration Type";
                                vatRegistrationNo: Text[20]; paymentTermsCode: Code[10]; genBusPostingGroup: Code[20]; vatBusPostingGroup: Code[20]; custPostingGroup: Code[20]; custBankAccName: Text[100];
                                iban: Code[50]; manager: Text[250]; managerVATRegNo: Text[20]; managerPosition: Text[100]; supplyPointType: Enum "SUC Omip Customer Type"; agentNo: Code[100]): Code[20]
    var
        Customer: Record Customer;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        CustomerBankAccount: Record "Customer Bank Account";
        NoSeries: Codeunit "No. Series";
        // SUCOmipManagement: Codeunit "SUC Omip Management";
        CustomerNo: Code[20];
        NextCustBankAccNo: Code[20];
    // CustExistLbl: Label 'Customer already exists, %1: %2';
    // IsDuplicate: Boolean;
    begin
        // IsDuplicate := SUCOmipManagement.IsCustomerDuplicate(email, phoneNo, vatRegistrationNo);

        SalesReceivablesSetup.Get();
        SalesReceivablesSetup.TestField("Customer Nos.");
        CustomerNo := NoSeries.GetNextNo(SalesReceivablesSetup."Customer Nos.", WorkDate(), true);
        Customer.Init();
        Customer.Validate("No.", CustomerNo);
        Customer.Validate(Name, name);
        Customer.Validate("Name 2", name2);
        Customer.Validate(Address, address);
        Customer.Validate("Address 2", address2);
        Customer.Validate("Country/Region Code", country);
        Customer.Validate("Post Code", postCode);
        Customer.Validate(City, city);
        Customer.Validate(County, county);
        Customer.Validate("Phone No.", phoneNo);
        Customer.Validate("Mobile Phone No.", mobilePhoneNo);
        Customer.Validate("E-Mail", email);
        Customer.Validate("Language Code", language);
        Customer.Validate("SUC VAT Registration Type", vatRegistrationType);
        Customer.Validate("VAT Registration No.", vatRegistrationNo);
        Customer.Validate("Payment Terms Code", paymentTermsCode);
        Customer.Validate("Gen. Bus. Posting Group", genBusPostingGroup);
        Customer.Validate("VAT Bus. Posting Group", vatBusPostingGroup);
        Customer.Validate("Customer Posting Group", custPostingGroup);
        Customer.Validate("SUC Manager", manager);
        Customer.Validate("SUC Manager VAT Reg. No", managerVATRegNo);
        Customer.Validate("SUC Manager Position", managerPosition);
        Customer.Validate("SUC Customer Type", supplyPointType);
        Customer.Validate("Agent No.", agentNo);
        // if IsDuplicate then
        //     Customer.Validate("Duplicate State", Enum::"SUC Omip Duplicate State"::"Pending validation duplicate customer")
        // else
        //     Customer.Validate("Duplicate State", Enum::"SUC Omip Duplicate State"::" ");
        Customer.Insert(true);

        CustomerBankAccount.Reset();
        CustomerBankAccount.SetRange("Customer No.", CustomerNo);
        CustomerBankAccount.SetRange(IBAN, iban);
        if not CustomerBankAccount.FindLast() then begin
            NextCustBankAccNo := GetNextCustBankAccNo(CustomerNo);
            CustomerBankAccount.Init();
            CustomerBankAccount.Validate("Customer No.", CustomerNo);
            CustomerBankAccount.Validate(Code, NextCustBankAccNo);
            CustomerBankAccount.Validate(Name, custBankAccName);
            CustomerBankAccount.Validate(IBAN, iban);
            CustomerBankAccount.Insert(true);

            Customer.Validate("Preferred Bank Account Code", NextCustBankAccNo);
            Customer.Modify();
        end;

        exit(CustomerNo);
    end;

    /// <summary>
    /// Updates a document in the SUC Omip system.
    /// </summary>
    /// <param name="documentType">The type of the document to update.</param>
    /// <param name="documentNo">The number of the document to update.</param>
    /// <param name="sucOmipStatusProposal">The status of the document to update.</param>
    /// <returns>The response text indicating the result of the update operation.</returns>
    procedure UpdateDocument(documentType: Enum "SUC Omip Document Type"; documentNo: Code[20]; sucOmipStatusProposal: Enum "SUC Omip Document Status") responseText: Text
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        SUCOmipDocumentType: Enum "SUC Omip Document Type";
        NotExistLbl: Label 'Document %1 not found';
    begin
        case documentType of
            documentType::Proposal:
                if SUCOmipProposals.Get(documentNo) then begin
                    SUCOmipProposals.Validate(Status, sucOmipStatusProposal);
                    SUCOmipProposals.Modify();
                    case sucOmipStatusProposal of
                        sucOmipStatusProposal::Accepted:
                            SUCOmipManagement.SendEmailToPurchases(SUCOmipProposals."No.", SUCOmipDocumentType::Proposal);
                    end;
                    responseText := 'OK';
                end else
                    Error(NotExistLbl, documentNo);
            documentType::Contract:
                if SUCOmipEnergyContracts.Get(documentNo) then begin
                    SUCOmipEnergyContracts.Validate(Status, sucOmipStatusProposal);
                    SUCOmipEnergyContracts.Modify();
                    case sucOmipStatusProposal of
                        sucOmipStatusProposal::Accepted:
                            SUCOmipManagement.SendEmailToPurchases(SUCOmipEnergyContracts."No.", SUCOmipDocumentType::Contract);
                    end;
                    responseText := 'OK';
                end;
            else
                Error(NotExistLbl, documentNo);
        end;
    end;

    /// <summary>
    /// PrintContractAPI.
    /// </summary>
    /// <param name="contractNo">Code[20].</param>
    /// <returns>Return value of type Text.</returns>
    procedure PrintContractAPI(contractNo: Code[20]): Text
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipManagement: Codeunit "SUC Omip Management";
    begin
        SUCOmipEnergyContracts.Reset();
        SUCOmipEnergyContracts.SetCurrentKey("No.");
        SUCOmipEnergyContracts.SetRange("No.", contractNo);
        if SUCOmipEnergyContracts.FindFirst() then
            exit(SUCOmipManagement.PrintContractToPDF(SUCOmipEnergyContracts));
    end;

    procedure GetAttachedDocument(documentType: Enum "SUC Omip Document Type"; documentNo: Code[20]): Text
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
        AttachedFile: Text;
    begin
        Clear(AttachedFile);
        case documentType of
            documentType::Proposal:
                begin
                    SUCOmipProposals.Get(documentNo);
                    if SUCOmipProposals.File.HasValue then begin
                        SUCOmipProposals.CalcFields(File);
                        SUCOmipProposals.File.CreateInStream(InStream);
                        TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), AttachedFile);
                        exit(AttachedFile);
                    end else
                        Error('The field File is empty');
                end;
            documentType::Contract:
                begin
                    SUCOmipEnergyContracts.Get(documentNo);
                    if SUCOmipEnergyContracts.File.HasValue then begin
                        SUCOmipEnergyContracts.CalcFields(File);
                        SUCOmipEnergyContracts.File.CreateInStream(InStream);
                        TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), AttachedFile);
                        exit(AttachedFile);
                    end else
                        Error('The field File is empty');
                end;
        end;
    end;

    /// <summary>
    /// ESendAcceptableContractAPI.
    /// </summary>
    /// <param name="contractNo">Code[20].</param>
    /// <param name="smsText">Text[1000].</param>
    /// <returns>Return value of type Text.</returns>
    // procedure ESendAcceptableContractAPI(contractNo: Code[20]; smsText: Text[1000]): Text
    // var
    //     SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    //     SUCOmipManagement: Codeunit "SUC Omip Management";
    //     RequestText: Text;
    // begin
    //     if SUCOmipEnergyContracts.Get(contractNo) then begin
    //         RequestText := SUCOmipManagement.ContractAcceptance(SUCOmipEnergyContracts);
    //         exit(RequestText);
    //     end;
    // end;

    /// <summary>
    /// ESendAcceptableProposalAPI.
    /// </summary>
    /// <param name="contractNo">Code[20].</param>
    /// <param name="SMSText">Text[1000].</param>
    /// <returns>Return value of type Text.</returns>
    // procedure ESendAcceptableProposalAPI(proposalNo: Code[20]; SMSText: Text[1000]): Text
    // var
    //     SUCOmipProposals: Record "SUC Omip Proposals";
    //     SUCOmipManagement: Codeunit "SUC Omip Management";
    //     ProposalSuccedLbl: Label 'Proposal %1 submitted successfully.';
    // begin
    //     if SUCOmipProposals.Get(proposalNo) then
    //         if SUCOmipManagement.SendProposal(SUCOmipProposals) then
    //             exit(StrSubstNo(ProposalSuccedLbl, SUCOmipProposals."No."));
    // end;

    /// <summary>
    /// EChangeStatusAcceptableProposalAPI.
    /// </summary>
    /// <param name="contractNo">Code[20].</param>
    /// <param name="SMSText">Text[1000].</param>
    /// <returns>Return value of type Text.</returns>
    // procedure EChangeStatusAcceptableProposalAPI(proposalNo: Code[20]; sucOmipAcceptanceMethod: Enum "SUC Omip Acceptance Method"; sucOmipStatusProposal: Enum "SUC Omip Document Status"): Text
    // var
    //     SUCOmipProposals: Record "SUC Omip Proposals";
    //     NotExistLbl: Label 'Proposal %1 not found';
    //     responseText: Text;
    // begin
    //     if not SUCOmipProposals.Get(proposalNo) then
    //         Error(NotExistLbl, proposalNo)
    //     else begin
    //         SUCOmipProposals.Validate("Acceptance Method", sucOmipAcceptanceMethod);
    //         SUCOmipProposals.Validate(Status, sucOmipStatusProposal);
    //         if SUCOmipProposals.Modify() then
    //             responseText := 'OK'
    //         else
    //             responseText := GetLastErrorText();
    //     end;
    // end;

    procedure SendAcceptanceAPI(documentType: Enum "SUC Omip Document Type"; documentNo: Code[20]): Text
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        ValidTime: Time;
        TodayDT: DateTime;
        DueDT: DateTime;
        DocumentOutTimeLbl: Label 'Document %1 is out of time';
    begin
        SUCOmipSetup.Get();
        case documentType of
            documentType::Proposal:
                begin
                    SUCOmipProposals.Get(documentNo);

                    ValidTime := DT2Time(SUCOmipProposals."DateTime Created");
                    TodayDT := CreateDateTime(Today, ValidTime);
                    DueDT := CreateDateTime(CalcDate(Format(SUCOmipSetup."Time Validity Contracts"), SUCOmipProposals."Date Created"), ValidTime);

                    if (TodayDT <= DueDT) then begin
                        if SUCOmipManagement.SendProposal(SUCOmipProposals) then
                            exit('OK');
                    end else begin
                        SUCOmipProposals.Status := SUCOmipProposals.Status::"Out of Time";
                        SUCOmipProposals.Modify();
                        exit(StrSubstNo(DocumentOutTimeLbl, SUCOmipProposals."No."));
                    end;
                end;
            documentType::Contract:
                begin
                    SUCOmipEnergyContracts.Get(documentNo);

                    ValidTime := DT2Time(SUCOmipEnergyContracts."DateTime Created");
                    TodayDT := CreateDateTime(Today, ValidTime);
                    DueDT := CreateDateTime(CalcDate(Format(SUCOmipSetup."Time Validity Contracts"), SUCOmipEnergyContracts."Date Created"), ValidTime);

                    if (TodayDT <= DueDT) then begin
                        if SUCOmipManagement.SendContract(SUCOmipEnergyContracts, true) then
                            exit('OK');
                    end else begin
                        SUCOmipEnergyContracts.Status := SUCOmipEnergyContracts.Status::"Out of Time";
                        SUCOmipEnergyContracts.Modify();
                        exit(StrSubstNo(DocumentOutTimeLbl, SUCOmipEnergyContracts."No."));
                    end;
                end;
        end;
    end;

    /// <summary>
    /// Uploads a file to the API.
    /// </summary>
    /// <param name="documentType">The type of document to upload (Proposal or Contract).</param>
    /// <param name="documentNo">The document number.</param>
    /// <param name="fileName">The name of the file.</param>
    /// <param name="base64File">The file content encoded in base64.</param>
    /// <returns>The result of the upload operation.</returns>
    procedure UploadFileAPI(documentType: Enum "SUC Omip Document Type"; documentNo: Code[20]; fileName: Text; base64File: Text): Text
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        OutStream: OutStream;
    begin
        case documentType of
            documentType::Proposal:
                begin
                    SUCOmipProposals.Get(documentNo);
                    Clear(SUCOmipProposals.File);
                    SUCOmipProposals.File.CreateOutStream(OutStream, TextEncoding::UTF8);
                    OutStream.WriteText(base64File);
                    SUCOmipProposals.Validate("File Name", fileName);
                    SUCOmipProposals.Modify();
                    exit('OK');
                end;
            documentType::Contract:
                begin
                    SUCOmipEnergyContracts.Get(documentNo);
                    Clear(SUCOmipEnergyContracts.File);
                    SUCOmipEnergyContracts.File.CreateOutStream(OutStream, TextEncoding::UTF8);
                    OutStream.WriteText(base64File);
                    SUCOmipEnergyContracts.Validate("File Name", fileName);
                    SUCOmipEnergyContracts.Modify();
                    exit('OK');
                end;
        end;
    end;
    /// <summary>
    /// TryLogin.
    /// </summary>
    /// <param name="userName">Text[250].</param>
    /// <param name="userPassword">Text[215].</param>
    /// <returns>Return variable responseText of type Text.</returns>
    procedure TryLoginAPI(userName: Text[250]; userPassword: Text[215]) responseText: Text
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        IncorrectPasswordLbl: Label 'Incorrect Password';
        EmailErrorLbl: Label 'Email does not exist or is disable';
        ExpiredUserLbl: Label 'User %1 is expired';
        ErrorLbl: Label 'Email and password are required';
    begin
        if (userName <> '') and (userPassword <> '') then begin
            SUCOmipExternalUsers.Reset();
            SUCOmipExternalUsers.SetRange("User Name", userName);
            SUCOmipExternalUsers.SetRange(State, SUCOmipExternalUsers.State::Enabled);
            if SUCOmipExternalUsers.FindLast() then
                if userPassword = SUCOmipExternalUsers.GetPassword() then begin
                    if SUCOmipExternalUsers."Expiry Date" <> 0DT then begin
                        if SUCOmipExternalUsers."Expiry Date" > CurrentDateTime then begin
                            UpdateLastAccessDate(SUCOmipExternalUsers."User Name");
                            exit(SUCOmipExternalUsers."User Name")
                        end else begin
                            NewExternalUsersLog(SUCOmipExternalUsers."User Name", StrSubstNo(ExpiredUserLbl, SUCOmipExternalUsers."User Name"));
                            exit(StrSubstNo(ExpiredUserLbl, SUCOmipExternalUsers."User Name"));
                        end
                    end else begin
                        UpdateLastAccessDate(SUCOmipExternalUsers."User Name");
                        exit(SUCOmipExternalUsers."User Name");
                    end;
                end else begin
                    NewExternalUsersLog(SUCOmipExternalUsers."User Name", IncorrectPasswordLbl);
                    exit(IncorrectPasswordLbl)
                end
            else begin
                NewExternalUsersLog(SUCOmipExternalUsers."User Name", EmailErrorLbl);
                exit(EmailErrorLbl);
            end
        end else begin
            NewExternalUsersLog(CopyStr(userName, 1, 100), ErrorLbl);
            responseText := ErrorLbl;
        end;
        exit(responseText);
    end;
    /// <summary>
    /// TryLoginTokenAPI.
    /// </summary>
    /// <param name="userName">Text[250].</param>
    /// <param name="fullName">Text[100].</param>
    /// <param name="state">Enum "SUC Omip Users State".</param>
    /// <param name="licenseType">Enum "SUC Omip Users License Type".</param>
    /// <param name="contactEmail">Text[250].</param>
    /// <returns>Return variable responseText of type Text.</returns>
    procedure TryLoginTokenAPI(userName: Code[100]; fullName: Text[100]; state: Enum "SUC Omip Users State"; licenseType: Enum "SUC Omip Users License Type"; contactEmail: Text[250]; apiKeyExternal: Text[1024]) responseText: Text
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipFEEGroups: Record "SUC Omip FEE Groups";
        SUCOmipManagement: Codeunit "SUC Omip Management";
    begin
        SUCOmipSetup.Get();
        if userName <> '' then begin
            SUCOmipExternalUsers.Reset();
            SUCOmipExternalUsers.SetRange("User Name", userName);
            SUCOmipExternalUsers.SetRange(State, SUCOmipExternalUsers.State::Enabled);
            if SUCOmipExternalUsers.FindLast() then begin
                SUCOmipExternalUsers."Last Access Date" := CurrentDateTime;
                SUCOmipExternalUsers.Modify();
                exit(SUCOmipExternalUsers."User Name")
            end else begin
                SUCOmipExternalUsers.Init();
                SUCOmipExternalUsers."User Name" := userName;
                SUCOmipExternalUsers."Full Name" := fullName;
                SUCOmipExternalUsers.State := state;
                SUCOmipExternalUsers."License Type" := licenseType;
                SUCOmipExternalUsers."Contact Email" := contactEmail;
                SUCOmipExternalUsers."Last Access Date" := CurrentDateTime;
                SUCOmipExternalUsers.Insert();

                if SUCOmipSetup."Default Marketer Ext. Users" <> '' then begin
                    SUCOmipExternalUsers."Filter Marketer" := true;
                    SUCOmipExternalUsers."Marketer No." := SUCOmipSetup."Default Marketer Ext. Users";
                end;

                SUCOmipExternalUsers.SetPassword(apiKeyExternal);

                SUCOmipFEEGroups.Reset();
                SUCOmipFEEGroups.SetRange(Default, true);
                if SUCOmipFEEGroups.FindLast() then
                    SUCOmipManagement.AssignFEEGroupsExternalUsers(SUCOmipExternalUsers, SUCOmipFEEGroups."Group Id.");

                exit(SUCOmipExternalUsers."User Name");
            end;
        end else begin
            NewExternalUsersLog(userName, 'TryLoginTokenAPI: The field User Name is required');
            Error('The field User Name is required');
        end;
    end;

    procedure TryLoginToken2API(userName: Code[100]; fullName: Text[100]; state: Enum "SUC Omip Users State"; licenseType: Enum "SUC Omip Users License Type"; contactEmail: Text[250]; apiKeyExternal: Text[1024]; agentCode: Code[10]) responseText: Text
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipFEEGroups: Record "SUC Omip FEE Groups";
        SUCOmipManagement: Codeunit "SUC Omip Management";
    begin
        SUCOmipSetup.Get();
        if userName <> '' then begin
            SUCOmipExternalUsers.Reset();
            SUCOmipExternalUsers.SetRange("User Name", userName);
            SUCOmipExternalUsers.SetRange(State, SUCOmipExternalUsers.State::Enabled);
            if SUCOmipExternalUsers.FindLast() then begin
                SUCOmipExternalUsers."Last Access Date" := CurrentDateTime;
                if (SUCOmipExternalUsers."Agent Code" = '') and (agentCode <> '') then
                    SUCOmipExternalUsers."Agent Code" := agentCode;
                SUCOmipExternalUsers.Modify();
                exit(SUCOmipExternalUsers."User Name")
            end else begin
                SUCOmipExternalUsers.Init();
                SUCOmipExternalUsers."User Name" := userName;
                SUCOmipExternalUsers."Full Name" := fullName;
                SUCOmipExternalUsers.State := state;
                SUCOmipExternalUsers."License Type" := licenseType;
                SUCOmipExternalUsers."Contact Email" := contactEmail;
                SUCOmipExternalUsers."Agent Code" := agentCode;
                SUCOmipExternalUsers."Last Access Date" := CurrentDateTime;
                SUCOmipExternalUsers.Insert();

                if SUCOmipSetup."Default Marketer Ext. Users" <> '' then begin
                    SUCOmipExternalUsers."Filter Marketer" := true;
                    SUCOmipExternalUsers."Marketer No." := SUCOmipSetup."Default Marketer Ext. Users";
                end;

                SUCOmipExternalUsers.SetPassword(apiKeyExternal);

                SUCOmipFEEGroups.Reset();
                SUCOmipFEEGroups.SetRange(Default, true);
                if SUCOmipFEEGroups.FindLast() then
                    SUCOmipManagement.AssignFEEGroupsExternalUsers(SUCOmipExternalUsers, SUCOmipFEEGroups."Group Id.");

                exit(SUCOmipExternalUsers."User Name");
            end;
        end else begin
            NewExternalUsersLog(userName, 'TryLoginToken2API: The field User Name is required');
            Error('The field User Name is required');
        end;
    end;

    procedure GetDocumentSupport(documentType: Enum "SUC Omip Document Type"; documentNo: Code[20]): Text
    var
        SUCOmipTrackingBTP: Record "SUC Omip Tracking BTP";
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
        AttachedFile: Text;
    begin
        SUCOmipTrackingBTP.Reset();
        SUCOmipTrackingBTP.SetRange("Document Type", documentType);
        SUCOmipTrackingBTP.SetRange("Document No.", documentNo);
        SUCOmipTrackingBTP.SetFilter("BTP status", '%1|%2', 20, 70);
        if SUCOmipTrackingBTP.FindLast() then
            if SUCOmipTrackingBTP."BTP doc".HasValue then begin
                SUCOmipTrackingBTP.CalcFields("BTP doc");
                SUCOmipTrackingBTP."BTP doc".CreateInStream(InStream);
                TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), AttachedFile);
                exit(AttachedFile);
            end else
                Error('The field File is empty');
    end;

    [Obsolete('Replaced by SetRateList2', '25.02')]
    procedure SetRateList(type: Enum "SUC Omip Rate Entry Types"; energyOrigen: Enum "SUC Omip Energy Origen") response: Text
    begin
    end;

    procedure SetRateList2(marketerNo: Code[20]; type: Enum "SUC Omip Rate Entry Types"; energyOrigen: Enum "SUC Omip Energy Origen") response: Text
    var
        SUCOmipMarketers: Record "SUC Omip Marketers";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        ComercialFEE: array[6] of Decimal;
        EnergyCalculationMatrix: array[6] of Decimal;
        RealFEE: array[6] of Decimal;
    begin
        SUCOmipManagement.GetComercialFEESetup(marketerNo, ComercialFEE);
        SUCOmipMarketers.Reset();
        if SUCOmipMarketers.FindSet() then
            repeat
                SUCOmipManagement.SetPricesByTime(type, SUCOmipMarketers."No.", EnergyOrigen::" ", false, ComercialFEE, false, EnergyCalculationMatrix, RealFEE);
            until SUCOmipMarketers.Next() = 0;

        response := 'OK';
    end;

    procedure GetSIPSData(documentType: Enum "SUC Omip Document Type"; documentNo: Code[20]; cups: Text[25]): Text
    var
        SUCOmipManagement: Codeunit "SUC Omip Management";
    begin
        if SUCOmipManagement.GetCUPSInfoFromSIPS(DocumentType, DocumentNo, CUPS) then
            exit('OK');
    end;

    procedure DuplicateProposal(documentNo: Code[20]): Text
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipManagement: Codeunit "SUC Omip Management";

    begin
        SUCOmipProposals.Get(documentNo);
        exit(SUCOmipManagement.DuplicateProposal(SUCOmipProposals));
    end;

    procedure UploadManual(fileDate: DateTime; manualFileName: Text[50]; manualFile: Text): Text
    var
        SUCOmipSetup: Record "SUC Omip Setup";
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup."Manual Date" := fileDate;
        SUCOmipSetup."Manual File Name" := manualFileName;
        SUCOmipSetup.SetManualFile(manualFile);
        exit('Manual file uploaded successfully');
    end;

    procedure DownloadManual(): Text
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
        ManualFileDoc: Text;
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.CalcFields("Manual File");
        if SUCOmipSetup."Manual File".HasValue then begin
            SUCOmipSetup."Manual File".CreateInStream(InStream, TextEncoding::UTF8);
            ManualFileDoc := TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), SUCOmipSetup.FieldName("Manual File"));
            exit(ManualFileDoc);
        end else
            exit('Manual file not found');
    end;

    [Obsolete('Replaced by GenerateContractIndAPI2', '25.02')]
    procedure GenerateContractIndAPI(omipContract: Boolean; marketerNo: Code[20]; energyType: Enum "SUC Energy Type"; rateNo: Code[20];
                                        rateType: Enum "SUC Rate Type Contract"; controlPricesEnergyId: Integer; contractModality: Text[100];
                                        multicups: Boolean; contratationType: Enum "SUC Contratation Type"; agentNo: Code[100]): Code[20]
    begin
    end;

    procedure GenerateContractIndAPI2(productType: Enum "SUC Product Type"; marketerNo: Code[20]; energyType: Enum "SUC Energy Type"; rateNo: Code[20];
    rateType: Enum "SUC Rate Type Contract"; controlPricesEnergyId: Integer; contractModality: Text[100];
    multicups: Boolean; contratationType: Enum "SUC Contratation Type"; agentNo: Code[100]): Code[20]
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        SUCOmipTimes: Enum "SUC Omip Times";
        SUCOmipEnergyOrigen: Enum "SUC Omip Energy Origen";
        SUCOmipRateEntryTypes: Enum "SUC Omip Rate Entry Types";
        DocNo: Code[20];
    begin
        DocNo := SUCOmipManagement.GenerateContractInd3(productType, marketerNo, rateNo, SUCOmipRateEntryTypes::"Type 1", SUCOmipTimes::"12M", SUCOmipEnergyOrigen::" ", multicups, energyType, contratationType, rateType, contractModality, controlPricesEnergyId, agentNo);
        SUCOmipEnergyContracts.Get(DocNo);
        SUCOmipEnergyContracts.Validate("Agent No.", agentNo);
        SUCOmipEnergyContracts.Modify();
        exit(DocNo);
    end;

    [Obsolete('Replaced by GenerateProposalPreviewAPI2', '25.02')]
    procedure GenerateProposalPreviewAPI(proposalNo: Code[20]; rateNo: Code[20]; rateType: Enum "SUC Omip Rate Entry Types"; omipTime: Enum "SUC Omip Times";
                                                 feePotency: Decimal; feeEnergy: Decimal; energyOrigen: Enum "SUC Omip Energy Origen"; marketerNo: Code[20]): Code[20]
    begin
    end;

    [Obsolete('Replaced by GenerateProposalPreviewAPI3', '25.02')]
    procedure GenerateProposalPreviewAPI2(proposalNo: Code[20]; rateNo: Code[20]; rateType: Enum "SUC Omip Rate Entry Types"; omipTime: Enum "SUC Omip Times";
                                             energyOrigen: Enum "SUC Omip Energy Origen"; marketerNo: Code[20]; agentNo: Code[100]): Code[20]
    begin
    end;

    procedure GenerateProposalPreviewAPI3(proposalNo: Code[20]; rateNo: Code[20]; rateType: Enum "SUC Omip Rate Entry Types"; omipTime: Enum "SUC Omip Times";
                                         energyOrigen: Enum "SUC Omip Energy Origen"; marketerNo: Code[20]; agentNo: Code[100]; customerCUPS: Text[25]; feeGroupID: Code[20]): Code[20]
    var
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipProposalPreview: Record "SUC Omip Proposal Preview";
        SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        NewProposalNo: Code[20];
        customerNo: Code[20];
    begin
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Customer No. Proposal Preview");
        customerNo := SUCOmipSetup."Customer No. Proposal Preview";

        if not SUCOmipCustomerCUPS.Get(customerNo, customerCUPS) then
            SUCOmipManagement.SetNewCUPSDefCustPrevProposals(customerNo, customerCUPS);

        if proposalNo = '' then begin
            NewProposalNo := SUCOmipManagement.GenerateProposalPreview3(marketerNo, rateNo, rateType, omipTime, energyOrigen, agentNo, customerNo, customerCUPS, feeGroupID);
            SUCOmipProposalPreview.Get(NewProposalNo);
            SUCOmipProposalPreview.SetDocumentPricesWithCalculation();
            exit(NewProposalNo);
        end else begin
            SUCOmipProposalPreview.Get(proposalNo);
            SUCOmipProposalPreview.SetDocumentPricesWithCalculation();
            exit(SUCOmipManagement.UpdateProposalPreview3(proposalNo, marketerNo, rateNo, rateType, omipTime, energyOrigen, agentNo, customerNo, customerCUPS, feeGroupID));
        end;
    end;

    local procedure NewExternalUsersLog(UserName: Code[100]; Description: Text[250])
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        SUCOmipExternalUsersLog: Record "SUC Omip External Users Log";
    begin
        if SUCOmipExternalUsers.Get(UserName) then begin
            SUCOmipExternalUsersLog.Init();
            SUCOmipExternalUsersLog."User Name" := UserName;
            SUCOmipExternalUsersLog."Line No." := NewLineNoExternalUsersLog(UserName);
            SUCOmipExternalUsersLog.Date := CurrentDateTime;
            SUCOmipExternalUsersLog.Description := Description;
            SUCOmipExternalUsersLog.Insert();
        end;
    end;

    local procedure NewLineNoExternalUsersLog(UserName: Code[100]): Integer
    var
        SUCOmipExternalUsersLog: Record "SUC Omip External Users Log";
    begin
        SUCOmipExternalUsersLog.Reset();
        SUCOmipExternalUsersLog.SetRange("User Name", UserName);
        if SUCOmipExternalUsersLog.FindLast() then
            exit(SUCOmipExternalUsersLog."Line No." + 10000)
        else
            exit(10000);
    end;

    local procedure UpdateLastAccessDate(UserName: Code[100])
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
    begin
        SUCOmipExternalUsers.Get(UserName);
        SUCOmipExternalUsers.Validate("Last Access Date", CurrentDateTime);
        SUCOmipExternalUsers.Modify();
    end;

    procedure UpdatePricesAfterModifyFEEs(documentType: Enum "SUC Omip Document Type"; documentNo: Code[20]): Boolean
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipProposalPreview: Record "SUC Omip Proposal Preview";
        SUCOmipManagement: Codeunit "SUC Omip Management";
    begin
        case documentType of
            documentType::Proposal:
                begin
                    SUCOmipProposals.Get(documentNo);
                    SUCOmipProposals.SetDocumentPricesWithCalculation();
                    SUCOmipManagement.UpdateCommisionsAfterModifyFEEs(documentType, documentNo, SUCOmipProposals."Rate No.");
                    exit(true);
                end;
            documentType::Contract:
                begin
                    SUCOmipEnergyContracts.Get(documentNo);
                    SUCOmipEnergyContracts.SetDocumentPricesWithCalculation();
                    SUCOmipManagement.UpdateCommisionsAfterModifyFEEs(documentType, documentNo, SUCOmipEnergyContracts."Rate No.");
                    exit(true);
                end;
            documentType::"Proposal Preview":
                begin
                    SUCOmipProposalPreview.Get(documentNo);
                    SUCOmipProposalPreview.SetDocumentPricesWithCalculation();
                    SUCOmipManagement.UpdateCommisionsAfterModifyFEEs(documentType, documentNo, SUCOmipProposalPreview."Rate No.");
                    exit(true);
                end;
        end;
    end;

    procedure GenerateProposalProsegurAPI(prosegurTypeUseIn: Code[20]; prosegurTypeAlarmIn: Code[20]; agentNo: Code[100]): Code[20]
    var
        SUCOmipManagement: Codeunit "SUC Omip Management";
        NewProposalNo: Code[20];
    begin
        NewProposalNo := SUCOmipManagement.GenerateProposalProsegur(ProsegurTypeUseIn, ProsegurTypeAlarmIn, agentNo);
        exit(NewProposalNo);
    end;
}