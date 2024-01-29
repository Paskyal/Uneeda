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
            Caption = 'Roll ID';
        }
        field(85019; "NV8 Jumbo Pull"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Jumbo Pull';
        }
        field(85026; "NV8 FIFO Code"; Code[7])
        {
            DataClassification = CustomerContent;
            Caption = 'FIFO Code';
        }
        field(85027; "NV8 FIFO Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'FIFO Date';
        }
        field(85040; "NV8 Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
            Caption = 'Material Type';
        }
        field(85050; "NV8 Pieces"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'ECMISC';
            DataClassification = CustomerContent;
            Caption = 'Pieces';
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'ECMISC';
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Unit Width Inches';
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
            Caption = 'Unit Length meters';
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            BlankZero = true;
            DataClassification = CustomerContent;
            Caption = 'Unit Length Inches';
        }
        field(85054; "NV8 Unit Area m2"; Decimal)
        {
            BlankZero = true;
            Description = 'Width / 36 x Length';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Unit Area m2';
        }
        field(85058; "NV8 Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'ECMISC';
            DataClassification = CustomerContent;
            Caption = 'Total Length meters';
        }
        field(85060; "NV8 Remaining Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Remaining Pieces';
        }
        field(85062; "NV8 Remaining Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Error on decimals';
            DataClassification = CustomerContent;
            Caption = 'Remaining Length meters';
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Total Area m2';
        }
        field(85065; "NV8 Remaining Area m2"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'Error on decimals';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Remaining Area m2';
        }
        field(85100; "NV8 Configurator No."; Code[100])
        {
            TableRelation = "NV8 Configurator Item" where(Status = filter(Item .. "Valid Item"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Configurator No.';
        }
        field(85110; "NV8 Shape"; Code[10])
        {
            TableRelation = "NV8 Configurator Shape";
            DataClassification = CustomerContent;
            Caption = 'Shape';
        }
        field(85120; "NV8 Material"; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
            DataClassification = CustomerContent;
            Caption = 'Material';
        }
        field(85180; "NV8 Grit"; Code[10])
        {
            TableRelation = "NV8 Configurator Grit";
            DataClassification = CustomerContent;
            Caption = 'Grit';
        }
        field(90001; "NV8 Lot Group Code"; Code[20])
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'Lot Group Code';
        }
        field(90002; "NV8 Lot Open in Bin"; Boolean)
        {
            Description = 'UE-407 Field updated by process report';
            DataClassification = CustomerContent;
            Caption = 'Lot Open in Bin';
        }
        field(91000; "NV8 Lot Processed"; Boolean)
        {
            Description = 'UE-559';
            DataClassification = CustomerContent;
            Caption = 'Lot Processed';
        }
        field(91100; "NV8 Lot Creation Date"; Date)
        {
            CalcFormula = lookup("Lot No. Information"."NV8 Creation Date" where("Item No." = field("Item No."),
                                                                              "Lot No." = field("Lot No.")));
            Description = 'UE-606';
            FieldClass = FlowField;
            Caption = 'Lot Creation Date';
        }
    }
}
