namespace Sucasuc.Omip.Contracts;
page 50268 "SUC Contract App. Cond. Body"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Contract App. Cond. Body";
    CardPageId = "SUC Contract App. Cond. Body C";
    Caption = 'Contract Applicable Conditions Body';
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    Editable = false;
                }
                field(BodyApplicableConditions; BodyApplicableConditions)
                {
                    ApplicationArea = All;
                    Caption = 'Body Applicable Conditions';
                    ToolTip = 'Specifies the value of the Body Applicable Conditions field.';
                    Editable = false;
                    trigger OnValidate()
                    begin
                        Rec.SetDataBlob(Rec.FieldNo("Body Applicable Conditions"), BodyApplicableConditions);
                    end;
                }
                field("Body Complement 1"; Rec."Body Complement 1")
                {
                    ToolTip = 'Specifies the value of the Body Complement 1 field.';
                    Editable = false;
                    Visible = false;
                }
                field("Body Complement 2"; Rec."Body Complement 2")
                {
                    ToolTip = 'Specifies the value of the Body Complement 2 field.';
                    Editable = false;
                    Visible = false;
                }
                field("Body Complement 3"; Rec."Body Complement 3")
                {
                    ToolTip = 'Specifies the value of the Body Complement 3 field.';
                    Editable = false;
                    Visible = false;
                }
                field("Body Complement 4"; Rec."Body Complement 4")
                {
                    ToolTip = 'Specifies the value of the Body Complement 4 field.';
                    Editable = false;
                    Visible = false;
                }
                field("Body Complement 5"; Rec."Body Complement 5")
                {
                    ToolTip = 'Specifies the value of the Body Complement 5 field.';
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Excel Files")
            {
                ApplicationArea = All;
                Caption = 'Import Excel Files';
                Image = ImportExcel;
                ToolTip = 'Import contract applicable conditions from Excel file';

                trigger OnAction()
                begin
                    Rec.ImportConditionsFromExcel();
                end;
            }
            action("Show Associated Modalities")
            {
                ApplicationArea = All;
                Caption = 'Show Associated Modalities';
                Image = ShowList;
                ToolTip = 'Show contract modalities that use this applicable condition';

                trigger OnAction()
                begin
                    ShowAssociatedModalities();
                end;
            }
            action("View Import Log")
            {
                ApplicationArea = All;
                Caption = 'View Import Log';
                Image = Log;
                ToolTip = 'View the import log for condition assignments';

                trigger OnAction()
                var
                    ConditionImportLog: Record "SUC Condition Import Log";
                    ImportLogPage: Page "SUC Condition Import Log";
                begin
                    ConditionImportLog.Reset();
                    ImportLogPage.SetTableView(ConditionImportLog);
                    ImportLogPage.Run();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        BodyApplicableConditions := Rec.GetDataValueBlob(Rec.FieldNo("Body Applicable Conditions"));
    end;

    local procedure ShowAssociatedModalities()
    var
        ContractModalities: Record "SUC Contract Modalities";
        ModalitiesPage: Page "SUC Contract Modalities";
        NoAssociatedModalitiesMsg: Label 'No modalities are associated with this applicable condition.';
    begin
        ContractModalities.Reset();
        ContractModalities.SetRange("No. Contract App. Cond. Body", Format(Rec."Entry No."));

        if ContractModalities.IsEmpty() then begin
            Message(NoAssociatedModalitiesMsg);
            exit;
        end;

        ModalitiesPage.SetTableView(ContractModalities);
        ModalitiesPage.Run();
    end;

    var
        BodyApplicableConditions: Text;
}