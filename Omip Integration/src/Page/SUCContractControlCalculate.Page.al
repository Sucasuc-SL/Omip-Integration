namespace Sucasuc.Omip.Utilities;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.User;
using Sucasuc.Omip.Contracts;
using Sucasuc.Omip.Documents;
using Sucasuc.Energy.Ledger;
/// <summary>
/// Page SUC Omip Rates Entry Calculate (ID 50163).
/// </summary>
page 50223 "SUC Contract Control Calculate"
{
    PageType = StandardDialog;
    Caption = 'Contract Control Calculate';
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
                    ValuesAllowed = Omip, "Energy (Light - Gas)";
                    trigger OnValidate()
                    begin
                        ViewFields();
                    end;
                }
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
                group("Energy Contracts")
                {
                    ShowCaption = false;
                    Visible = not VisibleOmipFields;
                    field(EnergyType; EnergyType)
                    {
                        ApplicationArea = All;
                        Caption = 'Energy Type';
                        ToolTip = 'Specifies the value of the Energy Type field.';
                    }
                }
                field(RateNo; RateNo)
                {
                    ApplicationArea = All;
                    Caption = 'Rate No.';
                    TableRelation = "SUC Omip Rates".Code;
                    ToolTip = 'Specifies the value of the Rate No. field.';
                }
                group("Energy Contracts 2")
                {
                    ShowCaption = false;
                    Visible = not VisibleOmipFields;
                    field(SUCRateTypeContract; SUCRateTypeContract)
                    {
                        ApplicationArea = All;
                        Caption = 'Rate Type Contract';
                        ToolTip = 'Specifies the value of the Rate Type Contract field.';
                    }
                    field(ContractModality; ContractModality)
                    {
                        ApplicationArea = All;
                        Caption = 'Contract Modality';
                        ToolTip = 'Specifies the value of the Contract Modality field.';
                        Editable = false;
                        trigger OnDrillDown()
                        var
                            SUCControlPricesEnergy: Record "SUC Control Prices Energy";
                            SUCControlPricesEnergyPage: Page "SUC Control Prices Energy";
                        begin
                            SUCControlPricesEnergy.Reset();
                            SUCControlPricesEnergy.SetRange("Marketer No.", MarketerNo);
                            SUCControlPricesEnergy.SetRange("Energy Type", EnergyType);
                            SUCControlPricesEnergy.SetRange("Rate No.", RateNo); // Use Rate No. to filter by tariff
                            SUCControlPricesEnergy.SetRange("Rate Type Contract", SUCRateTypeContract);
                            if SUCControlPricesEnergy.FindSet() then begin
                                SUCControlPricesEnergyPage.SetRecord(SUCControlPricesEnergy);
                                SUCControlPricesEnergyPage.SetTableView(SUCControlPricesEnergy);
                                SUCControlPricesEnergyPage.LookupMode(true);
                                if SUCControlPricesEnergyPage.RunModal() = Action::LookupOK then begin
                                    SUCControlPricesEnergyPage.GetRecord(SUCControlPricesEnergy);
                                    ContractModality := SUCControlPricesEnergy.Modality;
                                    ControlPricesEnergyId := SUCControlPricesEnergy."Id.";
                                end;
                            end;
                        end;
                    }
                    field(ContratationType; ContratationType)
                    {
                        ApplicationArea = All;
                        Caption = 'Contratation Type';
                        ToolTip = 'Specifies the value of the Contratation Type field.';
                    }
                }
                group("Omip Fields")
                {
                    ShowCaption = false;
                    Visible = VisibleOmipFields;
                    field(EnergyOrigen; EnergyOrigen)
                    {
                        ApplicationArea = All;
                        Caption = 'Energy Origen';
                        ToolTip = 'Specifies the value of the Energy Origen field.';
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
                    group("Energy Weighted")
                    {
                        Caption = 'Energy Weighted';
                        // field(RateCategory; RateCategory)
                        // {
                        //     ApplicationArea = All;
                        //     Caption = 'Rate Category';
                        //     TableRelation = "SUC Omip Rate Category"."Category Code";
                        //     ToolTip = 'Specifies the value of the Rate Category field.';
                        //     trigger OnValidate()
                        //     var
                        //         SUCOmipRateCategory: Record "SUC Omip Rate Category";
                        //     begin
                        //         SUCOmipRateCategory.Get(RateCategory);
                        //         FEEPotency := SUCOmipRateCategory."FEE Potency";
                        //         FEEEnergy := SUCOmipRateCategory."FEE Energy";
                        //     end;
                        // }
                        // field(FEEPotency; FEEPotency)
                        // {
                        //     ApplicationArea = All;
                        //     Caption = 'FEE Potency';
                        //     ToolTip = 'Specifies the value of the FEE Potency field.';
                        //     trigger OnValidate()
                        //     var
                        //         SUCOmipRatesEntrySetup: Record "SUC Omip Rates Entry Setup";
                        //     begin
                        //         SUCOmipRatesEntrySetup.Get(MarketerNo);
                        //         if SUCOmipRatesEntrySetup."Max. FEE Potency" <> 0 then
                        //             if FEEPotency > SUCOmipRatesEntrySetup."Max. FEE Potency" then
                        //                 Error(ErrorLbl, SUCOmipRatesEntrySetup."Max. FEE Potency");
                        //     end;
                        // }
                        // field(FEEEnergy; FEEEnergy)
                        // {
                        //     ApplicationArea = All;
                        //     Caption = 'FEE Energy';
                        //     ToolTip = 'Specifies the value of the FEE Energy field.';
                        //     trigger OnValidate()
                        //     var
                        //         SUCOmipRatesEntrySetup: Record "SUC Omip Rates Entry Setup";
                        //     begin
                        //         SUCOmipRatesEntrySetup.Get(MarketerNo);
                        //         if SUCOmipRatesEntrySetup."Max. FEE Energy" <> 0 then
                        //             if FEEEnergy > SUCOmipRatesEntrySetup."Max. FEE Energy" then
                        //                 Error(ErrorLbl, SUCOmipRatesEntrySetup."Max. FEE Energy");
                        //     end;
                        // }
                        field(FEECorrector; FEECorrector)
                        {
                            ApplicationArea = All;
                            Caption = 'FEE Corrector';
                            Editable = false;
                            ToolTip = 'Specifies the value of the FEE Corrector field.';
                        }
                    }
                }
                field(AgentNo; AgentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Agent No.';
                    TableRelation = "SUC Omip External Users"."User Name";
                    ToolTip = 'Specifies the value of the Agent No. field.';
                }

                field(Proposed; GenerateDoc)
                {
                    ApplicationArea = All;
                    Caption = 'Generate Document';
                    ToolTip = 'Specifies the value of the Generate Document field.';
                }
            }
        }
    }

    var
        SUCOmipManagement: Codeunit "SUC Omip Management";
        EnergyOrigen: Enum "SUC Omip Energy Origen";
        Type: Enum "SUC Omip Rate Entry Types";
        Time: Enum "SUC Omip Times";
        EnergyType: Enum "SUC Energy Type";
        ContratationType: Enum "SUC Contratation Type";
        SUCRateTypeContract: Enum "SUC Rate Type Contract";
        SUCProductType: Enum "SUC Product Type";
        GenerateDoc: Boolean;
        VisibleOmipFields: Boolean;
        MarketerNo: Code[20];
        RateNo: Code[20];
        AgentNo: Code[100];
        FEECorrector: Decimal;
        PriceBase: Decimal;
        ControlPricesEnergyId: Integer;
        ContractModality: Text[100];

    trigger OnOpenPage()
    begin
        ViewFields();
    end;

    trigger OnAfterGetRecord()
    begin
        ViewFields();
    end;

    [Obsolete('Replaced by GetDataToCalculate2', '25.02')]
    procedure GetDataToCalculate(var OmipOut: Boolean; var MarketerOut: Code[20]; var TypeOut: Enum "SUC Omip Rate Entry Types"; var TimeOut: Enum "SUC Omip Times";
                                         var PriceBaseOut: Decimal; var RateCategoryOut: Code[20];
                                         var FEECorrectorOut: Decimal; var RateNoOut: Code[20]; var ProposedOut: Boolean; var EnergyOrigenOut: Enum "SUC Omip Energy Origen";
                                         var EnergyTypeOut: Enum "SUC Energy Type"; var ContratationTypeOut: Enum "SUC Contratation Type";
                                         var SUCRateTypeContractOut: Enum "SUC Rate Type Contract"; var ContractModalityOut: Text[100]; var ControlPricesEnergyIdOut: Integer;
                                         var AgentNoOut: Code[100])
    begin
    end;

    [Obsolete('Replaced by GetDataToCalculate3', '25.02')]
    procedure GetDataToCalculate2(var OmipOut: Boolean; var MarketerOut: Code[20]; var TypeOut: Enum "SUC Omip Rate Entry Types"; var TimeOut: Enum "SUC Omip Times";
                                         var PriceBaseOut: Decimal; var FEECorrectorOut: Decimal; var RateNoOut: Code[20]; var ProposedOut: Boolean;
                                         var EnergyOrigenOut: Enum "SUC Omip Energy Origen"; var EnergyTypeOut: Enum "SUC Energy Type"; var ContratationTypeOut: Enum "SUC Contratation Type";
                                         var SUCRateTypeContractOut: Enum "SUC Rate Type Contract"; var ContractModalityOut: Text[100]; var ControlPricesEnergyIdOut: Integer;
                                         var AgentNoOut: Code[100])
    begin

    end;

    procedure GetDataToCalculate3(var SUCProductTypeOut: Enum "SUC Product Type"; var MarketerOut: Code[20]; var TypeOut: Enum "SUC Omip Rate Entry Types"; var TimeOut: Enum "SUC Omip Times";
                                 var PriceBaseOut: Decimal; var FEECorrectorOut: Decimal; var RateNoOut: Code[20]; var ProposedOut: Boolean;
                                 var EnergyOrigenOut: Enum "SUC Omip Energy Origen"; var EnergyTypeOut: Enum "SUC Energy Type"; var ContratationTypeOut: Enum "SUC Contratation Type";
                                 var SUCRateTypeContractOut: Enum "SUC Rate Type Contract"; var ContractModalityOut: Text[100]; var ControlPricesEnergyIdOut: Integer;
                                 var AgentNoOut: Code[100])
    begin
        SUCProductTypeOut := SUCProductType;
        MarketerOut := MarketerNo;
        TypeOut := Type;
        TimeOut := Time;
        PriceBaseOut := PriceBase;
        FEECorrectorOut := FEECorrector;
        RateNoOut := RateNo;
        ProposedOut := GenerateDoc;
        EnergyOrigenOut := EnergyOrigen;
        EnergyTypeOut := EnergyType;
        ContratationTypeOut := ContratationType;
        SUCRateTypeContractOut := SUCRateTypeContract;
        ContractModalityOut := ContractModality;
        ControlPricesEnergyIdOut := ControlPricesEnergyId;
        AgentNoOut := AgentNo;
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
                VisibleOmipFields := true
            else
                VisibleOmipFields := false;
        end;
    end;
}