namespace Sucasuc.Omip.Masters;
using Microsoft.Sales.Customer;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Proposals;
using Sucasuc.Omip.User;
using Microsoft.Foundation.Address;
using Sucasuc.Omip.Utilities;
tableextension 50150 "SUC Omip Customer" extends Customer
{
    fields
    {
        field(50150; "SUC Full Name"; Text[500])
        {
            Caption = 'Full Name';
        }
        field(50151; "SUC Manager"; Text[250])
        {
            Caption = 'Manager';
        }
        field(50152; "SUC Customer Type"; Enum "SUC Omip Customer Type")
        {
            Caption = 'Type';
        }
        field(50153; "SUC Supply Point Address"; Text[200])
        {
            Caption = 'Address';
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip Customer CUPS';
        }
        field(50154; "SUC Supply Point Post Code"; Code[20])
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip Customer CUPS';
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
        field(50155; "SUC Supply Point City"; Text[30])
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip Customer CUPS';
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
        field(50156; "SUC Supply Point County"; Text[30])
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip Customer CUPS';
            CaptionClass = '5,1,' + "SUC Supply Point Country";
            Caption = 'County';
        }
        field(50157; "SUC Supply Point Country"; Code[10])
        {
            ObsoleteState = Pending;
            ObsoleteReason = 'Field change by SUC Omip Customer CUPS';
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
        field(50158; "SUC VAT Registration Type"; Enum "SUC Omip VAT Registration Type")
        {
            Caption = 'VAT Registration Type';
        }
        field(50159; "SUC Manager Position"; Text[100])
        {
            Caption = 'Manager position';
        }
        field(50160; "SUC Manager VAT Reg. No"; Text[20])
        {
            Caption = 'Manager VAT Registration No.';
        }
        field(50161; "Agent No."; Code[100])
        {
            Caption = 'Agent No.';
            TableRelation = "SUC Omip External Users"."User Name";
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CalcFields("Agent Name");
            end;
        }
        field(50162; "Agent Name"; Text[100])
        {
            Caption = 'Agent Name';
            CalcFormula = lookup("SUC Omip External Users"."Full Name" where("User Name" = field("Agent No.")));
            FieldClass = FlowField;
        }
        field(50163; "Duplicate State"; Enum "SUC Omip Duplicate State")
        {
            Caption = 'Duplicate State';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                SUCOmipManagement: Codeunit "SUC Omip Management";
            begin
                if ("Duplicate State" = "Duplicate State"::" ") and (xRec."Duplicate State" = xRec."Duplicate State"::"Pending validation duplicate customer") then
                    SUCOmipManagement.SendDuplicateCustomerConfirmation(Rec);
            end;
        }
        field(50164; "Customer Type Plenitude"; Enum "SUC Customer Type Plenitude")
        {
            Caption = 'Customer Type Plenitude';
            DataClassification = CustomerContent;
        }
        modify(Name)
        {
            trigger OnAfterValidate()
            begin
                Validate("SUC Full Name", LowerCase(Name + ' ' + "Name 2"));
            end;
        }
        modify("Name 2")
        {
            trigger OnAfterValidate()
            begin
                Validate("SUC Full Name", LowerCase(Name + ' ' + "Name 2"));
            end;
        }
        modify("E-Mail")
        {
            trigger OnAfterValidate()
            var
                SUCOmipManagement: Codeunit "SUC Omip Management";
            begin
                if SUCOmipManagement.IsCustomerDuplicate2("No.", "E-Mail", "Phone No.", "VAT Registration No.") then
                    Rec."Duplicate State" := Rec."Duplicate State"::"Pending validation duplicate customer"
                else
                    Rec."Duplicate State" := Rec."Duplicate State"::" ";
            end;
        }
        modify("Phone No.")
        {
            trigger OnAfterValidate()
            var
                SUCOmipManagement: Codeunit "SUC Omip Management";
            begin
                if SUCOmipManagement.IsCustomerDuplicate2("No.", "E-Mail", "Phone No.", "VAT Registration No.") then
                    Rec."Duplicate State" := Rec."Duplicate State"::"Pending validation duplicate customer"
                else
                    Rec."Duplicate State" := Rec."Duplicate State"::" ";
            end;
        }
        modify("VAT Registration No.")
        {
            trigger OnAfterValidate()
            var
                SUCOmipManagement: Codeunit "SUC Omip Management";
            begin
                if SUCOmipManagement.IsCustomerDuplicate2("No.", "E-Mail", "Phone No.", "VAT Registration No.") then
                    Rec."Duplicate State" := Rec."Duplicate State"::"Pending validation duplicate customer"
                else
                    Rec."Duplicate State" := Rec."Duplicate State"::" ";
            end;
        }
    }

    trigger OnBeforeDelete()
    var
        SUCOmipProposals: Record "SUC Omip Proposals";
        SUCOmipEnergyContracts: Record "SUC Omip Energy Contracts";
        ErrorProposalsLbl: Label 'Customer cannot be deleted because it is used in the proposals.';
        ErrorContractsLbl: Label 'Customer cannot be deleted because it is used in the contracts.';
    begin
        SUCOmipProposals.Reset();
        SUCOmipProposals.SetRange("Customer No.", "No.");
        if not SUCOmipProposals.IsEmpty() then
            Error(ErrorProposalsLbl);

        SUCOmipEnergyContracts.Reset();
        SUCOmipEnergyContracts.SetRange("Customer No.", "No.");
        if not SUCOmipEnergyContracts.IsEmpty() then
            Error(ErrorContractsLbl);
    end;

    var
        PostCode: Record "Post Code";
}