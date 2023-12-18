tableextension 50083 "NV8 Production BOM Header" extends "Production BOM Header" //99000770
{
    fields
    {
        field(85001; "NV8 Configurator Type"; Option)
        {
            DataClassification = CustomerContent;
            Description = 'EC1.INV4.01';
            OptionMembers = "BOM Line",Configurator,"Material-Grit";
        }
        field(85081; "NV8 Standard Cost per BOM"; Decimal)
        {
            BlankZero = true;
            // CalcFormula = sum("Production BOM Line".Field29308100 where("Production BOM No." = field("No.")));//TODO PAP
            DecimalPlaces = 2 : 5;
            Description = 'EC1.INV4.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85100; "NV8 Assigned to Item No."; Code[20])
        {
            CalcFormula = lookup(Item."No." where("Production BOM No." = field("No.")));
            Description = 'EC1.INV4.01';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
