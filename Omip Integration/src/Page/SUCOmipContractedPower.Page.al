namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Utilities;
page 50201 "SUC Omip Contracted Power"
{
    Caption = 'Omip Contracted Power Term';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "SUC Omip Contracted Power";
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(CUPS; Rec.CUPS)
                {
                    ApplicationArea = All;
                }
                field("Rate No."; Rec."Rate No.")
                {
                    ApplicationArea = All;
                }
                field(P1; Rec.P1)
                {
                    ApplicationArea = All;
                }
                field(P2; Rec.P2)
                {
                    ApplicationArea = All;
                }
                field(P3; Rec.P3)
                {
                    ApplicationArea = All;
                }
                field(P4; Rec.P4)
                {
                    ApplicationArea = All;
                }
                field(P5; Rec.P5)
                {
                    ApplicationArea = All;
                }
                field(P6; Rec.P6)
                {
                    ApplicationArea = All;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Commission P1"; Rec."Commission P1")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Commission P2"; Rec."Commission P2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Commission P3"; Rec."Commission P3")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Commission P4"; Rec."Commission P4")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Commission P5"; Rec."Commission P5")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Commission P6"; Rec."Commission P6")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Commission"; Rec."Total Commission")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Get Contracted Power")
            {
                Caption = 'Get SIPS Information';
                ApplicationArea = All;
                Image = GetSourceDoc;

                trigger OnAction()
                var
                    SUCOmipManagement: Codeunit "SUC Omip Management";
                begin
                    SUCOmipManagement.GetCUPSInfoFromSIPS(Rec."Document Type", Rec."Document No.", Rec.CUPS);
                end;
            }
        }
    }
}