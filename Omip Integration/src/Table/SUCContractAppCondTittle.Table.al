namespace Sucasuc.Omip.Contracts;
using System.Reflection;
table 50220 "SUC Contract App. Cond. Tittle"
{
    DataClassification = CustomerContent;
    Caption = 'Contract Applicable Conditions Tittle';
    DrillDownPageId = "SUC Contract App. Cond. Tittle";
    LookupPageId = "SUC Contract App. Cond. Tittle";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Tittle Applicable Conditions"; Blob)
        {
            Caption = 'Tittle Applicable Conditions';
        }
        field(3; "Tittle Complement 1"; Text[100])
        {
            Caption = 'Tittle Complement 1';
        }
        field(4; "Tittle Complement 2"; Text[100])
        {
            Caption = 'Tittle Complement 2';
        }
        field(5; "Tittle Complement 3"; Text[100])
        {
            Caption = 'Tittle Complement 3';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    begin
        DisassociateTittleFromModalities();
    end;

    /// <summary>
    /// Disassociates this tittle from all contract modalities that reference it
    /// </summary>
    local procedure DisassociateTittleFromModalities()
    var
        ContractModalities: Record "SUC Contract Modalities";
    begin
        ContractModalities.Reset();
        ContractModalities.SetRange("No. Contract App. Cond. Tittle", "No.");

        if ContractModalities.FindSet() then
            repeat
                // Clear the tittle association
                ContractModalities."No. Contract App. Cond. Tittle" := '';

                // Clear Tittle Complement fields
                ContractModalities.Tittle := '';
                ContractModalities."Tittle Complement 1" := '';
                ContractModalities."Tittle Complement 2" := '';
                ContractModalities."Tittle Complement 3" := '';

                ContractModalities.Modify();
            until ContractModalities.Next() = 0;
    end;

    procedure SetDataBlob(FieldNo: Integer; NewData: Text)
    var
        OutStream: OutStream;
    begin
        case FieldNo of
            FieldNo("Tittle Applicable Conditions"):
                begin
                    Clear("Tittle Applicable Conditions");
                    "Tittle Applicable Conditions".CreateOutStream(OutStream, TextEncoding::UTF8);
                    OutStream.WriteText(NewData);
                    Modify();
                end;
        end;
    end;

    procedure GetDataValueBlob(FieldNo: Integer): Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        case FieldNo of
            FieldNo("Tittle Applicable Conditions"):
                begin
                    CalcFields("Tittle Applicable Conditions");
                    "Tittle Applicable Conditions".CreateInStream(InStream, TextEncoding::UTF8);
                    exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), FieldName("Tittle Applicable Conditions")));
                end;
        end;
    end;
}