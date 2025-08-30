namespace Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Documents;
using Sucasuc.Omip.User;
using Sucasuc.Omip.Prosegur;
/// <summary>
/// Page SUC Omip Rates Entry Calculate (ID 50163).
/// </summary>
page 50163 "SUC Omip Rates Entry Calculate"
{
    PageType = StandardDialog;
    Caption = 'Proposal Generation';
    ApplicationArea = All;
    UsageCategory = None;
    layout
    {
        area(Content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(SUCProductType; SUCProductType)
                {
                    ApplicationArea = All;
                    Caption = 'Product Type';
                    ToolTip = 'Specifies the value of the Product Type field.';
                    ValuesAllowed = Omip, Prosegur;
                    trigger OnValidate()
                    begin
                        ViewFields();
                    end;
                }
                group(Omip)
                {
                    Visible = VisibleOmip;
                    ShowCaption = false;
                    field(MarketerNo; MarketerNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Marketer No.';
                        ToolTip = 'Specifies the value of the Marketer No. field.';
                        TableRelation = "SUC Omip Marketers"."No.";
                        trigger OnValidate()
                        begin
                            GetGeneralData();
                        end;
                    }
                    field(Type; Type)
                    {
                        ApplicationArea = All;
                        Caption = 'Type';
                        ToolTip = 'Specifies the value of the Type field.';
                        trigger OnValidate()
                        begin
                            GetGeneralData();
                        end;
                    }
                    field(Time; Time)
                    {
                        ApplicationArea = All;
                        Caption = 'Time';
                        ToolTip = 'Specifies the value of the Time field.';
                        trigger OnValidate()
                        begin
                            GetGeneralData();
                        end;
                    }
                    field(PriceBase; PriceBase)
                    {
                        ApplicationArea = All;
                        Caption = 'Price Base';
                        Editable = false;
                        DecimalPlaces = 0 : 6;
                        ToolTip = 'Specifies the value of the Price Base field.';
                    }
                    field(EnergyOrigen; EnergyOrigen)
                    {
                        ApplicationArea = All;
                        Caption = 'Energy Origen';
                        ToolTip = 'Specifies the value of the Energy Origen field.';
                    }
                    field(RateNo; RateNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Rate No.';
                        TableRelation = "SUC Omip Rates".Code;
                        ToolTip = 'Specifies the value of the Rate No. field.';
                    }
                    group("Energy Weighted")
                    {
                        Caption = 'Energy Weighted';
                        field(FEECorrector; FEECorrector)
                        {
                            ApplicationArea = All;
                            Caption = 'FEE Corrector';
                            Editable = false;
                            ToolTip = 'Specifies the value of the FEE Corrector field.';
                        }
                        field(AgentNo; AgentNo)
                        {
                            ApplicationArea = All;
                            Caption = 'Agent No.';
                            TableRelation = "SUC Omip External Users"."User Name";
                            ToolTip = 'Specifies the value of the Agent No. field.';
                        }
                    }
                    field(Proposed; GenerateDoc)
                    {
                        ApplicationArea = All;
                        Caption = 'Generate Document';
                        ToolTip = 'Specifies the value of the Generate Document field.';
                    }
                }
                group(Prosegur)
                {
                    Visible = VisibleProsegur;
                    ShowCaption = false;
                    field(ProsegurTypeUse; ProsegurTypeUse)
                    {
                        ApplicationArea = All;
                        Caption = 'Prosegur Type Use';
                        ToolTip = 'Specifies the value of the Prosegur Type Use field.';
                        TableRelation = "SUC Prosegur Type Uses"."No.";
                    }
                    field(ProsegurTypeAlarm; ProsegurTypeAlarm)
                    {
                        ApplicationArea = All;
                        Caption = 'Prosegur Type Alarm';
                        ToolTip = 'Specifies the value of the Prosegur Type Alarm field.';
                        trigger OnDrillDown()
                        var
                            SUCProsegurTypeAlarm: Record "SUC Prosegur Type Alarm";
                            SUCProsegurTypeAlarmP: Page "SUC Prosegur Type Alarm";
                        begin
                            SUCProsegurTypeAlarm.Reset();
                            SUCProsegurTypeAlarm.SetRange("No. Type Use", ProsegurTypeUse);
                            if SUCProsegurTypeAlarm.FindSet() then begin
                                SUCProsegurTypeAlarmP.SetRecord(SUCProsegurTypeAlarm);
                                SUCProsegurTypeAlarmP.SetTableView(SUCProsegurTypeAlarm);
                                SUCProsegurTypeAlarmP.LookupMode(true);
                                if SUCProsegurTypeAlarmP.RunModal() = Action::LookupOK then begin
                                    SUCProsegurTypeAlarmP.GetRecord(SUCProsegurTypeAlarm);
                                    ProsegurTypeAlarm := SUCProsegurTypeAlarm."No. Type Alarm";
                                end;
                            end;
                        end;
                    }
                    field(AgentNo2; AgentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Agent No.';
                        TableRelation = "SUC Omip External Users"."User Name";
                        ToolTip = 'Specifies the value of the Agent No. field.';
                    }
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        ViewFields();
    end;

    trigger OnAfterGetRecord()
    begin
        ViewFields();
    end;

    var
        SUCOmipManagement: Codeunit "SUC Omip Management";
        EnergyOrigen: Enum "SUC Omip Energy Origen";
        SUCProductType: Enum "SUC Product Type";
        GenerateDoc: Boolean;
        MarketerNo: Code[20];
        RateNo: Code[20];
        AgentNo: Code[100];
        ProsegurTypeUse: Code[20];
        ProsegurTypeAlarm: Code[20];
        FEECorrector: Decimal;
        PriceBase: Decimal;
        Type: Enum "SUC Omip Rate Entry Types";
        Time: Enum "SUC Omip Times";
        VisibleOmip: Boolean;
        VisibleProsegur: Boolean;

    [Obsolete('Replaced by GetDataToCalculate2', '24.36')]
    procedure GetDataToCalculate(var TypeOut: Enum "SUC Omip Rate Entry Types"; var TimeOut: Enum "SUC Omip Times"; var PriceBaseOut: Decimal; var RateCategoryOut: Code[20]; var FEEPotencyOut: Decimal; var FEEEnergyOut: Decimal;
        var FEECorrectorOut: Decimal; var RateNoOut: Code[20]; var ProposedOut: Boolean; var EnergyOrigenOut: Enum "SUC Omip Energy Origen")
    begin
    end;

    [Obsolete('Replaced by GetDataToCalculate3', '25.2')]
    procedure GetDataToCalculate2(var MarketerOut: Code[20]; var TypeOut: Enum "SUC Omip Rate Entry Types"; var TimeOut: Enum "SUC Omip Times"; var PriceBaseOut: Decimal; var RateCategoryOut: Code[20]; var FEEPotencyOut: Decimal; var FEEEnergyOut: Decimal;
            var FEECorrectorOut: Decimal; var RateNoOut: Code[20]; var ProposedOut: Boolean; var EnergyOrigenOut: Enum "SUC Omip Energy Origen")
    begin
    end;

    [Obsolete('Replaced by GetDataToCalculate4', '25.2')]
    procedure GetDataToCalculate3(var MarketerOut: Code[20]; var TypeOut: Enum "SUC Omip Rate Entry Types"; var TimeOut: Enum "SUC Omip Times"; var PriceBaseOut: Decimal;
        var FEECorrectorOut: Decimal; var RateNoOut: Code[20]; var ProposedOut: Boolean; var EnergyOrigenOut: Enum "SUC Omip Energy Origen"; var AgentNoOut: Code[100])
    begin
    end;

    procedure GetDataToCalculate4(var ProductTypeOut: Enum "SUC Product Type"; var MarketerOut: Code[20]; var TypeOut: Enum "SUC Omip Rate Entry Types";
                                  var TimeOut: Enum "SUC Omip Times"; var PriceBaseOut: Decimal; var FEECorrectorOut: Decimal; var RateNoOut: Code[20];
                                  var ProposedOut: Boolean; var EnergyOrigenOut: Enum "SUC Omip Energy Origen"; var AgentNoOut: Code[100];
                                  var ProsegurTypeUseOut: Code[20]; var ProsegurTypeAlarmOut: Code[20])
    begin
        ProductTypeOut := SUCProductType;
        MarketerOut := MarketerNo;
        TypeOut := Type;
        TimeOut := Time;
        PriceBaseOut := PriceBase;
        FEECorrectorOut := FEECorrector;
        RateNoOut := RateNo;
        AgentNoOut := AgentNo;
        ProposedOut := GenerateDoc;
        EnergyOrigenOut := EnergyOrigen;
        ProsegurTypeUseOut := ProsegurTypeUse;
        ProsegurTypeAlarmOut := ProsegurTypeAlarm;
    end;

    local procedure GetGeneralData()
    begin
        PriceBase := SUCOmipManagement.SUCGetPriceBase(Type, Time.AsInteger());
        FEECorrector := SUCOmipManagement.GetFEECorrector(MarketerNo, Type, Time.AsInteger())
    end;

    local procedure ViewFields()
    begin
        case SUCProductType of
            SUCProductType::Omip:
                begin
                    VisibleOmip := true;
                    VisibleProsegur := false;
                end;
            SUCProductType::Prosegur:
                begin
                    VisibleOmip := false;
                    VisibleProsegur := true;
                end;
            else begin
                VisibleOmip := false;
                VisibleProsegur := false;
            end;
        end;
    end;
}