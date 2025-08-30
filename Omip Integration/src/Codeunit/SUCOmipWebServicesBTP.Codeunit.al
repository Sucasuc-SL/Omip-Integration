namespace Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.BTP;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.API;
codeunit 50156 "SUC Omip Web Services BTP"
{
    procedure SetDocumentSupport(ncal: Text[5]; nop: Text[20]; status: Integer; description: Text[250]; doc: Text; fecha: DateTime): Text
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        SUCOmipWebServices: Codeunit "SUC Omip Web Services";
        SUCOmipDocumentType: Enum "SUC Omip Document Type";
        SUCOmipAcceptanceMethod: Enum "SUC Omip Acceptance Method";
        SUCOmipActionTrackingBTP: Enum "SUC Omip Action Tracking BTP";
        NotExistLbl: Label 'Operation code (nop), does not exist.';
    begin
        if SUCOmipProposals.Get(nop) then begin
            SUCOmipDocumentType := SUCOmipDocumentType::Proposal;
            SUCOmipProposals.TestField(Status, SUCOmipProposals.Status::"Pending Acceptance");
        end;

        if SUCOmipEnergyContracts.Get(nop) then begin
            SUCOmipDocumentType := SUCOmipDocumentType::Contract;
            SUCOmipEnergyContracts.TestField(Status, SUCOmipEnergyContracts.Status::"Pending Acceptance");
        end;

        case SUCOmipDocumentType of
            SUCOmipDocumentType::Proposal, SUCOmipDocumentType::Contract:
                begin
                    SUCOmipManagement.NewTrackingBTP2(SUCOmipDocumentType, nop, CurrentDateTime, '', '', '', SUCOmipAcceptanceMethod::" ", '', SUCOmipActionTrackingBTP::" ",
                    ncal, nop, status, description, doc, fecha, false, '');
                    case status of
                        20, 70:
                            begin
                                SUCOmipManagement.SendEmailToPurchases(nop, SUCOmipDocumentType);
                                if SUCOmipDocumentType = SUCOmipDocumentType::Proposal then begin
                                    SUCOmipEnergyContracts.Reset();
                                    SUCOmipEnergyContracts.SetRange("Proposal No.", nop);
                                    if SUCOmipEnergyContracts.FindLast() then
                                        SUCOmipWebServices.SendAcceptanceAPI(SUCOmipDocumentType::Contract, SUCOmipEnergyContracts."No.");
                                end;
                            end;
                        30:
                            case SUCOmipDocumentType of
                                SUCOmipDocumentType::Proposal:
                                    begin
                                        SUCOmipProposals.Validate(Status, SUCOmipProposals.Status::Rejected);
                                        SUCOmipProposals.Modify();
                                    end;
                                SUCOmipDocumentType::Contract:
                                    begin
                                        SUCOmipEnergyContracts.Validate(Status, SUCOmipEnergyContracts.Status::Rejected);
                                        SUCOmipEnergyContracts.Modify();
                                    end;
                            end;
                    end;
                end;
            SUCOmipDocumentType::" ":
                Error(NotExistLbl);
        end;

        exit('OK');
    end;
}