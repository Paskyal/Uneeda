Table 50018 "NV8 Fractional Conversion"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; "Fraction Equivalent"; Text[30])
        {
        }
        field(3; "Decimal Equivalent"; Decimal)
        {
            DecimalPlaces = 6 : 6;
        }
        field(4; "Rounded Decimal"; Decimal)
        {
            DecimalPlaces = 2 : 2;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

