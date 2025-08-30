namespace Sucasuc.Omip.Masters;
using Microsoft.Sales.Customer;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Proposals;
using Microsoft.Foundation.Address;

/// <summary>
/// Table SUC Omip Customer CUPS (ID 50122).
/// </summary>
table 50172 "SUC Omip Customer CUPS"
{
    Caption = 'Omip Customer CUPS';
    DrillDownPageId = "SUC Omip Customer CUPS";
    LookupPageId = "SUC Omip Customer CUPS";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(2; CUPS; Text[25])
        {
            Caption = 'CUPS';
        }
        field(3; "SUC Supply Point Address"; Text[200])
        {
            Caption = 'Address';
        }
        field(4; "SUC Supply Point Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = if ("SUC Supply Point Country" = const('')) "Post Code"
            else
            if ("SUC Supply Point Country" = filter(<> '')) "Post Code" where("Country/Region Code" = field("SUC Supply Point Country"));
            ValidateTableRelation = false;
            trigger OnLookup()
            var
                CityTxt: Text;
                CountyTxt: Text;
            begin
                CityTxt := "SUC Supply Point City";
                CountyTxt := "SUC Supply Point County";
                PostCode.LookupPostCode(CityTxt, "SUC Supply Point Post Code", CountyTxt, "SUC Supply Point Country");
                "SUC Supply Point City" := CopyStr(CityTxt, 1, 30);
                "SUC Supply Point County" := CopyStr(CountyTxt, 1, 30);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode("SUC Supply Point City", "SUC Supply Point Post Code", "SUC Supply Point County", "SUC Supply Point Country", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(5; "SUC Supply Point City"; Text[30])
        {
            Caption = 'City';
            TableRelation = if ("SUC Supply Point Country" = const('')) "Post Code".City
            else
            if ("SUC Supply Point Country" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("SUC Supply Point Country"));
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                CityTxt: Text;
                CountyTxt: Text;
            begin
                CityTxt := "SUC Supply Point City";
                CountyTxt := "SUC Supply Point County";
                PostCode.LookupPostCode(CityTxt, "SUC Supply Point Post Code", CountyTxt, "SUC Supply Point Country");
                "SUC Supply Point City" := CopyStr(CityTxt, 1, 30);
                "SUC Supply Point County" := CopyStr(CountyTxt, 1, 30);
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity("SUC Supply Point City", "SUC Supply Point Post Code", "SUC Supply Point County", "SUC Supply Point Country", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(6; "SUC Supply Point County"; Text[30])
        {
            CaptionClass = '5,1,' + "SUC Supply Point Country";
            Caption = 'County';
        }
        field(7; "SUC Supply Point Country"; Code[10])
        {
            Caption = 'Country/Region';
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                CityTxt: Text;
                CountyTxt: Text;
            begin
                CityTxt := "SUC Supply Point City";
                CountyTxt := "SUC Supply Point County";
                PostCode.CheckClearPostCodeCityCounty(CityTxt, "SUC Supply Point Post Code", CountyTxt, "SUC Supply Point Country", xRec."SUC Supply Point Country");
                "SUC Supply Point City" := CopyStr(CityTxt, 1, 30);
                "SUC Supply Point County" := CopyStr(CountyTxt, 1, 30);
            end;
        }
    }

    keys
    {
        key(PK; "Customer No.", CUPS)
        {
            Clustered = true;
        }
    }
    trigger OnDelete()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        ErrorLbl: Label 'The CUPS is found in the document: %1 - %2';
    begin
        SUCOmipProposals.Reset();
        SUCOmipProposals.SetRange("Customer No.", "Customer No.");
        SUCOmipProposals.SetRange("Customer CUPS", CUPS);
        if SUCOmipProposals.FindLast() then
            Error(ErrorLbl, 'Propuesta', SUCOmipProposals."No.");

        SUCOmipEnergyContracts.Reset();
        SUCOmipEnergyContracts.SetRange("Customer No.", "Customer No.");
        SUCOmipEnergyContracts.SetRange("Customer CUPS", CUPS);
        if SUCOmipEnergyContracts.FindLast() then
            Error(ErrorLbl, 'Contrato', SUCOmipEnergyContracts."No.");
    end;

    var
        PostCode: Record "Post Code";
}