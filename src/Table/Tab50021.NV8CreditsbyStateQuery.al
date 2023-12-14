Table 50021 "NV8 Credits by State Query"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Ship-To Name"; Text[50])
        {
        }
        field(3; "Ship-To City"; Text[30])
        {
        }
        field(4; "Ship-To State"; Text[30])
        {
        }
        field(5; "Item No."; Code[20])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Posting Date"; Date)
        {
        }
        field(8; "Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

