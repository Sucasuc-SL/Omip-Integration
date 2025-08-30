namespace Sucasuc.Omip.Contracts;

page 50279 "SUC Condition Import Log"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SUC Condition Import Log";
    Caption = 'Condition Import Log';
    Editable = false;
    SourceTableView = sorting("Entry No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                }
                field("Import Date"; Rec."Import Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the import date and time.';
                }
                field("Row No."; Rec."Row No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the row number in the Excel file.';
                }
                field("Modality Name"; Rec."Modality Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the modality name.';
                }
                field("Condition Code"; Rec."Condition Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the condition code assigned.';
                }
                field("Condition Text Preview"; Rec."Condition Text Preview")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a preview of the condition text.';
                }
                field("Source"; Rec."Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source of the condition.';
                }
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the import status.';
                    StyleExpr = StatusStyle;
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the error message if any.';
                    StyleExpr = ErrorStyle;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Clear Log")
            {
                ApplicationArea = All;
                Caption = 'Clear Log';
                Image = ClearLog;
                ToolTip = 'Clear all log entries.';

                trigger OnAction()
                begin
                    if Confirm('Do you want to clear all log entries?') then begin
                        Rec.DeleteAll();
                        CurrPage.Update();
                    end;
                end;
            }
            action("View Condition")
            {
                ApplicationArea = All;
                Caption = 'View Condition';
                Image = View;
                ToolTip = 'View the condition details.';
                Enabled = Rec."Condition Code" <> '';

                trigger OnAction()
                var
                    ContractAppCondBody: Record "SUC Contract App. Cond. Body";
                    ContractAppCondBodyPage: Page "SUC Contract App. Cond. Body";
                begin
                    if ContractAppCondBody.Get(Rec."Condition Code") then begin
                        ContractAppCondBodyPage.SetRecord(ContractAppCondBody);
                        ContractAppCondBodyPage.Run();
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyles();
    end;

    local procedure SetStyles()
    begin
        case Rec."Status" of
            Rec."Status"::Success:
                begin
                    StatusStyle := 'Favorable';
                    ErrorStyle := '';
                end;
            Rec."Status"::Error:
                begin
                    StatusStyle := 'Unfavorable';
                    ErrorStyle := 'Unfavorable';
                end;
            Rec."Status"::Warning:
                begin
                    StatusStyle := 'Ambiguous';
                    ErrorStyle := 'Ambiguous';
                end;
            else begin
                StatusStyle := '';
                ErrorStyle := '';
            end;
        end;
    end;

    var
        StatusStyle: Text;
        ErrorStyle: Text;
}
