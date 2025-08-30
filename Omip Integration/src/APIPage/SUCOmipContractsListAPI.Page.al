namespace Sucasuc.Omip.API;

using Sucasuc.Omip.Contracts;
/// <summary>
/// Page SUC Omip Energy Contracts List (ID 50188).
/// </summary>
page 50188 "SUC Omip Contracts List API"
{
    APIPublisher = 'sucasuc';
    APIGroup = 'omip';
    APIVersion = 'v2.0';
    EntitySetName = 'sucOmipContractsLists';
    EntityName = 'sucOmipContractsList';
    PageType = API;
    DelayedInsert = true;
    SourceTable = "SUC Omip Energy Contracts";

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(no; Rec."No.") { }
                field(customerNo; Rec."Customer No.") { }
                field(customerName; Rec."Customer Name") { }
                field(customerName2; Rec."Customer Name 2") { }
                field(customerCUPS; Rec."Customer CUPS") { }
                field(vatRegistrationNo; Rec."VAT Registration No.") { }
                field(proposalNo; Rec."Proposal No.") { }
                field(acceptanceMethod; Rec."Acceptance Method") { }
                field(acceptanceSend; Rec."Acceptance Send") { }
                field(address; Rec."SUC Supply Point Address") { }
                field(alternativeAddress; Rec."Alternative Address") { }
                field(bankAccount; Rec.IBAN) { }
                field(bigAccount; Rec."Big Account") { }
                field(cae; Rec.CAE) { }
                field(caeInstallation; Rec."CAE Installation") { }
                field(cmakWh; Rec."CMA (kWh)") { }
                field(cellPhone; Rec."Mobile Phone No.") { }
                field(changeOfOwner; Rec."Change Of Owner") { }
                field(channelSendInvElectronic; Rec."Channel Send Inv. Electronic") { }
                field(completionDate; Rec."Completion Date") { }
                field(consumptionNo; Rec."Consumption No.") { }
                field(dateCreated; Rec."Date Created") { }
                field(dateInvoiceElectronic; Rec."Date Invoice Electronic") { }
                field(debitAccountAuthorization; Rec."Debit Account Authorization") { }
                field(hiredPotency; Rec."Hired Potency") { }
                field(invoiceElectronic; Rec."Invoice Electronic") { }
                field(invoiceElectronicEMail; Rec."Invoice Electronic E-Mail") { }
                field(marketingType; Rec."Marketing Type") { }
                field(noSeriesESend; Rec."No. Series E-Send") { }
                field(paymentMethodCode; Rec."Cust. Payment Method Code") { }
                field(paymentTermsCode; Rec."Cust. Payment Terms Code") { }
                field(phasesNo; Rec."Phases No.") { }
                field(phone; Rec."Phone No.") { }
                field(physicalContractReceived; Rec."Physical Contract Received") { }
                field(postCode; Rec."SUC Supply Point Post Code") { }
                field(proposalTransmitted; Rec."Proposal Transmitted") { }
                field(qtyHiredPotency; Rec."Qty. Hired Potency") { }
                field(rateCategory; Rec."Rate Category") { }
                field(rateNo; Rec."Rate No.") { }
                field(rateType; Rec."Rate Type Contract") { }
                field(renewalDate; Rec."Renewal Date") { }
                field(renovated; Rec.Renovated) { }
                field(requestAcceptance; Rec."Request Acceptance") { }
                field(sepaServicesType; Rec."SEPA Services Type") { }
                field(serieLightMeterNo; Rec."Serie Light Meter No.") { }
                field(shiptoAddress; Rec."Ship-to Address") { }
                field(shiptoAddress2; Rec."Ship-to Address 2") { }
                field(shiptoCity; Rec."Ship-to City") { }
                field(shiptoCode; Rec."Ship-to Code") { }
                field(shiptoName; Rec."Ship-to Name") { }
                field(shiptoName2; Rec."Ship-to Name 2") { }
                field(shiptoPostCode; Rec."Ship-to Post Code") { }
                field(shiptoVATRegistrationNo; Rec."Ship-to VAT Registration No.") { }
                field(signatureDate; Rec."Signature Date") { }
                field(contractStatus; Rec."Contract Status") { }
                field(status; Rec.Status) { }
                field(statusLightMeter; Rec."Status Light Meter") { }
                field(supplyStartDate; Rec."Supply Start Date") { }
                field(telecounting; Rec.Telecounting) { }
                field(times; Rec.Times) { }
                field(type; Rec."Type") { }
                field(voltageNo; Rec."Voltage No.") { }
                field(fileName; Rec."File Name") { }
                field(agentNo; Rec."Proposal Agent No.") { }
                field(agentName; Rec."Agent Name Contract") { }
                field(marketerNo; Rec."Marketer No.") { }
                field(marketerName; Rec."Marketer Name") { }
                field(receiveInvoiceElectronically; Rec."Receive invoice electronically") { }
                field(sendingCommunications; Rec."Sending Communications") { }
                // field(omipContract; Rec."Omip Contract") { }
                field(productType; Rec."Product Type") { }
                field(contractModality; Rec."Contract Modality") { }
                field(contractIdModality; Rec."Contract Id. Modality") { }
                field(contratationType; Rec."Contratation Type") { }
                field(energyType; Rec."Energy Type") { }
                field(multicups; Rec.Multicups) { }
                field(feeGroupId; Rec."FEE Group Id.") { }
                field(systemId; Rec.SystemId) { }
                field(systemCreatedAt; Rec.SystemCreatedAt) { }
                field(systemModifiedAt; Rec.SystemModifiedAt) { }
            }
        }
    }
}