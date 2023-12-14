Table 50022 "NV8 Lot No Allocations"
{
    DrillDownPageID = UnknownPage50034;
    LookupPageID = UnknownPage50034;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
            NotBlank = true;
            TableRelation = "Lot No. Information"."Lot No.";
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            NotBlank = true;
            TableRelation = "Production Order"."No.";
        }
        field(5; "DateTime Added"; DateTime)
        {
        }
    }

    keys
    {
        key(Key1; "Lot No.", "Prod. Order No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "DateTime Added" := CurrentDatetime;
    end;
}

