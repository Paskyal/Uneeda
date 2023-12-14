Table 50023 "NV8 Customer First Sale Query"
{
    DataClassification = CustomerContent;
    // UE-617  DB  10/27/17  Customer First Sales Query


    fields
    {
        field(1; "Customer No."; Code[20])
        {
            TableRelation = Customer;
        }
        field(2; "First Invoice No."; Code[20])
        {
            TableRelation = "Cust. Ledger Entry"."Document No." where("Document Type" = const(Invoice));
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; "Customer Name"; Text[50])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Editable = false;
            FieldClass = FlowField;
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

