Table 50001 "NV8 Customer Stocking Agr"
{
    DataClassification = CustomerContent;
    // UE-475  DB  5/16/16 Add Name & Edited by/on fields and link Customer No to Customer table

    // DrillDownPageID = UnknownPage50001;
    // LookupPageID = UnknownPage50001;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Description = 'PK,UE-475';
            TableRelation = Customer;
        }
        field(2; "Location Code"; Code[10])
        {
            Description = 'PK';
            TableRelation = Location;
        }
        field(3; "Item No."; Code[20])
        {
            Description = 'PK';
            TableRelation = Item;

            // trigger OnValidate()  PAP uncomment
            // begin
            //     Item.Get("Item No.");
            //     Description := Item.Description;
            //     "Description 2" := Item."Description 2";
            //     "Configurator No." := Item."Configurator No.";
            // end;
        }
        field(10; Quantity; Decimal)
        {
        }
        field(20; "Starting Date"; Date)
        {
        }
        field(30; "Unit of Measure"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(40; Description; Text[50])
        {
        }
        field(41; "Description 2"; Text[50])
        {
        }
        field(50; "Configurator No."; Text[100])
        {
            // TableRelation = "Configurator Item"."Configurator No."; //PAP Uncomment

            // trigger OnValidate() //TODO PAP Uncomment
            // var
            //     ConfigItem: Record "Configurator Item";
            // begin
            //     if ConfigItem.Get("Configurator No.") then
            //         Validate("Item No.", ConfigItem."Item No.");
            // end;
        }
        field(60; "Total Length (Meters)"; Decimal)
        {
        }
        field(61; "Customer Name"; Text[50])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Description = 'UE-475';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Customer Name 2"; Text[50])
        {
            CalcFormula = lookup(Customer."Name 2" where("No." = field("Customer No.")));
            Description = 'UE-475';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Last Edited By"; Code[50])
        {
            Description = 'UE-475';
            Editable = false;
        }
        field(64; "Last Edited On"; Date)
        {
            Description = 'UE-475';
            Editable = false;
        }
        field(65; Comments; Text[30])
        {
        }
        field(80; "Prior Stock Quantity"; Text[30])
        {
            Description = 'DC010318';
        }
        field(81; "Qty on Hand"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."),
                                                                  "Location Code" = field("Location Code"),
                                                                  "Drop Shipment" = const(false)));
            DecimalPlaces = 0 : 5;
            Description = 'DC092221,UNE-116';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Location Code", "Item No.", "Starting Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //>> UE-475
        if ("Last Edited By" <> UserId) or ("Last Edited On" <> Today) then begin
            "Last Edited By" := UserId;
            "Last Edited On" := Today;
        end;
        //<< UE-475
    end;

    var
        Item: Record Item;
}

