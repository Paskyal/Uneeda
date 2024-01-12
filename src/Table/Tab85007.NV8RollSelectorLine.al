Table 85007 "NV8 Roll Selector Line"
{
    // EC1.01  CDS  03.27.15
    //   New Key for quantity flowfield on Customer Item Sales Table
    // UE-596 DB  7/24/17 Changed Item Descriptions from 30 to 50

    Caption = 'Roll Selector Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(12; Quantity; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."),
                                                                  "Lot No." = field(filter("Lot No.")),
                                                                  "NV8 Lot Group Code" = field("Lot Group Code")));
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(13; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(14; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Invoiced Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(70; "Reserved Quantity"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = sum("Reservation Entry"."Quantity (Base)" where("Source ID" = const(''),
                                                                           "Source Ref. No." = field("Entry No."),
                                                                           "Source Type" = const(32),
                                                                           "Source Subtype" = const(0),
                                                                           "Source Batch Name" = const(''),
                                                                           "Source Prod. Order Line" = const(0),
                                                                           "Reservation Status" = const(Reservation)));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(91; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Editable = false;
        }
        field(100; "Floor Zone"; Code[250])
        {
        }
        field(110; "Warehouse Zone"; Code[250])
        {
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(6501; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';

            trigger OnLookup()
            begin
                //ItemTrackingMgt.LookupLotSerialNoInfo("Item No.","Variant Code",1,"Lot No.");
            end;
        }
        field(50000; "Bin Code"; Code[20])
        {
        }
        field(68056; "Jumbo Raw Material Status"; Option)
        {
            CalcFormula = lookup("NV8 Config Material-Grits"."Set Raw Material Status" where("Material Code" = field(Material),
                                                                                                "Grit Code" = field(Grit)));
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = Normal,Low,"Jumbo Out",Out,Discontinued;
        }
        field(68100; "Floor Quantity"; Decimal)
        {
            CalcFormula = sum("Warehouse Entry".Quantity where("Item No." = field("Item No."),
                                                                "Lot No." = field(filter("Lot No.")),
                                                                "Zone Code" = field(filter("Floor Zone")),
                                                                "Bin Code" = filter(<> 'ADJUSTMENT')));
            DecimalPlaces = 0 : 5;
            Description = 'Original: Sum("Allocation Entry".Quantity WHERE (Initial Item Ledger Entry No.=FIELD(Entry No.)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68101; "Allocation ID"; Integer)
        {
        }
        field(68102; "Allocated MFG"; Integer)
        {
            CalcFormula = count("NV8 Allocation Entry" where("Item Ledger Entry No." = field("Allocation ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68103; "Allocated UNY"; Integer)
        {
            CalcFormula = count("NV8 Allocation Entry" where("Item Ledger Entry No." = field("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68110; "Roll ID"; Code[20])
        {
        }
        field(68111; PIN; Code[10])
        {
        }
        field(68115; "Multi Roll ID"; Integer)
        {
            TableRelation = "Item Ledger Entry";
        }
        field(68120; "Pack Size"; Option)
        {
            OptionMembers = " ",,,"3",,"5",,,,,"10";
        }
        field(68900; OldInv; Boolean)
        {
            Description = 'Entries prior to 2012 valuation';
        }
        field(68901; OldRes; Integer)
        {
        }
        field(68910; "Phy. Inv Error"; Option)
        {
            Description = ' ,Good,Low,High,Unknown,Changed';
            OptionCaption = ' ,Good,Low,High,Unknown,Changed';
            OptionMembers = " ",Good,Low,High,Unknown,Changed;
        }
        field(71000; "Lot Group No. Series"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "No. Series";
        }
        field(84011; "Bin Type"; Option)
        {
            OptionMembers = PutAway,Staging,Inactive;
        }
        field(85000; "Customer Name"; Text[30])
        {
            Editable = false;
        }
        field(85001; "Customer Supply Location"; Code[20])
        {
            TableRelation = Location;
        }
        field(85003; "Skid No."; Text[30])
        {
        }
        field(85005; "Vendor Name"; Text[30])
        {
            Editable = false;
        }
        field(85006; "Transfer-Ship-To Name"; Text[50])
        {
            Editable = false;
        }
        field(85007; "Transfer-Receipt-To Name"; Text[50])
        {
            Editable = false;
        }
        field(85008; "Item Description"; Text[50])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Description = 'UE-596';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85015; "Item Description 2"; Text[50])
        {
            CalcFormula = lookup(Item."Description 2" where("No." = field("Item No.")));
            Description = 'UE-596';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85016; "Jumbo Prod. Order"; Code[20])
        {
            TableRelation = "Production Order"."No." where(Status = const(Released));
        }
        field(85017; "Jumbo Prod. Order Line No."; Integer)
        {
            TableRelation = "Prod. Order Line"."Line No." where(Status = const(Released),
                                                                 "Prod. Order No." = field("Jumbo Prod. Order"));
        }
        field(85018; "Jumbo Comment"; Text[80])
        {
        }
        field(85019; "Jumbo Pull"; Boolean)
        {
        }
        field(85020; "Bin Location"; Code[20])
        {
            TableRelation = "NV8 Bin Location".Code where("Location Code" = field("Location Code"));
        }
        field(85021; "FIFO Code"; Code[7])
        {
        }
        field(85022; "FIFO Date"; Date)
        {

            trigger OnValidate()
            begin
                "FIFO Code" := AGGetFIFOCode("FIFO Date");
            end;
        }
        field(85030; "Original Box Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            MinValue = 0;
        }
        field(85040; "Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
        }
        field(85050; Pieces; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(85051; "Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;

            trigger OnValidate()
            var
                Temp: Integer;
            begin
                Temp := ROUND("Unit Width Inches", 1, '<') * 100;
                Temp := Temp + ROUND((("Unit Width Inches" MOD 1) * 64), 1, '<');

                Validate("Unit Width Code", Format(Temp, 5, '<integer>'));
            end;
        }
        field(85052; "Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'Error on decimals';

            trigger OnValidate()
            begin
                "Unit Length Inches" := ROUND("Unit Length meters" * 39, 0.00001);
                UpdatePieces();
            end;
        }
        field(85053; "Unit Length Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'Error on decimals';

            trigger OnValidate()
            begin
                "Unit Length meters" := ROUND("Unit Length Inches" / 39, 0.00001);
                UpdatePieces();
            end;
        }
        field(85054; "Unit Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'Width / 36 x Length Error on decimals';
            Editable = false;
        }
        field(85055; "Unit Width Code"; Code[10])
        {
            CharAllowed = '09';

            trigger OnValidate()
            begin
                ConfiguratorSetup.Get();
                ConfiguratorSetup.SetDimLen("Unit Width Code", 5, "Unit Width Code", 0);
                "Unit Width Inches" := ConfiguratorSetup.GetDecimal("Unit Width Code");
                "Unit Width Text" := ConfiguratorSetup.GetDecimalText("Unit Width Code");
                UpdatePieces();
            end;
        }
        field(85056; "Unit Width Text"; Text[30])
        {
            Editable = false;
        }
        field(85058; "Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Error on decimals';

            trigger OnValidate()
            begin
                TestField(Pieces);
                Validate("Unit Length meters", ROUND("Total Length meters" / Pieces, 0.00001));
            end;
        }
        field(85059; "Cost Per meter"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85060; "Remaining Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85062; "Remaining Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Error on decimals';
        }
        field(85064; "Total Area m2"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'Error on decimals';
            Editable = false;
        }
        field(85065; "Remaining Area m2"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'Error on decimals';
            Editable = false;
        }
        field(85066; "Description 2"; Text[30])
        {
        }
        field(85069; "Allocator Comment"; Text[80])
        {
        }
        field(85092; "Consignment Reconciled"; Boolean)
        {
        }
        field(85094; "Sales Price UEI"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 4;
            Editable = false;
            FieldClass = Normal;
        }
        field(85098; "Sales Reps (All)"; Code[50])
        {

            trigger OnLookup()
            var
                SalesReps: Record "Salesperson/Purchaser";
            begin
                SalesReps.Reset();
                //SalesReps.SETFILTER(Code,STRSUBSTNO('%1',"Sales Reps (All)"));
                Page.RunModal(0, SalesReps);
            end;
        }
        field(85100; "Configurator No."; Code[100])
        {
            TableRelation = "NV8 Configurator Item";
        }
        field(85110; Shape; Code[10])
        {
            TableRelation = "NV8 Configurator Shape";
        }
        field(85120; Material; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
        }
        field(85121; "Original Material"; Code[10])
        {
        }
        field(85122; "Subst. Material"; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
        }
        field(85170; Specification; Code[10])
        {
            TableRelation = "NV8 Configurator Specification";
        }
        field(85180; Grit; Code[10])
        {
            TableRelation = "NV8 Configurator Grit";
        }
        field(85190; Joint; Code[10])
        {
            TableRelation = "NV8 Configurator Joint";
        }
        field(85200; "Economy Material"; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
        }
        field(85201; "PO No."; Code[20])
        {
            Editable = false;
        }
        field(85300; "Re-Cut"; Boolean)
        {

            trigger OnValidate()
            begin
                /*IF "Re-Cut" THEN BEGIN
                  TESTFIELD("Remaining Quantity");
                 // TESTFIELD(Positive,TRUE);
                  "Re-Cut No." := USERID;
                  // CALCFIELDS("Reserved Quantity");
                  "Re-Cut Quantity" := "Remaining Quantity" -"Reserved Quantity";
                  "Re-Cut Pieces" := "Remaining Pieces";
                  "Re-Cut Width Inches" := "Unit Width Inches";
                  "Re-Cut Length Inches" := "Unit Length Inches";
                END ELSE BEGIN
                  "Re-Cut No." := '';
                  "Re-Cut Quantity" := 0;
                  "Re-Cut Pieces" := 0;
                  "Re-Cut Width Inches" := 0;
                  "Re-Cut Length Inches" := 0;
                END;
                           */

            end;
        }
        field(85301; "Re-Cut No."; Code[20])
        {
            TableRelation = User;
        }
        field(85302; "Re-Cut Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85303; "Re-Cut Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85306; "Re-Cut Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;

            trigger OnValidate()
            var
                Temp: Integer;
            begin
            end;
        }
        field(85308; "Re-Cut Length Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85310; "Yield Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85311; "Yield Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85320; "Locked for Allocation"; Boolean)
        {
            Editable = false;
        }
        field(85321; "Allocated Quantity"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Roll Allocator Line"."Allocated Quantity" where("Item Ledger Entry No." = field("Entry No."),
                                                                                "Line No." = filter(> 0)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85322; "Allocated On"; Date)
        {
            CalcFormula = lookup("NV8 Roll Allocator Line"."Allocated On" where("Item Ledger Entry No." = field("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85323; "Allocated By"; Code[20])
        {
            CalcFormula = lookup("NV8 Roll Allocator Line"."Allocated By" where("Item Ledger Entry No." = field("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = User;
        }
        field(85325; "Allocated for Type"; Option)
        {
            OptionMembers = " ","Sale Order","Transfer Order";
        }
        field(85326; "Allocated for Code"; Code[20])
        {
            TableRelation = if ("Allocated for Type" = const("Sale Order")) Customer."No."
            else
            if ("Allocated for Type" = const("Transfer Order")) Location.Code;
        }
        field(85328; "Allocated for Order No"; Code[20])
        {
            TableRelation = if ("Allocated for Type" = const("Sale Order")) "Sales Header"."No." where("Document Type" = const(Order))
            else
            if ("Allocated for Type" = const("Transfer Order")) "Transfer Header"."No.";
        }
        field(85410; "Split Roll"; Boolean)
        {
        }
        field(85411; "Split Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(85412; "Split Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(85413; "Split Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(85420; "Shipped Split Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(85511; "FG Cost ($/UOM)"; Decimal)
        {
            CalcFormula = lookup(Item."NV8 FG Cost (/UOM)" where("No." = field("Item No.")));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85550; "Found Partial Box"; Boolean)
        {
        }
        field(85551; "Phys. Posting Description"; Text[50])
        {
        }
        field(90001; "Lot Group Code"; Code[20])
        {
        }
        field(90002; "Warehouse Quantity"; Decimal)
        {
            CalcFormula = sum("Warehouse Entry".Quantity where("Item No." = field("Item No."),
                                                                "Lot No." = field(filter("Lot No.")),
                                                                "NV8 Lot Group Code" = field(filter("Lot Group Code")),
                                                                "Zone Code" = field(filter("Warehouse Zone")),
                                                                "Bin Code" = filter(<> 'ADJUSTMENT')));
            FieldClass = FlowField;
        }
        field(90003; Select; Boolean)
        {
        }
        field(90012; "Base Quantity"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."),
                                                                  "Lot No." = field(filter("Lot No."))));
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }
        field(95000; "Whse Level"; Option)
        {
            Description = 'UE-441';
            OptionMembers = Upstairs,DownStairs;
        }
        field(95001; "Bin Level"; Integer)
        {
            Description = 'UE-441';
        }
        field(95002; "Created Date"; Date)
        {
            Description = 'UE-590/UE-606';
        }
        field(95003; "Has Whse. Activity"; Boolean)
        {
            CalcFormula = exist("Warehouse Activity Line" where("Lot No." = field("Roll ID")));
            Description = 'UE-614';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Unit Width Inches", "Unit Length meters", "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Lot Group Code")
        {
        }
        key(Key3; Shape, Material, Grit, Joint)
        {
        }
    }

    fieldgroups
    {
        // fieldgroup(DropDown; "Entry No.", Description, "Item No.", "Posting Date", Field4, Field6) //TODo PAP
        // {
        // }
    }

    var
        GLSetup: Record "General Ledger Setup";
        ReservEntry: Record "Reservation Entry";
        ReservEngineMgt: Codeunit "Reservation Engine Mgt.";
        ReserveItemLedgEntry: Codeunit "Item Ledger Entry-Reserve";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        GLSetupRead: Boolean;
        IsNotOnInventoryErr: label 'You have insufficient quantity of Item %1 on inventory.';
        Item: Record Item;
        InventorySetup: Record "Inventory Setup";
        ConfiguratorSetup: Record "NV8 Configurator Setup";
        ConfiguratorItem: Record "NV8 Configurator Item";
        ConfiguratorShape: Record "NV8 Configurator Shape";
        ConfiguratorMaterial: Record "NV8 Configurator Material";
        ConfiguratorMaterialGrit: Record "NV8 Config Material-Grits";
        Location: Record Location;
        YieldRate: Decimal;
        Cust: Record Customer;
        NoSeriesMgt: Codeunit NoSeriesManagement;

    local procedure "---"()
    begin
    end;


    procedure AGGetFIFOCode(Date: Date): Code[7]
    begin
        exit(Format(
          Date2dwy(Date, 3) * 1000 +
          Date2dwy(Date, 2) * 10 +
          Date2dwy(Date, 1)));
    end;


    procedure AGGetConfigurator(ItemJnlLine: Record "Item Journal Line")
    begin
        "Material Type" := ItemJnlLine."NV8 Material Type";
        Pieces := ItemJnlLine."NV8 Pieces";
        "Unit Width Inches" := ItemJnlLine."NV8 Unit Width Inches";
        "Unit Length meters" := ItemJnlLine."NV8 Unit Length meters";
        "Unit Length Inches" := ItemJnlLine."NV8 Unit Length Inches";
        "Unit Width Code" := ItemJnlLine."NV8 Unit Width Code";
        "Unit Width Text" := ItemJnlLine."NV8 Unit Width Text";
        "Unit Area m2" := ItemJnlLine."NV8 Unit Area m2";
        "Total Length meters" := ItemJnlLine."NV8 Total Length meters";
        "Cost Per meter" := ItemJnlLine."NV8 Cost Per meter";
        "Total Area m2" := ItemJnlLine."NV8 Total Area m2";
        if ItemJnlLine."NV8 FIFO Date" = 0D then
            Validate("FIFO Date", "Posting Date")
        else
            Validate("FIFO Date", ItemJnlLine."NV8 FIFO Date");
        "Skid No." := ItemJnlLine."NV8 Skid No.";
        /*
        IF Quantity > 0 THEN BEGIN
          //"Bin Location" := ItemJnlLine."Bin Location";
          InventorySetup.GET;
          //ECL remove
         // IF Location.GET("Location Code") THEN
        //    IF Location."Bin Location Mandatory" THEN
        //      TESTFIELD("Bin Location");
        END ELSE
          "Bin Location" := '';
        */
        //ECL remove

        //IF InventorySetup."Block Negative Inventory" AND ("Remaining Quantity" < 0) THEN
        //  ItemJnlLine.FIELDERROR(Quantity,
        //      STRSUBSTNO(AG001,
        //      Quantity,"Document No.","Item No.","Location Code","Bin Location"));


        Item.Get("Item No.");
        if ConfiguratorItem.Get(Item."NV8 Configurator No.") then begin
            "Configurator No." := Item."NV8 Configurator No.";
            Shape := ConfiguratorItem.Shape;
            Material := ConfiguratorItem.Material;
            Specification := ConfiguratorItem.Specification;
            Grit := ConfiguratorItem.Grit;
            Joint := ConfiguratorItem.Joint;

            if ConfiguratorShape.Get(Shape) then begin
                if ConfiguratorShape."Dimensioned Roll" then begin
                    if ConfiguratorMaterial.Get(Material) then begin
                        case true of
                            ("Unit Width Inches" > ConfiguratorMaterial."Jumbo Min. Width") and
                          ("Unit Length meters" > ConfiguratorMaterial."Jumbo Min. Length"):
                                "Material Type" := "material type"::Jumbo;
                            ("Unit Width Inches" > ConfiguratorMaterial."Narrow Remnant Min. Width") and
                          ("Unit Length meters" > ConfiguratorMaterial."Narrow Remnant Min. Length"):
                                "Material Type" := "material type"::"Narrow Remnant";
                            ("Unit Width Inches" > ConfiguratorMaterial."Short Remnant Min. Width") and
                          ("Unit Length meters" > ConfiguratorMaterial."Short Remnant Min. Length"):
                                "Material Type" := "material type"::"Short Remnant";
                            else
                                "Material Type" := "material type"::Scrap;
                        end;
                    end;
                end;
            end;
        end;

        if
          ("Material Type" = "material type"::" ") and
          ("Total Area m2" = 0) and
          ("Unit Area m2" <> 0) then
            "Total Area m2" := Quantity * "Unit Area m2";

        "Jumbo Pull" := ItemJnlLine."NV8 Jumbo Pull";

    end;


    procedure UpdateArea()
    begin
    end;


    procedure UpdatePieces()
    begin
        UpdateRemainingQty();
    end;


    procedure FixPieces()
    begin
        if "Material Type" = "material type"::" " then
            exit;
        Pieces := ROUND(TruePieces(), 1);
    end;


    procedure TruePieces(): Decimal
    begin
        if ("Unit Area m2" = 0) or ("Material Type" = "material type"::" ") then
            exit(0);
        exit(Quantity / "Unit Area m2");
    end;


    procedure UpdateRemainingQty()
    begin
    end;


    procedure ShippingDate(): Date
    begin
    end;


    procedure GetAdjustedUnitCost(): Decimal
    var
        AdjCostTmp: Decimal;
        MinAdjCost: Decimal;
        MaxAdjCost: Decimal;
    begin
    end;


    procedure AllocQty(): Decimal
    var
        RollAlloc: Record "NV8 Roll Allocator Line";
        NewAlloc: Decimal;
    begin
        RollAlloc.Reset();
        NewAlloc := 0;
        RollAlloc.SetRange("Item Ledger Entry No.", "Entry No.");
        if RollAlloc.FindSet() then begin
            repeat
                NewAlloc += RollAlloc."Allocated Quantity";
            until RollAlloc.Next() = 0;
            exit(NewAlloc);
        end else
            exit(0);
    end;


    procedure CreateRollID(): Boolean
    var
        NoSeries: Code[20];
    begin
        TestField("Roll ID", '');
        InventorySetup.Get();
        InventorySetup.TestField("NV8 Roll ID Nos.");
        NoSeriesMgt.InitSeries(InventorySetup."NV8 Roll ID Nos.", '', 0D, "Roll ID", NoSeries);
    end;


    procedure DisplayLocation(): Text[100]
    begin
    end;
}

