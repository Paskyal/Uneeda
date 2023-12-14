Table 68001 "NV8 Temp Table - Item Stat"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Unit cost"; Decimal)
        {
            DecimalPlaces = 4 : 4;
        }
        field(2; "Entry Number"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Unit cost", "Entry Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

