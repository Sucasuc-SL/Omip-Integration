namespace Sucasuc.Omip.Contracts;
using Sucasuc.Omip.BTP;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Utilities;
using System.Text;
using System.Utilities;
/// <summary>
/// Page SUC Omip Energy Contracts (ID 50152)
/// </summary>
page 50152 "SUC Omip Energy Contracts"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "SUC Omip Energy Contracts";
    Caption = 'Omip Contracts';
    ApplicationArea = All;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Type field.';
                    ValuesAllowed = Omip, "Energy (Light - Gas)";
                    trigger OnValidate()
                    begin
                        ViewFields();
                    end;
                }

                field("Contract Status"; Rec."Contract Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Multicups; Rec.Multicups)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Multicups field.';
                    trigger OnValidate()
                    begin
                        ViewFields();
                    end;
                }
                field("Marketer No."; Rec."Marketer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketer No. field.';
                }
                field("Marketer Name"; Rec."Marketer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Marketer Name field.';
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Created field.';
                    Editable = false;
                }
                field("Supply Start Date"; Rec."Supply Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supply Start Date field.';
                }
                group(RateField)
                {
                    Visible = VisibleRateField;
                    ShowCaption = false;
                    field("Rate No."; Rec."Rate No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Rate No. field.';
                    }
                }
                group("Energy Contracts")
                {
                    ShowCaption = false;
                    Visible = not VisibleOmipFields;
                    field("Energy Type"; Rec."Energy Type")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Energy Type field.';
                    }
                    field("Rate Type Contract"; Rec."Rate Type Contract")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Rate Type Contract field.';
                    }
                    field("Contratation Type"; Rec."Contratation Type")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Contratation Type field.';
                    }
                }
                group(Modality)
                {
                    ShowCaption = false;
                    field("Contract Modality"; Rec."Contract Modality")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Contract Modality field.';
                        Editable = not VisibleOmipFields;
                    }
                }
                group("Omip Fields")
                {
                    ShowCaption = false;
                    Visible = VisibleOmipFields;
                    field(Times; Rec.Times)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Time field.';
                    }
                    field(Type; Rec.Type)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Type field.';
                    }
                    field("Energy Origen"; Rec."Energy Origen")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Energy Origen field.';
                    }
                    field("Proposal No."; Rec."Proposal No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Proposal No field.';
                        Editable = false;
                    }
                }
                field("Agent No."; Rec."Agent No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent No. field.';
                }
                field("Agent Name"; Rec."Agent Name Contract")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Name field.';
                }
                group("Omip Fields 2")
                {
                    ShowCaption = false;
                    Visible = VisibleOmipFields;
                    field("FEE Group Id."; Rec."FEE Group Id.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the FEE Group Id. field.';
                    }
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Code field.';
                }
                field("Receive invoice electronically"; Rec."Receive invoice electronically")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Receive invoice electronically field.';
                }
                field("Sending Communications"; Rec."Sending Communications")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sending Communications field.';
                }
                group(Customer)
                {
                    Caption = 'Customer';
                    field("Customer No."; Rec."Customer No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Customer No. field.';
                    }
                    field("Customer Name"; Rec."Customer Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Customer Name field.';
                    }
                    field("VAT Registration No."; Rec."VAT Registration No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the VAT Registration No. field.';
                    }
                    field(Phone; Rec."Phone No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Phone field.';
                    }
                    field("Cell Phone"; Rec."Mobile Phone No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Cell Phone field.';
                    }
                    field("SUC Customer Manager Position"; Rec."SUC Customer Manager Position")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the SUC Customer Manager Position field.';
                    }
                }
                group("Supply Point")
                {
                    Caption = 'Supply Point';
                    Visible = VisibleCUPS;
                    field("Customer CUPS"; Rec."Customer CUPS")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the CUPS field.';
                    }
                    field("SUC Supply Point Address"; Rec."SUC Supply Point Address")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Address of the Supply Point';
                        Editable = false;
                    }
                    field("SUC Supply Point Country"; Rec."SUC Supply Point Country")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Country of the Supply Point';
                        Editable = false;
                    }
                    field("SUC Supply Point Postal Code"; Rec."SUC Supply Point Post Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Postal Code of the Supply Point';
                        Editable = false;
                    }
                    field("SUC Supply Point City"; Rec."SUC Supply Point City")
                    {
                        ApplicationArea = All;
                        ToolTip = 'City of the Supply Point';
                        Editable = false;
                    }
                    field("SUC Supply Point County"; Rec."SUC Supply Point County")
                    {
                        ApplicationArea = All;
                        ToolTip = 'County of the Supply Point';
                        Editable = false;
                    }
                    field("Language Code"; Rec."Language Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Language Code field.';
                    }
                }

                group("SUC Method of Shipment Acceptance")
                {
                    Caption = 'Method of Shipment Acceptance';
                    field("Acceptance Method"; Rec."Acceptance Method")
                    {
                        ToolTip = 'Specifies the value of the Acceptance Method field.';
                        ApplicationArea = All;
                    }
                    field("Acceptance Send"; Rec."Acceptance Send")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Acceptance Send field.';
                    }
                    field(Status; Rec.Status)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Status Acceptance field.';
                    }
                    group("SUC Attach Accepted Document")
                    {
                        Visible = false;
                        Caption = 'Attach Accepted Document';

                        field("File Name"; Rec."File Name")
                        {
                            ToolTip = 'Specifies the value of the File Name field.';
                            ApplicationArea = All;

                            trigger OnAssistEdit()
                            var
                                Base64Convert: Codeunit "Base64 Convert";
                                InStream: InStream;
                                ConfirMsg: Label 'Do you want to replace the file?';
                                OutStream: OutStream;
                                FileName: Text;
                                FileNameClient: Text;
                            begin
                                if Rec.File.HasValue then
                                    if not Confirm(ConfirMsg) then
                                        exit;
                                UploadIntoStream(FileNameClient, '', 'Document Files |*.pdf', FileName, InStream);
                                if not (FileName = '') then begin
                                    Clear(Rec.File);
                                    Rec.File.CreateOutStream(OutStream);
                                    OutStream.Write(Base64Convert.ToBase64(InStream));
                                    Rec.Validate("File Name", CopyStr(FileName, 1, 250));
                                    if not Rec.Modify(true) then
                                        Rec.Insert();
                                end;
                            end;

                            trigger OnDrillDown()
                            var
                                Base64Convert: Codeunit "Base64 Convert";
                                TempBlob: Codeunit "Temp Blob";
                                InStream: InStream;
                                InStream1: InStream;
                                OutStream: OutStream;
                                FileName: Text;
                                FileNameClient: Text;
                            begin
                                if Rec.File.HasValue then begin
                                    Rec.CalcFields(File);
                                    Rec.File.CreateInStream(InStream);
                                    while not (InStream.EOS) do
                                        InStream.Read(FileName);
                                    TempBlob.CreateOutStream(OutStream);
                                    Base64Convert.FromBase64(FileName, OutStream);
                                    TempBlob.CreateInStream(InStream1);
                                    FileNameClient := Rec."File Name";
                                    DownloadFromStream(InStream1, '', '', '', FileNameClient);
                                end;
                            end;
                        }
                    }
                }
                field("Tittle Applicable Conditions"; Rec."Tittle Applicable Conditions")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tittle Applicable Conditions field.';
                    Visible = false;
                }
                field(ConditionsApp; ConditionsApp)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                    Caption = 'Conditions Application';
                    ToolTip = 'Specifies the value of the Conditions Application field.';
                    Visible = false;
                    trigger OnValidate()
                    begin
                        Rec.SetDataBlob(Rec.FieldNo("Body Applicable Conditions"), ConditionsApp);
                    end;
                }
            }
            part("SUC Omip Energy Contracts Mul."; "SUC Omip Energy Contracts Mul.")
            {
                ApplicationArea = All;
                SubPageLink = "Contract No." = field("No.");
                Visible = VisibleMulticups;
            }
            part("SUC Omip FEE Power Document"; "SUC Omip FEE Power Document")
            {
                SubPageLink = "Document Type" = const(Contract), "Document No." = field("No."), "Marketer No." = field("Marketer No.");
                ApplicationArea = All;
                Visible = VisibleOmipContract;
            }
            part("SUC Omip FEE Energy Document"; "SUC Omip FEE Energy Document")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const(Contract), "Document No." = field("No."), "Marketer No." = field("Marketer No.");
                Visible = VisibleOmipContract;
            }
            part("SUC Omip Power Entry Sub Cont."; "SUC Omip Power Entry Sub Cont.")
            {
                ApplicationArea = All;
                SubPageLink = "Contract No." = field("No.");
            }
            part("SUC Omip Energy Entry Sub Cont"; "SUC Omip Energy Entry Sub Cont")
            {
                ApplicationArea = All;
                SubPageLink = "Contract No." = field("No."), Enabled = const(true);
            }
            part("SUC Omip Contracted Power"; "SUC Omip Contracted Power")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const("Contract"), "Document No." = field("No.");
                Visible = VisibleOmipContract;
            }
            part("SUC Omip Consumption Declared"; "SUC Omip Consumption Declared")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const("Contract"), "Document No." = field("No.");
                Visible = VisibleOmipContract;
            }
            part("SUC Commissions Entry"; "SUC Commissions Entry")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const(Contract), "Document No." = field("No.");
            }
            group(Shipment)
            {
                Caption = 'Shipment';

                field("Alternative Address"; Rec."Alternative Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Alternative Address field.';
                    trigger OnValidate()
                    begin
                        EditableShipTo := Rec."Alternative Address";
                    end;
                }
                field("Ship-to Code"; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ship-to Code field.';
                    Editable = EditableShipTo;
                }
                field("Ship-to Name"; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ship-to Name field.';
                    Editable = EditableShipTo;
                }
                field("Ship-to Name 2"; Rec."Ship-to Name 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ship-to Name 2 field.';
                    Editable = EditableShipTo;
                }
                field("Ship-to VAT Registration No."; Rec."Ship-to VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ship-to VAT Registration No. field.';
                    Editable = EditableShipTo;
                }
                field("Ship-to Address"; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ship-to Address field.';
                    Editable = EditableShipTo;
                }
                field("Ship-to Address 2"; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ship-to Address 2 field.';
                    Editable = EditableShipTo;
                }
                field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ship-to Country/Region Code field.';
                    Editable = EditableShipTo;
                }
                field("Ship-to Post Code"; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ship-to Post Code field.';
                    Editable = EditableShipTo;
                }
                field("Ship-to City"; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ship-to City field.';
                    Editable = EditableShipTo;
                }
                field("Ship-to County"; Rec."Ship-to County")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ship-to County field.';
                    Editable = EditableShipTo;
                }


                group("Invoice & Electronic")
                {
                    Caption = 'Data Invoice Electronic';
                    field("Invoice Electronic"; Rec."Invoice Electronic")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Invoice Electronic field.';
                    }
                    field("Invoice Electronic E-Mail"; Rec."Invoice Electronic E-Mail")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Invoice Electronic E-Mail field.';
                    }
                    field("Date Invoice Electronic"; Rec."Date Invoice Electronic")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Date Invoice Electronic field.';
                    }
                    field("Channel Send Inv. Electronic"; Rec."Channel Send Inv. Electronic")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Channel Send Inv. Electronic field.';
                    }
                }
            }
            group("Invoice Details")
            {
                Caption = 'Invoice Details';
                field("Payment Terms Code"; Rec."Cust. Payment Terms Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Terms Code field.';
                }
                field("Payment Method Code"; Rec."Cust. Payment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Method Code field.';
                }

                group("Direct Debit")
                {
                    Caption = 'Direct Debit';

                    field("SEPA Services Type"; Rec."SEPA Services Type")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the SEPA Services Type field.';
                    }
                    field("Bank Account"; Rec.IBAN)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Bank Account field.';
                    }
                    field("Debit Account Authorization"; Rec."Debit Account Authorization")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Debit Account Authorization (ADC) field.';
                    }
                }
            }

            group("Light Meter")
            {
                Caption = 'Light Meter';
                field("Serie Light Meter No."; Rec."Serie Light Meter No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Serie Light Meter No. field.';
                }
                field("Status Light Meter"; Rec."Status Light Meter")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status Light Meter field.';
                }
                field(Telecounting; Rec.Telecounting)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Telecounting field.';
                }
            }
            group(Readings)
            {
                Caption = 'Readings';

                field("CMA (kWh)"; Rec."CMA (kWh)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CMA (kWh) field.';
                }
            }
            field("DateTime Created"; Rec."DateTime Created")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the DateTime Created field.';
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("SUC Omip Send Acceptance")
            {
                Image = SendConfirmation;
                Caption = 'Omip Send Acceptance';
                ToolTip = 'Executes the Omip Send Acceptance action.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.SendContract(Rec, true);
                end;
            }
            action("SUC Cancel BTP")
            {
                ApplicationArea = All;
                Caption = 'Cancel BTP';
                Image = Cancel;
                ToolTip = 'Executes the Cancel BTP action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    SUCOmipDocumentType: Enum "SUC Omip Document Type";
                begin
                    SUCOmipManagement.CancelOperation(SUCOmipDocumentType::Contract, Rec."No.");
                end;
            }
            action("SUC Tracking BTP")
            {
                ApplicationArea = All;
                Caption = 'Tracking BTP';
                Image = Track;
                RunObject = page "SUC Omip Tracking BTP";
                RunPageLink = "Document Type" = const(Contract), "Document No." = field("No.");
                RunPageView = sorting("Document Type", "Document No.", "Line No.") order(descending);
            }
            action("SUC Send to Purchases")
            {
                Image = SendConfirmation;
                Caption = 'Send to Purchases';
                ToolTip = 'Executes the to Purchases action.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                    SUCOmipDocumentType: Enum "SUC Omip Document Type";
                    ConfirmLbl: Label 'Do you want to send the contract to Purchases?';
                begin
                    if Confirm(ConfirmLbl) then
                        SUCOmipManagement.SendEmailToPurchases(Rec."No.", SUCOmipDocumentType::Contract);
                end;
            }
        }
        area(Reporting)
        {
            action("SUC Print Contract")
            {
                Image = Print;
                Caption = 'Print';
                ToolTip = 'Executes the Print action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.PrintContract(Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        ViewFields();
    end;

    trigger OnAfterGetRecord()
    begin
        ViewFields();
        ConditionsApp := Rec.GetDataValueBlob(Rec.FieldNo("Body Applicable Conditions"));
    end;

    local procedure ViewFields()
    begin
        if Rec.Multicups then begin
            VisibleMulticups := true;
            VisibleCUPS := false;
        end else begin
            VisibleMulticups := false;
            VisibleCUPS := true;
        end;

        if Rec."Alternative Address" then
            EditableShipTo := true
        else
            EditableShipTo := false;

        case Rec."Product Type" of
            Rec."Product Type"::Omip:
                begin
                    VisibleOmipFields := true;
                    VisibleOmipContract := true;
                    if Rec.Multicups then
                        VisibleRateField := false
                    else
                        VisibleRateField := true;
                end;
            else begin
                VisibleOmipFields := false;
                VisibleRateField := true;
                VisibleOmipContract := false;
            end;
        end;
    end;

    var
        ConditionsApp: Text;
        VisibleMulticups: Boolean;
        VisibleCUPS: Boolean;
        EditableShipTo: Boolean;
        VisibleOmipFields: Boolean;
        VisibleRateField: Boolean;
        VisibleOmipContract: Boolean;
}