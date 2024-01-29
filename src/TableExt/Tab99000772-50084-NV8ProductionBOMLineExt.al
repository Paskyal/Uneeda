tableextension 50084 "NV8 Production BOM Line" extends "Production BOM Line" //99000772
{
    // TODO PAP Uncomment triggers
    fields
    {
        field(85000; "NV8 ConfiguratorCalc.perMeter"; Option)
        {
            DataClassification = CustomerContent;
            Description = 'EC1.INV4.01';
            OptionMembers = " ",Factor,FactorxD1,FactorxD2,FactorxD1xD2,"FactorxD1^2";
            Caption = 'ConfiguratorCalc.perMeter';
        }
        field(85001; "NV8 Configurator Type"; Option)
        {
            DataClassification = CustomerContent;
            Description = 'EC1.INV4.01';
            OptionMembers = "BOM Line",Configurator,"Material-Grit","New Raw Material";
            Caption = 'Configurator Type';

            // trigger OnValidate()
            // begin
            //     case "Configurator Type" of
            //         "configurator type"::"BOM Line":
            //             begin
            //                 if "Configurator Calc. per Meter" <> "configurator calc. per meter"::" " then
            //                     "Configurator Calc. per Meter" := "configurator calc. per meter"::" ";
            //                 TestField("Configurator Factor", 0);
            //             end;
            //         "configurator type"::Configurator:
            //             begin
            //                 if "Configurator Calc. per Meter" = "configurator calc. per meter"::" " then
            //                     "Configurator Calc. per Meter" := "configurator calc. per meter"::Factor;
            //                 TestField("Quantity per", 0);
            //             end;
            //         "configurator type"::"Material-Grit":
            //             begin
            //                 Validate(Type, Type::" ");
            //                 "No." := '';
            //                 "Configurator Type" := "configurator type"::"Material-Grit";
            //                 if "Configurator Calc. per Meter" = "configurator calc. per meter"::" " then
            //                     "Configurator Calc. per Meter" := "configurator calc. per meter"::Factor;
            //                 TestField("Quantity per", 0);
            //             end;
            //     end;
            // end;
        }
        field(85010; "NV8 Configurator Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Description = 'EC1.INV4.01';
            Caption = 'Configurator Factor';
            trigger OnValidate()
            begin
                if "NV8 Qty. per Unit of Measure" = 0 then
                    "NV8 Configurator Factor (Base)" := "NV8 Configurator Factor"
                else
                    "NV8 Configurator Factor (Base)" := ROUND("NV8 Configurator Factor" * "NV8 Qty. per Unit of Measure", 0.00001);
            end;
        }
        field(85080; "NV8 Comp. Standard Cost"; Decimal)
        {
            CalcFormula = lookup(Item."Standard Cost" where("No." = field("No.")));
            DecimalPlaces = 2 : 5;
            Description = 'EC1.INV4.01';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Comp. Standard Cost';
        }
        field(85081; "NV8 Standard Cost per"; Decimal)
        {
            BlankZero = true;
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Description = 'EC1.INV4.01';
            Caption = 'Standard Cost per';
        }
        field(85100; "NV8 Qty. per Unit of Measure"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Description = 'EC1.INV4.01';
            Editable = false;
            Caption = 'Qty. per Unit of Measure';
        }
        field(85101; "NV8 Quantity (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Description = 'EC1.INV4.01';
            Caption = 'Quantity (Base)';
        }
        field(85102; "NV8 Configurator Factor (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Description = 'EC1.INV4.01';
            Caption = 'Configurator Factor (Base)';
        }
        field(85410; "NV8 Raw Material Cost (/UOM)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 5;
            Description = 'EC1.INV4.01';
            Caption = 'Raw Material Cost (/UOM)';
        }
    }
}
