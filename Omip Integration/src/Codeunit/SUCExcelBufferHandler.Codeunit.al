namespace Sucasuc.Omip.Contracts;
using System.IO;

codeunit 50160 "SUC Excel Buffer Handler"
{
    [EventSubscriber(ObjectType::Table, Database::"Excel Buffer", 'OnBeforeParseCellValue', '', false, false)]
    local procedure ExcelBuffer_OnBeforeParseCellValue(var ExcelBuffer: Record "Excel Buffer"; var FormatString: Text; var IsHandled: Boolean; var Value: Text)
    begin
        ExcelBuffer."SUC Extended Cell Value Text" := CopyStr(Value, 1, MaxStrLen(ExcelBuffer."SUC Extended Cell Value Text"));
        ExcelBuffer."SUC Extended Cell Value Text 1" := CopyStr(Value, 2049, MaxStrLen(ExcelBuffer."SUC Extended Cell Value Text 1"));
    end;
}
