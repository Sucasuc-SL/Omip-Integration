namespace Sucasuc.Omip.Contracts;
using Sucasuc.Energy.Ledger;

page 50276 "SUC Modality Version Control"
{
    ApplicationArea = All;
    Caption = 'Modality Version Control';
    PageType = ListPart;
    SourceTable = "SUC Modality Version Control";
    UsageCategory = None;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Marketer No."; Rec."Marketer No.")
                {
                    ToolTip = 'Specifies the marketer number.';
                }
                field("Energy Type"; Rec."Energy Type")
                {
                    ToolTip = 'Specifies the energy type.';
                }
                field("Rate No."; Rec."Rate No.")
                {
                    ToolTip = 'Specifies the rate number.';
                }
                field("Base Modality Name"; Rec."Base Modality Name")
                {
                    ToolTip = 'Specifies the base modality name without version information.';
                }
                field("Full Modality Name"; Rec."Full Modality Name")
                {
                    ToolTip = 'Specifies the complete modality name including version.';
                }
                field("Version Code"; Rec."Version Code")
                {
                    ToolTip = 'Specifies the version code (e.g., V1, V2, V3).';
                }
                field("Version Number"; Rec."Version Number")
                {
                    ToolTip = 'Specifies the numeric version number.';
                }
                field(Quarter; Rec.Quarter)
                {
                    ToolTip = 'Specifies the quarter code (e.g., 1T, 2T, 3T, 4T).';
                }
                field("Is Active"; Rec."Is Active")
                {
                    ToolTip = 'Specifies if this version is active and controls the status of related price records.';
                    StyleExpr = ActiveStyleExpr;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies when this version was created.';
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ToolTip = 'Specifies when this version was last modified.';
                }
                field("Modified By"; Rec."Modified By")
                {
                    ToolTip = 'Specifies who last modified this version.';
                }
                field("Imported File Name"; Rec."Imported File Name")
                {
                    ToolTip = 'Specifies the name of the imported Excel file.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Version Management")
            {
                Caption = 'Version Management';

                action("Activate Version")
                {
                    Caption = 'Activate Version';
                    ApplicationArea = All;
                    Image = Approve;
                    ToolTip = 'Activates selected versions and updates related price control records.';

                    trigger OnAction()
                    var
                        VersionControl: Record "SUC Modality Version Control";
                        NoRecordsSelectedMsg: Label 'No records selected.';
                        ConfirmActivateQst: Label 'Do you want to activate %1 selected version(s)? This will also activate all related price control records.';
                        VersionsActivatedMsg: Label '%1 version(s) have been activated. All related price control records have been activated.';
                        SelectedCount: Integer;
                    begin
                        CurrPage.SetSelectionFilter(VersionControl);
                        SelectedCount := VersionControl.Count();

                        if SelectedCount = 0 then begin
                            Message(NoRecordsSelectedMsg);
                            exit;
                        end;

                        if Confirm(ConfirmActivateQst, false, SelectedCount) then begin
                            if VersionControl.FindSet() then
                                repeat
                                    VersionControl.ActivateVersion(false);
                                until VersionControl.Next() = 0;
                            CurrPage.Update();
                            Message(VersionsActivatedMsg, SelectedCount);
                        end;
                    end;
                }

                action("Deactivate Version")
                {
                    Caption = 'Deactivate Version';
                    ApplicationArea = All;
                    Image = Cancel;
                    ToolTip = 'Deactivates selected versions and updates related price control records.';

                    trigger OnAction()
                    var
                        VersionControl: Record "SUC Modality Version Control";
                        NoRecordsSelectedMsg: Label 'No records selected.';
                        ConfirmDeactivateQst: Label 'Do you want to deactivate %1 selected version(s)? This will also deactivate all related price control records.';
                        VersionsDeactivatedMsg: Label '%1 version(s) have been deactivated. All related price control records have been deactivated.';
                        SelectedCount: Integer;
                    begin
                        CurrPage.SetSelectionFilter(VersionControl);
                        SelectedCount := VersionControl.Count();

                        if SelectedCount = 0 then begin
                            Message(NoRecordsSelectedMsg);
                            exit;
                        end;

                        if Confirm(ConfirmDeactivateQst, false, SelectedCount) then begin
                            if VersionControl.FindSet() then
                                repeat
                                    VersionControl.DeactivateVersion();
                                until VersionControl.Next() = 0;
                            CurrPage.Update();
                            Message(VersionsDeactivatedMsg, SelectedCount);
                        end;
                    end;
                }

                action("Activate Exclusive")
                {
                    Caption = 'Activate Exclusive';
                    ApplicationArea = All;
                    Image = SelectEntries;
                    ToolTip = 'Activates selected versions exclusively and deactivates all other versions of the same base modalities.';

                    trigger OnAction()
                    var
                        VersionControl: Record "SUC Modality Version Control";
                        NoRecordsSelectedMsg: Label 'No records selected.';
                        ConfirmActivateExclusiveQst: Label 'Do you want to activate %1 selected version(s) exclusively? This will deactivate all other versions of the same base modalities and update all related price control records.';
                        VersionsActivatedExclusiveMsg: Label '%1 version(s) have been activated exclusively. All other versions and their related price control records have been deactivated.';
                        SelectedCount: Integer;
                    begin
                        CurrPage.SetSelectionFilter(VersionControl);
                        SelectedCount := VersionControl.Count();

                        if SelectedCount = 0 then begin
                            Message(NoRecordsSelectedMsg);
                            exit;
                        end;

                        if Confirm(ConfirmActivateExclusiveQst, false, SelectedCount) then begin
                            if VersionControl.FindSet() then
                                repeat
                                    VersionControl.ActivateVersion(true);
                                until VersionControl.Next() = 0;
                            CurrPage.Update();
                            Message(VersionsActivatedExclusiveMsg, SelectedCount);
                        end;
                    end;
                }
            }

            group("Data Management")
            {
                Caption = 'Data Management';
                Image = Database;

                action("Show Related Price Records")
                {
                    Caption = 'Show Related Price Records';
                    ApplicationArea = All;
                    Image = Price;
                    ToolTip = 'Shows all price control records related to this specific version.';

                    trigger OnAction()
                    var
                        ControlPricesEnergy: Record "SUC Control Prices Energy";
                        ControlPricesPage: Page "SUC Control Prices Energy";
                    begin
                        ControlPricesEnergy.Reset();
                        ControlPricesEnergy.SetRange("Marketer No.", Rec."Marketer No.");
                        ControlPricesEnergy.SetRange("Energy Type", Rec."Energy Type");
                        ControlPricesEnergy.SetRange("Rate No.", Rec."Rate No.");
                        ControlPricesEnergy.SetRange(Modality, Rec."Base Modality Name");
                        ControlPricesEnergy.SetRange(Version, Rec."Version Code");
                        ControlPricesPage.SetTableView(ControlPricesEnergy);
                        ControlPricesPage.Run();
                    end;
                }

                action("Extract Version Info")
                {
                    Caption = 'Extract Version Info';
                    ApplicationArea = All;
                    Image = DataEntry;
                    ToolTip = 'Extracts version information from the full modality name.';

                    trigger OnAction()
                    var
                        ModalityVersionControl: Record "SUC Modality Version Control";
                        EnterModalityNameMsg: Label 'Please enter a full modality name first.';
                        ExtractSuccessMsg: Label 'Version information extracted successfully.\Base Name: %1\Version: %2\Number: %3\Quarter: %4';
                        ExtractionFailedMsg: Label 'No version information could be extracted from: %1';
                        BaseModalityName: Text[100];
                        VersionCode: Code[10];
                        VersionNumber: Integer;
                        QuarterCode: Code[10];
                    begin
                        if Rec."Full Modality Name" = '' then begin
                            Message(EnterModalityNameMsg);
                            exit;
                        end;

                        if ModalityVersionControl.ExtractVersionInfo(Rec."Full Modality Name", BaseModalityName, VersionCode, VersionNumber, QuarterCode) then begin
                            Rec."Base Modality Name" := BaseModalityName;
                            Rec."Version Code" := VersionCode;
                            Rec."Version Number" := VersionNumber;
                            Rec.Quarter := QuarterCode;
                            Rec.Modify();
                            CurrPage.Update();
                            Message(ExtractSuccessMsg, BaseModalityName, VersionCode, VersionNumber, QuarterCode);
                        end else
                            Message(ExtractionFailedMsg, Rec."Full Modality Name");
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyleExpressions();
    end;

    local procedure SetStyleExpressions()
    begin
        if Rec."Is Active" then
            ActiveStyleExpr := 'Favorable'
        else
            ActiveStyleExpr := 'Unfavorable';
    end;

    var
        ActiveStyleExpr: Text;
}
