Table 50029 "NV8 Customer Source Code"
{
    DrillDownPageID = UnknownPage50060;
    LookupPageID = UnknownPage50060;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Source Code"; Code[10])
        {
        }
        field(2; "Source Description"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Source Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

