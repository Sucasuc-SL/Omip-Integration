namespace Sucasuc.Omip.Masters;
table 50212 "SUC Omip Consum. Distributor"
{
    DataClassification = CustomerContent;
    Caption = 'Omip Consumption Established by Distributor';

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
        }
        field(3; P2; Decimal)
        {
            Caption = 'P2';
        }
        field(4; P3; Decimal)
        {
            Caption = 'P3';
        }
        field(5; P4; Decimal)
        {
            Caption = 'P4';
        }
        field(6; P5; Decimal)
        {
            Caption = 'P5';
        }
        field(7; P6; Decimal)
        {
            Caption = 'P6';
        }
    }

    keys
    {
        key(Key1; "Rate No.")
        {
            Clustered = true;
        }
    }
}