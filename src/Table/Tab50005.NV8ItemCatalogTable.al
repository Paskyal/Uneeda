Table 50005 "NV8 Item Catalog Table"
{
    // DrillDownPageID = UnknownPage50015; //TODO PAP
    // LookupPageID = UnknownPage50015;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Catalog No."; Code[20])
        {
        }
        field(2; "Item No."; Code[20])
        {
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                if Item.Get("Item No.") then begin
                    Description := Item.Description;
                    "Description 2" := Item."Description 2";
                end;
            end;
        }
        field(3; Description; Text[50])
        {
        }
        field(4; "Description 2"; Text[50])
        {
        }
    }

    keys
    {
        key(Key1; "Catalog No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
}

