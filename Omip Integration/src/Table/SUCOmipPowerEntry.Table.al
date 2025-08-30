namespace Sucasuc.Omip.Masters;
using Sucasuc.Omip.Proposals;
/// <summary>
/// Table SUC Omip Power Entry (ID 50119).
/// </summary>
table 50169 "SUC Omip Power Entry"
{
    Caption = 'Omip Power Entry';
    DataClassification = CustomerContent;
    LookupPageId = "SUC Omip Power Entry Subform";
    DrillDownPageId = "SUC Omip Power Entry Subform";

    fields
    {
        field(1; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
        }
        field(2; P1; Decimal)
        {
            Caption = 'P1';
            DecimalPlaces = 0 : 4;
        }
        field(3; P2; Decimal)
        {
            Caption = 'P2';
            DecimalPlaces = 0 : 4;
        }
        field(4; P3; Decimal)
        {
            Caption = 'P3';
            DecimalPlaces = 0 : 4;
        }
        field(5; P4; Decimal)
        {
            Caption = 'P4';
            DecimalPlaces = 0 : 4;
        }
        field(6; P5; Decimal)
        {
            Caption = 'P5';
            DecimalPlaces = 0 : 4;
        }
        field(7; P6; Decimal)
        {
            Caption = 'P6';
            DecimalPlaces = 0 : 4;
        }
        field(8; "Proposal No."; Code[20])
        {
            Caption = 'Proposal No.';
            TableRelation = "SUC Omip Proposals"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetProposal();
            end;
        }
        field(9; "Proposal Id"; Guid)
        {
            Caption = 'Proposal Id';
            TableRelation = "SUC Omip Proposals".SystemId;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Proposal No.", "Rate No.")
        {
            Clustered = true;
        }
    }

    local procedure GetProposal()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
    begin
        if SUCOmipProposals.Get("Proposal No.") then
            Validate("Proposal Id", SUCOmipProposals.SystemId);
    end;
}