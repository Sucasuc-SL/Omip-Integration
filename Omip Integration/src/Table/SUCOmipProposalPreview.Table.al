namespace Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Setup;
using Sucasuc.Omip.User;
using Sucasuc.Omip.Ledger;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.NoSeries;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Utilities;
table 50197 "SUC Omip Proposal Preview"
{
    Caption = 'Omip Proposals';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Preview Proposal No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    SUCOmipSetup.Get();
                    NoSeries.TestManual(SUCOmipSetup."Preview Proposal Nos.");
                    "No." := '';
                end;
            end;
        }
        field(2; "Date Proposal"; Date)
        {
            Caption = 'Date Proposal';
            DataClassification = CustomerContent;
        }
        field(3; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
            trigger OnValidate()
            begin
                ClearRelations();
                SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::"Proposal Preview", "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::"Proposal Preview", "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
            end;
        }
        field(4; Times; Enum "SUC Omip Times")
        {
            Caption = 'Time';
        }
        field(5; Type; Enum "SUC Omip Rate Entry Types")
        {
            Caption = 'Type';

            trigger OnValidate()
            var
                SUCOmipTypes: Record "SUC Omip Types";
            begin
                if SUCOmipTypes.Get(Type) then begin
                    SUCOmipTypes.TestField("Start Date Contract");
                    "Contract Start Date" := CalcDate('<-CM>', CalcDate(SUCOmipTypes."Start Date Contract", "Date Proposal"));
                end else
                    "Contract Start Date" := 0D;
            end;
        }
        field(6; "FEE Potency"; Decimal)
        {
            Caption = 'FEE Potency';
            DecimalPlaces = 0 : 6;
            ObsoleteState = Pending;
            ObsoleteReason = 'Change by Table "SUC Omip FEE Power Document"';
            ObsoleteTag = '25.02';
        }
        field(7; "Energy Origen"; Enum "SUC Omip Energy Origen")
        {
            Caption = 'Energy Origen';
            trigger OnValidate()
            begin
                TestField("Marketer No.");
                ClearRelations();
                SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::"Proposal Preview", "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::"Proposal Preview", "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
            end;
        }
        field(8; "Contract Start Date"; Date)
        {
            Caption = 'Contract Start Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
            end;
        }
        field(9; "Date Created"; Date)
        {
            Caption = 'Date Created';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Marketer No."; Code[20])
        {
            Caption = 'Marketer';
            TableRelation = "SUC Omip Marketers"."No.";
            trigger OnValidate()
            var
            begin
                CalcFields("Marketer Name");
                ClearRelations();
                SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::"Proposal Preview", "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::"Proposal Preview", "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
            end;
        }
        field(11; "Marketer Name"; Text[250])
        {
            Caption = 'Marketer Name';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Omip Marketers".Name where("No." = field("Marketer No.")));
        }
        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(13; "FEE Energy"; Decimal)
        {
            Caption = 'FEE Energy';
            DecimalPlaces = 0 : 6;
            ObsoleteState = Pending;
            ObsoleteReason = 'Change by Table "SUC Omip FEE Power Document"';
            ObsoleteTag = '25.02';
        }
        field(14; "DateTime Created"; DateTime)
        {
            Caption = 'DateTime Created';
        }
        field(15; "Agent No."; Code[100])
        {
            Caption = 'Agent No.';
            TableRelation = "SUC Omip External Users"."User Name";
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                GroupFEEId: Code[20];
            begin
                ClearRelations();

                GroupFEEId := SUCOmipManagement.GetUserFEEGroupIdDefault("Agent No.");

                Validate("FEE Group Id.", GroupFEEId);
                // SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::"Proposal Preview", "No.", "Marketer No.", "Rate No.", "Agent No.");
                // SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::"Proposal Preview", "No.", "Marketer No.", "Rate No.", "Agent No.");
            end;
        }
        field(16; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalcFields("Customer Name");
            end;
        }
        field(17; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            FieldClass = FlowField;
        }
        field(18; "Customer CUPS"; Text[25])
        {
            Caption = 'CUPS';
            TableRelation = "SUC Omip Customer CUPS".CUPS where("Customer No." = field("Customer No."));
            trigger OnValidate()
            begin
                ValidationsCustomerCUPSandRateNo();

                if ("Customer CUPS" = '') and (xRec."Customer CUPS" <> '') then begin
                    ClearContractedPower(xRec."Customer CUPS");
                    ClearConsumptionDeclared(xRec."Customer CUPS");
                end;
            end;
        }
        field(19; "Volume"; Decimal)
        {
            Caption = 'Volume';
            Editable = false;
            DecimalPlaces = 0 : 0;
        }
        field(20; CUPS; Text[25])
        {
            Caption = 'CUPS';
            trigger OnValidate()
            var
                SUCOmipSetup: Record "SUC Omip Setup";
                SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
                SUCOmipManagement: Codeunit "SUC Omip Management";
            begin
                SUCOmipSetup.Get();
                SUCOmipSetup.TestField("Customer No. Proposal Preview");
                if not SUCOmipCustomerCUPS.Get(SUCOmipSetup."Customer No. Proposal Preview", CUPS) then
                    SUCOmipManagement.SetNewCUPSDefCustPrevProposals(SUCOmipSetup."Customer No. Proposal Preview", CUPS);
                Validate("Customer No.", SUCOmipSetup."Customer No. Proposal Preview");
                Validate("Customer CUPS", CUPS);
            end;
        }
        field(21; "FEE Group Id."; Code[20])
        {
            Caption = 'FEE Group Id.';
            TableRelation = "SUC Omip Ext. Users Groups FEE"."Group Id." where("User Name" = field("Agent No."));
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                SUCOmipManagement.SetPowerFEEAgentDoc(SUCOmipDocumentType::"Proposal Preview", "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
                SUCOmipManagement.SetEnergyFEEAgentDoc(SUCOmipDocumentType::"Proposal Preview", "No.", "Marketer No.", "Rate No.", "Agent No.", "FEE Group Id.");
            end;
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
            SUCOmipSetup.TestField("Preview Proposal Nos.");
            "No." := NoSeries.GetNextNo(SUCOmipSetup."Preview Proposal Nos.", WorkDate());
            "Date Created" := Today;
            "Date Proposal" := Today;
        end;
    end;

    trigger OnDelete()
    begin
        ClearPowerEntry();
        ClearEnergyEntry();
    end;

    procedure AssistEdit(OldSUCOmipProposalPreview: Record "SUC Omip Proposal Preview"): Boolean
    var
        SUCOmipProposalPreview: Record "SUC Omip Proposal Preview";
    begin
        SUCOmipProposalPreview := Rec;
        SUCOmipSetup.Get();
        SUCOmipSetup.TestField("Preview Proposal Nos.");
        if NoSeries.LookupRelatedNoSeries(SUCOmipSetup."Preview Proposal Nos.", OldSUCOmipProposalPreview."No. Series", SUCOmipProposalPreview."No. Series") then begin
            SUCOmipSetup.Get();
            SUCOmipSetup.TestField("Preview Proposal Nos.");
            SUCOmipProposalPreview."No." := NoSeries.GetNextNo(SUCOmipProposalPreview."No. Series");
            Rec := SUCOmipProposalPreview;
            exit(true);
        end;
    end;

    // local procedure GetCalculateEnergy()
    // begin
    //     SUCOmipManagement.CalculateEnergyPreview2(Rec, "Rate No.", Type, Times);
    // end;

    local procedure ClearPowerEntry()
    var
        SUCOmipPowerEntryPreview: Record "SUC Omip Power Entry Preview";
    begin
        SUCOmipPowerEntryPreview.Reset();
        SUCOmipPowerEntryPreview.SetRange("Proposal No.", "No.");
        if SUCOmipPowerEntryPreview.FindSet() then
            repeat
                SUCOmipPowerEntryPreview.Delete();
            until SUCOmipPowerEntryPreview.Next() = 0;
    end;

    local procedure ClearEnergyEntry()
    var
        SUCOmipEnergyEntryPreview: Record "SUC Omip Energy Entry Preview";
    begin
        SUCOmipEnergyEntryPreview.Reset();
        SUCOmipEnergyEntryPreview.SetRange("Proposal No.", "No.");
        if SUCOmipEnergyEntryPreview.FindSet() then
            repeat
                SUCOmipEnergyEntryPreview.Delete();
            until SUCOmipEnergyEntryPreview.Next() = 0;
    end;

    local procedure ClearFEEPowerDocument()
    begin
        SUCOmipFEEPowerDocument.Reset();
        SUCOmipFEEPowerDocument.SetRange("Document Type", SUCOmipDocumentType::"Proposal Preview");
        SUCOmipFEEPowerDocument.SetRange("Document No.", "No.");
        SUCOmipFEEPowerDocument.SetRange("Marketer No.", "Marketer No.");
        if SUCOmipFEEPowerDocument.FindSet() then
            repeat
                SUCOmipFEEPowerDocument.Delete();
            until SUCOmipFEEPowerDocument.Next() = 0;
    end;

    local procedure ClearFEEEnergyDocument()
    begin
        SUCOmipFEEEnergyDocument.Reset();
        SUCOmipFEEEnergyDocument.SetRange("Document Type", SUCOmipDocumentType::"Proposal Preview");
        SUCOmipFEEEnergyDocument.SetRange("Document No.", "No.");
        SUCOmipFEEEnergyDocument.SetRange("Marketer No.", "Marketer No.");
        if SUCOmipFEEEnergyDocument.FindSet() then
            repeat
                SUCOmipFEEEnergyDocument.Delete();
            until SUCOmipFEEEnergyDocument.Next() = 0;

    end;

    local procedure ClearRelations()
    begin
        ClearFEEPowerDocument();
        ClearFEEEnergyDocument();
        ClearPowerEntry();
        ClearEnergyEntry();
    end;

    procedure SetDocumentPricesWithCalculation()
    var
        WithSIPSInformation: Boolean;
        EnergyCalculationMatrix: array[6] of Decimal;
        RealFEE: array[6] of Decimal;
    begin
        SUCOmipManagement.CalculateRealFEEEnergy(SUCOmipDocumentType::"Proposal Preview", "No.");
        SUCOmipManagement.GetComercialFEEEnergyDocument(SUCOmipDocumentType::"Proposal Preview", "No.", "Marketer No.", "Rate No.", ComercialFEE);
        SUCOmipManagement.ValidateWithSIPSInformation(SUCOmipDocumentType::"Proposal Preview", "No.", "Rate No.", WithSIPSInformation, EnergyCalculationMatrix, RealFEE);
        SUCOmipManagement.SetPricesByTime(Type, "Marketer No.", "Energy Origen", false, ComercialFEE, WithSIPSInformation, EnergyCalculationMatrix, RealFEE);
        SUCOmipManagement.CalculateEnergyPreview2(Rec, "Rate No.", Type, Times);
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

        UpdateContractedPower(ArrayPotence);
        UpdateConsumptionDeclared(ArraykWhAnual);
        SUCOmipManagement.CalculateRealFEEEnergy(SUCOmipDocumentType::"Proposal Preview", "No.");
        SetDocumentPricesWithCalculation();
    end;

    local procedure ClearContractedPower(byCUPS: Text[25])
    var
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
    begin
        SUCOmipContractedPower.Reset();
        SUCOmipContractedPower.SetRange("Document Type", SUCOmipContractedPower."Document Type"::"Proposal Preview");
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
        SUCOmipConsumptionDeclared.SetRange("Document Type", SUCOmipConsumptionDeclared."Document Type"::"Proposal Preview");
        SUCOmipConsumptionDeclared.SetRange("Document No.", "No.");
        if byCUPS <> '' then
            SUCOmipConsumptionDeclared.SetRange("CUPS", byCUPS);
        if SUCOmipConsumptionDeclared.FindSet() then
            repeat
                SUCOmipConsumptionDeclared.Delete();
            until SUCOmipConsumptionDeclared.Next() = 0;
    end;

    local procedure UpdateContractedPower(ArrayPotence: array[6] of Decimal)
    var
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
    begin
        SUCOmipContractedPower.Reset();
        SUCOmipContractedPower.SetRange("Document Type", SUCOmipContractedPower."Document Type"::"Proposal Preview");
        SUCOmipContractedPower.SetRange("Document No.", "No.");
        if SUCOmipContractedPower.FindSet() then
            repeat
                SUCOmipContractedPower.Delete();
            until SUCOmipContractedPower.Next() = 0;

        if not SUCOmipContractedPower.Get(SUCOmipContractedPower."Document Type"::"Proposal Preview", "No.", "Customer CUPS") then begin
            SUCOmipContractedPower.Init();
            SUCOmipContractedPower.Validate("Document Type", SUCOmipContractedPower."Document Type"::"Proposal Preview");
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
        end;
    end;

    local procedure UpdateConsumptionDeclared(ArraykWhAnual: array[6] of Decimal)
    var
        SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
    begin
        SUCOmipConsumptionDeclared.Reset();
        SUCOmipConsumptionDeclared.SetRange("Document Type", SUCOmipConsumptionDeclared."Document Type"::"Proposal Preview");
        SUCOmipConsumptionDeclared.SetRange("Document No.", "No.");
        if SUCOmipConsumptionDeclared.FindSet() then
            repeat
                SUCOmipConsumptionDeclared.Delete();
            until SUCOmipConsumptionDeclared.Next() = 0;

        if not SUCOmipConsumptionDeclared.Get(SUCOmipConsumptionDeclared."Document Type"::"Proposal Preview", "No.", "Customer CUPS") then begin
            SUCOmipConsumptionDeclared.Init();
            SUCOmipConsumptionDeclared.Validate("Document Type", SUCOmipConsumptionDeclared."Document Type"::"Proposal Preview");
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

    var
        SUCOmipSetup: Record "SUC Omip Setup";
        SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
        SUCOmipFEEEnergyDocument: Record "SUC Omip FEE Energy Document";
        NoSeries: Codeunit "No. Series";
        SUCOmipManagement: Codeunit "SUC Omip Management";
        SUCOmipDocumentType: Enum "SUC Omip Document Type";
        ComercialFEE: array[6] of Decimal;
}