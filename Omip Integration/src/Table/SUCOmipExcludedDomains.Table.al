namespace Sucasuc.Omip.Setup;
/// <summary>
/// Table SUC Omip Excluded Domains (ID 50120).
/// </summary>
table 50170 "SUC Omip Excluded Domains"
{
    Caption = 'Omip Excluded Domains';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Domains; Text[250])
        {
            Caption = 'Domains';

            trigger OnValidate()
            var
                StrPosIn: Integer;
            begin
                StrPosIn := StrPos(Domains, '@');

                if StrPosIn > 0 then
                    Domains := DelStr(Domains, StrPosIn, 1)
                else
                    "Domains Email" := CopyStr('@' + Domains, 1, 250);
            end;
        }
        field(2; "Domains Email"; Text[250])
        {
            Caption = 'Domains Email';
            Editable = false;
        }
    }

    keys
    {
        key(PK; Domains)
        {
            Clustered = true;
        }
    }

}