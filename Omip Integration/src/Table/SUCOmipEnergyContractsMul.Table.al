namespace Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Masters;
using Microsoft.Foundation.Address;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Documents;
table 50188 "SUC Omip Energy Contracts Mul."
{
    DataClassification = CustomerContent;
    Caption = 'Multicups contracts';
    LookupPageId = "SUC Omip Energy Contracts Mul.";
    DrillDownPageId = "SUC Omip Energy Contracts Mul.";

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            DataClassification = CustomerContent;
            TableRelation = "SUC Omip Energy Contracts"."No.";
            trigger OnValidate()
            var
                SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
            begin
                SUCOmipEnergyContracts.Get("Contract No.");
                Validate("Contract Id", SUCOmipEnergyContracts.SystemId);
            end;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Energy Contracts"."Customer No." where("No." = field("Contract No.")));
        }
        field(3; "Customer CUPS"; Text[25])
        {
            Caption = 'CUPS';
            trigger OnLookup()
            var
                SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
                SUCOmipCustomerCUPSPage: Page "SUC Omip Customer CUPS";
            begin
                CalcFields("Customer No.");
                CalcFields("Product Type");
                CalcFields("Rate No. Contract");
                SUCOmipCustomerCUPS.Reset();
                SUCOmipCustomerCUPS.SetRange("Customer No.", "Customer No.");
                if SUCOmipCustomerCUPS.FindSet() then begin
                    SUCOmipCustomerCUPSPage.SetRecord(SUCOmipCustomerCUPS);
                    SUCOmipCustomerCUPSPage.SetTableView(SUCOmipCustomerCUPS);
                    SUCOmipCustomerCUPSPage.LookupMode(true);
                    if SUCOmipCustomerCUPSPage.RunModal() = Action::LookupOK then begin
                        SUCOmipCustomerCUPSPage.GetRecord(SUCOmipCustomerCUPS);
                        Validate("Customer CUPS", SUCOmipCustomerCUPS.CUPS);

                        SUCOmipCustomerCUPS.TestField("SUC Supply Point Address");
                        SUCOmipCustomerCUPS.TestField("SUC Supply Point Country");
                        SUCOmipCustomerCUPS.TestField("SUC Supply Point Post Code");
                        SUCOmipCustomerCUPS.TestField("SUC Supply Point City");
                        SUCOmipCustomerCUPS.TestField("SUC Supply Point County");

                        "SUC Supply Point Address" := SUCOmipCustomerCUPS."SUC Supply Point Address";
                        "SUC Supply Point Post Code" := SUCOmipCustomerCUPS."SUC Supply Point Post Code";
                        "SUC Supply Point City" := SUCOmipCustomerCUPS."SUC Supply Point City";
                        "SUC Supply Point County" := SUCOmipCustomerCUPS."SUC Supply Point County";
                        "SUC Supply Point Country" := SUCOmipCustomerCUPS."SUC Supply Point Country";

                        CreateContractedPower();
                        CreateConsumptionDeclared();
                        case "Product Type" of
                            "Product Type"::"Energy (Light - Gas)":
                                "Rate No." := "Rate No. Contract";
                        end;
                    end;
                end;
            end;

            trigger OnValidate()
            begin
                ValidateStatusDocument();
                ValidationsCustomerCUPSandRateNo();
            end;
        }
        field(4; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;

            trigger OnValidate()
            var
                ArrayPotence: array[6] of Decimal;
                ArraykWhAnual: array[6] of Decimal;
                RateNo: Text;
            begin
                ValidateStatusDocument();
                if "Customer CUPS" <> '' then
                    if SUCOmipManagement.GetDataSIPS("Customer CUPS", ArrayPotence, ArraykWhAnual, RateNo) then
                        if (Rec."Rate No." <> '') and (RateNo <> '') then
                            if RateNo <> Rec."Rate No." then
                                Error(ErrorLbl, "Customer CUPS", Rec."Rate No.", RateNo);

                if (Rec."Rate No." <> '') or (Rec."Rate No." <> xRec."Rate No.") then begin
                    CalcFields("Marketer No.", "Agent No.");
                    SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::Contract, "Contract No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                    SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::Contract, "Contract No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                    GetCalculateEnergy();
                end;
            end;
        }
        field(5; "SUC Supply Point Address"; Text[200])
        {
            Caption = 'Address';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
            end;
        }
        field(6; "SUC Supply Point Post Code"; Code[20])
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
                ValidateStatusDocument();
                PostCode.ValidatePostCode("SUC Supply Point City", "SUC Supply Point Post Code", "SUC Supply Point County", "SUC Supply Point Country", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(7; "SUC Supply Point City"; Text[30])
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
                ValidateStatusDocument();
                PostCode.ValidateCity("SUC Supply Point City", "SUC Supply Point Post Code", "SUC Supply Point County", "SUC Supply Point Country", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(8; "SUC Supply Point County"; Text[30])
        {
            CaptionClass = '5,1,' + "SUC Supply Point Country";
            Caption = 'County';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
            end;
        }
        field(9; "SUC Supply Point Country"; Code[10])
        {
            Caption = 'Country/Region';
            TableRelation = "Country/Region";
            trigger OnValidate()
            var
                CityTxt: Text;
                CountyTxt: Text;
            begin
                ValidateStatusDocument();
                CityTxt := "SUC Supply Point City";
                CountyTxt := "SUC Supply Point County";
                PostCode.CheckClearPostCodeCityCounty(CityTxt, "SUC Supply Point Post Code", CountyTxt, "SUC Supply Point Country", xRec."SUC Supply Point Country");
                "SUC Supply Point City" := CopyStr(CityTxt, 1, 30);
                "SUC Supply Point County" := CopyStr(CountyTxt, 1, 30);
            end;
        }
        field(10; P1; Decimal)
        {
            Caption = 'P1';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                UpdateContractedPower();
            end;
        }
        field(11; P2; Decimal)
        {
            Caption = 'P2';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                UpdateContractedPower();
            end;
        }
        field(12; P3; Decimal)
        {
            Caption = 'P3';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                UpdateContractedPower();
            end;
        }
        field(13; P4; Decimal)
        {
            Caption = 'P4';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                UpdateContractedPower();
            end;
        }
        field(14; P5; Decimal)
        {
            Caption = 'P5';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                UpdateContractedPower();
            end;
        }
        field(15; P6; Decimal)
        {
            Caption = 'P6';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                ValidateStatusDocument();
                UpdateContractedPower();
            end;
        }
        field(16; "Activation Date"; Date)
        {
            Caption = 'Activation Date';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
            end;
        }
        field(17; Volume; Integer)
        {
            Caption = 'Volume';
            trigger OnValidate()
            begin
                ValidateStatusDocument();
            end;
        }
        field(18; "Contract Id"; Guid)
        {
            Caption = 'Contract Id';
            TableRelation = "SUC Omip Energy Contracts".SystemId;
            DataClassification = CustomerContent;
        }
        field(19; "Omip Contract"; Boolean)
        {
            Caption = 'Omip Contract';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Energy Contracts"."Omip Contract" where("No." = field("Contract No.")));
            // ObsoleteState = Pending; //TODO
            // ObsoleteReason = 'Field change by "Product Type"';
            // ObsoleteTag = '25.08';
        }
        field(20; "Rate No. Contract"; Code[20])
        {
            Caption = 'Rate No. Contract';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Energy Contracts"."Rate No." where("No." = field("Contract No.")));
        }
        field(21; "Marketer No."; Code[20])
        {
            Caption = 'Marketer';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Energy Contracts"."Marketer No." where("No." = field("Contract No.")));
        }
        field(22; "Agent No."; Code[100])
        {
            Caption = 'Agent No.';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Energy Contracts"."Agent No." where("No." = field("Contract No.")));
        }
        field(23; "FEE Group Id."; Code[20])
        {
            Caption = 'Agent No.';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Energy Contracts"."FEE Group Id." where("No." = field("Contract No.")));
        }
        field(24; "Product Type"; Enum "SUC Product Type")
        {
            Caption = 'Product Type';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Energy Contracts"."Product Type" where("No." = field("Contract No.")));
        }
    }

    keys
    {
        key(Key1; "Contract No.", "Customer CUPS")
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        SUCOmipEnergyContractsMul: Record "SUC Omip Energy Contracts Mul.";
        SUCOmipPowerEntryContract: Record "SUC Omip Power Entry Contract";
        SUCOmipEnergyEntryContract: Record "SUC Omip Energy Entry Contract";
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
        SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
        SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
        SUCOmipFEEEnergyDocument: Record "SUC Omip FEE Energy Document";
        NoRowsRateNo: Integer;
    begin
        SUCOmipEnergyContractsMul.Reset();
        SUCOmipEnergyContractsMul.SetRange("Contract No.", "Contract No.");
        SUCOmipEnergyContractsMul.SetRange("Rate No.", "Rate No.");
        NoRowsRateNo := SUCOmipEnergyContractsMul.Count;
        if NoRowsRateNo = 1 then begin
            SUCOmipPowerEntryContract.Reset();
            SUCOmipPowerEntryContract.SetRange("Contract No.", "Contract No.");
            SUCOmipPowerEntryContract.SetRange("Rate No.", "Rate No.");
            SUCOmipPowerEntryContract.DeleteAll();

            SUCOmipEnergyEntryContract.Reset();
            SUCOmipEnergyEntryContract.SetRange("Contract No.", "Contract No.");
            SUCOmipEnergyEntryContract.SetRange("Rate No.", "Rate No.");
            SUCOmipEnergyEntryContract.DeleteAll();

            SUCOmipFEEPowerDocument.Reset();
            SUCOmipFEEPowerDocument.SetRange("Document Type", SUCOmipFEEPowerDocument."Document Type"::Contract);
            SUCOmipFEEPowerDocument.SetRange("Document No.", "Contract No.");
            SUCOmipFEEPowerDocument.SetRange("Rate No.", "Rate No.");
            SUCOmipFEEPowerDocument.DeleteAll();

            SUCOmipFEEEnergyDocument.Reset();
            SUCOmipFEEEnergyDocument.SetRange("Document Type", SUCOmipFEEEnergyDocument."Document Type"::Contract);
            SUCOmipFEEEnergyDocument.SetRange("Document No.", "Contract No.");
            SUCOmipFEEEnergyDocument.SetRange("Rate No.", "Rate No.");
            SUCOmipFEEEnergyDocument.DeleteAll();
        end;

        SUCOmipContractedPower.Reset();
        SUCOmipContractedPower.SetRange("Document Type", SUCOmipContractedPower."Document Type"::Contract);
        SUCOmipContractedPower.SetRange("Document No.", "Contract No.");
        SUCOmipContractedPower.SetRange("CUPS", "Customer CUPS");
        SUCOmipContractedPower.DeleteAll();

        SUCOmipConsumptionDeclared.Reset();
        SUCOmipConsumptionDeclared.SetRange("Document Type", SUCOmipConsumptionDeclared."Document Type"::Contract);
        SUCOmipConsumptionDeclared.SetRange("Document No.", "Contract No.");
        SUCOmipConsumptionDeclared.SetRange("CUPS", "Customer CUPS");
        SUCOmipConsumptionDeclared.DeleteAll();
    end;

    local procedure GetCalculateEnergy()
    SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    begin
        SUCOmipEnergyContracts.Get("Contract No.");
        SUCOmipManagement.CalculateEnergyContract2(SUCOmipEnergyContracts, "Rate No.", SUCOmipEnergyContracts.Type, SUCOmipEnergyContracts.Times);
    end;

    local procedure CreateContractedPower()
    var
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
    begin
        if not SUCOmipContractedPower.Get(SUCOmipContractedPower."Document Type"::Contract, "Contract No.", "Customer CUPS") then begin
            SUCOmipContractedPower.Init();
            SUCOmipContractedPower."Document Type" := SUCOmipContractedPower."Document Type"::Contract;
            SUCOmipContractedPower."Document No." := "Contract No.";
            SUCOmipContractedPower.CUPS := "Customer CUPS";
            SUCOmipContractedPower."Rate No." := "Rate No.";
            SUCOmipContractedPower.Insert();
        end;
    end;

    local procedure CreateConsumptionDeclared()
    var
        SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
    begin
        if not SUCOmipConsumptionDeclared.Get(SUCOmipConsumptionDeclared."Document Type"::Contract, "Contract No.", "Customer CUPS") then begin
            SUCOmipConsumptionDeclared.Init();
            SUCOmipConsumptionDeclared."Document Type" := SUCOmipConsumptionDeclared."Document Type"::Contract;
            SUCOmipConsumptionDeclared."Document No." := "Contract No.";
            SUCOmipConsumptionDeclared.CUPS := "Customer CUPS";
            SUCOmipConsumptionDeclared."Rate No." := "Rate No.";
            SUCOmipConsumptionDeclared.Insert();
        end;
    end;

    local procedure ValidateStatusDocument()
    var
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
    begin
        SUCOmipEnergyContracts.Get("Contract No.");
        SUCOmipEnergyContracts.TestField(Status, SUCOmipEnergyContracts.Status::"Pending Acceptance");
    end;

    local procedure UpdateContractedPower()
    var
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
    begin
        if SUCOmipContractedPower.Get(SUCOmipContractedPower."Document Type"::Contract, "Contract No.", "Customer CUPS") then begin
            SUCOmipContractedPower.P1 := P1;
            SUCOmipContractedPower.P2 := P2;
            SUCOmipContractedPower.P3 := P3;
            SUCOmipContractedPower.P4 := P4;
            SUCOmipContractedPower.P5 := P5;
            SUCOmipContractedPower.P6 := P6;
            //* Commisions
            SUCOmipContractedPower.CalculateCommision();
            //* End Commisions
            SUCOmipContractedPower.Modify();
        end;
    end;

    local procedure ValidationsCustomerCUPSandRateNo()
    var
        SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
        SUCOmipRates: Record "SUC Omip Rates";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        ArrayPotence: array[6] of Decimal;
        ArraykWhAnual: array[6] of Decimal;
        EnergyCalculationMatrix: array[6] of Decimal;
        RealFEE: array[6] of Decimal;
        WithSIPSInformation: Boolean;
        RateNo: Text;
        ErrorRateNotFoundLbl: Label 'The SIPS indicates rate %1 for CUPS %2, which does not exist, you must create the rate to use this CUPS.';
    begin
        SUCOmipEnergyContracts.Get("Contract No.");
        if SUCOmipManagement.GetDataSIPS("Customer CUPS", ArrayPotence, ArraykWhAnual, RateNo) then
            if Rec."Rate No." <> '' then begin
                if (RateNo <> '') and (RateNo <> Rec."Rate No.") then
                    Error(ErrorLbl, "Customer CUPS", Rec."Rate No.", RateNo);
            end else
                if RateNo <> '' then
                    if SUCOmipRates.Get(RateNo) then
                        "Rate No." := CopyStr(RateNo, 1, MaxStrLen(Rec."Rate No."))
                    else
                        Error(ErrorRateNotFoundLbl, RateNo, "Customer CUPS");

        if "Rate No." <> '' then begin
            CalcFields("Marketer No.", "Agent No.", "FEE Group Id.");

            SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::Contract, "Contract No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
            SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::Contract, "Contract No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");

            if SUCOmipCustomerCUPS.Get("Customer No.", "Customer CUPS") then begin
                SUCOmipCustomerCUPS.TestField("SUC Supply Point Address");
                SUCOmipCustomerCUPS.TestField("SUC Supply Point Country");
                SUCOmipCustomerCUPS.TestField("SUC Supply Point Post Code");
                SUCOmipCustomerCUPS.TestField("SUC Supply Point City");
                SUCOmipCustomerCUPS.TestField("SUC Supply Point County");
            end;

            SUCOmipManagement.CalculateRealFEEEnergy(SUCOmipDocumentType::Contract, "Contract No.");
            SUCOmipManagement.GetComercialFEEEnergyDocument(SUCOmipDocumentType::Contract, "Contract No.", "Marketer No.", "Rate No.", ComercialFEE);
            SUCOmipManagement.ValidateWithSIPSInformation(SUCOmipDocumentType::Contract, "Contract No.", "Rate No.", WithSIPSInformation, EnergyCalculationMatrix, RealFEE);
            SUCOmipManagement.SetPricesByTime(SUCOmipEnergyContracts.Type, "Marketer No.", SUCOmipEnergyContracts."Energy Origen", true, ComercialFEE, WithSIPSInformation, EnergyCalculationMatrix, RealFEE);
            GetCalculateEnergy();
        end;
        UpdateContractedPower(ArrayPotence);
        UpdateConsumptionDeclared(ArraykWhAnual);
    end;

    local procedure UpdateContractedPower(ArrayPotence: array[6] of Decimal)
    var
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
    begin
        SUCOmipContractedPower.Reset();
        SUCOmipContractedPower.SetRange("Document Type", SUCOmipContractedPower."Document Type"::Contract);
        SUCOmipContractedPower.SetRange("Document No.", "Contract No.");
        SUCOmipContractedPower.SetRange("CUPS", "Customer CUPS");
        if SUCOmipContractedPower.FindSet() then
            repeat
                SUCOmipContractedPower.Delete();
            until SUCOmipContractedPower.Next() = 0;

        if not SUCOmipContractedPower.Get(SUCOmipContractedPower."Document Type"::Contract, "Contract No.", "Customer CUPS") then begin
            SUCOmipContractedPower.Init();
            SUCOmipContractedPower.Validate("Document Type", SUCOmipContractedPower."Document Type"::Contract);
            SUCOmipContractedPower.Validate("Document No.", "Contract No.");
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

            P1 := SUCOmipContractedPower.P1;
            P2 := SUCOmipContractedPower.P2;
            P3 := SUCOmipContractedPower.P3;
            P4 := SUCOmipContractedPower.P4;
            P5 := SUCOmipContractedPower.P5;
            P6 := SUCOmipContractedPower.P6;
        end;
    end;

    local procedure UpdateConsumptionDeclared(ArraykWhAnual: array[6] of Decimal)
    var
        SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
    begin
        SUCOmipConsumptionDeclared.Reset();
        SUCOmipConsumptionDeclared.SetRange("Document Type", SUCOmipConsumptionDeclared."Document Type"::Contract);
        SUCOmipConsumptionDeclared.SetRange("Document No.", "Contract No.");
        SUCOmipConsumptionDeclared.SetRange("CUPS", "Customer CUPS");
        if SUCOmipConsumptionDeclared.FindSet() then
            repeat
                SUCOmipConsumptionDeclared.Delete();
            until SUCOmipConsumptionDeclared.Next() = 0;

        if not SUCOmipConsumptionDeclared.Get(SUCOmipConsumptionDeclared."Document Type"::Contract, "Contract No.", "Customer CUPS") then begin
            SUCOmipConsumptionDeclared.Init();
            SUCOmipConsumptionDeclared.Validate("Document Type", SUCOmipConsumptionDeclared."Document Type"::Contract);
            SUCOmipConsumptionDeclared.Validate("Document No.", "Contract No.");
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

    var
        PostCode: Record "Post Code";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        SUCOmipDocumentType: Enum "SUC Omip Document Type";
        ComercialFEE: array[6] of Decimal;
        ErrorLbl: Label 'CUPS %1 is not valid for rate %2. SIPS indicates the rate is %3.';
}