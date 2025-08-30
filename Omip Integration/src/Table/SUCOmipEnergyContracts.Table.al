namespace Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Proposals;
using System.Reflection;
using Microsoft.Bank.BankAccount;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Address;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Setup;
using Microsoft.Sales.Customer;
using Sucasuc.Energy.Ledger;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.User;
using Sucasuc.Omip.Auditing;
using Microsoft.Foundation.NoSeries;

/// <summary>
/// Table SUC Omip Energy Contracts (ID 50102)
/// </summary>
table 50152 "SUC Omip Energy Contracts"
{
    Caption = 'Omip Contracts';
    LookupPageId = "SUC Omip Energy Contracts List";
    DrillDownPageId = "SUC Omip Energy Contracts List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Contract No.';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                if "No." <> xRec."No." then begin
                    SUCOmipSetup.Get();
                    NoSeries.TestManual(SUCOmipSetup."Contract Nos.");
                    "No." := '';
                end;
            end;
        }
        field(2; "Marketing Type"; Code[10])
        {
            Caption = 'Marketing Type';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                Customer: Record Customer;
                CustomerBankAccount: Record "Customer Bank Account";
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                if Customer.Get("Customer No.") then begin
                    Customer.TestField("Duplicate State", Customer."Duplicate State"::" ");
                    Validate("Ship-to Code", Customer."No.");
                    Validate("Ship-to Name", Customer.Name);
                    Validate("Ship-to Name 2", Customer."Name 2");
                    Validate("Ship-to Address", Customer.Address);
                    Validate("Ship-to Address 2", Customer."Address 2");
                    Validate("Ship-to Post Code", Customer."Post Code");
                    Validate("Ship-to City", Customer.City);
                    Validate("Ship-to VAT Registration No.", Customer."VAT Registration No.");
                    Validate("Ship-to County", Customer.County);
                    Validate("Ship-to Country/Region Code", Customer."Country/Region Code");
                    Validate("Cust. Payment Method Code", Customer."Payment Method Code");
                    Validate("Cust. Payment Terms Code", Customer."Payment Terms Code");
                    if Customer."Preferred Bank Account Code" <> '' then begin
                        CustomerBankAccount.Get(Customer."No.", Customer."Preferred Bank Account Code");
                        Validate(IBAN, CustomerBankAccount.IBAN);
                    end;

                    if Customer."SUC Customer Type" = Customer."SUC Customer Type"::Particular then
                        "SUC Customer Manager Position" := 'TITULAR'
                    else
                        "SUC Customer Manager Position" := Customer."SUC Manager Position";
                end else begin
                    Validate("Ship-to Code", '');
                    Validate("Ship-to Name", '');
                    Validate("Ship-to Name 2", '');
                    Validate("Ship-to Address", '');
                    Validate("Ship-to Address 2", '');
                    Validate("Ship-to Post Code", '');
                    Validate("Ship-to City", '');
                    Validate("Ship-to VAT Registration No.", '');
                    Validate("Ship-to County", '');
                    Validate("Ship-to Country/Region Code", '');
                    Validate("Customer CUPS", '');
                    Validate("Cust. Payment Method Code", '');
                    Validate("Cust. Payment Terms Code", '');
                    Validate(IBAN, '');
                    Validate("Invoice Electronic E-Mail", '');
                    Validate("SUC Customer Manager Position", '');
                end;
            end;
        }
        field(4; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
        field(5; "Customer Name 2"; Text[50])
        {
            Caption = 'Customer Name 2';
            CalcFormula = lookup(Customer."Name 2" where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
        field(6; "Phone No."; Text[30])
        {
            Caption = 'Phone';
            CalcFormula = lookup(Customer."Phone No." where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
        field(7; "Mobile Phone No."; Text[30])
        {
            Caption = 'Cell Phone';
            CalcFormula = lookup(Customer."Mobile Phone No." where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
        field(8; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            CalcFormula = lookup(Customer."VAT Registration No." where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
        field(9; "Big Account"; Boolean)
        {
            Caption = 'Big Account';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(10; "Alternative Address"; Boolean)
        {
            Caption = 'Alternative Address';
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                if "Alternative Address" then begin
                    Validate("Ship-to Code", '');
                    Validate("Ship-to Name", '');
                    Validate("Ship-to Name 2", '');
                    Validate("Ship-to Address", '');
                    Validate("Ship-to Address 2", '');
                    Validate("Ship-to Post Code", '');
                    Validate("Ship-to City", '');
                    Validate("Ship-to VAT Registration No.", '');
                    Validate("Ship-to County", '');
                    Validate("Ship-to Country/Region Code", '');
                end else
                    if Customer.Get("Customer No.") then begin
                        Validate("Ship-to Code", Customer."No.");
                        Validate("Ship-to Name", Customer.Name);
                        Validate("Ship-to Name 2", Customer."Name 2");
                        Validate("Ship-to Address", Customer.Address);
                        Validate("Ship-to Address 2", Customer."Address 2");
                        Validate("Ship-to Post Code", Customer."Post Code");
                        Validate("Ship-to City", Customer.City);
                        Validate("Ship-to VAT Registration No.", Customer."VAT Registration No.");
                        Validate("Ship-to County", Customer.County);
                        Validate("Ship-to Country/Region Code", Customer."Country/Region Code");
                    end;
            end;
        }
        field(11; "Ship-to Code"; Code[20])
        {
            Caption = 'Ship-to Code';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(12; "Ship-to Name"; Text[100])
        {
            Caption = 'Ship-to Name';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(13; "Ship-to Name 2"; Text[50])
        {
            Caption = 'Ship-to Name 2';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(14; "Ship-to Address"; Text[100])
        {
            Caption = 'Ship-to Address';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(15; "Ship-to Address 2"; Text[50])
        {
            Caption = 'Ship-to Address 2';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(16; "Ship-to Post Code"; Code[20])
        {
            Caption = 'Ship-to Post Code';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(17; "Ship-to City"; Text[30])
        {
            Caption = 'Ship-to City';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(18; "Ship-to VAT Registration No."; Text[20])
        {
            Caption = 'Ship-to VAT Registration No.';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(19; "Invoice Electronic"; Boolean)
        {
            Caption = 'Invoice Electronic';
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                if "Invoice Electronic" then
                    if Customer.Get("Customer No.") then
                        Validate("Invoice Electronic E-Mail", Customer."E-Mail")
                    else
                        Validate("Invoice Electronic E-Mail", '')
                else
                    Validate("Invoice Electronic E-Mail", '');
            end;
        }
        field(20; "Invoice Electronic E-Mail"; Text[250])
        {
            Caption = 'Invoice Electronic E-Mail';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(21; "Date Invoice Electronic"; Text[250])
        {
            Caption = 'Date Invoice Electronic';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(22; "Channel Send Inv. Electronic"; Enum "SUC Omip Channel Elect. Inv.")
        {
            Caption = 'Channel Send Inv. Electronic';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(23; "Signature Date"; Date)
        {
            Caption = 'Signature Contract Date';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(24; "Supply Start Date"; Date)
        {
            Caption = 'Supply Start Date';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                SetContractApplicableConditions();
            end;
        }
        field(25; "Completion Date"; Date)
        {
            Caption = 'Completion Date';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(26; "Renewal Date"; Date)
        {
            Caption = 'Renewal Date';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(27; Renovated; Boolean)
        {
            Caption = 'Renovated';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(28; "Contract Status"; Enum "SUC Omip Contract Status")
        {
            Caption = 'Contract Status';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(29; "Physical Contract Received"; Boolean)
        {
            Caption = 'Physical Contract Received';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(30; "Consumption No."; Code[30])
        {
            Caption = 'Consumption No.';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(31; "SUC Supply Point Address"; Text[200])
        {
            Caption = 'Address';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(32; "SUC Supply Point Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = if ("SUC Supply Point Country" = const('')) "Post Code"
            else
            if ("SUC Supply Point Country" = filter(<> '')) "Post Code" where("Country/Region Code" = field("SUC Supply Point Country"));
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                CityTxt: Text;
                CountyTxt: Text;
            begin
                CityTxt := "SUC Supply Point City";
                CountyTxt := "SUC Supply Point County";
                PostCode.LookupPostCode(CityTxt, "SUC Supply Point Post Code", CountyTxt, "SUC Supply Point Country");
                "SUC Supply Point City" := CopyStr(CityTxt, 1, 30);
                "SUC Supply Point County" := CopyStr(CountyTxt, 1, 30);
            end;

            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                PostCode.ValidatePostCode("SUC Supply Point City", "SUC Supply Point Post Code", "SUC Supply Point County", "SUC Supply Point Country", (CurrFieldNo <> 0) and GuiAllowed);
                ValidateContractModality();
            end;
        }
        field(33; "Phases No."; Enum "SUC Omip Phases No.")
        {
            Caption = 'Phases No.';
            Editable = false;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(34; "Change Of Owner"; Boolean)
        {
            Caption = 'Change of Owner';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(35; CAE; Code[20])
        {
            Caption = 'CAE';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(36; "CAE Installation"; Code[20])
        {
            Caption = 'CAE Installation';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(37; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            CalcFormula = lookup(Customer."Payment Terms Code" where("No." = field("Customer No.")));
            FieldClass = FlowField;
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip Customer CUPS';
        }
        field(38; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            CalcFormula = lookup(Customer."Payment Method Code" where("No." = field("Customer No.")));
            FieldClass = FlowField;
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip Customer CUPS';
        }
        field(39; "SEPA Services Type"; Enum "SUC Omip SEPA Services Type")
        {
            Caption = 'SEPA Services Type';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(40; "Bank Account"; Code[20])
        {
            Caption = 'Bank Account';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by IBAN';
        }
        field(41; "Debit Account Authorization"; Code[20])
        {
            Caption = 'Debit Account Authorization (ADC)';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(42; "Serie Light Meter No."; Code[20])
        {
            Caption = 'Serie Light Meter No.';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(43; "Status Light Meter"; Enum "SUC Omip Status Light Meter")
        {
            Caption = 'Status Light Meter';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(44; Telecounting; Boolean)
        {
            Caption = 'Telecounting';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(45; "CMA (kWh)"; Decimal)
        {
            Caption = 'CMA (kWh)';
            AutoFormatType = 2;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(46; "Voltage No."; Code[20])
        {
            Caption = 'Voltage No.';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(47; "Rate Type"; Enum "SUC Omip Rate Type")
        {
            Caption = 'Rate Type';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(48; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                case "Product Type" of
                    "Product Type"::Omip:
                        begin
                            if not Multicups then
                                ClearFEEs();
                            SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::Contract, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                            SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::Contract, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                            ValidationsCustomerCUPSandRateNo();
                        end;
                    else
                        Validate("Contract Modality", '');
                end;
            end;
        }
        field(49; "Hired Potency"; Enum "SUC Omip Hired Potency")
        {
            Caption = 'Hired Potency';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(50; "Qty. Hired Potency"; Decimal)
        {
            Caption = 'Qty. Hired Potency';
            AutoFormatType = 2;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(51; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(52; Status; Enum "SUC Omip Document Status")
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

                            RequiredFields();
                            SUCOmipManagement.ContractAcceptance(Rec);
                        end;
                    Status::Rejected:
                        xRec.TestField(Status, Status::"Pending Acceptance");
                    Status::"Out of Time":
                        begin
                            xRec.TestField(Status, Status::"Pending Acceptance");
                            SUCOmipSetup.Get();
                            ValidTime := DT2Time("DateTime Created");
                            TodayDT := CreateDateTime(Today, ValidTime);
                            DueDT := CreateDateTime(CalcDate(Format(SUCOmipSetup."Time Validity Contracts"), "Date Created"), ValidTime);

                            if (TodayDT < DueDT) then
                                Error(ErrorDueDateLbl);
                        end;
                    Status::Canceled:
                        xRec.TestField(Status, Status::Accepted);
                end;

                // if xRec.Status = xRec.Status::Accepted then
                //     Error(StatusAcceptedLbl);

                // case Status of
                //     Status::Accepted:
                //         begin
                //             RequiredFields();
                //             SUCOmipManagement.ContractAcceptance(Rec);
                //         end;
                // end;
                SUCOmipManagement.SetNewCustomerDocs(SUCOmipDocumentType::Contract, "No.", "Customer No.", Status, CurrentDateTime, "Agent No.");
            end;
        }
        field(53; "Acceptance Method"; Enum "SUC Omip Acceptance Method")
        {
            Caption = 'Acceptance Method';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                TestField(Status, Status::"Pending Acceptance");
                if xRec."Acceptance Method" <> xRec."Acceptance Method"::Paper then //*When is paper acceptance, is possible to change the acceptance method
                    TestField("Proposal No.", '');
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
        field(54; "Acceptance Send"; Text[250])
        {
            Caption = 'Acceptance Send';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                if xRec."Acceptance Method" <> xRec."Acceptance Method"::Paper then //*When is paper acceptance, is possible to change the acceptance method
                    TestField("Proposal No.", '');
            end;
        }
        field(55; "Proposal No."; Code[20])
        {
            Caption = 'Proposal No.';
            Editable = false;
            DataClassification = CustomerContent;
            TableRelation = "SUC Omip Proposals"."No.";
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(56; Times; Enum "SUC Omip Times")
        {
            Caption = 'Time';
            trigger OnValidate()
            var
                SUCDefaultModalityByTime: Record "SUC Default Modality By Time";
            // EnergyCalculationMatrix: array[6] of Decimal;
            // RealFEE: array[6] of Decimal;
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                if (Rec.Times <> Rec.Times::" ") or (Rec.Times <> xRec.Times) then //begin
                    if Type <> Type::" " then begin
                        TestField("Marketer No.");
                        // SUCOmipManagement.GetComercialFEEEnergyDocument(SUCOmipDocumentType::Contract, "No.", "Marketer No.", "Rate No.", ComercialFEE);
                        // SUCOmipManagement.SetPricesByTime(Type, "Marketer No.", "Energy Origen", true, ComercialFEE, false, EnergyCalculationMatrix, RealFEE);
                        SetDocumentPricesWithCalculation();
                    end;
                // SetDocumentPrices();
                // end;

                SUCDefaultModalityByTime.Get(Rec.Times);
                Validate("Contract Modality", SUCDefaultModalityByTime."Default Contract Modality");

                SetContractApplicableConditions();
            end;
        }
        field(57; Type; Enum "SUC Omip Rate Entry Types")
        {
            Caption = 'Type';
            trigger OnValidate()
            var
                SUCOmipTypes: Record "SUC Omip Types";
            // EnergyCalculationMatrix: array[6] of Decimal;
            // RealFEE: array[6] of Decimal;
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                TestField(Times);

                if (Rec.Type <> Rec.Type::" ") or (Rec.Type <> xRec.Type) then begin
                    TestField("Marketer No.");
                    // SUCOmipManagement.GetComercialFEEEnergyDocument(SUCOmipDocumentType::Contract, "No.", "Marketer No.", "Rate No.", ComercialFEE);
                    // SUCOmipManagement.SetPricesByTime(Type, "Marketer No.", "Energy Origen", true, ComercialFEE, false, EnergyCalculationMatrix, RealFEE);
                    // SetDocumentPrices();
                    SetDocumentPricesWithCalculation();
                end;

                case "Product Type" of
                    "Product Type"::Omip:
                        if SUCOmipTypes.Get(Type) then begin
                            SUCOmipTypes.TestField("Start Date Contract");
                            "Supply Start Date" := CalcDate('<-CM>', CalcDate(SUCOmipTypes."Start Date Contract", "Date Created"));
                        end else
                            "Supply Start Date" := 0D;
                end;
            end;
        }
        field(58; "FEE Potency"; Decimal)
        {
            Caption = 'FEE Potency';
            DecimalPlaces = 0 : 6;
            Editable = false;
            ObsoleteState = Pending;
            ObsoleteReason = 'Change by Table "SUC Omip FEE Power Document"';
            ObsoleteTag = '25.02';
        }
        field(59; "Rate Category"; Code[20])
        {
            Caption = 'Rate Category';
            TableRelation = "SUC Omip Rate Category"."Category Code";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(60; "Proposal Transmitted"; Boolean)
        {
            Caption = 'Proposal transmitted';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(61; "No. Series E-Send"; Code[20])
        {
            Caption = 'No. Series E-Send';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(62; "Request Acceptance"; Text[100])
        {
            Caption = 'Request Acceptance';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(63; "File Name"; Text[250])
        {
            Caption = 'File Name';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                if "File Name" <> '' then
                    Validate(Status);
            end;
        }
        field(64; "File"; Blob)
        {
            Caption = 'File';
            DataClassification = CustomerContent;
        }
        field(65; "Proposal Agent No."; Code[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Proposals"."Agent No." where("No." = field("Proposal No.")));
        }
        field(66; "SUC Supply Point City"; Text[30])
        {
            Caption = 'City';
            TableRelation = if ("SUC Supply Point Country" = const('')) "Post Code".City
            else
            if ("SUC Supply Point Country" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("SUC Supply Point Country"));
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                CityTxt: Text;
                CountyTxt: Text;
            begin
                CityTxt := "SUC Supply Point City";
                CountyTxt := "SUC Supply Point County";
                PostCode.LookupPostCode(CityTxt, "SUC Supply Point Post Code", CountyTxt, "SUC Supply Point Country");
                "SUC Supply Point City" := CopyStr(CityTxt, 1, 30);
                "SUC Supply Point County" := CopyStr(CountyTxt, 1, 30);
            end;

            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                PostCode.ValidateCity("SUC Supply Point City", "SUC Supply Point Post Code", "SUC Supply Point County", "SUC Supply Point Country", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(67; "SUC Supply Point County"; Text[30])
        {
            CaptionClass = '5,1,' + "SUC Supply Point Country";
            Caption = 'County';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(68; "SUC Supply Point Country"; Code[10])
        {
            Caption = 'Country/Region';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                CityTxt: Text;
                CountyTxt: Text;
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                CityTxt := "SUC Supply Point City";
                CountyTxt := "SUC Supply Point County";
                PostCode.CheckClearPostCodeCityCounty(CityTxt, "SUC Supply Point Post Code", CountyTxt, "SUC Supply Point Country", xRec."SUC Supply Point Country");
                "SUC Supply Point City" := CopyStr(CityTxt, 1, 30);
                "SUC Supply Point County" := CopyStr(CountyTxt, 1, 30);
            end;
        }
        field(69; "Ship-to County"; Text[30])
        {
            CaptionClass = '5,1,' + "Ship-to Country/Region Code";
            Caption = 'County';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(70; "Ship-to Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                CityTxt: Text;
                CountyTxt: Text;
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                CityTxt := "Ship-to City";
                CountyTxt := "Ship-to County";
                PostCode.CheckClearPostCodeCityCounty(CityTxt, "Ship-to Post Code", CountyTxt, "Ship-to Country/Region Code", xRec."Ship-to Country/Region Code");
            end;
        }
        field(71; "Receive invoice electronically"; Boolean)
        {
            Caption = 'Receive invoice electronically';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(72; "Sending Communications"; Boolean)
        {
            Caption = 'Sending Communications';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(73; "Customer CUPS"; Text[25])
        {
            Caption = 'CUPS';
            TableRelation = "SUC Omip Customer CUPS".CUPS where("Customer No." = field("Customer No."));
            trigger OnValidate()
            var
                SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
                ArrayPotence: array[6] of Decimal;
                ArraykWhAnual: array[6] of Decimal;
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');

                if SUCOmipCustomerCUPS.Get("Customer No.", "Customer CUPS") then begin
                    "SUC Supply Point Address" := SUCOmipCustomerCUPS."SUC Supply Point Address";
                    "SUC Supply Point Country" := SUCOmipCustomerCUPS."SUC Supply Point Country";
                    "SUC Supply Point County" := SUCOmipCustomerCUPS."SUC Supply Point County";
                    "SUC Supply Point City" := SUCOmipCustomerCUPS."SUC Supply Point City";
                    Validate("SUC Supply Point Post Code", SUCOmipCustomerCUPS."SUC Supply Point Post Code");
                end else begin
                    "SUC Supply Point Address" := '';
                    "SUC Supply Point Country" := '';
                    "SUC Supply Point County" := '';
                    "SUC Supply Point City" := '';
                    "SUC Supply Point Post Code" := '';
                end;

                case "Product Type" of
                    "Product Type"::Omip:
                        ValidationsCustomerCUPSandRateNo()
                    else
                        ValidateRateWithSIPSData(ArrayPotence, ArraykWhAnual);
                end;

                if ("Customer CUPS" = '') and (xRec."Customer CUPS" <> '') then begin
                    ClearContractedPower(xRec."Customer CUPS");
                    ClearConsumptionDeclared(xRec."Customer CUPS");
                end;
            end;
        }
        field(74; "Marketer No."; Code[20])
        {
            Caption = 'Marketer';
            TableRelation = "SUC Omip Marketers"."No.";
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                CalcFields("Marketer Name");
                case "Product Type" of
                    "Product Type"::Omip:
                        begin
                            SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::Contract, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                            SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::Contract, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                            // SetDocumentPrices();
                            SetDocumentPricesWithCalculation();

                        end;
                end;
                SetContractApplicableConditions();
            end;
        }
        field(75; "Marketer Name"; Text[250])
        {
            Caption = 'Marketer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Marketers".Name where("No." = field("Marketer No.")));
        }
        field(76; "Agent Name"; Text[100])
        {
            Caption = 'Agent Name';
            CalcFormula = lookup("SUC Omip External Users"."Full Name" where("User Name" = field("Proposal Agent No.")));
            FieldClass = FlowField;
        }
        field(77; Multicups; Boolean)
        {
            Caption = 'Multicups';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                if Rec.Multicups then begin
                    // case "Product Type" of //* Clear the tables for all product types
                    //     "Product Type"::Omip:
                    //         begin
                    Validate("Rate No.", '');
                    ClearPowerEntry();
                    ClearEnergyEntry();
                    ClearContractedPower("Customer CUPS");
                    ClearConsumptionDeclared("Customer CUPS");
                    // end;
                    // end;
                    Validate("Customer CUPS", '');
                end else
                    ClearMulticups();

                ClearFEEs();
                ClearCommisionEntry();

                SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::Contract, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::Contract, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SetContractApplicableConditions();
            end;
        }
        field(78; "DateTime Created"; DateTime)
        {
            Caption = 'DateTime Created';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(79; "Order TED Addendum"; Text[100])
        {
            Caption = 'Order TED Addendum';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(80; "Resolution Addendum"; Text[100])
        {
            Caption = 'Resolution Addendum';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(89; "FEE Energy"; Decimal)
        {
            Caption = 'FEE Energy';
            Editable = false;
            DecimalPlaces = 0 : 6;
            ObsoleteState = Pending;
            ObsoleteReason = 'Change by Table "SUC Omip FEE Power Document"';
            ObsoleteTag = '25.02';
        }
        field(90; "Cust. Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code';
            TableRelation = "Payment Terms";
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(91; "Cust. Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(92; "Agent No."; Code[100])
        {
            Caption = 'Agent No.';
            TableRelation = "SUC Omip External Users"."User Name";
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                SUCOmipExternalUsers: Record "SUC Omip External Users";
                GroupFEEId: Code[20];
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                CalcFields("Agent Name Contract");
                case "Product Type" of
                    "Product Type"::Omip:
                        begin
                            GroupFEEId := SUCOmipManagement.GetUserFEEGroupIdDefault("Agent No.");
                            Validate("FEE Group Id.", GroupFEEId);
                        end;
                end;
                if SUCOmipExternalUsers.Get("Agent No.") then
                    Validate("Agent Code", SUCOmipExternalUsers."Agent Code")
                else
                    Validate("Agent Code", '');
            end;
        }
        field(93; "Agent Name Contract"; Text[100])
        {
            Caption = 'Agent Name';
            CalcFormula = lookup("SUC Omip External Users"."Full Name" where("User Name" = field("Agent No.")));
            FieldClass = FlowField;
        }
        field(94; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(95; "Energy Origen"; Enum "SUC Omip Energy Origen")
        {
            Caption = 'Energy Origen';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
            end;
        }
        field(96; Volume; Decimal)
        {
            Caption = 'Volume';
            Editable = false;
            DecimalPlaces = 0 : 0;
            DataClassification = CustomerContent;
        }
        field(97; IBAN; Text[50])
        {
            Caption = 'IBAN';
            DataClassification = CustomerContent;
        }
        field(98; "Omip Contract"; Boolean)
        {
            Caption = 'Omip Contract';
            DataClassification = CustomerContent;
            // ObsoleteState = Pending; //TODO
            // ObsoleteReason = 'Field change by "Product Type"';
            // ObsoleteTag = '25.08';
        }
        field(99; "Energy Type"; Enum "SUC Energy Type")
        {
            Caption = 'Energy Type';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                case "Product Type" of
                    "Product Type"::"Energy (Light - Gas)":
                        Validate("Contract Modality", '');
                end;
            end;
        }
        field(100; "Contratation Type"; Enum "SUC Contratation Type")
        {
            Caption = 'Contratation Type';
            DataClassification = CustomerContent;
        }
        field(101; "Contract Modality"; Text[100])
        {
            Caption = 'Contract Modality';
            DataClassification = CustomerContent;
            trigger OnLookup()
            var
                SUCControlPricesEnergy: Record "SUC Control Prices Energy";
                SUCControlPricesEnergyPage: Page "SUC Control Prices Energy";
            begin
                SUCControlPricesEnergy.Reset();
                SUCControlPricesEnergy.SetRange("Marketer No.", "Marketer No.");
                SUCControlPricesEnergy.SetRange("Energy Type", "Energy Type");
                SUCControlPricesEnergy.SetRange("Rate No.", "Rate No."); // Use Rate No. to filter by tariff
                SUCControlPricesEnergy.SetRange("Rate Type Contract", "Rate Type Contract");
                if SUCControlPricesEnergy.FindSet() then begin
                    SUCControlPricesEnergyPage.SetRecord(SUCControlPricesEnergy);
                    SUCControlPricesEnergyPage.SetTableView(SUCControlPricesEnergy);
                    SUCControlPricesEnergyPage.LookupMode(true);
                    if SUCControlPricesEnergyPage.RunModal() = Action::LookupOK then begin
                        SUCControlPricesEnergyPage.GetRecord(SUCControlPricesEnergy);
                        Validate("Contract Id. Modality", SUCControlPricesEnergy."Id.");
                        Validate("Contract Modality", SUCControlPricesEnergy.Modality);
                    end;
                end;
            end;

            trigger OnValidate()
            begin
                ValidateContractModality();
            end;
        }
        field(102; "Contract Id. Modality"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(103; "Rate Type Contract"; Enum "SUC Rate Type Contract")
        {
            Caption = 'Rate Type';
            trigger OnValidate()
            begin
                case "Product Type" of
                    "Product Type"::"Energy (Light - Gas)":
                        Validate("Contract Modality", '');
                end;
            end;
        }
        field(104; "Reference Contract"; Text[50])
        {
            Caption = 'Reference Contract';
        }
        field(105; "SUC Customer Manager Position"; Text[100])
        {
            Caption = 'Customer Manager position';
        }
        field(106; "Agent Code"; Code[100])
        {
            Caption = 'Agent Code';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
            end;
        }
        field(107; "Tittle Applicable Conditions"; Text[250])
        {
            Caption = 'Tittle Applicable Conditions';
        }
        field(108; "Body Applicable Conditions"; Blob)
        {
            Caption = 'Body Applicable Conditions';
        }
        field(109; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = "SUC Omip Languages"."Language Code" where("Country Code" = field("SUC Supply Point Country"));
        }
        field(110; "Energy Use"; Enum "SUC Omip Energy Use")
        {
            Caption = 'Energy Use';
        }
        field(111; "FEE Group Id."; Code[20])
        {
            Caption = 'FEE Group Id.';
            TableRelation = "SUC Omip Ext. Users Groups FEE"."Group Id." where("User Name" = field("Agent No."));
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::Contract, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::Contract, "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SetDocumentPricesWithCalculation();
            end;
        }
        field(112; "Product Type"; Enum "SUC Product Type")
        {
            Caption = 'Product Type';
            trigger OnValidate()
            begin
                TestField(Status, Status::"Pending Acceptance");
                TestField("Proposal No.", '');
                case "Product Type" of
                    "Product Type"::"Energy (Light - Gas)":
                        begin
                            ClearPowerEntry();
                            ClearEnergyEntry();
                            ClearContractedPower("Customer CUPS");
                            ClearConsumptionDeclared("Customer CUPS");
                            ClearMulticups();
                            ClearFEEs();
                        end;
                end;
            end;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Customer No.") { }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            SUCOmipSetup.Get();
            SUCOmipSetup.TestField("Contract Nos.");
            "No." := NoSeries.GetNextNo(SUCOmipSetup."Contract Nos.", WorkDate());
            "Date Created" := Today;
            Status := Status::"Pending Acceptance";
        end;
    end;

    trigger OnDelete()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
    begin
        SUCOmipSetup.Get();
        if SUCOmipSetup."Allow Delete Related Documents" then begin
            if "Proposal No." <> '' then begin
                SUCOmipProposals.Get("Proposal No.");
                SUCOmipProposals."Contract No." := '';
                SUCOmipProposals.Modify();
            end;
        end else
            TestField("Proposal No.", '');
        DeleteTrackingBTP(Rec);
    end;

    local procedure RequiredFields()
    begin
        TestField("No.");
        TestField("Date Created");
        TestField("Supply Start Date");

        if not Rec.Multicups then
            TestField("Rate No.");

        TestField(Times);
        TestField(Type);
        TestField("Customer No.");
    end;

    local procedure DeleteTrackingBTP(SUCOmipEnergyContractsIn: Record "SUC Omip Energy Contracts")
    var
        SUCOmipTrackingBTP: Record "SUC Omip Tracking BTP";
    begin
        SUCOmipTrackingBTP.Reset();
        SUCOmipTrackingBTP.SetRange("Document Type", SUCOmipTrackingBTP."Document Type"::Contract);
        SUCOmipTrackingBTP.SetRange("Document No.", SUCOmipEnergyContractsIn."No.");
        if SUCOmipTrackingBTP.FindSet() then
            repeat
                SUCOmipTrackingBTP.Delete();
            until SUCOmipTrackingBTP.Next() = 0;
    end;

    procedure AssistEdit(OldSUCOmipEnergyContracts: Record "SUC Omip Energy Contracts"): Boolean
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    begin
        SUCOmipEnergyContracts := Rec;
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Contract Nos.");
        if NoSeries.LookupRelatedNoSeries(SUCOmipSetup."Contract Nos.", OldSUCOmipEnergyContracts."No. Series", SUCOmipEnergyContracts."No. Series") then begin
            SUCOmipSetup.Get();
            SUCOmipSetup.TestField("Contract Nos.");
            SUCOmipEnergyContracts."No." := NoSeries.GetNextNo(SUCOmipEnergyContracts."No. Series");
            Rec := SUCOmipEnergyContracts;
            exit(true);
        end;
    end;

    procedure SetDocumentPrices()
    var
    // SUCOmipEnergyContractsMul: Record "SUC Omip Energy Contracts Mul.";
    // RatesProcessed: List of [Code[20]];
    begin
        // if Multicups then begin
        //     Clear(RatesProcessed);
        //     if ((Rec.Times <> Rec.Times::" ") or (Rec.Times <> xRec.Times)) or ((Rec.Type <> Rec.Type::" ") or (Rec.Type <> xRec.Type)) then begin
        //         SUCOmipEnergyContractsMul.Reset();
        //         SUCOmipEnergyContractsMul.SetRange("Contract No.", "No.");
        //         if SUCOmipEnergyContractsMul.FindSet() then
        //             repeat
        //                 if not RatesProcessed.Contains(SUCOmipEnergyContractsMul."Rate No.") then begin
        //                     SUCOmipManagement.CalculateEnergyContract2(Rec, SUCOmipEnergyContractsMul."Rate No.", Type, Times);
        //                     RatesProcessed.Add(SUCOmipEnergyContractsMul."Rate No.");
        //                 end;
        //             until SUCOmipEnergyContractsMul.Next() = 0;
        //     end;
        // end else
        SUCOmipManagement.CalculateEnergyContract2(Rec, "Rate No.", Type, Times);
    end;

    local procedure ClearPowerEntry()
    var
        SUCOmipPowerEntryContract: Record "SUC Omip Power Entry Contract";
    begin
        SUCOmipPowerEntryContract.Reset();
        SUCOmipPowerEntryContract.SetRange("Contract No.", "No.");
        if SUCOmipPowerEntryContract.FindSet() then
            repeat
                SUCOmipPowerEntryContract.Delete();
            until SUCOmipPowerEntryContract.Next() = 0;
    end;

    local procedure ClearEnergyEntry()
    var
        SUCOmipEnergyEntryContract: Record "SUC Omip Energy Entry Contract";
    begin
        SUCOmipEnergyEntryContract.Reset();
        SUCOmipEnergyEntryContract.SetRange("Contract No.", "No.");
        if SUCOmipEnergyEntryContract.FindSet() then
            repeat
                SUCOmipEnergyEntryContract.Delete();
            until SUCOmipEnergyEntryContract.Next() = 0;
    end;

    local procedure UpdateContractedPower(ArrayPotence: array[6] of Decimal)
    var
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
    begin
        SUCOmipContractedPower.Reset();
        SUCOmipContractedPower.SetRange("Document Type", SUCOmipContractedPower."Document Type"::Contract);
        SUCOmipContractedPower.SetRange("Document No.", "No.");
        if SUCOmipContractedPower.FindSet() then
            repeat
                SUCOmipContractedPower.Delete();
            until SUCOmipContractedPower.Next() = 0;

        if not SUCOmipContractedPower.Get(SUCOmipContractedPower."Document Type"::Contract, "No.", "Customer CUPS") then begin
            SUCOmipContractedPower.Init();
            SUCOmipContractedPower.Validate("Document Type", SUCOmipContractedPower."Document Type"::Contract);
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
        SUCOmipConsumptionDeclared.SetRange("Document Type", SUCOmipConsumptionDeclared."Document Type"::Contract);
        SUCOmipConsumptionDeclared.SetRange("Document No.", "No.");
        if SUCOmipConsumptionDeclared.FindSet() then
            repeat
                SUCOmipConsumptionDeclared.Delete();
            until SUCOmipConsumptionDeclared.Next() = 0;

        if not SUCOmipConsumptionDeclared.Get(SUCOmipConsumptionDeclared."Document Type"::Contract, "No.", "Customer CUPS") then begin
            SUCOmipConsumptionDeclared.Init();
            SUCOmipConsumptionDeclared.Validate("Document Type", SUCOmipConsumptionDeclared."Document Type"::Contract);
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

    local procedure ClearContractedPower(byCUPS: Text[25])
    var
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
    begin
        SUCOmipContractedPower.Reset();
        SUCOmipContractedPower.SetRange("Document Type", SUCOmipContractedPower."Document Type"::Contract);
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
        SUCOmipConsumptionDeclared.SetRange("Document Type", SUCOmipConsumptionDeclared."Document Type"::Contract);
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
        SUCOmipEnergyContractsMul: Record "SUC Omip Energy Contracts Mul.";
    begin
        SUCOmipEnergyContractsMul.Reset();
        SUCOmipEnergyContractsMul.SetRange("Contract No.", "No.");
        if SUCOmipEnergyContractsMul.FindSet() then
            repeat
                SUCOmipEnergyContractsMul.Delete();
            until SUCOmipEnergyContractsMul.Next() = 0;
    end;

    local procedure ClearFEEs()
    var
        SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
        SUCOmipFEEEnergyDocument: Record "SUC Omip FEE Energy Document";
    begin
        SUCOmipFEEPowerDocument.Reset();
        SUCOmipFEEPowerDocument.SetRange("Document Type", SUCOmipFEEPowerDocument."Document Type"::Contract);
        SUCOmipFEEPowerDocument.SetRange("Document No.", "No.");
        SUCOmipFEEPowerDocument.DeleteAll();

        SUCOmipFEEEnergyDocument.Reset();
        SUCOmipFEEEnergyDocument.SetRange("Document Type", SUCOmipFEEEnergyDocument."Document Type"::Contract);
        SUCOmipFEEEnergyDocument.SetRange("Document No.", "No.");
        SUCOmipFEEEnergyDocument.DeleteAll();
    end;

    local procedure ValidationsCustomerCUPSandRateNo()
    var
        SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
        ArrayPotence: array[6] of Decimal;
        ArraykWhAnual: array[6] of Decimal;

    begin
        ValidateRateWithSIPSData(ArrayPotence, ArraykWhAnual);

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
            SUCOmipManagement.CalculateRealFEEEnergy(SUCOmipDocumentType::Contract, "No.");
        end;
        SetDocumentPricesWithCalculation();
    end;

    local procedure ValidateRateWithSIPSData(var ArrayPotenceOut: array[6] of Decimal; var ArraykWhAnualOut: array[6] of Decimal)
    var
        SUCOmipRates: Record "SUC Omip Rates";
        RateNo: Text;
        ErrorLbl: Label 'CUPS %1 is not valid for rate %2. SIPS indicates the rate is %3.';
        ErrorRateNotFoundLbl: Label 'The SIPS indicates rate %1 for CUPS %2, which does not exist, you must create the rate to use this CUPS.';
    begin
        if SUCOmipManagement.GetDataSIPS("Customer CUPS", ArrayPotenceOut, ArraykWhAnualOut, RateNo) then
            if Rec."Rate No." <> '' then begin
                if (RateNo <> '') and (RateNo <> Rec."Rate No.") then
                    Error(ErrorLbl, "Customer CUPS", Rec."Rate No.", RateNo);
            end else
                if RateNo <> '' then
                    if SUCOmipRates.Get(RateNo) then
                        Validate("Rate No.", RateNo)
                    else
                        Error(ErrorRateNotFoundLbl, RateNo, "Customer CUPS");
    end;

    procedure SetDocumentPricesWithCalculation()
    var
        SUCOmipEnergyContractsMul: Record "SUC Omip Energy Contracts Mul.";
        WithSIPSInformation: Boolean;
        EnergyCalculationMatrix: array[6] of Decimal;
        RealFEE: array[6] of Decimal;
        RatesProcessed: List of [Code[20]];
    begin
        TestField(Status, Status::"Pending Acceptance");
        if not Multicups then begin
            SUCOmipManagement.CalculateRealFEEEnergy(SUCOmipDocumentType::Contract, "No.");
            SUCOmipManagement.GetComercialFEEEnergyDocument(SUCOmipDocumentType::Contract, "No.", "Marketer No.", "Rate No.", ComercialFEE);
            SUCOmipManagement.ValidateWithSIPSInformation(SUCOmipDocumentType::Contract, "No.", "Rate No.", WithSIPSInformation, EnergyCalculationMatrix, RealFEE);
            SUCOmipManagement.SetPricesByTime(Type, "Marketer No.", "Energy Origen", true, ComercialFEE, WithSIPSInformation, EnergyCalculationMatrix, RealFEE);
            //SetDocumentPrices("Rate No.", Type, Times);
            SUCOmipManagement.CalculateEnergyContract2(Rec, "Rate No.", Type, Times);
        end else begin
            Clear(RatesProcessed);
            SUCOmipEnergyContractsMul.Reset();
            SUCOmipEnergyContractsMul.SetRange("Contract No.", "No.");
            SUCOmipEnergyContractsMul.SetFilter("Rate No.", '<>%1', '');
            if SUCOmipEnergyContractsMul.FindSet() then
                repeat
                    if not RatesProcessed.Contains(SUCOmipEnergyContractsMul."Rate No.") then begin
                        SUCOmipManagement.CalculateRealFEEEnergy(SUCOmipDocumentType::Contract, "No.");
                        SUCOmipManagement.GetComercialFEEEnergyDocument(SUCOmipDocumentType::Contract, "No.", "Marketer No.", SUCOmipEnergyContractsMul."Rate No.", ComercialFEE);
                        SUCOmipManagement.ValidateWithSIPSInformation(SUCOmipDocumentType::Contract, "No.", SUCOmipEnergyContractsMul."Rate No.", WithSIPSInformation, EnergyCalculationMatrix, RealFEE);
                        SUCOmipManagement.SetPricesByTime(Type, "Marketer No.", "Energy Origen", true, ComercialFEE, WithSIPSInformation, EnergyCalculationMatrix, RealFEE);
                        // SetDocumentPrices(SUCOmipProposalMulticups."Rate No.", Type, Times);
                        SUCOmipManagement.CalculateEnergyContract2(Rec, SUCOmipEnergyContractsMul."Rate No.", Type, Times);
                        RatesProcessed.Add(SUCOmipEnergyContractsMul."Rate No.");
                    end;
                until SUCOmipEnergyContractsMul.Next() = 0;
        end;
    end;

    procedure SetDataBlob(FieldNo: Integer; NewData: Text)
    var
        OutStream: OutStream;
    begin
        case FieldNo of
            FieldNo("Body Applicable Conditions"):
                begin
                    Clear("Body Applicable Conditions");
                    "Body Applicable Conditions".CreateOutStream(OutStream, TextEncoding::UTF8);
                    OutStream.WriteText(NewData);
                    Modify();
                end;
        end;
    end;

    procedure GetDataValueBlob(FieldNo: Integer): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        case FieldNo of
            FieldNo("Body Applicable Conditions"):
                begin
                    CalcFields("Body Applicable Conditions");
                    "Body Applicable Conditions".CreateInStream(InStream, TextEncoding::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Body Applicable Conditions")));
                end;
        end;
    end;

    local procedure SetContractApplicableConditions()
    var
        TittleAppConditions: Text[250];
        AppConditions: Text;
    begin
        SUCOmipManagement.GetContractApplicableConditions2(Rec."Product Type", Rec."Marketer No.", Rec.Times, Rec.Multicups, Rec."Supply Start Date", TittleAppConditions, AppConditions);
        Rec."Tittle Applicable Conditions" := TittleAppConditions;
        Rec.SetDataBlob(Rec.FieldNo("Body Applicable Conditions"), AppConditions);
    end;

    local procedure ClearCommisionEntry()
    var
        SUCCommissionsEntry: Record "SUC Commissions Entry";
    begin
        SUCCommissionsEntry.Reset();
        SUCCommissionsEntry.SetRange("Document Type", SUCCommissionsEntry."Document Type"::Contract);
        SUCCommissionsEntry.SetRange("Document No.", "No.");
        if SUCCommissionsEntry.FindSet() then
            repeat
                SUCCommissionsEntry.Delete();
            until SUCCommissionsEntry.Next() = 0;
    end;

    local procedure ValidateContractModality()
    begin
        case "Product Type" of
            "Product Type"::"Energy (Light - Gas)":
                begin
                    ClearFEEs();
                    ClearPowerEntry();
                    ClearEnergyEntry();
                    if SUCContractModalities.Get("Marketer No.", "Energy Type", "Contract Modality") then begin
                        SUCContractModalities.TestField("Reference Contract Code");
                        "Reference Contract" := SUCContractModalities."Reference Contract Code";
                        SUCOmipManagement.CalculateControlPricesContract(Rec, Rec."Rate No.");
                    end else begin
                        "Contract Modality" := '';
                        "Contract Id. Modality" := 0;
                    end;
                end;
        end;
    end;

    var
        SUCOmipSetup: Record "SUC Omip Setup";
        PostCode: Record "Post Code";
        SUCContractModalities: Record "SUC Contract Modalities";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        NoSeries: Codeunit "No. Series";
        SUCOmipDocumentType: Enum "SUC Omip Document Type";
        ComercialFEE: array[6] of Decimal;
}