namespace Sucasuc.Omip.Contracts;
using System.IO;

tableextension 50154 "SUC Omip Excel Buffer" extends "Excel Buffer"
{
    fields
    {
        field(50150; "SUC Extended Cell Value Text"; Text[2048])
        {
            Caption = 'Extended Cell Value Text';
            DataClassification = CustomerContent;
        }
        field(50151; "SUC Extended Cell Value Text 1"; Text[2048])
        {
            Caption = 'Extended Cell Value Text';
            DataClassification = CustomerContent;
        }
    }
}
