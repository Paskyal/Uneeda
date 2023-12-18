Table 50015 "NV8 Bin Content Buff-Uneeda"
{
    Caption = 'Bin Content Buffer - Uneeda';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            NotBlank = true;
            TableRelation = Location;
        }
        field(2; "Zone Code"; Code[10])
        {
            Caption = 'Zone Code';
            NotBlank = true;
            TableRelation = Zone.Code where("Location Code" = field("Location Code"));
        }
        field(3; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            NotBlank = true;
            TableRelation = if ("Zone Code" = filter('')) Bin.Code where("Location Code" = field("Location Code"))
            else
            if ("Zone Code" = filter(<> '')) Bin.Code where("Location Code" = field("Location Code"),
                                                                               "Zone Code" = field("Zone Code"));
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(5; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(6; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(10; Cubage; Decimal)
        {
            Caption = 'Cubage';
            DecimalPlaces = 0 : 5;
        }
        field(11; Weight; Decimal)
        {
            Caption = 'Weight';
            DecimalPlaces = 0 : 5;
        }
        field(12; "Base Unit of Measure"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(50; "Qty. to Handle (Base)"; Decimal)
        {
            Caption = 'Qty. to Handle (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(51; "Qty. Outstanding (Base)"; Decimal)
        {
            Caption = 'Qty. Outstanding (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(6500; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }
        field(6501; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
        }
        field(68110; "Roll ID"; Code[20])
        {
            Description = 'EC1.MFG04.01';
        }
        field(85019; "Jumbo Pull"; Boolean)
        {
        }
        field(85026; "FIFO Code"; Code[7])
        {
        }
        field(85027; "FIFO Date"; Date)
        {
        }
        field(85040; "Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
        }
        field(85050; Pieces; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'ECMISC';
        }
        field(85051; "Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'ECMISC';
            MaxValue = 999;
            MinValue = 0;

            trigger OnValidate()
            var
                Temp: Decimal;
            begin
            end;
        }
        field(85052; "Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'ECMISC';
        }
        field(85053; "Unit Length Inches"; Decimal)
        {
            BlankZero = true;
        }
        field(85054; "Unit Area m2"; Decimal)
        {
            BlankZero = true;
            Description = 'Width / 36 x Length';
            Editable = false;
        }
        field(85058; "Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'ECMISC';
        }
        field(85060; "Remaining Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85062; "Remaining Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Error on decimals';
        }
        field(85064; "Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
        }
        field(85065; "Remaining Area m2"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'Error on decimals';
            Editable = false;
        }
        field(85100; "Configurator No."; Code[100])
        {
            TableRelation = "NV8 Configurator Item" where(Status = filter(Item .. "Valid Item"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(85110; Shape; Code[10])
        {
            TableRelation = "NV8 Configurator Shape";
        }
        field(85120; Material; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
        }
        field(85180; Grit; Code[10])
        {
            TableRelation = "NV8 Configurator Grit";
        }
    }

    keys
    {
        key(Key1; "Location Code", "Bin Code", "Item No.", "Variant Code", "Unit of Measure Code", "Unit Length Inches", "Unit Width Inches", Pieces, "Lot No.", "Serial No.", "Roll ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

