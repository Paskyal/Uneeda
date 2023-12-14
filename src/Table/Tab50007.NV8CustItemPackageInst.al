Table 50007 "NV8 Cust. Item Package Inst"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            TableRelation = Customer."No.";
        }
        field(2; "Item No."; Code[20])
        {
        }
        field(3; Instructions; Text[80])
        {
        }
    }

    keys
    {
        key(Key1; "Customer No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

