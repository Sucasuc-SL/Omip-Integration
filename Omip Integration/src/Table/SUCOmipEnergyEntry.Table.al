namespace Sucasuc.Omip.Ledger;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.Documents;

/// <summary>
/// Table SUC Omip Energy Entry (ID 50116).
/// </summary>
table 50166 "SUC Omip Energy Entry"
{
    Caption = 'Omip Energy Entry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Rate No."; Code[20])
        {
            Caption = 'Rate No.';
            TableRelation = "SUC Omip Rates".Code;
        }
        field(2; Times; Enum "SUC Omip Times")
        {
            Caption = 'Time', Comment = 'ESP="Tiempo"';

            trigger OnValidate()
            begin
                case Times of
                    Times::"12M":
                        "Times Text" := 'AÑO 01';
                    Times::"24M":
                        "Times Text" := 'AÑO 02';
                    Times::"36M":
                        "Times Text" := 'AÑO 03';
                    Times::"48M":
                        "Times Text" := 'AÑO 04';
                    Times::"60M":
                        "Times Text" := 'AÑO 05';
                end;
            end;
        }
        field(3; Type; Enum "SUC Omip Rate Entry Types")
        {
            Caption = 'Type';
        }
        field(4; P1; Decimal)
        {
            Caption = 'P1';
            DecimalPlaces = 0 : 6;
        }
        field(5; P2; Decimal)
        {
            Caption = 'P2';
            DecimalPlaces = 0 : 6;
        }
        field(6; P3; Decimal)
        {
            Caption = 'P3';
            DecimalPlaces = 0 : 6;
        }
        field(7; P4; Decimal)
        {
            Caption = 'P4';
            DecimalPlaces = 0 : 6;
        }
        field(8; P5; Decimal)
        {
            Caption = 'P5';
            DecimalPlaces = 0 : 6;
        }
        field(9; P6; Decimal)
        {
            Caption = 'P6';
            DecimalPlaces = 0 : 6;
        }
        field(10; "Times Text"; Text[50])
        {
            Caption = 'Times Text';
        }
        field(11; "Proposal No."; Code[20])
        {
            Caption = 'Proposal No.';
            TableRelation = "SUC Omip Proposals"."No.";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                GetProposal();
            end;
        }
        field(12; "Proposal Id"; Guid)
        {
            Caption = 'Proposal Id';
            TableRelation = "SUC Omip Proposals".SystemId;
            DataClassification = CustomerContent;
        }
        field(13; "Omip price"; Decimal)
        {
            Caption = 'Omip price';
        }
        field(14; Enabled; Boolean)
        {
            Caption = 'Enabled';
        }
    }

    keys
    {
        key(PK; "Proposal No.", "Rate No.", Times, Type)
        {
            Clustered = true;
        }
    }

    local procedure GetProposal()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
    begin
        if SUCOmipProposals.Get("Proposal No.") then
            "Proposal Id" := SUCOmipProposals.SystemId;
    end;
}