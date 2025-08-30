namespace Sucasuc.Omip.Setup;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Contracts;
/// <summary>
/// Page SUC Omip Setup (ID 50150).
/// </summary>
page 50150 "SUC Omip Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SUC Omip Setup";
    Caption = 'Omip Setup';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Email Prices Confirmation"; Rec."Email Prices Confirmation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email Prices Confirmation field.';
                }
                field("Email Duplicate Customers"; Rec."Email Duplicate Customers")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email Duplicate Customers field.';
                }
                field("Order TED"; Rec."Order TED Addendum")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Order TED field.';
                }
                field(Resolution; Rec."Resolution Addendum")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Resolution field.';
                }
                field("Default Marketer No. Users"; Rec."Default Marketer Ext. Users")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Marketer No. Users field.';
                }
            }
            part("Rates Entry Setup"; "SUC Omip Rates Entry Setup")
            {
                ApplicationArea = All;
            }
            group("Number Series")
            {
                Caption = 'Number Series';

                field("Proposal Nos."; Rec."Proposal Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Proposal Nos. field.';
                }
                field("Contract Nos."; Rec."Contract Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Contract Nos. field.';
                }
                field("Preview Proposal Nos."; Rec."Preview Proposal Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Preview Proposal Nos. field.';
                }
            }
            group(Proposal)
            {
                Caption = 'Proposal';

                field("Email Proposal Confirmation"; Rec."Email Proposal Confirmation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email Proposal Confirmation field.';
                }
                field("Time Validity Proposals"; Rec."Time Validity Proposals")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Validity Proposals field.';
                }
                field("Message Body Proposals"; Rec."Message Body Proposals")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Message Body Proposals field.';
                    MultiLine = true;
                }
                field("Customer No. Proposal Preview"; Rec."Customer No. Proposal Preview")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. Proposal Preview field.';
                }

            }
            group(Contracts)
            {
                Caption = 'Contracts';
                field("Email Contract Confirmation"; Rec."Email Contract Confirmation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email Contract Confirmation field.';
                }
                field("Time Validity Contracts"; Rec."Time Validity Contracts")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Time Validity Contracts field.';
                }
                field("Default Reference Contract"; Rec."Default Reference Contract")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Default Reference Contract field.';
                }
                field("Message Body Contracts"; Rec."Message Body Contracts")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Message Body Contracts field.';
                    MultiLine = true;
                }
                field("Allow Delete Related Documents"; Rec."Allow Delete Related Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Allow Delete Related Documents field.';
                }
                part("SUC Default Modality By Time"; "SUC Default Modality By Time")
                {
                    ApplicationArea = All;
                }
            }
            group("E-Send Setup")
            {
                Caption = 'E-Send Setup';
                field("Email Delivery Provider"; Rec."Email Delivery Provider")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email Delivery Provider field.';
                }
                field("Show BTP Request"; Rec."Show BTP Request")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Show BTP Request field.';
                }
            }
            part("SUC Omip E-Send Doc. Setup"; "SUC Omip E-Send Doc. Setup")
            {
                ApplicationArea = All;
            }
            group("SIPS Setup")
            {
                Caption = 'SIPS Setup';
                field("URL SIPS"; Rec."URL SIPS")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the URL SIPS field.';
                }
            }
            group("Plenitude Setup")
            {
                Caption = 'Plenitude Setup';
                field("URL Plenitude"; Rec."URL Plenitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the URL Plenitude field.';
                }
                field("User Plenitude"; Rec."User Plenitude")
                {
                    ApplicationArea = All;
                }
                field("Password Plenitude"; Rec."Password Plenitude")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                    ToolTip = 'Specifies the value of the Password Plenitude field.';
                }
                field("Version Plenitude"; Rec."Version Plenitude")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Version Plenitude field.';
                }
                field("Show Plenitude Request"; Rec."Show Plenitude Request")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Show Plenitude Request field.';
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("SUC Excluded Domains")
            {
                ApplicationArea = All;
                Caption = 'Excluded Domains';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = ExternalDocument;
                RunObject = page "SUC Omip Excluded Domains";
                ToolTip = 'Executes the Excluded Domains action.';
            }
            action("SUC Download Manual")
            {
                ApplicationArea = All;
                Caption = 'Download Manual';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Download;
                trigger OnAction()
                begin
                    Rec.DownloadManualFile();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}