Table 50014 "NV8 Partial Prod. Order Print"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Prod. Order No."; Code[20])
        {
        }
        field(2; "Date Printed"; Date)
        {
        }
        field(3; "Time Printed"; Time)
        {
        }
        field(4; "USERID Printed"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Prod. Order No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

