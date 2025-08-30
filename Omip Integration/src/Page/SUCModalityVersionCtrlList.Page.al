namespace Sucasuc.Omip.Contracts;
using Sucasuc.Energy.Ledger;

page 50278 "SUC Modality Version Ctrl List"
{
    ApplicationArea = All;
    Caption = 'Modality Version Control';
    PageType = List;
    SourceTable = "SUC Modality Version Control";
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
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
                    ToolTip = 'Specifies the rate number for tariff-based version control.';
                }
                field("Base Modality Name"; Rec."Base Modality Name")
                {
                    ToolTip = 'Specifies the base modality name without version.';
                }
                field("Version Code"; Rec."Version Code")
                {
                    ToolTip = 'Specifies the version code.';
                }
                field("Full Modality Name"; Rec."Full Modality Name")
                {
                    ToolTip = 'Specifies the complete modality name with version.';
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
                    ToolTip = 'Specifies whether this version is active.';
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
                    ToolTip = 'Activates selected versions and optionally deactivates others for the same base modality.';
                    ApplicationArea = All;
                    Image = Approve;

                    trigger OnAction()
                    var
                        ModalityVersionControl: Record "SUC Modality Version Control";
                        ConfirmDeactivateOthersQst: Label 'Do you want to deactivate all other versions of the same base modality for the selected records?';
                        ConfirmActivateMultipleQst: Label 'Do you want to activate %1 selected versions and deactivate other versions of the same base modalities?';
                        NoRecordsSelectedMsg: Label 'No records selected.';
                        VersionsActivatedMsg: Label '%1 version(s) activated successfully.';
                        AllVersionsActiveMsg: Label 'All selected versions were already active.';
                        DeactivateOthers: Boolean;
                        SelectedCount: Integer;
                        ActivatedCount: Integer;
                    begin
                        CurrPage.SetSelectionFilter(ModalityVersionControl);
                        SelectedCount := ModalityVersionControl.Count();

                        if SelectedCount = 0 then begin
                            Message(NoRecordsSelectedMsg);
                            exit;
                        end;

                        if SelectedCount = 1 then
                            DeactivateOthers := Confirm(ConfirmDeactivateOthersQst, true)
                        else
                            DeactivateOthers := Confirm(ConfirmActivateMultipleQst, true, SelectedCount);

                        if ModalityVersionControl.FindSet() then
                            repeat
                                if not ModalityVersionControl."Is Active" then begin
                                    ModalityVersionControl.ActivateVersion(DeactivateOthers);
                                    ActivatedCount += 1;
                                end;
                            until ModalityVersionControl.Next() = 0;

                        CurrPage.Update(false);
                        if ActivatedCount > 0 then
                            Message(VersionsActivatedMsg, ActivatedCount)
                        else
                            Message(AllVersionsActiveMsg);
                    end;
                }

                action("Deactivate Version")
                {
                    Caption = 'Deactivate Version';
                    ToolTip = 'Deactivates selected versions and updates related control prices records.';
                    ApplicationArea = All;
                    Image = Cancel;

                    trigger OnAction()
                    var
                        ModalityVersionControl: Record "SUC Modality Version Control";
                        ConfirmDeactivateQst: Label 'Are you sure you want to deactivate the selected version(s)?';
                        NoRecordsSelectedMsg: Label 'No records selected.';
                        VersionsDeactivatedMsg: Label '%1 version(s) deactivated successfully.';
                        AllVersionsInactiveMsg: Label 'All selected versions were already inactive.';
                        SelectedCount: Integer;
                        DeactivatedCount: Integer;
                    begin
                        CurrPage.SetSelectionFilter(ModalityVersionControl);
                        SelectedCount := ModalityVersionControl.Count();

                        if SelectedCount = 0 then begin
                            Message(NoRecordsSelectedMsg);
                            exit;
                        end;

                        if not Confirm(ConfirmDeactivateQst, false) then
                            exit;

                        if ModalityVersionControl.FindSet() then
                            repeat
                                if ModalityVersionControl."Is Active" then begin
                                    ModalityVersionControl.DeactivateVersion();
                                    DeactivatedCount += 1;
                                end;
                            until ModalityVersionControl.Next() = 0;

                        CurrPage.Update(false);
                        if DeactivatedCount > 0 then
                            Message(VersionsDeactivatedMsg, DeactivatedCount)
                        else
                            Message(AllVersionsInactiveMsg);
                    end;
                }

                action("Toggle Active Status")
                {
                    Caption = 'Toggle Active Status';
                    ToolTip = 'Toggles the active status of the selected versions.';
                    ApplicationArea = All;
                    Image = ChangeStatus;

                    trigger OnAction()
                    var
                        ModalityVersionControl: Record "SUC Modality Version Control";
                        NoRecordsSelectedMsg: Label 'No records selected.';
                        VersionStatusChangedMsg: Label '%1 version status(es) changed successfully.';
                        SelectedCount: Integer;
                        ToggledCount: Integer;
                    begin
                        CurrPage.SetSelectionFilter(ModalityVersionControl);
                        SelectedCount := ModalityVersionControl.Count();

                        if SelectedCount = 0 then begin
                            Message(NoRecordsSelectedMsg);
                            exit;
                        end;

                        if ModalityVersionControl.FindSet() then
                            repeat
                                if ModalityVersionControl."Is Active" then
                                    ModalityVersionControl.DeactivateVersion()
                                else
                                    ModalityVersionControl.ActivateVersion(false);
                                ToggledCount += 1;
                            until ModalityVersionControl.Next() = 0;

                        CurrPage.Update(false);
                        Message(VersionStatusChangedMsg, ToggledCount);
                    end;
                }
            }

            group("Related Records")
            {
                Caption = 'Related Records';

                action("Show Related Price Records")
                {
                    Caption = 'Show Related Price Records';
                    ToolTip = 'Shows control prices records related to this version.';
                    ApplicationArea = All;
                    Image = ItemLedger;

                    trigger OnAction()
                    var
                        ControlPricesEnergy: Record "SUC Control Prices Energy";
                        ControlPricesEnergyPage: Page "SUC Control Prices Energy";
                    begin
                        ControlPricesEnergy.Reset();
                        ControlPricesEnergy.SetRange("Marketer No.", Rec."Marketer No.");
                        ControlPricesEnergy.SetRange("Energy Type", Rec."Energy Type");
                        ControlPricesEnergy.SetRange("Rate No.", Rec."Rate No.");
                        ControlPricesEnergy.SetRange(Modality, Rec."Base Modality Name");
                        ControlPricesEnergy.SetRange(Version, Rec."Version Code");

                        ControlPricesEnergyPage.SetTableView(ControlPricesEnergy);
                        ControlPricesEnergyPage.Run();
                    end;
                }

                action("Show All Versions for Base Modality")
                {
                    Caption = 'Show All Versions for Base Modality';
                    ToolTip = 'Shows all versions for the same base modality.';
                    ApplicationArea = All;
                    Image = ShowList;

                    trigger OnAction()
                    var
                        ModalityVersionControl: Record "SUC Modality Version Control";
                        ModalityVersionControlPage: Page "SUC Modality Version Ctrl List";
                    begin
                        ModalityVersionControl.Reset();
                        ModalityVersionControl.SetRange("Marketer No.", Rec."Marketer No.");
                        ModalityVersionControl.SetRange("Energy Type", Rec."Energy Type");
                        ModalityVersionControl.SetRange("Rate No.", Rec."Rate No.");
                        ModalityVersionControl.SetRange("Base Modality Name", Rec."Base Modality Name");

                        ModalityVersionControlPage.SetTableView(ModalityVersionControl);
                        ModalityVersionControlPage.Run();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetActiveStyleExpr();
    end;

    local procedure SetActiveStyleExpr()
    begin
        if Rec."Is Active" then
            ActiveStyleExpr := 'Favorable'
        else
            ActiveStyleExpr := 'Unfavorable';
    end;

    var
        ActiveStyleExpr: Text;
}
