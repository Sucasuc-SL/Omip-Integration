namespace Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.User;
using Sucasuc.Omip.Contracts;
table 50216 "SUC Commissions Entry"
{
    Caption = 'Commissions Entry';
    DataClassification = CustomerContent;
    DrillDownPageId = "SUC Commissions Entry";
    LookupPageId = "SUC Commissions Entry";

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
        field(3; "Agent No."; Code[100])
        {
            Caption = 'Agent No.';
            TableRelation = "SUC Omip External Users"."User Name";
        }
        field(4; "Commercial Figures Type"; Code[20])
        {
            Caption = 'Commercial Figures Type';
            TableRelation = "SUC Commercial Figures Type"."Id.";
            trigger OnValidate()
            begin
                Validate("Commercial Figure", '');
            end;
        }
        field(5; "Commercial Figure"; Code[20])
        {
            Caption = 'Commercial Figure';
            TableRelation = "SUC Commercial Figures"."Id." where(Type = field("Commercial Figures Type"));
        }
        field(6; "Percent Commision Own Sale"; Decimal)
        {
            Caption = '% Commision Own Sale';
        }
        field(7; "Superior Officer"; Code[100])
        {
            Caption = 'Superior Officer';
            TableRelation = "SUC Omip External Users"."User Name";
        }
        field(8; "Percent Hierarchy Distribution"; Decimal)
        {
            Caption = '% Hierarchy Distribution';
        }
        field(9; "Power Commission Amount"; Decimal)
        {
            Caption = 'Power Commission Amount';
            DecimalPlaces = 2;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
            trigger OnValidate()
            begin
                Validate("Total Commission Amount", "Power Commission Amount" + "Energy Commission Amount");
            end;
        }
        field(10; "Energy Commission Amount"; Decimal)
        {
            Caption = 'Energy Commission Amount';
            DecimalPlaces = 2;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
            trigger OnValidate()
            begin
                Validate("Total Commission Amount", "Power Commission Amount" + "Energy Commission Amount");
            end;
        }
        field(11; "Total Commission Amount"; Decimal)
        {
            Caption = 'Total Commission Amount';
            DecimalPlaces = 2;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
            trigger OnValidate()
            begin
                if "First Agent Calculation" then
                    Validate("Percent Commision Drag", "Percent Commision Own Sale");
            end;
        }
        field(12; "Percent Commision Drag"; Decimal)
        {
            Caption = '% Commision Drag';
            trigger OnValidate()
            begin
                Validate("Commission Drag Amount", "Total Commission Amount" * ("Percent Commision Drag" / 100));
            end;
        }
        field(13; "Commission Drag Amount"; Decimal)
        {
            Caption = 'Commission Drag Amount';
            DecimalPlaces = 2;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
            trigger OnValidate()
            begin
                CalculateSuperiorOfficerCommission();
            end;
        }
        field(14; "First Agent Calculation"; Boolean)
        {
            Caption = 'First Agent Calculation';
        }
        field(15; "Hierarchical Level"; Integer)
        {
            Caption = 'Hierarchical Level';
        }
        field(16; "Commision Own Sale"; Decimal)
        {
            Caption = 'Commision Own Sale';
            DecimalPlaces = 2;
            AutoFormatType = 10;
            AutoFormatExpression = ExprLbl;
        }
        field(17; "Superseded by Contract"; Boolean)
        {
            Caption = 'Superseded by Contract';
            DataClassification = CustomerContent;
        }
        field(18; "Source Proposal No."; Code[20])
        {
            Caption = 'Source Proposal No.';
            DataClassification = CustomerContent;
            TableRelation = "SUC Omip Proposals"."No.";
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Agent No.")
        {
            Clustered = true;
        }
        key(Key2; "Hierarchical Level") { }
    }
    procedure CalculateSuperiorOfficerCommission()
    var
        SUCCommissionsEntry: Record "SUC Commissions Entry";
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        SUCOmipExternalUsersSuperior: Record "SUC Omip External Users";
        SUCCommercialFigures: Record "SUC Commercial Figures";
        SUCCommercialFiguresSuperior: Record "SUC Commercial Figures";
        SUCOmipUserComFigures: Record "SUC Omip Ext User Com. Figures";
        SUCOmipUserComFiguresSuperior: Record "SUC Omip Ext User Com. Figures";
        SupperiorOfficer: Code[100];
        PercentDistributionApplied: Decimal;
    begin
        if "First Agent Calculation" then begin
            "Commision Own Sale" := "Total Commission Amount" * ("Percent Commision Own Sale" / 100);
            ClearOtherCommisions();
            if "Superior Officer" <> '' then begin
                SupperiorOfficer := "Superior Officer";
                PercentDistributionApplied := "Percent Hierarchy Distribution" - "Percent Commision Own Sale";
                while SupperiorOfficer <> '' do begin
                    SUCOmipExternalUsers.Get(SupperiorOfficer); //* Superior officer
                    SUCOmipExternalUsers.TestField("Active Commisions", true);

                    // Get superior's commercial figure data from new table
                    SUCOmipUserComFigures.Reset();
                    SUCOmipUserComFigures.SetRange("User Name", SupperiorOfficer);
                    SUCOmipUserComFigures.SetRange("Commercial Figures Type", "Commercial Figures Type");
                    if SUCOmipUserComFigures.FindFirst() then begin
                        SUCOmipUserComFigures.TestField("Commercial Figures Type");
                        SUCOmipUserComFigures.TestField("Commercial Figure");

                        SUCCommercialFigures.Get(SUCOmipUserComFigures."Commercial Figures Type", SUCOmipUserComFigures."Commercial Figure");
                        SUCCommercialFigures.TestField("Distribution");

                        SUCCommissionsEntry.Init();
                        SUCCommissionsEntry.Validate("Document Type", "Document Type");
                        SUCCommissionsEntry.Validate("Document No.", "Document No.");
                        SUCCommissionsEntry.Validate("Agent No.", SupperiorOfficer);
                        SUCCommissionsEntry.Validate("Commercial Figures Type", SUCOmipUserComFigures."Commercial Figures Type");
                        SUCCommissionsEntry.Validate("Commercial Figure", SUCOmipUserComFigures."Commercial Figure");
                        SUCCommissionsEntry.Validate("Percent Commision Own Sale", SUCCommercialFigures.Distribution);
                        SUCCommissionsEntry.Validate("Hierarchical Level", SUCCommercialFigures."Hierarchical Level");

                        if SUCOmipUserComFigures."Superior Officer" <> '' then begin
                            SUCOmipExternalUsersSuperior.Get(SUCOmipUserComFigures."Superior Officer");
                            SUCOmipExternalUsersSuperior.TestField("Active Commisions", true);

                            // Get superior's superior commercial figure data from new table
                            SUCOmipUserComFiguresSuperior.Reset();
                            SUCOmipUserComFiguresSuperior.SetRange("User Name", SUCOmipUserComFigures."Superior Officer");
                            SUCOmipUserComFiguresSuperior.SetRange("Commercial Figures Type", SUCOmipUserComFigures."Commercial Figures Type");
                            if SUCOmipUserComFiguresSuperior.FindFirst() then begin
                                SUCOmipUserComFiguresSuperior.TestField("Commercial Figures Type");
                                SUCOmipUserComFiguresSuperior.TestField("Commercial Figure");

                                SUCCommercialFiguresSuperior.Get(SUCOmipUserComFiguresSuperior."Commercial Figures Type", SUCOmipUserComFiguresSuperior."Commercial Figure");
                                SUCCommercialFiguresSuperior.TestField("Distribution");

                                SUCCommissionsEntry.Validate("Superior Officer", SUCOmipUserComFigures."Superior Officer");
                                SUCCommissionsEntry.Validate("Percent Hierarchy Distribution", SUCCommercialFiguresSuperior.Distribution);
                            end;
                        end;
                        SUCCommissionsEntry.Validate("Power Commission Amount", "Power Commission Amount");
                        SUCCommissionsEntry.Validate("Energy Commission Amount", "Energy Commission Amount");
                        SUCCommissionsEntry.Validate("Total Commission Amount", "Total Commission Amount");

                        // Check if Distribution by Figure is enabled
                        if SUCCommercialFigures."Distribution by Figure" then
                            // Find all users with the same commercial figure
                            CreateCommissionsForSameFigure(SUCCommissionsEntry, SUCCommercialFigures, PercentDistributionApplied)
                        else begin
                            SUCCommissionsEntry."Percent Commision Drag" := PercentDistributionApplied;
                            SUCCommissionsEntry."Commission Drag Amount" := "Total Commission Amount" * (PercentDistributionApplied / 100);
                            SUCCommissionsEntry."Commision Own Sale" := "Total Commission Amount" * (SUCCommercialFigures.Distribution / 100);
                            SUCCommissionsEntry.Insert();
                        end;

                        SupperiorOfficer := SUCOmipUserComFigures."Superior Officer";
                        if SUCOmipUserComFiguresSuperior."Commercial Figures Type" <> '' then
                            PercentDistributionApplied := SUCCommercialFiguresSuperior.Distribution - SUCCommercialFigures.Distribution
                        else
                            SupperiorOfficer := '';
                    end else
                        SupperiorOfficer := '';
                end;
            end;
        end;
    end;

    local procedure CreateCommissionsForSameFigure(var BaseCommissionEntry: Record "SUC Commissions Entry"; CommercialFigures: Record "SUC Commercial Figures"; PercentToDistribute: Decimal)
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        SUCOmipUserComFigures: Record "SUC Omip Ext User Com. Figures";
        SUCCommissionsEntry: Record "SUC Commissions Entry";
        UsersWithSameFigure: List of [Code[100]];
        UserCode: Code[100];
        DistributionPerUser: Decimal;
        UserCount: Integer;
    begin
        // Find all users with the same commercial figure in the new table
        SUCOmipUserComFigures.Reset();
        SUCOmipUserComFigures.SetRange("Commercial Figures Type", CommercialFigures.Type);
        SUCOmipUserComFigures.SetRange("Commercial Figure", CommercialFigures."Id.");
        if SUCOmipUserComFigures.FindSet() then
            repeat
                // Verify that the user has active commissions
                if SUCOmipExternalUsers.Get(SUCOmipUserComFigures."User Name") then
                    if SUCOmipExternalUsers."Active Commisions" then
                        UsersWithSameFigure.Add(SUCOmipUserComFigures."User Name");
            until SUCOmipUserComFigures.Next() = 0;

        UserCount := UsersWithSameFigure.Count();
        if UserCount > 0 then begin
            DistributionPerUser := PercentToDistribute / UserCount;

            foreach UserCode in UsersWithSameFigure do begin
                SUCCommissionsEntry.Init();
                SUCCommissionsEntry.TransferFields(BaseCommissionEntry);
                SUCCommissionsEntry.Validate("Agent No.", UserCode);
                SUCCommissionsEntry."Percent Commision Drag" := DistributionPerUser;
                SUCCommissionsEntry."Commission Drag Amount" := BaseCommissionEntry."Total Commission Amount" * (DistributionPerUser / 100);
                SUCCommissionsEntry."Commision Own Sale" := BaseCommissionEntry."Total Commission Amount" * (CommercialFigures.Distribution / 100);
                SUCCommissionsEntry.Insert();
            end;
        end;
    end;

    local procedure ClearOtherCommisions()
    var
        SUCCommissionsEntry: Record "SUC Commissions Entry";
    begin
        SUCCommissionsEntry.Reset();
        SUCCommissionsEntry.SetRange("Document Type", "Document Type");
        SUCCommissionsEntry.SetRange("Document No.", "Document No.");
        SUCCommissionsEntry.SetFilter("Agent No.", '<>%1', "Agent No.");
        if SUCCommissionsEntry.FindSet() then
            repeat
                SUCCommissionsEntry.Delete();
            until SUCCommissionsEntry.Next() = 0;
    end;

    var
        ExprLbl: Label '1,EUR';
}