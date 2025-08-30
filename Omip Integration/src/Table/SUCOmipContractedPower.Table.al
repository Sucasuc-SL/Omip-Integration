namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.User;
using Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Contracts;
table 50177 "SUC Omip Contracted Power"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Contracted Power Term';
    LookupPageId = "SUC Omip Contracted Power";
    DrillDownPageId = "SUC Omip Contracted Power";

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
            trigger OnLookup()
            var
                SUCOmipProposals: Record "SUC Omip Proposals";
                SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
                SUCOmipCustomerCUPS: Record "SUC Omip Customer CUPS";
                SUCOmipCustomersCUPS: Page "SUC Omip Customer CUPS";
                CustomerNo: Code[20];
                ErrorLbl: Label 'You must use the multicups document, it is not possible to add a different CUPS for this type of document.';
            begin
                case "Document Type" of
                    "Document Type"::Contract:
                        begin
                            SUCOmipEnergyContracts.Get("Document No.");
                            CustomerNo := SUCOmipEnergyContracts."Customer No.";
                        end;
                    "Document Type"::Proposal:
                        begin
                            SUCOmipProposals.Get("Document No.");
                            CustomerNo := SUCOmipProposals."Customer No.";
                        end;
                end;
                SUCOmipCustomerCUPS.Reset();
                SUCOmipCustomerCUPS.SetRange("Customer No.", CustomerNo);
                if SUCOmipCustomerCUPS.FindSet() then begin
                    SUCOmipCustomersCUPS.SetRecord(SUCOmipCustomerCUPS);
                    SUCOmipCustomersCUPS.SetTableView(SUCOmipCustomerCUPS);
                    SUCOmipCustomersCUPS.LookupMode(true);
                    if SUCOmipCustomersCUPS.RunModal() = Action::LookupOK then begin
                        SUCOmipCustomersCUPS.GetRecord(SUCOmipCustomerCUPS);

                        case "Document Type" of
                            "Document Type"::Proposal:
                                if not SUCOmipProposals.Multicups then
                                    if SUCOmipCustomerCUPS.CUPS <> SUCOmipProposals."Customer CUPS" then
                                        Error(ErrorLbl);
                            "Document Type"::Contract:
                                if not SUCOmipEnergyContracts.Multicups then
                                    if SUCOmipCustomerCUPS.CUPS <> SUCOmipEnergyContracts."Customer CUPS" then
                                        Error(ErrorLbl);
                        end;

                        CUPS := SUCOmipCustomerCUPS.CUPS;
                    end;
                end;
            end;

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
                UpdateMulticups();
                CalculateTotal();
                CalculateCommision();
            end;
        }
        field(5; P2; Decimal)
        {
            Caption = 'P2';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                TestField("P2 From SIPS", false);
                UpdateMulticups();
                CalculateTotal();
                CalculateCommision();
            end;
        }
        field(6; P3; Decimal)
        {
            Caption = 'P3';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                TestField("P3 From SIPS", false);
                UpdateMulticups();
                CalculateTotal();
                CalculateCommision();
            end;
        }
        field(7; P4; Decimal)
        {
            Caption = 'P4';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                TestField("P4 From SIPS", false);
                UpdateMulticups();
                CalculateTotal();
                CalculateCommision();
            end;
        }
        field(8; P5; Decimal)
        {
            Caption = 'P5';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                TestField("P5 From SIPS", false);
                UpdateMulticups();
                CalculateTotal();
                CalculateCommision();
            end;
        }
        field(9; P6; Decimal)
        {
            Caption = 'P6';
            DecimalPlaces = 0 : 6;
            trigger OnValidate()
            begin
                TestField("P6 From SIPS", false);
                UpdateMulticups();
                CalculateTotal();
                CalculateCommision();
            end;
        }
        field(10; Total; Decimal)
        {
            Caption = 'Total';
            DecimalPlaces = 0 : 6;
        }
        field(11; "P1 From SIPS"; Boolean)
        {
            Caption = 'P1 from SIPS';
        }
        field(12; "P2 From SIPS"; Boolean)
        {
            Caption = 'P2 from SIPS';
        }
        field(13; "P3 From SIPS"; Boolean)
        {
            Caption = 'P3 from SIPS';
        }
        field(14; "P4 From SIPS"; Boolean)
        {
            Caption = 'P4 from SIPS';
        }
        field(15; "P5 From SIPS"; Boolean)
        {
            Caption = 'P5 from SIPS';
        }
        field(16; "P6 From SIPS"; Boolean)
        {
            Caption = 'P6 from SIPS';
        }
        field(17; "SIPS Information"; Boolean)
        {
            Caption = 'SIPS Information';
        }
        field(18; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
        }
        field(19; "Commission P1"; Decimal)
        {
            Caption = 'Commission P1';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(20; "Commission P2"; Decimal)
        {
            Caption = 'Commission P2';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(21; "Commission P3"; Decimal)
        {
            Caption = 'Commission P3';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(22; "Commission P4"; Decimal)
        {
            Caption = 'Commission P4';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(23; "Commission P5"; Decimal)
        {
            Caption = 'Commission P5';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(24; "Commission P6"; Decimal)
        {
            Caption = 'Commission P6';
            DecimalPlaces = 0 : 6;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(25; "Total Commission"; Decimal)
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

    procedure UpdateMulticups()
    var
        SUCOmipEnergyContractsMul: Record "SUC Omip Energy Contracts Mul.";
        SUCOmipProposalMulticups: Record "SUC Omip Proposal Multicups";
    begin
        case "Document Type" of
            "Document Type"::Contract:
                if SUCOmipEnergyContractsMul.Get("Document No.", CUPS) then begin
                    SUCOmipEnergyContractsMul.P1 := P1;
                    SUCOmipEnergyContractsMul.P2 := P2;
                    SUCOmipEnergyContractsMul.P3 := P3;
                    SUCOmipEnergyContractsMul.P4 := P4;
                    SUCOmipEnergyContractsMul.P5 := P5;
                    SUCOmipEnergyContractsMul.P6 := P6;
                    SUCOmipEnergyContractsMul.Modify();
                end;
            "Document Type"::Proposal:
                if SUCOmipProposalMulticups.Get("Document No.", CUPS) then begin
                    SUCOmipProposalMulticups.P1 := P1;
                    SUCOmipProposalMulticups.P2 := P2;
                    SUCOmipProposalMulticups.P3 := P3;
                    SUCOmipProposalMulticups.P4 := P4;
                    SUCOmipProposalMulticups.P5 := P5;
                    SUCOmipProposalMulticups.P6 := P6;
                    SUCOmipProposalMulticups.Modify();
                end;
        end;
    end;

    local procedure CalculateTotal()
    begin
        Total := P1 + P2 + P3 + P4 + P5 + P6;
    end;

    procedure CalculateCommision()
    var
        SUCOmipFEEPowerDocument: Record "SUC Omip FEE Power Document";
        TotalCommision: Decimal;
    begin
        SUCOmipFEEPowerDocument.Reset();
        SUCOmipFEEPowerDocument.SetRange("Document Type", "Document Type");
        SUCOmipFEEPowerDocument.SetRange("Document No.", "Document No.");
        SUCOmipFEEPowerDocument.SetRange("Rate No.", "Rate No.");
        if SUCOmipFEEPowerDocument.FindFirst() then begin
            Validate("Commission P1", SUCOmipFEEPowerDocument.P1 * P1);
            Validate("Commission P2", SUCOmipFEEPowerDocument.P2 * P2);
            Validate("Commission P3", SUCOmipFEEPowerDocument.P3 * P3);
            Validate("Commission P4", SUCOmipFEEPowerDocument.P4 * P4);
            Validate("Commission P5", SUCOmipFEEPowerDocument.P5 * P5);
            Validate("Commission P6", SUCOmipFEEPowerDocument.P6 * P6);
            TotalCommision := "Commission P1" + "Commission P2" + "Commission P3" + "Commission P4" + "Commission P5" + "Commission P6";
            Validate("Total Commission", TotalCommision);
        end;

        SetCommisionsEntry();
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
                    SUCCommissionsEntry.Validate("Power Commission Amount", "Total Commission" + GetTotalOthersCommisions());
                    SUCCommissionsEntry.Modify();
                end;
            end;
    end;

    local procedure GetTotalOthersCommisions(): Decimal
    var
        SUCOmipContractedPower: Record "SUC Omip Contracted Power";
        CommissionTotal: Decimal;
    begin
        Clear(CommissionTotal);
        SUCOmipContractedPower.Reset();
        SUCOmipContractedPower.SetRange("Document Type", "Document Type");
        SUCOmipContractedPower.SetRange("Document No.", "Document No.");
        SUCOmipContractedPower.SetFilter("Rate No.", '<>%1', "Rate No.");
        if SUCOmipContractedPower.FindSet() then
            repeat
                CommissionTotal += SUCOmipContractedPower.Total;
            until SUCOmipContractedPower.Next() = 0;
        exit(CommissionTotal);
    end;

    var
        ExprLbl: Label '1,EUR';
}