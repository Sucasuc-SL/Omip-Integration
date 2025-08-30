namespace Sucasuc.Omip.Proposals;
using System.Text;
using Sucasuc.Omip.Auditing;
using Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.BTP;
using System.Utilities;
/// <summary>
/// Page SUC Omip Proposals Card (ID 50171).
/// </summary>
page 50171 "SUC Omip Proposals Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "SUC Omip Proposals";
    Caption = 'Omip Proposals';
    ApplicationArea = All;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Proposal No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proposal No. field.';

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
                    ValuesAllowed = Omip, Prosegur;
                    trigger OnValidate()
                    begin
                        ViewFields();
                    end;
                }
                group("Product Type Omip")
                {
                    Visible = VisibleOmip;
                    ShowCaption = false;
                    field(Multicups; Rec.Multicups)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Multicups field.';
                        trigger OnValidate()
                        begin
                            ViewCUPS();
                        end;
                    }
                    field("Marketer No."; Rec."Marketer No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Marketer field.';
                    }
                    field("Marketer Name"; Rec."Marketer Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Marketer Name field.';
                    }
                    field("Date Proposal"; Rec."Date Proposal")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Date Proposal field.';
                    }
                    field("Date Created"; Rec."Date Created")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Date Created field.';
                    }
                    field("Contract Start Date"; Rec."Contract Start Date")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Contract Start Date field.';
                    }
                    group(Rate)
                    {
                        Visible = VisibleCUPS;
                        ShowCaption = false;
                        field("Rate No."; Rec."Rate No.")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Rate No. field.';
                        }
                    }
                    field(Times; Rec.Times)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Time field.', Comment = 'ESP="Tiempo"';
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
                }
                field("Agent No."; Rec."Agent No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent No. field.';
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Name field.';
                }
                group("Product Type Omip 1")
                {
                    Visible = VisibleOmip;
                    ShowCaption = false;
                    field("FEE Group Id."; Rec."FEE Group Id.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the FEE Group Id. field.';
                    }
                }
                group("Product Type Prosegur")
                {
                    Visible = VisibleProsegur;
                    ShowCaption = false;
                    field("Prosegur Type Use"; Rec."Prosegur Type Use")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Prosegur Type Use field.';
                    }
                    field("Prosegur Type Alarm"; Rec."Prosegur Type Alarm")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Prosegur Type Alarm field.';
                    }
                }
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                group("Product Type Omip 2")
                {
                    Visible = VisibleOmip;
                    ShowCaption = false;
                    field("Contract No."; Rec."Contract No.")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Contract No field.';
                    }
                    group(CUPS)
                    {
                        Visible = VisibleCUPS;
                        ShowCaption = false;
                        field("Customer CUPS"; Rec."Customer CUPS")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the CUPS field.';
                        }
                    }
                }
                field("Customer Phone No."; Rec."Customer Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Phone No. field.';
                }
                field("Customer VAT Registration No."; Rec."Customer VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer VAT Registration No. field.';
                }
                group("Product Type Omip 3")
                {
                    Visible = VisibleOmip;
                    ShowCaption = false;
                    group(VolumeGroup)
                    {
                        Visible = VisibleCUPS;
                        ShowCaption = false;
                        field(Volume; Rec.Volume)
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Volume field.';
                        }
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

                    group("SUC Method of Shipment Acceptance")
                    {
                        Caption = 'Method of Shipment Acceptance';
                        field("Acceptance Method"; Rec."Acceptance Method")
                        {
                            ToolTip = 'Specifies the value of the Acceptance Method field.';
                            ApplicationArea = All;
                        }
                        group(AcceptanceSendGroup)
                        {
                            ShowCaption = false;
                            field("Acceptance Send"; Rec."Acceptance Send")
                            {
                                ApplicationArea = All;
                                ToolTip = 'Specifies the value of the Acceptance Send field.';
                            }
                        }
                        field("Request Acceptance"; Rec."Request Acceptance")
                        {
                            ApplicationArea = All;
                            ToolTip = 'Specifies the value of the Request Acceptance field.';
                        }

                        group("SUC Attach Accepted Document")
                        {
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
                                    HeaderLbl: Label 'Document Files |*.pdf';
                                    OutStream: OutStream;
                                    FileName: Text;
                                    FileNameClient: Text;
                                begin
                                    if Rec.File.HasValue then
                                        if not Confirm(ConfirMsg) then
                                            exit;
                                    UploadIntoStream(FileNameClient, '', HeaderLbl, FileName, InStream);
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
                }
            }
            group("Prosegur Installation Address")
            {
                Caption = 'Installation Address';
                Visible = VisibleProsegur;
                field("Customer Address"; Rec."Customer Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Address field.';
                }
                field("Prosegur Type Road"; Rec."Prosegur Type Road")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Type Road field.';
                }
                field("Prosegur Name Road"; Rec."Prosegur Name Road")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Name Road field.';
                }
                field("Prosegur Number Road"; Rec."Prosegur Number Road")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Number Road field.';
                }
                field("Prosegur Floor"; Rec."Prosegur Floor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Floor field.';
                }
                field("Prosegur Country"; Rec."Prosegur Country")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Country field.';
                }
                field("Prosegur Post Code"; Rec."Prosegur Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Postal Code field.';
                }
                field("Prosegur City"; Rec."Prosegur City")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur City field.';
                }
                field("Prosegur County"; Rec."Prosegur County")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur County field.';
                }
            }
            group("Prosegur Billing Information")
            {
                Caption = 'Billing Information';
                Visible = VisibleProsegur;
                field("Prosegur Account Holder"; Rec."Prosegur Account Holder")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Account Holder field.';
                }
                field("Prosegur IBAN"; Rec."Prosegur IBAN")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur IBAN field.';
                }
                field("Prosegur Entity"; Rec."Prosegur Entity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Entity field.';
                }
                field("Prosegur Office"; Rec."Prosegur Office")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Office field.';
                }
                field("Prosegur D.C."; Rec."Prosegur D.C.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur D.C. field.';
                }
                field("Prosegur Account No."; Rec."Prosegur Account No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Account No. field.';
                }
            }
            group("Prosegur Contact Information")
            {
                Caption = 'Contact Information';
                Visible = VisibleProsegur;
                field("Prosegur Contact Person"; Rec."Prosegur Contact Person")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Contact Person field.';
                }
                field("Prosegur Contact Phone"; Rec."Prosegur Contact Phone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Contact Phone field.';
                }
                field("Prosegur Contact Relation"; Rec."Prosegur Contact Relation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Contact Relation field.';
                }
                field("Prosegur Contact Person 2"; Rec."Prosegur Contact Person 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Contact Person 2 field.';
                }
                field("Prosegur Contact Phone 2"; Rec."Prosegur Contact Phone 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Contact Phone 2 field.';
                }
                field("Prosegur Contact Relation 2"; Rec."Prosegur Contact Relation 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prosegur Contact Relation 2 field.';
                }
            }
            part("SUC Omip Proposal Multicups"; "SUC Omip Proposal Multicups")
            {
                ApplicationArea = All;
                SubPageLink = "Proposal No." = field("No.");
                Visible = VisibleMulticups;
            }
            part("SUC Omip FEE Power Document"; "SUC Omip FEE Power Document")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const(Proposal), "Document No." = field("No."), "Marketer No." = field("Marketer No.");
                Visible = VisibleOmip;
            }
            part("SUC Omip FEE Energy Document"; "SUC Omip FEE Energy Document")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const(Proposal), "Document No." = field("No."), "Marketer No." = field("Marketer No.");
                Visible = VisibleOmip;
            }
            part("SUC Omip Power Entry Subform"; "SUC Omip Power Entry Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Proposal No." = field("No.");
                Visible = VisibleOmip;
            }
            part("SUC Omip Energy Entry Subform"; "SUC Omip Energy Entry Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Proposal No." = field("No."), Enabled = const(true);
                Visible = VisibleOmip;
            }
            part("SUC Omip Contracted Power"; "SUC Omip Contracted Power")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const("Proposal"), "Document No." = field("No.");
                Visible = VisibleOmip;
            }
            part("SUC Omip Consumption Declared"; "SUC Omip Consumption Declared")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const("Proposal"), "Document No." = field("No.");
                Visible = VisibleOmip;
            }
            part("SUC Commissions Entry"; "SUC Commissions Entry")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = const(Proposal), "Document No." = field("No.");
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
                Caption = 'Send Acceptance';
                ToolTip = 'Executes the Send Acceptance action.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.SendProposal(Rec);
                end;
            }
            action("SUC Convert to Contract")
            {
                Image = TransferToLines;
                Caption = 'Convert to Contract';
                ToolTip = 'Executes the Convert to Contract action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.GenerateContract(Rec);
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
                    case Rec."Product Type" of
                        Rec."Product Type"::Omip:
                            SUCOmipManagement.CancelOperation(SUCOmipDocumentType::Proposal, Rec."No.");
                    end;
                end;
            }
            action("SUC Tracking BTP")
            {
                ApplicationArea = All;
                Caption = 'Tracking BTP';
                Image = Track;
                RunObject = page "SUC Omip Tracking BTP";
                RunPageLink = "Document Type" = const(Proposal), "Document No." = field("No.");
                RunPageView = sorting("Document Type", "Document No.", "Line No.") order(descending);
                ToolTip = 'Executes the Tracking BTP action.';
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
                    ConfirmLbl: Label 'Do you want to send the proposal to Purchases?';
                begin
                    case Rec."Product Type" of
                        Rec."Product Type"::Omip:
                            if Confirm(ConfirmLbl) then
                                SUCOmipManagement.SendEmailToPurchases(Rec."No.", SUCOmipDocumentType::Proposal);
                    end;
                end;
            }
            action("SUC Duplicate Proposal")
            {
                Image = Copy;
                Caption = 'Duplicate Proposal';
                ToolTip = 'Executes the Duplicate Proposal action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.DuplicateProposal(Rec);
                end;
            }
        }
        area(Reporting)
        {
            action("SUC Print Proposal")
            {
                Image = Print;
                Caption = 'Print';
                ToolTip = 'Executes the Print action.';
                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.PrintProposal(Rec);
                end;
            }
        }
        area(Navigation)
        {
            action("SUC Comment Line")
            {
                ApplicationArea = All;
                Caption = 'Comments';
                Image = Comment;
                RunObject = page "SUC Omip Comment Line";
                RunPageLink = "No." = field("No."), "Document Type" = const(Proposal);
                ToolTip = 'Executes the Comments action.';
            }
            action("SUC Change Log Entry")
            {
                Image = Log;
                Caption = 'Change Log Entry';
                ToolTip = 'Executes the Change Log Entry action.';
                RunObject = page "SUC Omip Change Log Entries";
                RunPageLink = "Primary Key field 1 Value" = field("No.");
            }
        }
    }
    trigger OnOpenPage()
    begin
        ViewCUPS();
        ViewFields();
    end;

    trigger OnAfterGetRecord()
    begin
        ViewCUPS();
        ViewFields();
    end;

    local procedure ViewCUPS()
    begin
        if Rec.Multicups then begin
            VisibleMulticups := true;
            VisibleCUPS := false;
        end else begin
            VisibleMulticups := false;
            VisibleCUPS := true;
        end;
    end;

    local procedure ViewFields()
    begin
        case Rec."Product Type" of
            Rec."Product Type"::Omip:
                begin
                    VisibleOmip := true;
                    VisibleProsegur := false;
                    ViewCUPS();
                end;
            Rec."Product Type"::Prosegur:
                begin
                    VisibleOmip := false;
                    VisibleMulticups := false;
                    VisibleProsegur := true;
                end;
            else begin
                VisibleOmip := false;
                VisibleProsegur := false;
            end;
        end;
    end;

    var
        VisibleMulticups: Boolean;
        VisibleCUPS: Boolean;
        VisibleOmip: Boolean;
        VisibleProsegur: Boolean;
}