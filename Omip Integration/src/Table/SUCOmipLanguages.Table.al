namespace Sucasuc.Omip.Masters;
using Microsoft.Foundation.Address;
using System.Globalization;
table 50207 "SUC Omip Languages"
{
    Caption = 'Omip Languages';
    DataClassification = CustomerContent;
    LookupPageId = "SUC Omip Languages";
    DrillDownPageId = "SUC Omip Languages";

    fields
    {
        field(1; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region".Code;
            trigger OnValidate()
            begin
                CalcFields("Country Name");
            end;
        }
        field(2; "Country Name"; Text[50])
        {
            Caption = 'Country Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Country/Region".Name where(Code = field("Country Code")));
        }
        field(3; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language.Code;
            trigger OnValidate()
            begin
                CalcFields("Language Name");
            end;
        }
        field(4; "Language Name"; Text[100])
        {
            Caption = 'Language Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Language.Name where(Code = field("Language Code")));
        }
        field(5; "Id. Plenitude"; Integer)
        {
            Caption = 'Id. Plenitude';
        }
    }

    keys
    {
        key(Key1; "Country Code", "Language Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Country Name", "Language Name") { }
    }
}