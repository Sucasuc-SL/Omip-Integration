namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.User;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Contracts;
table 50178 "SUC Omip Consumption Declared"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Consumption Declared';
    LookupPageId = "SUC Omip Consumption Declared";
    DrillDownPageId = "SUC Omip Consumption Declared";

    fields
    {
        field(1; "Document Type"; Enum "SUC Omip Document Type")
        {
            Caption = 'Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = if ("Document Type" = const("Proposal")) "SUC Omip Proposals"."No."
            else
            if ("Document Type" = const("Contract")) "SUC Omip Energy Contracts"."No.";
        }
        field(3; "CUPS"; Text[25])
        {
            Caption = 'CUPS';
            TableRelation = "SUC Omip Customer CUPS".CUPS;
            trigger OnValidate()
            var
                SUCOmipProposals: Record "SUC Omip Proposals";
                SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
            begin
                case "Document Type" of
                    "Document Type"::Proposal:
                        if SUCOmipProposals.Get("Document No.") then
                            if not SUCOmipProposals.Multicups then
                                if CUPS <> SUCOmipProposals."Customer CUPS" then
                                    TestField("CUPS", SUCOmipProposals."Customer CUPS");
                    "Document Type"::Contract:
                        if SUCOmipEnergyContracts.Get("Document No.") then
                            if not SUCOmipEnergyContracts.Multicups then
                                if CUPS <> SUCOmipEnergyContracts."Customer CUPS" then
                                    TestField("CUPS", SUCOmipEnergyContracts."Customer CUPS");
                end;
            end;
        }
        field(4; P1; Decimal)
        {
            Caption = 'P1';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                TestField("P1 From SIPS", false);
                UpdateVolume();
                CalculateTotal();
                CalculateRealFEE();
            end;
        }
        field(5; P2; Decimal)
        {
            Caption = 'P2';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                TestField("P2 From SIPS", false);
                UpdateVolume();
                CalculateTotal();
                CalculateRealFEE();
            end;
        }
        field(6; P3; Decimal)
        {
            Caption = 'P3';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                TestField("P3 From SIPS", false);
                UpdateVolume();
                CalculateTotal();
                CalculateRealFEE();
            end;
        }
        field(7; P4; Decimal)
        {
            Caption = 'P4';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                TestField("P4 From SIPS", false);
                UpdateVolume();
                CalculateTotal();
                CalculateRealFEE();
            end;
        }
        field(8; P5; Decimal)
        {
            Caption = 'P5';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                TestField("P5 From SIPS", false);
                UpdateVolume();
                CalculateTotal();
                CalculateRealFEE();
            end;
        }
        field(9; P6; Decimal)
        {
            Caption = 'P6';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                TestField("P6 From SIPS", false);
                UpdateVolume();
                CalculateTotal();
                CalculateRealFEE();
            end;
        }
        field(10; Total; Decimal)
        {
            Caption = 'Total';
            DecimalPlaces = 0 : 6;
        }

        field(11; "P1 %"; Decimal)
        {
            Caption = 'P1 %';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:2><Standard Format,0>%';
            Editable = false;
        }
        field(12; "P2 %"; Decimal)
        {
            Caption = 'P2 %';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:2><Standard Format,0>%';
            Editable = false;
        }
        field(13; "P3 %"; Decimal)
        {
            Caption = 'P3 %';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:2><Standard Format,0>%';
            Editable = false;
        }
        field(14; "P4 %"; Decimal)
        {
            Caption = 'P4 %';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:2><Standard Format,0>%';
            Editable = false;
        }
        field(15; "P5 %"; Decimal)
        {
            Caption = 'P5 %';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:2><Standard Format,0>%';
            Editable = false;
        }
        field(16; "P6 %"; Decimal)
        {
            Caption = 'P6 %';
            AutoFormatType = 10;
            AutoFormatExpression = '<precision, 2:2><Standard Format,0>%';
            Editable = false;
        }
        field(17; "P1 From SIPS"; Boolean)
        {
            Caption = 'P1 from SIPS';
        }
        field(18; "P2 From SIPS"; Boolean)
        {
            Caption = 'P2 from SIPS';
        }
        field(19; "P3 From SIPS"; Boolean)
        {
            Caption = 'P3 from SIPS';
        }
        field(20; "P4 From SIPS"; Boolean)
        {
            Caption = 'P4 from SIPS';
        }
        field(21; "P5 From SIPS"; Boolean)
        {
            Caption = 'P5 from SIPS';
        }
        field(22; "P6 From SIPS"; Boolean)
        {
            Caption = 'P6 from SIPS';
        }
        field(23; "SIPS Information"; Boolean)
        {
            Caption = 'SIPS Information';
        }
        field(24; "Real FEE P1"; Decimal)
        {
            Caption = 'Real FEE P1';
            DecimalPlaces = 0 : 6;
        }
        field(25; "Real FEE P2"; Decimal)
        {
            Caption = 'Real FEE P2';
            DecimalPlaces = 0 : 6;
        }
        field(26; "Real FEE P3"; Decimal)
        {
            Caption = 'Real FEE P3';
            DecimalPlaces = 0 : 6;
        }
        field(27; "Real FEE P4"; Decimal)
        {
            Caption = 'Real FEE P4';
            DecimalPlaces = 0 : 6;
        }
        field(28; "Real FEE P5"; Decimal)
        {
            Caption = 'Real FEE P5';
            DecimalPlaces = 0 : 6;
        }
        field(29; "Real FEE P6"; Decimal)
        {
            Caption = 'Real FEE P6';
            DecimalPlaces = 0 : 6;
        }
        field(30; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
        }
        field(31; "From Update Prices"; Boolean)
        {
            Caption = 'From Update Prices';
        }
        field(32; "Real FEE Total"; Decimal)
        {
            Caption = 'Real FEE Total';
            DecimalPlaces = 0 : 6;
        }
        field(33; "Commission P1"; Decimal)
        {
            Caption = 'Commission P1';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(34; "Commission P2"; Decimal)
        {
            Caption = 'Commission P2';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(35; "Commission P3"; Decimal)
        {
            Caption = 'Commission P3';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(36; "Commission P4"; Decimal)
        {
            Caption = 'Commission P4';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(37; "Commission P5"; Decimal)
        {
            Caption = 'Commission P5';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(38; "Commission P6"; Decimal)
        {
            Caption = 'Commission P6';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(39; "Total Commission"; Decimal)
        {
            Caption = 'Total Commission';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
            trigger OnValidate()
            begin
                SetCommisionsEntry();
            end;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "CUPS")
        {
            Clustered = true;
        }
    }
    trigger OnModify()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
    begin
        case "Document Type" of
            "Document Type"::Proposal:
                if SUCOmipProposals.Get("Document No.") then
                    SUCOmipProposals.TestField(Status, SUCOmipProposals.Status::"Pending Acceptance");
        end;
    end;

    local procedure UpdateVolume()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipProposalMulticups: Record "SUC Omip Proposal Multicups";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCOmipEnergyContractsMul: Record "SUC Omip Energy Contracts Mul.";
        NewVolume: Decimal;
    begin
        TestField(CUPS);
        case "Document Type" of
            "Document Type"::Proposal:
                begin
                    SUCOmipProposals.Get("Document No.");
                    if SUCOmipProposals.Multicups then begin
                        SUCOmipProposalMulticups.Get("Document No.", CUPS);
                        NewVolume := P1 + P2 + P3 + P4 + P5 + P6;
                        SUCOmipProposalMulticups.Volume := NewVolume;
                        SUCOmipProposalMulticups.Modify();
                    end else begin
                        NewVolume := P1 + P2 + P3 + P4 + P5 + P6;
                        SUCOmipProposals."Volume" := NewVolume;
                        SUCOmipProposals.Modify();
                    end;
                end;
            "Document Type"::Contract:
                begin
                    SUCOmipEnergyContracts.Get("Document No.");
                    if SUCOmipEnergyContracts.Multicups then begin
                        SUCOmipEnergyContractsMul.Get("Document No.", CUPS);
                        NewVolume := P1 + P2 + P3 + P4 + P5 + P6;
                        SUCOmipEnergyContractsMul.Volume := NewVolume;
                        SUCOmipEnergyContractsMul.Modify();
                    end else begin
                        NewVolume := P1 + P2 + P3 + P4 + P5 + P6;
                        SUCOmipEnergyContracts."Volume" := NewVolume;
                        SUCOmipEnergyContracts.Modify();
                    end;
                end;
        end;
    end;

    procedure CalculateTotal()
    begin
        Total := P1 + P2 + P3 + P4 + P5 + P6;
        if Total <> 0 then begin
            "P1 %" := P1 / Total;
            "P2 %" := P2 / Total;
            "P3 %" := P3 / Total;
            "P4 %" := P4 / Total;
            "P5 %" := P5 / Total;
            "P6 %" := P6 / Total;
        end;
    end;

    procedure CalculateRealFEE()
    var
        SUCOmipFEEEnergyDocument: Record "SUC Omip FEE Energy Document";
        SUCOmipRatesEntrySetup: Record "SUC Omip Rates Entry Setup";
        TotalRealFEE: Decimal;
        ErrorMaxFEELbl: Label 'The total value of the actual FEE is %1, it must be maximum %2.';
    begin
        SUCOmipFEEEnergyDocument.Reset();
        SUCOmipFEEEnergyDocument.SetRange("Document Type", "Document Type");
        SUCOmipFEEEnergyDocument.SetRange("Document No.", "Document No.");
        SUCOmipFEEEnergyDocument.SetRange("Rate No.", "Rate No.");
        if SUCOmipFEEEnergyDocument.FindFirst() then begin
            "Real FEE P1" := SUCOmipFEEEnergyDocument.P1 * "P1 %";
            "Real FEE P2" := SUCOmipFEEEnergyDocument.P2 * "P2 %";
            "Real FEE P3" := SUCOmipFEEEnergyDocument.P3 * "P3 %";
            "Real FEE P4" := SUCOmipFEEEnergyDocument.P4 * "P4 %";
            "Real FEE P5" := SUCOmipFEEEnergyDocument.P5 * "P5 %";
            "Real FEE P6" := SUCOmipFEEEnergyDocument.P6 * "P6 %";
            TotalRealFEE := "Real FEE P1" + "Real FEE P2" + "Real FEE P3" + "Real FEE P4" + "Real FEE P5" + "Real FEE P6";
            "Real FEE Total" := TotalRealFEE;
            //*Commisions
            "Commission P1" := "Real FEE P1" * P1;
            "Commission P2" := "Real FEE P2" * P2;
            "Commission P3" := "Real FEE P3" * P3;
            "Commission P4" := "Real FEE P4" * P4;
            "Commission P5" := "Real FEE P5" * P5;
            "Commission P6" := "Real FEE P6" * P6;
            Validate("Total Commission", "Real FEE Total" * (Total / 1000)); //* Total is calculate in kWh, we passed it to MWh
            //*End Commisions
            SUCOmipRatesEntrySetup.Get(SUCOmipFEEEnergyDocument."Marketer No.");
            SUCOmipRatesEntrySetup.TestField("Max. FEE Energy");
            if TotalRealFEE > SUCOmipRatesEntrySetup."Max. FEE Energy" then
                Error(ErrorMaxFEELbl, TotalRealFEE, SUCOmipRatesEntrySetup."Max. FEE Energy");
        end;
    end;

    local procedure SetCommisionsEntry()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        SUCCommissionsEntry: Record "SUC Commissions Entry";
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        SUCOmipExternalUsersSuperior: Record "SUC Omip External Users";
        SUCOmipUserComFigures: Record "SUC Omip Ext User Com. Figures";
        SUCOmipUserComFiguresSuperior: Record "SUC Omip Ext User Com. Figures";
        SUCCommercialFigures: Record "SUC Commercial Figures";
        SUCCommercialFiguresSuperior: Record "SUC Commercial Figures";
        AgentNo: Code[100];
    begin
        case "Document Type" of
            "Document Type"::Proposal:
                begin
                    SUCOmipProposals.Get("Document No.");
                    AgentNo := SUCOmipProposals."Agent No.";
                end;
            "Document Type"::Contract:
                begin
                    SUCOmipEnergyContracts.Get("Document No.");
                    AgentNo := SUCOmipEnergyContracts."Agent No.";
                end;
        end;

        if SUCOmipExternalUsers.Get(AgentNo) then
            if SUCOmipExternalUsers."Active Commisions" then begin
                //* Get first commercial figure record for this agent
                SUCOmipUserComFigures.Reset();
                SUCOmipUserComFigures.SetRange("User Name", AgentNo);
                if SUCOmipUserComFigures.FindFirst() then begin
                    //* Required fields for commissions entry
                    SUCOmipUserComFigures.TestField("Commercial Figures Type");
                    SUCOmipUserComFigures.TestField("Commercial Figure");

                    SUCCommercialFigures.Get(SUCOmipUserComFigures."Commercial Figures Type", SUCOmipUserComFigures."Commercial Figure");
                    SUCCommercialFigures.TestField(Distribution);
                    SUCCommercialFigures.TestField("Hierarchical Level");

                    if not SUCCommissionsEntry.Get("Document Type", "Document No.", AgentNo) then begin
                        SUCCommissionsEntry.Init();
                        SUCCommissionsEntry.Validate("Document Type", "Document Type");
                        SUCCommissionsEntry.Validate("Document No.", "Document No.");
                        SUCCommissionsEntry.Validate("Agent No.", AgentNo);
                        SUCCommissionsEntry.Validate("Commercial Figures Type", SUCOmipUserComFigures."Commercial Figures Type");
                        SUCCommissionsEntry.Validate("Commercial Figure", SUCOmipUserComFigures."Commercial Figure");
                        SUCCommissionsEntry.Validate("Percent Commision Own Sale", SUCCommercialFigures.Distribution);
                        SUCCommissionsEntry.Validate("Hierarchical Level", SUCCommercialFigures."Hierarchical Level");
                        SUCCommissionsEntry.Validate("Superior Officer", SUCOmipUserComFigures."Superior Officer");
                        //* Superior Officer Information
                        if SUCOmipUserComFigures."Superior Officer" <> '' then begin
                            SUCOmipExternalUsersSuperior.Get(SUCOmipUserComFigures."Superior Officer");
                            SUCOmipExternalUsersSuperior.TestField("Active Commisions", true);
                            SUCOmipUserComFiguresSuperior.Reset();
                            SUCOmipUserComFiguresSuperior.SetRange("User Name", SUCOmipUserComFigures."Superior Officer");
                            SUCOmipUserComFiguresSuperior.SetRange("Commercial Figures Type", SUCOmipUserComFigures."Commercial Figures Type");
                            if SUCOmipUserComFiguresSuperior.FindFirst() then begin
                                SUCCommercialFiguresSuperior.Get(SUCOmipUserComFiguresSuperior."Commercial Figures Type", SUCOmipUserComFiguresSuperior."Commercial Figure");
                                SUCCommissionsEntry.Validate("Percent Hierarchy Distribution", SUCCommercialFiguresSuperior.Distribution);
                            end;
                        end;
                        SUCCommissionsEntry.Validate("First Agent Calculation", true);
                        SUCCommissionsEntry.Insert();
                    end;
                    SUCCommissionsEntry.Validate("Energy Commission Amount", "Total Commission" + GetTotalOthersCommisions());
                    SUCCommissionsEntry.Modify();
                end;
            end;
    end;

    local procedure GetTotalOthersCommisions(): Decimal
    var
        SUCOmipConsumptionDeclared: Record "SUC Omip Consumption Declared";
        CommissionTotal: Decimal;
    begin
        Clear(CommissionTotal);
        SUCOmipConsumptionDeclared.Reset();
        SUCOmipConsumptionDeclared.SetRange("Document Type", "Document Type");
        SUCOmipConsumptionDeclared.SetRange("Document No.", "Document No.");
        SUCOmipConsumptionDeclared.SetFilter("Rate No.", '<>%1', "Rate No.");
        if SUCOmipConsumptionDeclared.FindSet() then
            repeat
                CommissionTotal += SUCOmipConsumptionDeclared.Total;
            until SUCOmipConsumptionDeclared.Next() = 0;
        exit(CommissionTotal);
    end;

    var
        ExprLbl: Label '1,EUR';
}