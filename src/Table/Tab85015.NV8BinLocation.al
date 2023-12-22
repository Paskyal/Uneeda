Table 85015 "NV8 Bin Location"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(2; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(100; "No Of Different Items in Bin"; Integer)
        {
            BlankZero = true;
            CalcFormula = count("Item Ledger Entry" where(Open = const(true),
                                                           Positive = const(true),
                                                           "Location Code" = field("Location Code"),
                                                           "NV8 Bin Location" = field(Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(1000; "Jumbo Pull Not Required"; Boolean)
        {
        }
        field(84011; "Bin Type"; Option)
        {
            OptionMembers = PutAway,Staging,Inactive;
        }
    }

    keys
    {
        key(Key1; "Location Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

