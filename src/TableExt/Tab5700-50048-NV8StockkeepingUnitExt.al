tableextension 50048 "NV8 Stockkeeping Unit" extends "Stockkeeping Unit" //5700
{
    fields
    {
        field(50000; "NV8 Qty. on Transfer Order"; Decimal)
        {
            CalcFormula = sum("Transfer Line"."Outstanding Qty. (Base)" where("Item No." = field("Item No."),
                                                                               "Variant Code" = field("Variant Code")));
            DecimalPlaces = 0 : 5;
            Description = 'EC VAR003';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "NV8 Customer Stock Agreement"; Decimal)
        {
            CalcFormula = sum("Customer Stocking Agreements".Quantity where("Location Code" = field("Location Code"),
                                                                             "Item No." = field("Item No.")));
            Description = 'UE-438';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50050; "NV8 Reorder Point History"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."),
                                                                  "Variant Code" = field("Variant Code"),
                                                                  "Location Code" = field("Location Code"),
                                                                  Positive = const(false),
                                                                  "Posting Date" = field("Reorder Date Filter"),
                                                                  "Entry Type" = field("Reorder Entry Type Filter")));
            DecimalPlaces = 0 : 0;
            Description = 'UE-438,UE-474';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50051; "NV8 Max Inventory History"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."),
                                                                  "Variant Code" = field("Variant Code"),
                                                                  "Location Code" = field("Location Code"),
                                                                  Positive = const(false),
                                                                  "Posting Date" = field("Max Date Filter"),
                                                                  "Entry Type" = field("Reorder Entry Type Filter")));
            DecimalPlaces = 0 : 0;
            Description = 'UE-438,UE-474';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50052; "NV8 Exclude from Max Update"; Boolean)
        {
            Description = 'UE-438';
            DataClassification = CustomerContent;
        }
        field(50060; "NV8 Def.Reorder Calculation Option"; Option)
        {
            CalcFormula = lookup("Configurator Shape"."Def.Reorder Calculation Option" where(Code = field(Shape)));
            Description = 'UE-438';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'All(S-T-AC),Sale,Transfer';
            OptionMembers = "All(S-T-AC)",Sale,Transfer;
        }
        field(50061; "NV8 Reorder Calculation Option"; Option)
        {
            Description = 'UE-438';
            FieldClass = Normal;
            OptionCaption = ' ,All(S-T-AC),Sale,Transfer';
            OptionMembers = " ","All(S-T-AC)",Sale,Transfer;
            DataClassification = CustomerContent;
        }
        field(50062; "NV8 Reorder Date Filter"; Date)
        {
            Description = 'UE-438';
            FieldClass = FlowFilter;
        }
        field(50063; "NV8 Max Date Filter"; Date)
        {
            Description = 'UE-438';
            FieldClass = FlowFilter;
        }
        field(50064; "NV8 Reorder Entry Type Filter"; Option)
        {
            Caption = 'Reorder Entry Type Filter';
            Description = 'UE-438';
            FieldClass = FlowFilter;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(68001; "NV8 Max Inventory Formula"; DateFormula)
        {
            Description = 'UE-438';
            DataClassification = CustomerContent;
        }
        field(68002; "NV8 Reorder Point Formula"; DateFormula)
        {
            Description = 'UE-438';
            DataClassification = CustomerContent;
        }
        field(68005; "NV8 Def. Max Inventory Formula"; DateFormula)
        {
            CalcFormula = lookup("Configurator Shape"."Def. Safety Stock Formula" where(Code = field(Shape)));
            Description = 'UE-438';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68006; "NV8 Def. Reorder Point Formula"; DateFormula)
        {
            CalcFormula = lookup("Configurator Shape"."Def. Reorder Point Formula" where(Code = field(Shape)));
            Description = 'UE-438';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85110; "NV8 Shape"; Code[10])
        {
            Description = 'UE-438';
            Editable = false;
            TableRelation = "Configurator Shape";
            DataClassification = CustomerContent;
        }
    }
}
