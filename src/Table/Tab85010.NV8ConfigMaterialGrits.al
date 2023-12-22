Table 85010 "NV8 Config Material-Grits"
{
    // UE-106  08.31.15 Added new fields
    // EC1.    DB  9/15/15 Corrected Flowfield property for
    //             - Jumbo Rolls on Hand to be Remaining Pieces
    //             - Jumbo Rolls on Hand (OCEAN)
    // UNE-151  DB  10/13/2021  Change Flowfield for Jumbo Rolls on Hange to Pieces and change option to blank first
    // UNE-151 DC 12-21-21
    //   - Change Raw Material M. on Hand to use Material and Grit Code
    //   - Chane to IF statment

    // TODO PAP
    // DrillDownPageID = UnknownPage85020;
    // LookupPageID = UnknownPage85020;
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Material Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = "NV8 Configurator Material";
        }
        field(3; "Grit Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = "NV8 Configurator Grit";
        }
        field(10; Description; Text[30])
        {
        }
        field(11; "Description 2"; Text[30])
        {
        }
        field(50; "Default Routing No."; Code[20])
        {
            TableRelation = "Routing Header";
        }
        field(55; "Default BOM No."; Code[20])
        {
            TableRelation = "Production BOM Header";

            trigger OnValidate()
            var
                MfgSetup: Record "Manufacturing Setup";
                ProdBOMHeader: Record "Production BOM Header";
                CalcLowLevel: Codeunit "Calculate Low-Level Code";
            begin
            end;
        }
        field(90; "Material Item No."; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                if "Material Item No." = '' then begin
                    "Material Configurator No." := '';
                    exit;
                end;
                Item.Get("Material Item No.");
                "Material Configurator No." := Item."NV8 Configurator No.";
                Item."NV8 Raw Material Roll" := true;
                Item.Modify();
            end;
        }
        field(91; "Material Configurator No."; Code[100])
        {
            TableRelation = "NV8 Configurator Item";

            trigger OnValidate()
            begin
                ConfiguratorItem.Get("Material Configurator No.");
                "Material Item No." := ConfiguratorItem."Item No.";
                if "Material Item No." = '' then
                    exit;
                Item.Get("Material Item No.");
                Item."NV8 Raw Material Roll" := true;
                Item.Modify();
            end;
        }
        field(95; "Creating Raw Material Item"; Boolean)
        {
        }
        field(150; "Jumbo Pull Formula"; DateFormula)
        {
            CalcFormula = lookup("NV8 Configurator Material"."Jumbo Pull Formula" where(Code = field("Material Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(151; "Jumbo Pull Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(160; "Jumbo Pull M2 for period"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Total Area m2" where("NV8 Material" = field("Material Code"),
                                                                         "NV8 Grit" = field("Grit Code"),
                                                                         "Location Code" = const('AA-FLOOR'),
                                                                         Positive = const(true),
                                                                         "NV8 Jumbo Pull" = const(true),
                                                                         "Posting Date" = field("Jumbo Pull Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(161; "Jumbo Pull Len. M for period"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Total Length meters" where("NV8 Material" = field("Material Code"),
                                                                               "NV8 Grit" = field("Grit Code"),
                                                                               "Location Code" = const('AA-FLOOR'),
                                                                               Positive = const(true),
                                                                               "NV8 Jumbo Pull" = const(true),
                                                                               "Posting Date" = field("Jumbo Pull Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(170; "Sales M2 for period"; Decimal)
        {
            CalcFormula = - sum("Item Ledger Entry"."NV8 Total Area m2" where("Entry Type" = const(Sale),
                                                                          "NV8 Material" = field("Material Code"),
                                                                          "NV8 Grit" = field("Grit Code"),
                                                                          "Posting Date" = field("Jumbo Pull Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(171; "Sales Len. M for period"; Decimal)
        {
            CalcFormula = - sum("Item Ledger Entry"."NV8 Total Length meters" where("Entry Type" = const(Sale),
                                                                                "NV8 Material" = field("Material Code"),
                                                                                "NV8 Grit" = field("Grit Code"),
                                                                                "Posting Date" = field("Jumbo Pull Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(1000; "Quantity On Hand"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Item Ledger Entry".Quantity where("NV8 Material" = field("Material Code"),
                                                                  "NV8 Grit" = field("Grit Code")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(1100; "Raw Material Cost (/m2)"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(68010; "Tertial Start Date"; Date)
        {
            TableRelation = Date."Period Start" where("Period Type" = const(Month));
        }
        field(68015; "Tertial Meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(68020; "Vendor Classification"; Option)
        {
            OptionMembers = " ",A,B,C;

            trigger OnValidate()
            begin
                if Item.Get("Material Item No.") then begin
                    Item."NV8 Vendor Classification" := "Vendor Classification";
                    Item.Modify();
                end;
            end;
        }
        field(68055; "Set Raw Material Status"; Option)
        {
            Description = 'UNE-151';
            OptionCaption = ' ,Normal,Low,Jumbo Out,Out,Discontinued';
            OptionMembers = " ",Normal,Low,"Jumbo Out",Out,Discontinued;
        }
        field(85066; Blocked; Boolean)
        {
        }
        field(85070; "Jumbo Low Threshold"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 0;

            trigger OnValidate()
            begin
                UpdateRawMaterialStatus();
            end;
        }
        field(85100; "Standard Cost"; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup(Item."Standard Cost" where("No." = field("Material Item No.")));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85164; "Jumbo Meters on Hand (UNY)"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Unit Length meters" where("Item No." = field("Material Item No."),
                                                                              "Location Code" = const('AA-UNY'),
                                                                              "Drop Shipment" = const(false),
                                                                              "NV8 Material Type" = const(Jumbo),
                                                                              "NV8 Exclude From RawMat Status" = const(false)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85165; "Jumbo Rolls on Hand (UNY)"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Pieces" where("Item No." = field("Material Item No."),
                                                                "Location Code" = const('AA-UNY'),
                                                                "Drop Shipment" = const(false),
                                                                "NV8 Material Type" = const(Jumbo),
                                                                Open = const(true),
                                                                "NV8 Exclude From RawMat Status" = const(false)));
            DecimalPlaces = 0 : 5;
            Description = 'UNE';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85166; "Jumbo Qty. on Hand (UNY)"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Material Item No."),
                                                                  "Location Code" = const('AA-UNY'),
                                                                  "Drop Shipment" = const(false),
                                                                  "NV8 Material Type" = const(Jumbo),
                                                                  "NV8 Exclude From RawMat Status" = const(false)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85167; "Jumbo Meters on Hand (OCEAN)"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Unit Length meters" where("Item No." = field("Material Item No."),
                                                                              "Location Code" = const('AA-UNY'),
                                                                              "Drop Shipment" = const(false),
                                                                              "NV8 Material Type" = const(Jumbo),
                                                                              "NV8 Exclude From RawMat Status" = const(false)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85168; "Jumbo Rolls on Hand (OCEAN)"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Pieces" where("Item No." = field("Material Item No."),
                                                                "Location Code" = const('AA-OCEAN'),
                                                                "Drop Shipment" = const(false),
                                                                "NV8 Material Type" = const(Jumbo),
                                                                Open = const(true),
                                                                "NV8 Exclude From RawMat Status" = const(false)));
            DecimalPlaces = 0 : 5;
            Description = 'UNE';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85169; "Raw Material M. on Hand (UNY)"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Unit Length meters" where("Item No." = field("Material Item No."),
                                                                              "Location Code" = const('AA-UNY'),
                                                                              "Drop Shipment" = const(false),
                                                                              Open = const(true),
                                                                              //   "NV8 Shape" = const(RO),//TODO PAP
                                                                              "NV8 Material" = field("Material Code"),
                                                                              "NV8 Grit" = field("Grit Code"),
                                                                              "NV8 Exclude From RawMat Status" = const(false)));
            DecimalPlaces = 0 : 5;
            Description = 'UNE-151,changed sum Unit Length meters';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85170; "Std. Length"; Decimal)
        {
            Description = 'UE106';
        }
        field(85171; "Std. Width"; Decimal)
        {
            Description = 'UE106';
        }
    }

    keys
    {
        key(Key1; "Material Code", "Grit Code")
        {
            Clustered = true;
        }
        key(Key2; "Grit Code", "Material Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        Item.SetCurrentkey("NV8 Material", "NV8 Grit");
        Item.SetRange("NV8 Material", "Material Code");
        Item.SetRange("NV8 Grit", "Grit Code");
        if Item.FindFirst() then
            Error('You can not delete %1 %2 because it is used in Item %3', "Material Code", "Grit Code", Item."No.");
    end;

    var
        Item: Record Item;
        ConfiguratorItem: Record "NV8 Configurator Item";


    procedure SetJumboDateFilter()
    var
        StartDate: Date;
        EndDate: Date;
    begin
        CalcFields("Jumbo Pull Formula");
        if Format("Jumbo Pull Formula") = '' then
            //str-temp
            //StartDate := 00010101D
            StartDate := 0D
        //str-temp
        else
            StartDate := CalcDate("Jumbo Pull Formula", WorkDate());
        EndDate := Today;
        SetFilter("Jumbo Pull Date Filter", '%1..%2', StartDate, EndDate);
    end;


    procedure SetRawMeterialStatus()
    var
        NewStatus: Integer;
    begin
        NewStatus := StrMenu('Normal,Low,Jumbo Out,Out,Discontinued', "Set Raw Material Status" + 1);
        if NewStatus = 0 then
            exit;
        "Set Raw Material Status" := NewStatus - 1;
        Modify();
    end;


    procedure UpdateRawMaterialStatus()
    begin
        if "Set Raw Material Status" = "set raw material status"::Discontinued then
            exit;

        CalcFields("Jumbo Rolls on Hand (UNY)", "Raw Material M. on Hand (UNY)");
        //UNE-151
        if "Jumbo Rolls on Hand (UNY)" >= "Jumbo Low Threshold" then
            "Set Raw Material Status" := "set raw material status"::Normal;

        if "Jumbo Rolls on Hand (UNY)" < "Jumbo Low Threshold" then
            "Set Raw Material Status" := "set raw material status"::Low;

        if "Jumbo Rolls on Hand (UNY)" = 0 then
            "Set Raw Material Status" := "set raw material status"::"Jumbo Out";

        if "Raw Material M. on Hand (UNY)" = 0 then
            "Set Raw Material Status" := "set raw material status"::Out;


        Modify();
    end;
}

