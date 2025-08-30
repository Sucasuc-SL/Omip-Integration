namespace Sucasuc.Energy.Ledger;
using Sucasuc.Omip.Masters;
using Sucasuc.Omip.Contracts;

page 50222 "SUC Control Prices Energy"
{
    ApplicationArea = All;
    Caption = 'Control Prices Energy';
    PageType = List;
    SourceTable = "SUC Control Prices Energy";
    UsageCategory = Administration;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = sorting("Id.", Modality) order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                // Excel column order (127 columns): CONTRATACION, COMPARATIVA, WEB, ESTADO_CONTRATACION, ESTADO_COMPARATIVA, FUENTE_PRECIOS, COMERCIALIZADORA, TIPO_ENERGIA, TIPO_PRECIO, TARIFA, FAMILIA_MODALIDAD, MODALIDAD, ANEXO, ANEXO_PERSONALIZADO, MODALIDAD_ACTIVACION_FUTURA, CODIGO_REFERENCIA_CONTRATO, ID_TARIFA_WS, TIPO_CLIENTE_WS, TIPO_CLIENTE, PRECIO_ESPECIAL_PARA, PROVINCIA, GASTOS_OPERATIVOS_VISIBLES, ESCALA_TIEMPO_GESTIONES, COSTES_GESTION_EQUIPOS_MEDIDA, COSTES_GESTION_MANTENIMIENTO, COSTES_CAPACIDAD, COSTES_REMUNERACION_COMPANIA, COSTES_REMUNERACION_COMPANIA_BASE, COSTES_FINANCIEROS, COSTES_SGE, COSTES_SGEV, KW_CONTRATADOS, DESCUENTO_GENERAL, BONIFICACION_POTENCIA, RECARGO_POTENCIA, POTENCIA_DESDE, POTENCIA_HASTA, ESCALA_TIEMPO_POTENCIA, DESCUENTO_PRIMER_ANIO_POTENCIA, P1, P2, P3, P4, P5, P6, ENERGIA_DESDE, ENERGIA_HASTA, ESCALA_ENERGIA, DESCUENTO_PRIMER_ANIO_ENERGIA, E1, E2, E3, E4, E5, E6, INDEX_P1_MES_12...INDEX_P6_MES_1
                field("Id."; Rec."Id.")
                {
                    ToolTip = 'Specifies the unique identifier for the control price record.';
                    Editable = false;
                }
                // Column 1: CONTRATACION
                field(Contracting; Rec.Contracting)
                {
                    ToolTip = 'Specifies the value of the Contracting field.';
                }
                // Column 2: COMPARATIVA
                field(Comparison; Rec.Comparison)
                {
                    ToolTip = 'Specifies the value of the Comparison field.';
                }
                // Column 3: WEB
                field(Web; Rec.Web)
                {
                    ToolTip = 'Specifies the value of the Web field.';
                }
                // Column 4: ESTADO_CONTRATACION
                field("Contracting Status"; Rec."Contracting Status")
                {
                    ToolTip = 'Specifies the value of the Contracting Status field.';
                }
                // Column 5: ESTADO_COMPARATIVA
                field("Comparison Status"; Rec."Comparison Status")
                {
                    ToolTip = 'Specifies the value of the Comparison Status field.';
                }
                // Column 6: FUENTE_PRECIOS
                field("Price Source"; Rec."Price Source")
                {
                    ToolTip = 'Specifies the value of the Price Source field.';
                }
                // Column 7: COMERCIALIZADORA
                field("Marketer No."; Rec."Marketer No.")
                {
                    ToolTip = 'Specifies the value of the Marketer No. field.';
                }
                // Column 8: TIPO_ENERGIA
                field("Energy Type"; Rec."Energy Type")
                {
                    ToolTip = 'Specifies the value of the Energy Type field.';
                }
                // Column 9: TIPO_PRECIO
                field("Price Type"; Rec."Price Type")
                {
                    ToolTip = 'Specifies the value of the Price Type field.';
                }
                // Column 10: TARIFA
                field("Rate No."; Rec."Rate No.")
                {
                    ToolTip = 'Specifies the value of the Rate No. field.';
                }
                // Column 11: FAMILIA_MODALIDAD
                field("Modality Family"; Rec."Modality Family")
                {
                    ToolTip = 'Specifies the value of the Modality Family field.';
                }
                // Full Modality Name (as imported from Excel)
                field("Full Modality Name"; Rec."Full Modality Name")
                {
                    ToolTip = 'Specifies the full modality name as imported from Excel, including version.';
                }
                // Column 12: MODALIDAD (Base name without version)
                field(Modality; Rec.Modality)
                {
                    ToolTip = 'Specifies the value of the Modality field.';
                    StyleExpr = ModalityStyleExpr;
                }
                field(Version; Rec.Version)
                {
                    ToolTip = 'Specifies the version of the modality.';
                }
                // Column 13: ANEXO
                field(Annex; Rec.Annex)
                {
                    ToolTip = 'Specifies the value of the Annex field.';
                }
                // Column 14: ANEXO_PERSONALIZADO
                field("Custom Annex"; Rec."Custom Annex")
                {
                    ToolTip = 'Specifies the value of the Custom Annex field.';
                }
                // Column 15: MODALIDAD_ACTIVACION_FUTURA
                field("Future Activation Modality"; Rec."Future Activation Modality")
                {
                    ToolTip = 'Specifies the value of the Future Activation Modality field.';
                }
                // Column 16: CODIGO_REFERENCIA_CONTRATO
                field("Contract Reference Code"; Rec."Contract Reference Code")
                {
                    ToolTip = 'Specifies the value of the Contract Reference Code field.';
                }
                // Column 16: ID_TARIFA_WS
                field("Id Rate WS"; Rec."Id Rate WS")
                {
                    ToolTip = 'Specifies the value of the Id Rate WS field.';
                }
                // Column 17: TIPO_CLIENTE_WS (no corresponding field in table)
                // Column 18: TIPO_CLIENTE
                field("Customer Type"; Rec."Customer Type")
                {
                    ToolTip = 'Specifies the value of the Customer Type field.';
                }
                // Column 19: PRECIO_ESPECIAL_PARA
                field("Special Price For"; Rec."Special Price For")
                {
                    ToolTip = 'Specifies the value of the Special Price For field.';
                }
                // Column 20: PROVINCIA
                field(Province; Rec.Province)
                {
                    ToolTip = 'Specifies the value of the Province field.';
                }
                // Column 21: GASTOS_OPERATIVOS_VISIBLES
                field("Visible Operating Costs"; Rec."Visible Operating Costs")
                {
                    ToolTip = 'Specifies the value of the Visible Operating Costs field.';
                }
                // Column 22: ESCALA_TIEMPO_GESTIONES
                field("Management Time Scale"; Rec."Management Time Scale")
                {
                    ToolTip = 'Specifies the value of the Management Time Scale field.';
                }
                // Column 23: COSTES_GESTION_EQUIPOS_MEDIDA
                field("Measurement Equip. Mngt. Costs"; Rec."Measurement Equip. Mngt. Costs")
                {
                    ToolTip = 'Specifies the value of the Measurement Equipment Management Costs field.';
                }
                // Column 24: COSTES_GESTION_MANTENIMIENTO
                field("Maintenance Management Costs"; Rec."Maintenance Management Costs")
                {
                    ToolTip = 'Specifies the value of the Maintenance Management Costs field.';
                }
                // Column 25: COSTES_CAPACIDAD
                field("Capacity Costs"; Rec."Capacity Costs")
                {
                    ToolTip = 'Specifies the value of the Capacity Costs field.';
                }
                // Column 26: COSTES_REMUNERACION_COMPANIA
                field("Company Remuneration Costs"; Rec."Company Remuneration Costs")
                {
                    ToolTip = 'Specifies the value of the Company Remuneration Costs field.';
                }
                // Column 27: COSTES_REMUNERACION_COMPANIA_BASE
                field("Base Company Rem. Costs"; Rec."Base Company Rem. Costs")
                {
                    ToolTip = 'Specifies the value of the Base Company Remuneration Costs field.';
                }
                // Column 28: COSTES_FINANCIEROS
                field("Financial Costs"; Rec."Financial Costs")
                {
                    ToolTip = 'Specifies the value of the Financial Costs field.';
                }
                // Column 29: COSTES_SGE
                field("SGE Costs"; Rec."SGE Costs")
                {
                    ToolTip = 'Specifies the value of the SGE Costs field.';
                }
                // Column 30: COSTES_SGEV
                field("SGEV Costs"; Rec."SGEV Costs")
                {
                    ToolTip = 'Specifies the value of the SGEV Costs field.';
                }
                // Column 31: KW_CONTRATADOS
                field("Contracted KW"; Rec."Contracted KW")
                {
                    ToolTip = 'Specifies the value of the Contracted KW field.';
                }
                // Column 32: DESCUENTO_GENERAL
                field("General Discount"; Rec."General Discount")
                {
                    ToolTip = 'Specifies the value of the General Discount field.';
                }
                // Column 33: BONIFICACION_POTENCIA
                field("Power Bonus"; Rec."Power Bonus")
                {
                    ToolTip = 'Specifies the value of the Power Bonus field.';
                }
                // Column 34: RECARGO_POTENCIA
                field("Power Surcharge"; Rec."Power Surcharge")
                {
                    ToolTip = 'Specifies the value of the Power Surcharge field.';
                }
                // Column 35: POTENCIA_DESDE
                field("Power From"; Rec."Power From")
                {
                    ToolTip = 'Specifies the value of the Power From field.';
                }
                // Column 36: POTENCIA_HASTA
                field("Power To"; Rec."Power To")
                {
                    ToolTip = 'Specifies the value of the Power To field.';
                }
                // Column 37: ESCALA_TIEMPO_POTENCIA
                field("Power Time Scale"; Rec."Power Time Scale")
                {
                    ToolTip = 'Specifies the value of the Power Time Scale field.';
                }
                // Column 38: DESCUENTO_PRIMER_ANIO_POTENCIA
                field("First Year Power Discount"; Rec."First Year Power Discount")
                {
                    ToolTip = 'Specifies the value of the First Year Power Discount field.';
                }
                // Columns 39-44: P1-P6
                field(P1; Rec.P1)
                {
                    ToolTip = 'Specifies the value of the P1 field.';
                }
                field(P2; Rec.P2)
                {
                    ToolTip = 'Specifies the value of the P2 field.';
                }
                field(P3; Rec.P3)
                {
                    ToolTip = 'Specifies the value of the P3 field.';
                }
                field(P4; Rec.P4)
                {
                    ToolTip = 'Specifies the value of the P4 field.';
                }
                field(P5; Rec.P5)
                {
                    ToolTip = 'Specifies the value of the P5 field.';
                }
                field(P6; Rec.P6)
                {
                    ToolTip = 'Specifies the value of the P6 field.';
                }
                // Column 45: ENERGIA_DESDE
                field("Energy From"; Rec."Energy From")
                {
                    ToolTip = 'Specifies the value of the Energy From field.';
                }
                // Column 46: ENERGIA_HASTA
                field("Energy To"; Rec."Energy To")
                {
                    ToolTip = 'Specifies the value of the Energy To field.';
                }
                // Column 47: ESCALA_ENERGIA
                field("Energy Scale"; Rec."Energy Scale")
                {
                    ToolTip = 'Specifies the value of the Energy Scale field.';
                }
                // Column 48: DESCUENTO_PRIMER_ANIO_ENERGIA
                field("First Year Energy Discount"; Rec."First Year Energy Discount")
                {
                    ToolTip = 'Specifies the value of the First Year Energy Discount field.';
                }
                // Columns 49-54: E1-E6
                field(E1; Rec.E1)
                {
                    ToolTip = 'Specifies the value of the E1 field.';
                }
                field(E2; Rec.E2)
                {
                    ToolTip = 'Specifies the value of the E2 field.';
                }
                field(E3; Rec.E3)
                {
                    ToolTip = 'Specifies the value of the E3 field.';
                }
                field(E4; Rec.E4)
                {
                    ToolTip = 'Specifies the value of the E4 field.';
                }
                field(E5; Rec.E5)
                {
                    ToolTip = 'Specifies the value of the E5 field.';
                }
                field(E6; Rec.E6)
                {
                    ToolTip = 'Specifies the value of the E6 field.';
                }
                // Columns 55-126: Historical index fields (INDEX_P1_MES_12...INDEX_P6_MES_1)
                // Note: Historical data is stored in separate SUC Historical Prices table

                // Additional fields for processing
                field("Processing Date"; Rec."Processing Date")
                {
                    ToolTip = 'Specifies the date when this record was processed from Excel.';
                    Visible = false;
                }
                field("Potency Upper"; Rec."Potency Upper")
                {
                    ToolTip = 'Specifies the value of the Potency Upper field.';
                    Visible = false;
                }
                field("Potency Lower"; Rec."Potency Lower")
                {
                    ToolTip = 'Specifies the value of the Potency Lower field.';
                    Visible = false;
                }
                field("Rate Type"; Rec."Rate Type Contract")
                {
                    ToolTip = 'Specifies the value of the Rate Type field.';
                    Visible = false;
                }
                field("GOs Visible"; Rec."GOs Visible")
                {
                    ToolTip = 'Specifies the value of the GOs Visible field.';
                    Visible = false;
                }
                field(Discount; Rec.Discount)
                {
                    ToolTip = 'Specifies the value of the Discount field.';
                    Visible = false;
                }
                field(Maintenance; Rec.Maintenance)
                {
                    ToolTip = 'Specifies the value of the Maintenance field.';
                    Visible = false;
                }
                field(SGE; Rec.SGE)
                {
                    ToolTip = 'Specifies the value of the SGE field.';
                    Visible = false;
                }
                field(SGEV; Rec.SGEV)
                {
                    ToolTip = 'Specifies the value of the SGEV field.';
                    Visible = false;
                }
                field(Remuneration; Rec.Remuneration)
                {
                    ToolTip = 'Specifies the value of the Remuneration field.';
                    Visible = false;
                }
                field("Imported File Name"; Rec."Imported File Name")
                {
                    ToolTip = 'Specifies the name of the imported Excel file.';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies if this price control record is active.';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Data Management")
            {
                Caption = 'Data Management';
                Image = Database;
                action("Import Excel")
                {
                    Caption = 'Import Excel Files';
                    ApplicationArea = All;
                    Image = Import;
                    ToolTip = 'Executes the Import Excel Files action.';
                    trigger OnAction()
                    var
                        SUCControlPricesEnergy: Record "SUC Control Prices Energy";
                    begin
                        SUCControlPricesEnergy.ProcessExcel();
                    end;
                }
            }
            group("Historical Data")
            {
                Caption = 'Historical Data';
                Image = History;
                action("Historical Prices")
                {
                    Caption = 'Historical Prices for Record';
                    ApplicationArea = All;
                    Image = Price;
                    ToolTip = 'Shows historical index prices for the selected record.';

                    trigger OnAction()
                    var
                        HistoricalPrices: Record "SUC Historical Prices";
                        HistoricalPricesPage: Page "SUC Historical Prices";
                    begin
                        HistoricalPrices.Reset();
                        HistoricalPrices.SetRange("Control Prices Id.", Rec."Id.");
                        HistoricalPricesPage.SetTableView(HistoricalPrices);
                        HistoricalPricesPage.Run();
                    end;
                }
                action("All Historical Prices")
                {
                    Caption = 'All Historical Prices';
                    ApplicationArea = All;
                    Image = DataEntry;
                    ToolTip = 'Shows all historical index prices across all records.';
                    trigger OnAction()
                    var
                        HistoricalPricesPage: Page "SUC Historical Prices";
                    begin
                        HistoricalPricesPage.Run();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStyleExpressions();
    end;

    local procedure SetStyleExpressions()
    var
        SUCOmipRates: Record "SUC Omip Rates";
        SUCContractModalities: Record "SUC Contract Modalities";
    begin
        // Validate Rate No.
        RateStyleExpr := '';
        if Rec."Rate No." <> '' then begin
            SUCOmipRates.Reset();
            SUCOmipRates.SetRange(Code, Rec."Rate No.");
            if SUCOmipRates.IsEmpty() then
                RateStyleExpr := 'Attention';
        end;

        // Validate Modality
        ModalityStyleExpr := '';
        if Rec.Modality <> '' then begin
            SUCContractModalities.Reset();
            SUCContractModalities.SetRange(Name, Rec.Modality);
            SUCContractModalities.SetRange("Marketer No.", Rec."Marketer No.");
            SUCContractModalities.SetRange("Energy Type", Rec."Energy Type");
            if SUCContractModalities.IsEmpty() then
                ModalityStyleExpr := 'Attention';
        end;
    end;

    var
        RateStyleExpr: Text;
        ModalityStyleExpr: Text;
}