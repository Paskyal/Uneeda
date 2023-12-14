Table 50028 "NV8 keComTrackModification"
{
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Table ID"; Integer)
        {
        }
        field(3; "Code"; Text[250])
        {
        }
        field(4; ModifiedDate; DateTime)
        {
        }
        field(5; RecordID; RecordID)
        {
        }
    }

    keys
    {
        key(Key1; "Table ID", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

