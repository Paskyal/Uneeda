Table 50010 "NV8 User Location Access"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Description = 'PK';
        }
        field(2; "Location Code"; Code[10])
        {
            Description = 'PK';
            TableRelation = Location;
        }
        field(10; "Transfer Shipment"; Boolean)
        {
        }
        field(20; "Transfer Receipt"; Boolean)
        {
        }
        field(30; "Sales Shipment"; Boolean)
        {
        }
        field(40; "Purchase Receipt"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "User ID", "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

