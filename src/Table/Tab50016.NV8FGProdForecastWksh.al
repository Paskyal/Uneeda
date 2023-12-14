Table 50016 "NV8 FG Prod. Forecast Wksh"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Description = 'EC VAR003';
        }
        field(2; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(3; "Location Code"; Code[10])
        {
        }
        field(4; "Qty. on Hand"; Decimal)
        {
        }
        field(5; "P1 Usage"; Decimal)
        {
        }
        field(6; "P2 Usage"; Decimal)
        {
        }
        field(7; "P3 Usage"; Decimal)
        {
        }
        field(8; "P4 Usage"; Decimal)
        {
        }
        field(9; "P5 Usage"; Decimal)
        {
        }
        field(10; "P6 Usage"; Decimal)
        {
        }
        field(11; "P7 Usage"; Decimal)
        {
        }
        field(12; "P8 Usage"; Decimal)
        {
        }
        field(13; "P9 Usage"; Decimal)
        {
        }
        field(14; "P10 Usage"; Decimal)
        {
        }
        field(15; "P11 Usage"; Decimal)
        {
        }
        field(16; "P12 Usage"; Decimal)
        {
        }
        field(17; "New Forecast Qty."; Decimal)
        {
        }
        field(18; "Forecast Period"; Option)
        {
            OptionCaption = 'Day,Week,Month,Quarter,Year';
            OptionMembers = Day,Week,Month,Quarter,Year;
        }
        field(19; "Forecast Length"; DateFormula)
        {
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

