tableextension 50062 "NV8 Value Entry" extends "Value Entry" //5802
{
    fields
    {
        field(51002; "NV8 Web"; Boolean)
        {
            Description = 'UE-657';
            DataClassification = CustomerContent;
        }
        field(85000; "NV8 Customer Name"; Text[50])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Source No.")));
            Description = 'UE-651';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85005; "NV8 Vendor Name"; Text[30])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Source No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85008; "NV8 Item Description"; Text[50])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Description = 'UE-651';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85009; "NV8 Item Source"; Text[50])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Source No.")));
            Description = 'UE-651';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85010; "NV8 Item Description 2"; Text[50])
        {
            CalcFormula = lookup(Item."Description 2" where("No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85064; "NV8 Configurator No."; Code[100])
        {
            CalcFormula = lookup(Item."Configurator No." where("No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85202; "NV8 Purchase Direct Cost"; Decimal)
        {
            AutoFormatExpression = "Purchase Currency Code";
            AutoFormatType = 2;
            BlankZero = true;
            CalcFormula = lookup("Purch. Inv. Line"."Direct Unit Cost" where("Document No." = field("Document No."),
                                                                              Type = const(Item),
                                                                              "No." = field("Item No."),
                                                                              Quantity = field("Invoiced Quantity")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85203; "NV8 Purchase Currency Code"; Code[10])
        {
            CalcFormula = lookup("Purch. Inv. Header"."Currency Code" where("No." = field("Document No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Currency;
        }
        field(85204; "NV8 Purchase Cost Per Meter"; Decimal)
        {
            AutoFormatExpression = "Purchase Currency Code";
            AutoFormatType = 2;
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
    }
}
