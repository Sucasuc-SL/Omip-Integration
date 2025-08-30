namespace Sucasuc.Omip.Contracts;

page 50225 "SUC Contract Modalities"
{
    ApplicationArea = All;
    Caption = 'Contract Modalities';
    PageType = List;
    SourceTable = "SUC Contract Modalities";
    CardPageId = "SUC Contract Modalities Card";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Marketer No."; Rec."Marketer No.")
                {
                    ToolTip = 'Specifies the value of the Marketer field.';
                }
                field("Energy Type"; Rec."Energy Type")
                {
                    ToolTip = 'Specifies the value of the Energy Type field.';
                }
                field("Family Code"; Rec."Family Code")
                {
                    ToolTip = 'Specifies the value of the Family Code field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("Custom Name"; Rec."Custom Name")
                {
                    ToolTip = 'Specifies the value of the Custom Name field.';
                }
                field("Reference Contract Code"; Rec."Reference Contract Code")
                {
                    ToolTip = 'Specifies the value of the Reference Contract Code field.';
                }
                field(Observations; Rec.Observations)
                {
                    ToolTip = 'Specifies the value of the Observations field.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Import Excel")
            {
                Caption = 'Import Excel Files';
                ApplicationArea = All;
                Image = Import;
                ToolTip = 'Import modalities from Excel file';
                Visible = false;
                trigger OnAction()
                var
                    SUCContractModalities: Record "SUC Contract Modalities";
                begin
                    SUCContractModalities.ImportModalitiesFromExcel();
                end;
            }
        }
    }
}
