namespace Sucasuc.Omip.Proposals;
using Sucasuc.Omip.User;
using Microsoft.Sales.Customer;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Auditing;
using Sucasuc.Omip.Setup;
using Sucasuc.Omip.Prosegur;
using Microsoft.Foundation.Address;
using Microsoft.Foundation.NoSeries;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Utilities;
/// <summary>
/// Table SUC Proposel (ID 50115).
/// </summary>
table 50165 "SUC Omip Proposals"
{
    Caption = 'Omip Proposals';
    LookupPageId = "SUC Omip Proposals";
    DrillDownPageId = "SUC Omip Proposals";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Proposal No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                if "No." <> xRec."No." then begin
                    SUCOmipSetup.Get();
                    NoSeries.TestManual(SUCOmipSetup."Proposal Nos.");
                    "No." := '';
                end;
            end;
        }
        field(2; "Date Proposal"; Date)
        {
            Caption = 'Date Proposal';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(3; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                if not Multicups then
                    ClearFEEs();
                SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::Proposal, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::Proposal, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                ValidationsCustomerCUPSandRateNo();
            end;
        }
        field(4; Times; Enum "SUC Omip Times")
        {
            Caption = 'Time';

            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                if not Rec.Multicups then
                    TestField("Rate No.");

                if (Rec.Times <> Rec.Times::" ") or (Rec.Times <> xRec.Times) then
                    if Type <> Type::" " then begin
                        TestField("Marketer No.");
                        SetDocumentPricesWithCalculation();
                    end;
            end;
        }
        field(5; Type; Enum "SUC Omip Rate Entry Types")
        {
            Caption = 'Type';

            trigger OnValidate()
            var
                SUCOmipTypes: Record "SUC Omip Types";
            begin
                TestField(Status, Status::"Pending Acceptance");
                if not Rec.Multicups then
                    TestField("Rate No.");

                TestField(Times);
                if (Rec.Type <> Rec.Type::" ") or (Rec.Type <> xRec.Type) then begin
                    TestField("Marketer No.");

                    SetDocumentPricesWithCalculation();

                    if SUCOmipTypes.Get(Type) then begin
                        SUCOmipTypes.TestField("Start Date Contract");
                        "Contract Start Date" := CalcDate('<-CM>', CalcDate(SUCOmipTypes."Start Date Contract", "Date Proposal"));
                    end else
                        "Contract Start Date" := 0D;
                end;
            end;
        }
        field(6; "FEE Potency"; Decimal)
        {
            Caption = 'FEE Potency';
            Editable = false;
            DecimalPlaces = 0 : 6;
            // trigger OnValidate()
            // begin
            //     TestField(Status, Status::"Pending Acceptance");
            //     if not Rec.Multicups then
            //         TestField("Rate No.");

            //     TestField(Times);
            //     TestField(Type);
            //     if (Rec."FEE Potency" <> 0) or (Rec."FEE Potency" <> xRec."FEE Potency") then
            //         GetCalculateEnergy();
            // end;
        }
        field(7; "Energy Origen"; Enum "SUC Omip Energy Origen")
        {
            Caption = 'Energy Origen';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(8; "Agent No."; Code[100])
        {
            Caption = 'Agent No.';
            TableRelation = "SUC Omip External Users"."User Name";
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                GroupFEEId: Code[20];
            begin
                TestField(Status, Status::"Pending Acceptance");
                CalcFields("Agent Name");

                case "Product Type" of
                    "Product Type"::Omip:
                        begin
                            GroupFEEId := SUCOmipManagement.GetUserFEEGroupIdDefault("Agent No.");
                            Validate("FEE Group Id.", GroupFEEId);
                            ClearCommisionEntry();
                        end;
                end;
            end;
        }
        field(9; "Agent Name"; Text[100])
        {
            Caption = 'Agent Name';
            CalcFormula = lookup("SUC Omip External Users"."Full Name" where("User Name" = field("Agent No.")));
            FieldClass = FlowField;
        }
        field(10; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Customer: Record Customer;
                CustomerBankAccount: Record "Customer Bank Account";
            begin
                TestField(Status, Status::"Pending Acceptance");
                if Customer.Get("Customer No.") then
                    Customer.TestField("Duplicate State", Customer."Duplicate State"::" ");
                CalcFields("Customer Name");
                CalcFields("Customer Phone No.");
                CalcFields("Customer VAT Registration No.");
                CalcFields("Customer Address");
                if Customer.Get("Customer No.") then
                    if Customer."Preferred Bank Account Code" <> '' then begin
                        CustomerBankAccount.Get("Customer No.", Customer."Preferred Bank Account Code");
                        IBAN := CustomerBankAccount.IBAN;
                    end;
                case "Product Type" of
                    "Product Type"::Prosegur:
                        begin
                            Validate("Prosegur Post Code", Customer."Post Code");
                            Validate("Prosegur City", Customer.City);
                            Validate("Prosegur County", Customer."County");
                        end;
                end;
            end;
        }
        field(11; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
        field(12; "Contract Start Date"; Date)
        {
            Caption = 'Contract Start Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(13; Status; Enum "SUC Omip Document Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ValidTime: Time;
                TodayDT: DateTime;
                DueDT: DateTime;
                ErrorDueDateLbl: Label 'It is not possible to assign the status "Out of Time" due to the validity period.';
            begin
                case Status of
                    Status::"Pending Acceptance":
                        xRec.TestField(Status, Status::"Pending Acceptance");
                    Status::Accepted:
                        begin
                            xRec.TestField(Status, Status::"Pending Acceptance");
                            case "Product Type" of
                                "Product Type"::Omip:
                                    begin
                                        if "Contract No." <> '' then
                                            Error(StatusAcceptedLbl, Rec."No.");

                                        RequiredFields();
                                        SUCOmipManagement.GenerateContract(Rec);
                                    end;
                            end;
                        end;
                    Status::Rejected:
                        xRec.TestField(Status, Status::"Pending Acceptance");
                    Status::"Out of Time":
                        begin
                            xRec.TestField(Status, Status::"Pending Acceptance");
                            case "Product Type" of
                                "Product Type"::Omip:
                                    begin
                                        SUCOmipSetup.Get();
                                        ValidTime := DT2Time("DateTime Created");
                                        TodayDT := CreateDateTime(Today, ValidTime);
                                        DueDT := CreateDateTime(CalcDate(Format(SUCOmipSetup."Time Validity Proposals"), "Date Created"), ValidTime);

                                        if (TodayDT < DueDT) then
                                            Error(ErrorDueDateLbl);
                                    end;
                            end;
                        end;
                    Status::Canceled:
                        xRec.TestField(Status, Status::Accepted);
                end;
                SUCOmipManagement.SetNewCustomerDocs(SUCOmipDocumentType::Proposal, "No.", "Customer No.", Status, CurrentDateTime, "Agent No.");
            end;
        }
        field(14; "Acceptance Method"; Enum "SUC Omip Acceptance Method")
        {
            Caption = 'Acceptance Method';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                TestField(Status, Status::"Pending Acceptance");
                if ("Customer No." <> '') then begin
                    Customer.Get("Customer No.");
                    case "Acceptance Method" of
                        "Acceptance Method"::Email:
                            if Customer."E-Mail" <> '' then
                                Validate("Acceptance Send", Customer."E-Mail")
                            else
                                Validate("Acceptance Send", '');
                        "Acceptance Method"::SMS:
                            if Customer."Mobile Phone No." <> '' then
                                Validate("Acceptance Send", Customer."Mobile Phone No.")
                            else
                                Validate("Acceptance Send", '');
                        else
                            Validate("Acceptance Send", '');
                    end;
                end;
            end;
        }
        field(15; "Acceptance Send"; Text[250])
        {
            Caption = 'Acceptance Send';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(16; "File Name"; Text[250])
        {
            Caption = 'File Name';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                if "File Name" <> '' then
                    Validate(Status);
            end;
        }
        field(17; "File"; Blob)
        {
            Caption = 'File';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(18; "Date Created"; Date)
        {
            Caption = 'Date Created';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(19; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            Editable = false;
            TableRelation = "SUC Omip Energy Contracts"."No.";
        }
        field(20; "Rate Category"; Code[20])
        {
            Caption = 'Rate Category';
            TableRelation = "SUC Omip Rate Category"."Category Code";
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                SUCOmipRateCategory: Record "SUC Omip Rate Category";
            begin
                TestField(Status, Status::"Pending Acceptance");
                SUCOmipRateCategory.Get("Rate Category");
                // Validate("FEE Potency", SUCOmipRateCategory."FEE Potency");
                // Validate("FEE Energy", SUCOmipRateCategory."FEE Energy");
            end;
        }
        field(21; "Customer CUPS"; Text[25])
        {
            Caption = 'CUPS';
            TableRelation = "SUC Omip Customer CUPS".CUPS where("Customer No." = field("Customer No."));
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                ClearCommisionEntry();
                ValidationsCustomerCUPSandRateNo();

                if ("Customer CUPS" = '') and (xRec."Customer CUPS" <> '') then begin
                    ClearContractedPower(xRec."Customer CUPS");
                    ClearConsumptionDeclared(xRec."Customer CUPS");
                end;
            end;
        }
        field(22; "Customer Phone No."; Text[30])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Phone No." where("No." = field("Customer No.")));
        }
        field(23; "Customer VAT Registration No."; Text[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."VAT Registration No." where("No." = field("Customer No.")));
        }
        field(24; "Marketer No."; Code[20])
        {
            Caption = 'Marketer';
            TableRelation = "SUC Omip Marketers"."No.";
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                CalcFields("Marketer Name");
                SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::Proposal, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::Proposal, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SetDocumentPricesWithCalculation();
            end;
        }
        field(25; "Marketer Name"; Text[250])
        {
            Caption = 'Marketer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Marketers".Name where("No." = field("Marketer No.")));
        }
        field(26; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(27; "Proposal Transmitted"; Boolean)
        {
            Caption = 'Proposal transmitted';
            DataClassification = CustomerContent;
        }
        field(28; "Request Acceptance"; Text[100])
        {
            Caption = 'Request Acceptance';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(29; "Volume"; Decimal)
        {
            Caption = 'Volume';
            Editable = false;
            DecimalPlaces = 0 : 0;
        }
        field(30; "Receive invoice electronically"; Boolean)
        {
            Caption = 'Receive invoice electronically';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(31; "Sending Communications"; Boolean)
        {
            Caption = 'Sending Communications';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(32; "FEE Energy"; Decimal)
        {
            Caption = 'FEE Energy';
            Editable = false;
            DecimalPlaces = 0 : 6;
            // trigger OnValidate()
            // begin
            //     TestField(Status, Status::"Pending Acceptance");
            // end;
        }
        field(33; Multicups; Boolean)
        {
            Caption = 'Multicups';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                if Rec.Multicups then begin
                    Rec."Rate No." := '';
                    Rec."Customer CUPS" := '';
                    ClearPowerEntry();
                    ClearEnergyEntry();
                    ClearContractedPower("Customer CUPS");
                    ClearConsumptionDeclared("Customer CUPS");
                end else
                    ClearMulticups();

                ClearFEEs();
                ClearCommisionEntry();

                SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::Proposal, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::Proposal, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
            end;
        }
        field(34; "DateTime Created"; DateTime)
        {
            Caption = 'DateTime Created';
        }
        field(35; IBAN; Code[50])
        {
            Caption = 'Customer IBAN';
            DataClassification = CustomerContent;
        }
        field(36; "FEE Group Id."; Code[20])
        {
            Caption = 'FEE Group Id.';
            TableRelation = "SUC Omip Ext. Users Groups FEE"."Group Id." where("User Name" = field("Agent No."));
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::Proposal, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::Proposal, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SetDocumentPricesWithCalculation();
                SUCOmipManagement.UpdateCommisionsAfterModifyFEEs(SUCOmipDocumentType::Proposal, "No.", Rec."Rate No.")
            end;
        }
        field(37; "Product Type"; Enum "SUC Product Type")
        {
            Caption = 'Product Type';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                case "Product Type" of
                    "Product Type"::Prosegur:
                        begin
                            ClearPowerEntry();
                            ClearEnergyEntry();
                            ClearContractedPower("Customer CUPS");
                            ClearConsumptionDeclared("Customer CUPS");
                            ClearMulticups();
                            ClearFEEs();
                        end;
                    "Product Type"::Omip:
                        ClearProsegur();
                end;
            end;
        }
        field(38; "Prosegur Type Use"; Code[20])
        {
            Caption = 'Type Use';
            TableRelation = "SUC Prosegur Type Uses"."No.";
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(39; "Prosegur Type Alarm"; Code[20])
        {
            Caption = 'Type Alarm';
            TableRelation = "SUC Prosegur Type Alarm"."No. Type Alarm" where("No. Type Use" = field("Prosegur Type Use"));
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(40; "Prosegur Type Road"; Text[50])
        {
            Caption = 'Type of Road';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(41; "Prosegur Name Road"; Text[50])
        {
            Caption = 'Name of Road';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(42; "Prosegur Number Road"; Text[50])
        {
            Caption = 'Number of Road';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(43; "Prosegur Floor"; Text[50])
        {
            Caption = 'Floor';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(44; "Prosegur County"; Text[30])
        {
            CaptionClass = '5,1,' + "Prosegur Country";
            Caption = 'County';
        }
        field(45; "Prosegur Country"; Code[10])
        {
            Caption = 'Country/Region';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                CityTxt: Text;
                CountyTxt: Text;
            begin
                TestField(Status, Status::"Pending Acceptance");

                CityTxt := "Prosegur City";
                CountyTxt := "Prosegur County";
                PostCode.CheckClearPostCodeCityCounty(CityTxt, "Prosegur Post Code", CountyTxt, "Prosegur Country", xRec."Prosegur Country");
                "Prosegur City" := CopyStr(CityTxt, 1, 30);
                "Prosegur County" := CopyStr(CountyTxt, 1, 30);
            end;
        }
        field(46; "Prosegur Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = if ("Prosegur Post Code" = const('')) "Post Code"
            else
            if ("Prosegur Post Code" = filter(<> '')) "Post Code" where("Country/Region Code" = field("Prosegur Country"));
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                CityTxt: Text;
                CountyTxt: Text;
            begin
                TestField(Status, Status::"Pending Acceptance");
                CityTxt := "Prosegur City";
                CountyTxt := "Prosegur County";
                PostCode.LookupPostCode(CityTxt, "Prosegur Post Code", CountyTxt, "Prosegur Country");
                "Prosegur City" := CopyStr(CityTxt, 1, 30);
                "Prosegur County" := CopyStr(CountyTxt, 1, 30);
            end;

            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                PostCode.ValidatePostCode("Prosegur City", "Prosegur Post Code", "Prosegur County", "Prosegur Country", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(47; "Prosegur City"; Text[30])
        {
            Caption = 'City';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(48; "Prosegur Account Holder"; Text[100])
        {
            Caption = 'Account Holder';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(49; "Prosegur IBAN"; Code[50])
        {
            Caption = 'IBAN';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(50; "Prosegur Entity"; Code[20])
        {
            Caption = 'Entity';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(51; "Prosegur Office"; Text[100])
        {
            Caption = 'Office';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(52; "Prosegur D.C."; Text[20])
        {
            Caption = 'D.C.';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(53; "Prosegur Account No."; Text[20])
        {
            Caption = 'Account No.';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(54; "Prosegur Contact Person"; Text[100])
        {
            Caption = 'Contact Person';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(55; "Prosegur Contact Phone"; Text[30])
        {
            Caption = 'Contact Phone';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(56; "Prosegur Contact Relation"; Text[100])
        {
            Caption = 'Contact Relation';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(57; "Prosegur Contact Person 2"; Text[100])
        {
            Caption = 'Contact Person 2';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(58; "Prosegur Contact Phone 2"; Text[30])
        {
            Caption = 'Contact Phone 2';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(59; "Prosegur Contact Relation 2"; Text[100])
        {
            Caption = 'Contact Relation 2';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(60; "Customer Address"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Address where("No." = field("Customer No.")));
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SUCOmipSetup.Get();
            SUCOmipSetup.TestField("Proposal Nos.");
            "No." := NoSeries.GetNextNo(SUCOmipSetup."Proposal Nos.", WorkDate());
            "Date Created" := Today;
            Status := Status::"Pending Acceptance";
        end;

        RecordRef.GetTable(Rec);
        SUCOmipChangeLogManagement.LogInsertion(RecordRef);
    end;

    trigger OnModify()
    begin
        RecordRef.GetTable(Rec);
        SUCOmipChangeLogManagement.LogModification(RecordRef);
    end;

    trigger OnDelete()
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    begin
        SUCOmipSetup.Get();
        if SUCOmipSetup."Allow Delete Related Documents" then begin
            if "Contract No." <> '' then begin
                SUCOmipEnergyContracts.Get("Contract No.");
                SUCOmipEnergyContracts."Proposal No." := '';
                SUCOmipEnergyContracts.Modify();
            end;
        end else
            TestField("Contract No.", '');
        RecordRef.GetTable(Rec);
        SUCOmipChangeLogManagement.LogDeletion(RecordRef);
        DeleteTrackingBTP(Rec);
    end;

    trigger OnRename()
    begin
        TestField("Contract No.", '');
        RecordRef.GetTable(Rec);
        xRecordRef.GetTable(Rec);
        SUCOmipChangeLogManagement.LogRename(RecordRef, xRecordRef);
    end;

    /// <summary>
    /// AssistEdit.
    /// </summary>
    /// <param name="OldSUCOmipProposals">Record "SUC Omip Proposals".</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure AssistEdit(OldSUCOmipProposals: Record "SUC Omip Proposals"): Boolean
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
    begin
        SUCOmipProposals := Rec;
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Proposal Nos.");
        if NoSeries.LookupRelatedNoSeries(SUCOmipSetup."Proposal Nos.", OldSUCOmipProposals."No. Series", SUCOmipProposals."No. Series") then begin
            SUCOmipSetup.Get();
            SUCOmipSetup.TestField("Proposal Nos.");
            SUCOmipProposals."No." := NoSeries.GetNextNo(SUCOmipProposals."No. Series");
            Rec := SUCOmipProposals;
            exit(true);
        end;
    end;

    procedure SetDocumentPrices(RateNo: Code[20]; TypeIn: Enum "SUC Omip Rate Entry Types"; TimesIn: Enum "SUC Omip Times")
    var
    // SUCOmipProposalMulticups: Record "SUC Omip Proposal Multicups";
    // RatesProcessed: List of [Code[20]];
    begin
        // if Multicups then begin
        //     Clear(RatesProcessed);
        //     // if ((Rec.Times <> Rec.Times::" ") or (Rec.Times <> xRec.Times)) or ((Rec.Type <> Rec.Type::" ") or (Rec.Type <> xRec.Type)) or ((Rec."FEE Potency" <> 0) or (Rec."FEE Potency" <> xRec."FEE Potency")) then begin
        //     if ((Rec.Times <> Rec.Times::" ") or (Rec.Times <> xRec.Times)) or ((Rec.Type <> Rec.Type::" ") or (Rec.Type <> xRec.Type)) then begin
        //         SUCOmipProposalMulticups.Reset();
        //         SUCOmipProposalMulticups.SetRange("Proposal No.", "No.");
        //         if SUCOmipProposalMulticups.FindSet() then
        //             repeat
        //                 if not RatesProcessed.Contains(SUCOmipProposalMulticups."Rate No.") then begin
        //                     SUCOmipManagement.CalculateEnergy2(Rec, SUCOmipProposalMulticups."Rate No.", Type, Times);
        //                     RatesProcessed.Add(SUCOmipProposalMulticups."Rate No.");
        //                 end;
        //             until SUCOmipProposalMulticups.Next() = 0;
        //     end;
        // end else
        // SUCOmipManagement.CalculateEnergy2(Rec, "Rate No.", Type, Times);
        SUCOmipManagement.CalculateEnergy2(Rec, RateNo, TypeIn, TimesIn);
    end;

    local procedure RequiredFields()
    var
        FileErrorLbl: Label 'You must attach the document accepting the proposal.';
    begin
        TestField("No.");
        TestField("Date Created");
        TestField("Date Proposal");

        if not Rec.Multicups then
            TestField("Rate No.");

        TestField(Times);
        TestField(Type);
        TestField("Contract Start Date");
        TestField("Customer No.");
        TestField("Marketer No.");
        if (Status = Status::Accepted) and ("Acceptance Method" = "Acceptance Method"::Paper) then begin
            CalcFields(File);
            if not File.HasValue then
                Error(FileErrorLbl);
        end;
    end;

    local procedure DeleteTrackingBTP(SUCOmipProposalsIn: Record "SUC Omip Proposals")
    var
        SUCOmipTrackingBTP: Record "SUC Omip Tracking BTP";
    begin
        SUCOmipTrackingBTP.Reset();
        SUCOmipTrackingBTP.SetRange("Document Type", SUCOmipTrackingBTP."Document Type"::Proposal);
        SUCOmipTrackingBTP.SetRange("Document No.", SUCOmipProposalsIn."No.");
        if SUCOmipTrackingBTP.FindSet() then
            repeat
                SUCOmipTrackingBTP.Delete();
            until SUCOmipTrackingBTP.Next() = 0;
    end;

    local procedure ClearPowerEntry()
    var
        SUCOmipPowerEntry: Record "SUC Omip Power Entry";
    begin
        SUCOmipPowerEntry.Reset();
        SUCOmipPowerEntry.SetRange("Proposal No.", "No.");
        if SUCOmipPowerEntry.FindSet() then
            repeat
                SUCOmipPowerEntry.Delete();
            until SUCOmipPowerEntry.Next() = 0;
    end;

    local procedure ClearEnergyEntry()
    var
        SUCOmipEnergyEntry: Record "SUC Omip Energy Entry";
    begin
        SUCOmipEnergyEntry.Reset();
        SUCOmipEnergyEntry.SetRange("Proposal No.", "No.");
        if SUCOmipEnergyEntry.FindSet() then
            repeat
                SUCOmipEnergyEntry.Delete();
            until SUCOmipEnergyEntry.Next() = 0;
    end;

    local procedure ClearContractedPower(byCUPS: Text[25])
    var
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
    begin
        SUCOmipContractedPower.Reset();
        SUCOmipContractedPower.SetRange("Document Type", SUCOmipContractedPower."Document Type"::Proposal);
        SUCOmipContractedPower.SetRange("Document No.", "No.");
        if byCUPS <> '' then
            SUCOmipContractedPower.SetRange("CUPS", byCUPS);
        if SUCOmipContractedPower.FindSet() then
            repeat
                SUCOmipContractedPower.Delete();
            until SUCOmipContractedPower.Next() = 0;
    end;

    local procedure ClearConsumptionDeclared(byCUPS: Text[25])
    var
        SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
    begin
        SUCOmipConsumptionDeclared.Reset();
        SUCOmipConsumptionDeclared.SetRange("Document Type", SUCOmipConsumptionDeclared."Document Type"::Proposal);
        SUCOmipConsumptionDeclared.SetRange("Document No.", "No.");
        if byCUPS <> '' then
            SUCOmipConsumptionDeclared.SetRange("CUPS", byCUPS);
        if SUCOmipConsumptionDeclared.FindSet() then
            repeat
                SUCOmipConsumptionDeclared.Delete();
            until SUCOmipConsumptionDeclared.Next() = 0;
    end;

    local procedure ClearMulticups()
    var
        SUCOmipProposalMulticups: Record "SUC Omip Proposal Multicups";
    begin
        SUCOmipProposalMulticups.Reset();
        SUCOmipProposalMulticups.SetRange("Proposal No.", "No.");
        if SUCOmipProposalMulticups.FindSet() then
            repeat
                SUCOmipProposalMulticups.Delete(true);
            until SUCOmipProposalMulticups.Next() = 0;
    end;

    local procedure ClearFEEs()
    var
        SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
        SUCOmipFEEEnergyDocument: Record "SUC Omip FEE Energy Document";
    begin
        SUCOmipFEEPowerDocument.Reset();
        SUCOmipFEEPowerDocument.SetRange("Document Type", SUCOmipFEEPowerDocument."Document Type"::Proposal);
        SUCOmipFEEPowerDocument.SetRange("Document No.", "No.");
        SUCOmipFEEPowerDocument.DeleteAll();

        SUCOmipFEEEnergyDocument.Reset();
        SUCOmipFEEEnergyDocument.SetRange("Document Type", SUCOmipFEEEnergyDocument."Document Type"::Proposal);
        SUCOmipFEEEnergyDocument.SetRange("Document No.", "No.");
        SUCOmipFEEEnergyDocument.DeleteAll();
    end;

    local procedure UpdateContractedPower(ArrayPotence: array[6] of Decimal)
    var
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
    begin
        SUCOmipContractedPower.Reset();
        SUCOmipContractedPower.SetRange("Document Type", SUCOmipContractedPower."Document Type"::Proposal);
        SUCOmipContractedPower.SetRange("Document No.", "No.");
        if SUCOmipContractedPower.FindSet() then
            repeat
                SUCOmipContractedPower.Delete();
            until SUCOmipContractedPower.Next() = 0;

        if not SUCOmipContractedPower.Get(SUCOmipContractedPower."Document Type"::Proposal, "No.", "Customer CUPS") then begin
            SUCOmipContractedPower.Init();
            SUCOmipContractedPower.Validate("Document Type", SUCOmipContractedPower."Document Type"::Proposal);
            SUCOmipContractedPower.Validate("Document No.", "No.");
            SUCOmipContractedPower.CUPS := "Customer CUPS";
            SUCOmipContractedPower.Insert();

            SUCOmipContractedPower."Rate No." := "Rate No.";
            SUCOmipContractedPower.P1 := ArrayPotence[1];
            if ArrayPotence[1] <> 0 then
                SUCOmipContractedPower."P1 From SIPS" := true;
            SUCOmipContractedPower.P2 := ArrayPotence[2];
            if ArrayPotence[2] <> 0 then
                SUCOmipContractedPower."P2 From SIPS" := true;
            SUCOmipContractedPower.P3 := ArrayPotence[3];
            if ArrayPotence[3] <> 0 then
                SUCOmipContractedPower."P3 From SIPS" := true;
            SUCOmipContractedPower.P4 := ArrayPotence[4];
            if ArrayPotence[4] <> 0 then
                SUCOmipContractedPower."P4 From SIPS" := true;
            SUCOmipContractedPower.P5 := ArrayPotence[5];
            if ArrayPotence[5] <> 0 then
                SUCOmipContractedPower."P5 From SIPS" := true;
            SUCOmipContractedPower.P6 := ArrayPotence[6];
            if ArrayPotence[6] <> 0 then
                SUCOmipContractedPower."P6 From SIPS" := true;

            if (ArrayPotence[1] <> 0) or (ArrayPotence[2] <> 0) or (ArrayPotence[3] <> 0) or (ArrayPotence[4] <> 0) or (ArrayPotence[5] <> 0) or (ArrayPotence[6] <> 0) then
                SUCOmipContractedPower."SIPS Information" := true
            else
                SUCOmipContractedPower."SIPS Information" := false;

            SUCOmipContractedPower.Total := SUCOmipContractedPower.P1 + SUCOmipContractedPower.P2 + SUCOmipContractedPower.P3 + SUCOmipContractedPower.P4 + SUCOmipContractedPower.P5 + SUCOmipContractedPower.P6;
            //* Commisions
            SUCOmipContractedPower.CalculateCommision();
            //* End Commisions
            SUCOmipContractedPower.Modify();
            SUCOmipContractedPower.UpdateMulticups();
        end;
    end;

    local procedure UpdateConsumptionDeclared(ArraykWhAnual: array[6] of Decimal)
    var
        SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
    begin
        SUCOmipConsumptionDeclared.Reset();
        SUCOmipConsumptionDeclared.SetRange("Document Type", SUCOmipConsumptionDeclared."Document Type"::Proposal);
        SUCOmipConsumptionDeclared.SetRange("Document No.", "No.");
        if SUCOmipConsumptionDeclared.FindSet() then
            repeat
                SUCOmipConsumptionDeclared.Delete();
            until SUCOmipConsumptionDeclared.Next() = 0;

        if not SUCOmipConsumptionDeclared.Get(SUCOmipConsumptionDeclared."Document Type"::Proposal, "No.", "Customer CUPS") then begin
            SUCOmipConsumptionDeclared.Init();
            SUCOmipConsumptionDeclared.Validate("Document Type", SUCOmipConsumptionDeclared."Document Type"::Proposal);
            SUCOmipConsumptionDeclared.Validate("Document No.", "No.");
            SUCOmipConsumptionDeclared.CUPS := "Customer CUPS";
            SUCOmipConsumptionDeclared.Insert();

            SUCOmipConsumptionDeclared."Rate No." := "Rate No.";
            SUCOmipConsumptionDeclared.P1 := ArraykWhAnual[1];
            if ArraykWhAnual[1] <> 0 then
                SUCOmipConsumptionDeclared."P1 From SIPS" := true;
            SUCOmipConsumptionDeclared.P2 := ArraykWhAnual[2];
            if ArraykWhAnual[2] <> 0 then
                SUCOmipConsumptionDeclared."P2 From SIPS" := true;
            SUCOmipConsumptionDeclared.P3 := ArraykWhAnual[3];
            if ArraykWhAnual[3] <> 0 then
                SUCOmipConsumptionDeclared."P3 From SIPS" := true;
            SUCOmipConsumptionDeclared.P4 := ArraykWhAnual[4];
            if ArraykWhAnual[4] <> 0 then
                SUCOmipConsumptionDeclared."P4 From SIPS" := true;
            SUCOmipConsumptionDeclared.P5 := ArraykWhAnual[5];
            if ArraykWhAnual[5] <> 0 then
                SUCOmipConsumptionDeclared."P5 From SIPS" := true;
            SUCOmipConsumptionDeclared.P6 := ArraykWhAnual[6];
            if ArraykWhAnual[6] <> 0 then
                SUCOmipConsumptionDeclared."P6 From SIPS" := true;

            if (ArraykWhAnual[1] <> 0) or (ArraykWhAnual[2] <> 0) or (ArraykWhAnual[3] <> 0) or (ArraykWhAnual[4] <> 0) or (ArraykWhAnual[5] <> 0) or (ArraykWhAnual[6] <> 0) then
                SUCOmipConsumptionDeclared."SIPS Information" := true
            else
                SUCOmipConsumptionDeclared."SIPS Information" := false;
            SUCOmipConsumptionDeclared.CalculateTotal();
            SUCOmipConsumptionDeclared.CalculateRealFEE();
            SUCOmipConsumptionDeclared.Modify();

            Volume := SUCOmipConsumptionDeclared.P1 + SUCOmipConsumptionDeclared.P2 + SUCOmipConsumptionDeclared.P3 + SUCOmipConsumptionDeclared.P4 + SUCOmipConsumptionDeclared.P5 + SUCOmipConsumptionDeclared.P6;
        end;
    end;

    local procedure ValidationsCustomerCUPSandRateNo()
    var
        SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
        SUCOmipRates: Record "SUC Omip Rates";
        ArrayPotence: array[6] of Decimal;
        ArraykWhAnual: array[6] of Decimal;
        RateNo: Text;
        ErrorLbl: Label 'CUPS %1 is not valid for rate %2. SIPS indicates the rate is %3.';
        ErrorRateNotFoundLbl: Label 'The SIPS indicates rate %1 for CUPS %2, which does not exist, you must create the rate to use this CUPS.';
    begin
        if SUCOmipManagement.GetDataSIPS("Customer CUPS", ArrayPotence, ArraykWhAnual, RateNo) then
            if Rec."Rate No." <> '' then begin
                if (RateNo <> '') and (RateNo <> Rec."Rate No.") then
                    Error(ErrorLbl, "Customer CUPS", Rec."Rate No.", RateNo);
            end else
                if RateNo <> '' then
                    if SUCOmipRates.Get(RateNo) then
                        Validate("Rate No.", RateNo)
                    else
                        Error(ErrorRateNotFoundLbl, RateNo, "Customer CUPS");

        if SUCOmipCustomerCUPS.Get("Customer No.", "Customer CUPS") then begin
            SUCOmipCustomerCUPS.TestField("SUC Supply Point Address");
            SUCOmipCustomerCUPS.TestField("SUC Supply Point Country");
            SUCOmipCustomerCUPS.TestField("SUC Supply Point Post Code");
            SUCOmipCustomerCUPS.TestField("SUC Supply Point City");
            SUCOmipCustomerCUPS.TestField("SUC Supply Point County");
        end;

        if not Multicups then begin
            UpdateContractedPower(ArrayPotence);
            UpdateConsumptionDeclared(ArraykWhAnual);
            SUCOmipManagement.CalculateRealFEEEnergy(SUCOmipDocumentType::Proposal, "No.");
        end;
        SetDocumentPricesWithCalculation();
    end;

    procedure SetDocumentPricesWithCalculation()
    var
        SUCOmipProposalMulticups: Record "SUC Omip Proposal Multicups";
        WithSIPSInformation: Boolean;
        EnergyCalculationMatrix: array[6] of Decimal;
        RealFEE: array[6] of Decimal;
        RatesProcessed: List of [Code[20]];
    begin
        TestField(Status, Status::"Pending Acceptance");
        if not Multicups then begin
            SUCOmipManagement.CalculateRealFEEEnergy(SUCOmipDocumentType::Proposal, "No.");
            SUCOmipManagement.GetComercialFEEEnergyDocument(SUCOmipDocumentType::Proposal, "No.", "Marketer No.", "Rate No.", ComercialFEE);
            SUCOmipManagement.ValidateWithSIPSInformation(SUCOmipDocumentType::Proposal, "No.", "Rate No.", WithSIPSInformation, EnergyCalculationMatrix, RealFEE);
            SUCOmipManagement.SetPricesByTime(Type, "Marketer No.", "Energy Origen", true, ComercialFEE, WithSIPSInformation, EnergyCalculationMatrix, RealFEE);
            //SetDocumentPrices("Rate No.", Type, Times);
            SUCOmipManagement.CalculateEnergy2(Rec, "Rate No.", Type, Times);
        end else begin
            Clear(RatesProcessed);
            SUCOmipProposalMulticups.Reset();
            SUCOmipProposalMulticups.SetRange("Proposal No.", "No.");
            SUCOmipProposalMulticups.SetFilter("Rate No.", '<>%1', '');
            if SUCOmipProposalMulticups.FindSet() then
                repeat
                    if not RatesProcessed.Contains(SUCOmipProposalMulticups."Rate No.") then begin
                        SUCOmipManagement.CalculateRealFEEEnergy(SUCOmipDocumentType::Proposal, "No.");
                        SUCOmipManagement.GetComercialFEEEnergyDocument(SUCOmipDocumentType::Proposal, "No.", "Marketer No.", SUCOmipProposalMulticups."Rate No.", ComercialFEE);
                        SUCOmipManagement.ValidateWithSIPSInformation(SUCOmipDocumentType::Proposal, "No.", SUCOmipProposalMulticups."Rate No.", WithSIPSInformation, EnergyCalculationMatrix, RealFEE);
                        SUCOmipManagement.SetPricesByTime(Type, "Marketer No.", "Energy Origen", true, ComercialFEE, WithSIPSInformation, EnergyCalculationMatrix, RealFEE);
                        // SetDocumentPrices(SUCOmipProposalMulticups."Rate No.", Type, Times);
                        SUCOmipManagement.CalculateEnergy2(Rec, SUCOmipProposalMulticups."Rate No.", Type, Times);
                        RatesProcessed.Add(SUCOmipProposalMulticups."Rate No.");
                    end;
                until SUCOmipProposalMulticups.Next() = 0;
        end;
    end;

    local procedure ClearProsegur()
    begin
        "Prosegur Type Use" := '';
        "Prosegur Type Alarm" := '';
    end;

    local procedure ClearCommisionEntry()
    var
        SUCCommissionsEntry: Record "SUC Commissions Entry";
    begin
        SUCCommissionsEntry.Reset();
        SUCCommissionsEntry.SetRange("Document Type", SUCCommissionsEntry."Document Type"::Proposal);
        SUCCommissionsEntry.SetRange("Document No.", "No.");
        if SUCCommissionsEntry.FindSet() then
            repeat
                SUCCommissionsEntry.Delete();
            until SUCCommissionsEntry.Next() = 0;
    end;

    var
        SUCOmipSetup: Record "SUC Omip Setup";
        PostCode: Record "Post Code";
        NoSeries: Codeunit "No. Series";
        SUCOmipChangeLogManagement: Codeunit "SUC Omip Change Log Management";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        RecordRef: RecordRef;
        xRecordRef: RecordRef;
        SUCOmipDocumentType: Enum "SUC Omip Document Type";
        ComercialFEE: array[6] of Decimal;
        StatusAcceptedLbl: Label 'Proposal %1 has been previously accepted.';
}