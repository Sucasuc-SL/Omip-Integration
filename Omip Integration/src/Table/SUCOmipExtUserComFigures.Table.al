namespace Sucasuc.Omip.User;
using Sucasuc.Omip.Masters;

/// <summary>
/// Table "SUC Omip Comercial Figures"
/// </summary>
table 50222 "SUC Omip Ext User Com. Figures"
{
    DataClassification = CustomerContent;
    Caption = 'User Commercial Figures';
    LookupPageId = "SUC Omip Ext User Com Fig List";
    DrillDownPageId = "SUC Omip Ext User Com Fig List";

    fields
    {
        field(1; "User Name"; Code[100])
        {
            Caption = 'User Name';
            TableRelation = "SUC Omip External Users"."User Name";
            NotBlank = true;
        }
        field(2; "Commercial Figures Type"; Code[20])
        {
            Caption = 'Commercial Figures Type';
            TableRelation = "SUC Commercial Figures Type"."Id.";
            NotBlank = true;
            trigger OnValidate()
            begin
                Validate("Commercial Figure", '');
                CalcFields("Hierarchical Level", "Percent Commission");
            end;
        }
        field(3; "Commercial Figure"; Code[20])
        {
            Caption = 'Commercial Figure';
            TableRelation = "SUC Commercial Figures"."Id." where(Type = field("Commercial Figures Type"));
            NotBlank = true;
            trigger OnValidate()
            begin
                CalcFields("Hierarchical Level", "Percent Commission");
                CalculateCommissionDragPercentage();
            end;
        }
        field(4; "Superior Officer"; Code[100])
        {
            Caption = 'Superior Officer';
            TableRelation = "SUC Omip External Users"."User Name";
            trigger OnValidate()
            var
                SUCOmipExternalUsers: Record "SUC Omip External Users";
                SUCOmipUserSupervisionTypes: Record "SUC Omip Ext User Com. Figures";
                SuperiorCommercialFigures: Record "SUC Commercial Figures";
                ErrorHierarchicalLbl: Label 'The superior officer must have a higher hierarchical level.';
                ErrorCannotSuperviseLbl: Label 'The superior officer cannot supervise users of commercial figure type %1.';
            begin
                CalcFields("Hierarchical Level");

                if "Superior Officer" <> '' then begin
                    SUCOmipExternalUsers.Get("Superior Officer");

                    // Verificar en la tabla de tipos de supervisión que el superior puede supervisar este tipo
                    SUCOmipUserSupervisionTypes.Reset();
                    SUCOmipUserSupervisionTypes.SetRange("User Name", "Superior Officer");
                    SUCOmipUserSupervisionTypes.SetRange("Commercial Figures Type", "Commercial Figures Type");
                    if SUCOmipUserSupervisionTypes.IsEmpty() then
                        Error(ErrorCannotSuperviseLbl, "Commercial Figures Type");

                    // Usar la figura comercial de la tabla de supervisión para validaciones
                    SUCOmipUserSupervisionTypes.FindFirst();
                    SuperiorCommercialFigures.Get(SUCOmipUserSupervisionTypes."Commercial Figures Type", SUCOmipUserSupervisionTypes."Commercial Figure");
                    SuperiorCommercialFigures.TestField(Distribution);
                    SuperiorCommercialFigures.TestField("Hierarchical Level");

                    // Validar nivel jerárquico
                    if SuperiorCommercialFigures."Hierarchical Level" >= "Hierarchical Level" then
                        Error(ErrorHierarchicalLbl);
                end;

                CalculateCommissionDragPercentage();
            end;
        }
        field(5; "Hierarchical Level"; Integer)
        {
            Caption = 'Hierarchical Level';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Commercial Figures"."Hierarchical Level" where(Type = field("Commercial Figures Type"), "Id." = field("Commercial Figure")));
            Editable = false;
        }
        field(6; "Percent Commission"; Decimal)
        {
            Caption = 'Percent Commission';
            FieldClass = FlowField;
            CalcFormula = lookup("SUC Commercial Figures".Distribution where(Type = field("Commercial Figures Type"), "Id." = field("Commercial Figure")));
            Editable = false;
        }
        field(7; "Percent. Commission Drag"; Decimal)
        {
            Caption = 'Percent. Commission Drag';
            DecimalPlaces = 0 : 6;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "User Name", "Commercial Figures Type")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        CalcFields("Hierarchical Level", "Percent Commission");
    end;

    trigger OnModify()
    begin
        CalcFields("Hierarchical Level", "Percent Commission");
    end;

    /// <summary>
    /// Calculate the commission drag percentage for this supervision type
    /// </summary>
    procedure CalculateCommissionDragPercentage()
    var
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        SUCOmipUserSupervisionTypes: Record "SUC Omip Ext User Com. Figures";
        CurrentCommercialFigures: Record "SUC Commercial Figures";
        UsersWithSameFigure: Record "SUC Omip Ext User Com. Figures";
        SuperiorPercentage: Decimal;
        CurrentPercentage: Decimal;
        UsersCount: Integer;
    begin
        // Reset the percentage
        "Percent. Commission Drag" := 0;

        if "Superior Officer" = '' then
            exit;

        if ("Commercial Figures Type" = '') or ("Commercial Figure" = '') then
            exit;

        // Get superior officer's commercial figure data from supervision types table
        if SUCOmipExternalUsers.Get("Superior Officer") then begin
            // Verificar en la tabla de tipos de supervisión que el superior puede supervisar este tipo
            SUCOmipUserSupervisionTypes.Reset();
            SUCOmipUserSupervisionTypes.SetRange("User Name", "Superior Officer");
            SUCOmipUserSupervisionTypes.SetRange("Commercial Figures Type", "Commercial Figures Type");
            if SUCOmipUserSupervisionTypes.FindFirst() then begin
                SUCOmipUserSupervisionTypes.CalcFields("Percent Commission");
                SuperiorPercentage := SUCOmipUserSupervisionTypes."Percent Commission";
            end;
        end;

        // Get current commercial figure distribution
        if CurrentCommercialFigures.Get("Commercial Figures Type", "Commercial Figure") then begin
            CurrentPercentage := CurrentCommercialFigures.Distribution;

            // Check if current commercial figure has "Distribution by Figure" enabled
            if CurrentCommercialFigures."Distribution by Figure" then begin
                // Count users with the same commercial figure in this supervision types table
                Clear(UsersCount);
                UsersWithSameFigure.Reset();
                UsersWithSameFigure.SetRange("Commercial Figures Type", "Commercial Figures Type");
                UsersWithSameFigure.SetRange("Commercial Figure", "Commercial Figure");
                UsersCount := UsersWithSameFigure.Count();

                if UsersCount > 0 then
                    CurrentPercentage := CurrentPercentage / UsersCount;

                "Percent. Commission Drag" := CurrentPercentage;

                // Update all other users with the same commercial figure
                UpdateAllUsersWithSameFigure("Commercial Figures Type", "Commercial Figure", CurrentPercentage);
            end else
                "Percent. Commission Drag" := SuperiorPercentage - CurrentPercentage;
        end;
    end;

    /// <summary>
    /// Update commission drag percentage for all users with the same commercial figure
    /// when Distribution by Figure is enabled
    /// </summary>
    local procedure UpdateAllUsersWithSameFigure(CommercialFiguresType: Code[20]; CommercialFigure: Code[20]; NewPercentage: Decimal)
    var
        SUCOmipExtUserComFigures: Record "SUC Omip Ext User Com. Figures";
    begin
        // Update in supervision types table
        SUCOmipExtUserComFigures.Reset();
        SUCOmipExtUserComFigures.SetRange("Commercial Figures Type", CommercialFiguresType);
        SUCOmipExtUserComFigures.SetRange("Commercial Figure", CommercialFigure);
        if SUCOmipExtUserComFigures.FindSet() then
            repeat
                if SUCOmipExtUserComFigures."User Name" <> "User Name" then begin // Don't update the current record
                    SUCOmipExtUserComFigures."Percent. Commission Drag" := NewPercentage;
                    SUCOmipExtUserComFigures.Modify();
                end;
            until SUCOmipExtUserComFigures.Next() = 0;
    end;
}
