namespace Sucasuc.Omip.User;
using Sucasuc.Omip.Masters;

/// <summary>
/// Page SUC Omip Ext User Com. Figures List
/// </summary>
page 50286 "SUC Omip Ext User Com Fig List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Omip Ext User Com. Figures";
    Caption = 'External User Commercial Figures';
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(UserComFigures)
            {
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ToolTip = 'Specifies the external user name.';
                }
                field("Commercial Figures Type"; Rec."Commercial Figures Type")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ToolTip = 'Specifies the commercial figures type.';
                }
                field("Commercial Figure"; Rec."Commercial Figure")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ToolTip = 'Specifies the commercial figure.';
                }
                field("Superior Officer"; Rec."Superior Officer")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the superior officer for this user and commercial figure type.';
                }
                field("Hierarchical Level"; Rec."Hierarchical Level")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the hierarchical level of the commercial figure.';
                }
                field("Percent Commission"; Rec."Percent Commission")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the commission percentage of the commercial figure.';
                }
                field("Percent. Commission Drag"; Rec."Percent. Commission Drag")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the calculated commission drag percentage.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Calculate Commission Drag")
            {
                ApplicationArea = All;
                Caption = 'Calculate Commission Drag %';
                Image = Calculate;
                ToolTip = 'Calculate the commission drag percentage for selected commercial figures.';
                trigger OnAction()
                var
                    SUCOmipExtUserComFigures: Record "SUC Omip Ext User Com. Figures";
                    NoRows: Integer;
                    ProcessedRecords: Integer;
                    ConfirmLbl: Label 'This will calculate the commission drag percentage for all selected commercial figures. Do you want to continue?';
                    CompletedLbl: Label 'Commission drag percentage calculated for %1 record(s).';
                begin
                    if not Confirm(ConfirmLbl) then
                        exit;

                    CurrPage.SetSelectionFilter(SUCOmipExtUserComFigures);
                    NoRows := SUCOmipExtUserComFigures.Count;

                    if NoRows = 0 then
                        exit;

                    Clear(ProcessedRecords);

                    if NoRows = 1 then begin
                        Rec.CalculateCommissionDragPercentage();
                        Rec.Modify();
                        ProcessedRecords := 1;
                    end else
                        if SUCOmipExtUserComFigures.FindSet() then
                            repeat
                                SUCOmipExtUserComFigures.CalculateCommissionDragPercentage();
                                SUCOmipExtUserComFigures.Modify();
                                ProcessedRecords += 1;
                            until SUCOmipExtUserComFigures.Next() = 0;

                    Message(CompletedLbl, ProcessedRecords);
                    CurrPage.Update(false);
                end;
            }
            action("Validate Commercial Figures")
            {
                ApplicationArea = All;
                Caption = 'Validate Commercial Figures';
                Image = Check;
                ToolTip = 'Validate the commercial figures and hierarchy relationships.';
                trigger OnAction()
                var
                    SUCOmipExtUserComFigures: Record "SUC Omip Ext User Com. Figures";
                    NoRows: Integer;
                    ProcessedRecords: Integer;
                    ErrorsFound: Integer;
                    ConfirmLbl: Label 'This will validate all selected commercial figure records. Do you want to continue?';
                    CompletedLbl: Label 'Validation completed. %1 record(s) processed, %2 error(s) found.';
                begin
                    if not Confirm(ConfirmLbl) then
                        exit;

                    CurrPage.SetSelectionFilter(SUCOmipExtUserComFigures);
                    NoRows := SUCOmipExtUserComFigures.Count;

                    if NoRows = 0 then
                        exit;

                    Clear(ProcessedRecords);
                    Clear(ErrorsFound);

                    if NoRows = 1 then begin
                        if ValidateCommercialFigureRecord(Rec) then
                            ErrorsFound += 1;
                        ProcessedRecords := 1;
                    end else
                        if SUCOmipExtUserComFigures.FindSet() then
                            repeat
                                if ValidateCommercialFigureRecord(SUCOmipExtUserComFigures) then
                                    ErrorsFound += 1;
                                ProcessedRecords += 1;
                            until SUCOmipExtUserComFigures.Next() = 0;

                    Message(CompletedLbl, ProcessedRecords, ErrorsFound);
                end;
            }
        }
        area(Navigation)
        {
            action("External User Card")
            {
                ApplicationArea = All;
                Caption = 'External User Card';
                Image = User;
                RunObject = Page "SUC Omip External Users Card";
                RunPageLink = "User Name" = field("User Name");
                ToolTip = 'Open the external user card for this record.';
            }
        }
    }

    /// <summary>
    /// Validate a commercial figure record
    /// </summary>
    local procedure ValidateCommercialFigureRecord(var CommercialFigureRec: Record "SUC Omip Ext User Com. Figures"): Boolean
    var
        SUCCommercialFigures: Record "SUC Commercial Figures";
        SUCOmipExternalUsers: Record "SUC Omip External Users";
        ValidationErrorLbl: Label 'Record %1/%2: %3';
        ErrorFound: Boolean;
    begin
        Clear(ErrorFound);

        // Validate user exists
        if not SUCOmipExternalUsers.Get(CommercialFigureRec."User Name") then begin
            Message(ValidationErrorLbl, CommercialFigureRec."User Name", CommercialFigureRec."Commercial Figures Type", 'User does not exist');
            ErrorFound := true;
        end;

        // Validate commercial figure exists
        if not SUCCommercialFigures.Get(CommercialFigureRec."Commercial Figures Type", CommercialFigureRec."Commercial Figure") then begin
            Message(ValidationErrorLbl, CommercialFigureRec."User Name", CommercialFigureRec."Commercial Figures Type", 'Commercial figure does not exist');
            ErrorFound := true;
        end;

        // Validate superior officer exists if specified
        if CommercialFigureRec."Superior Officer" <> '' then
            if not SUCOmipExternalUsers.Get(CommercialFigureRec."Superior Officer") then begin
                Message(ValidationErrorLbl, CommercialFigureRec."User Name", CommercialFigureRec."Commercial Figures Type", 'Superior officer does not exist');
                ErrorFound := true;
            end;

        exit(ErrorFound);
    end;
}
