Table 50000 "NV8 Special Price"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Description = 'PK';
            TableRelation = Customer;
        }
        field(2; "Special Price Code"; Code[10])
        {
            Description = 'PK';
        }
        field(10; Description; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Special Price Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

