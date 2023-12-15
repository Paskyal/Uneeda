tableextension 50071 "NV8 Warehouse Entry" extends "Warehouse Entry" //7312
{
    fields
    {
        field(50000; "NV8 External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            Description = 'UE-524';
            DataClassification = CustomerContent;
        }
        field(68110; "NV8 Roll ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(85019; "NV8 Jumbo Pull"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85026; "NV8 FIFO Code"; Code[7])
        {
            DataClassification = CustomerContent;
        }
        field(85027; "NV8 FIFO Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(85040; "NV8 Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
        }
        field(85050; "NV8 Pieces"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'ECMISC';
            DataClassification = CustomerContent;
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'ECMISC';
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Temp: Decimal;
            begin
            end;
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'ECMISC';
            DataClassification = CustomerContent;
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            BlankZero = true;
            DataClassification = CustomerContent;
        }
        field(85054; "NV8 Unit Area m2"; Decimal)
        {
            BlankZero = true;
            Description = 'Width / 36 x Length';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85058; "NV8 Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'ECMISC';
            DataClassification = CustomerContent;
        }
        field(85060; "NV8 Remaining Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(85062; "NV8 Remaining Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Error on decimals';
            DataClassification = CustomerContent;
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85065; "NV8 Remaining Area m2"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'Error on decimals';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85100; "NV8 Configurator No."; Code[100])
        {
            TableRelation = "Configurator Item" where(Status = filter(Item .. "Valid Item"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(85110; "NV8 Shape"; Code[10])
        {
            TableRelation = "Configurator Shape";
            DataClassification = CustomerContent;
        }
        field(85120; "NV8 Material"; Code[10])
        {
            TableRelation = "Configurator Material";
            DataClassification = CustomerContent;
        }
        field(85180; "NV8 Grit"; Code[10])
        {
            TableRelation = "Configurator Grit";
            DataClassification = CustomerContent;
        }
        field(90001; "NV8 Lot Group Code"; Code[20])
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
        }
        field(90002; "NV8 Lot Open in Bin"; Boolean)
        {
            Description = 'UE-407 Field updated by process report';
            DataClassification = CustomerContent;
        }
        field(91000; "NV8 Lot Processed"; Boolean)
        {
            Description = 'UE-559';
            DataClassification = CustomerContent;
        }
        field(91100; "NV8 Lot Creation Date"; Date)
        {
            CalcFormula = lookup("Lot No. Information"."Creation Date" where("Item No." = field("Item No."),
                                                                              "Lot No." = field("Lot No.")));
            Description = 'UE-606';
            FieldClass = FlowField;
        }
    }
}
