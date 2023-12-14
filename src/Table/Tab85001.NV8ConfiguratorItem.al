Table 85001 "NV8 Configurator Item"
{
    // EC VAR003  08.25.15  BJM Added fields 50004..50006
    //                      DB added code to get default informartion from Configurator Shape & create SKU
    //            09.02.15  DB change Replenishment and Reordering Policy from 3.7 fields to 2015 fields.  Add Manufacturing Policy
    // EC1.01  08.31.15  BJM  Change to Reserve = Optional not Always
    // 
    // EC1.LOT1.01 MD 9/15/15
    //   - Add tracking code for auto track items in create item
    // UE-142  BJM  11.05.15  Added Include Inventory -initvalue = Yes
    // UE-193  BJM  11.06.15  Add fields in UpdateItemFields function
    // UE-438  DB  4/20/16 Transfer Shape to SKU
    // UE-619  DB  1/25/18 Create BOM and Routing versions
    //         DB  4/3/19  Update Routing version process
    // UE-651  DB  6/13/20  Expand Item Description and Item Description 2 to 50
    // UE-651  DB  1/28/21 Create Item Default Dimensions when Item created
    // UNE-165 DB  11/9/21 Change Create Item Action to use Status from setup
    // UNE-192 DB  12/15/21  Add record to Sales Price table when create Item
    //         DC  12/21/21  Moved code under ItemUpdate
    // UNE-191 DC  01/31/21 Move Configurator Validate above Des & Desc 2 on ItemUpdateFields
    //                      Added Validate to Description 2
    // CAS-40665-Y3X3S1  DB  2/23/23 Expand Item Description to 100 to match Microsft update of the Item table description

    DrillDownPageID = UnknownPage85002;
    LookupPageID = UnknownPage85002;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Configurator No."; Code[100])
        {
        }
        field(2; "Prototype No."; Code[20])
        {
            NotBlank = true;
        }
        field(3; "Item Description"; Text[100])
        {
            Description = 'UE-651,CAS-40665-Y3X3S1';
        }
        field(4; "Description OK"; Boolean)
        {
        }
        field(5; "Item Description 2"; Text[50])
        {
            Description = 'UE-651';
        }
        field(6; "Description 2 OK"; Boolean)
        {
        }
        field(8; "Temp Configurator No."; Code[100])
        {
        }
        field(9; Status; Option)
        {
            OptionMembers = Prototype,Item,"Valid Item",Blocked;
        }
        field(10; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(11; "Item Created"; Boolean)
        {
            CalcFormula = exist(Item where("No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Configurator Suffix"; Code[20])
        {

            trigger OnValidate()
            begin
                if "Configurator Suffix" = '' then
                    CreateCfgSeries;
            end;
        }
        field(13; "Suffix No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(14; "Item No. Lookup"; Code[20])
        {
            CalcFormula = lookup(Item."No." where("Configurator No." = field("Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "File Pro No."; Code[35])
        {
            Description = 'This is for the existing part number in the File Pro System';
        }
        field(16; "Raw Material"; Code[100])
        {
            TableRelation = if (Status = const(Prototype)) "Configurator Item"
            else
            if (Status = filter(Item .. "Valid Item")) Item;
        }
        field(17; "Replacement Configurator No."; Code[100])
        {
        }
        field(18; "Configurator No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(19; "Item No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(20; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            MinValue = 0;
        }
        field(24; "Standard Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Standard Cost';
            MinValue = 0;
        }
        field(29; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name" = const(Item),
                                                      "No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(35; "Rule - Description"; Text[80])
        {
            CalcFormula = lookup("Configurator Shape"."Rule - Description" where(Code = field(Shape)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Rule - Description 2"; Text[80])
        {
            CalcFormula = lookup("Configurator Shape"."Rule - Description 2" where(Code = field(Shape)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Inventory Posting Group"; Code[10])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(41; "Gen. Prod. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(42; "Base Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(43; "Tax Bus. Posting Gr. (Price)"; Code[10])
        {
            TableRelation = "VAT Business Posting Group";
        }
        field(44; "Tax Group Code"; Code[10])
        {
            TableRelation = "Tax Group";
        }
        field(45; "Tax Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(46; "Requisition Method Code"; Code[10])
        {
            Description = 'remove this field';
        }
        field(47; "Requisition System"; Option)
        {
            OptionCaption = 'Purchase,Prod. Order, ';
            OptionMembers = Purchase,"Prod. Order"," ";
        }
        field(50; "Routing No."; Code[20])
        {
            TableRelation = "Routing Header";
        }
        field(51; "Routing OK"; Boolean)
        {
        }
        field(55; "Production BOM No."; Code[20])
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
        field(56; "BOM OK"; Boolean)
        {
        }
        field(57; "Do Not Create Item"; Boolean)
        {
        }
        field(90; "Raw Material Item No."; Code[20])
        {
            CalcFormula = lookup("Configurator Material-Grits"."Material Item No." where("Material Code" = field(Material),
                                                                                          "Grit Code" = field(Grit)));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Item;
        }
        field(91; "Raw Material Configurator No."; Code[100])
        {
            CalcFormula = lookup("Configurator Material-Grits"."Material Configurator No." where("Material Code" = field(Material),
                                                                                                  "Grit Code" = field(Grit)));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Configurator Item";
        }
        field(92; "Source Item No."; Code[20])
        {
            CalcFormula = lookup(Item."No." where(Shape = field(Shape),
                                                   Material = field(Material),
                                                   Specification = field(Specification),
                                                   Grit = field(Grit)));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Item;
        }
        field(93; "Source Configurator No."; Code[100])
        {
            CalcFormula = lookup("Configurator Item"."Configurator No." where(Shape = field(Shape),
                                                                               Material = field(Material),
                                                                               Specification = field(Specification),
                                                                               Grit = field(Grit)));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Configurator Item";
        }
        field(95; "Create New Raw Material"; Boolean)
        {

            trigger OnValidate()
            begin
                TestField("Item No.", '');
                ConfiguratorSetup.Get;
                Validate(Shape, ConfiguratorSetup."Raw Material Shape");
            end;
        }
        field(96; "Raw Material Created"; Boolean)
        {
        }
        field(100; "Configurator Description 1"; Text[80])
        {
        }
        field(101; "Configurator Description 2"; Text[80])
        {
        }
        field(102; "Configurator Description 3"; Text[80])
        {
        }
        field(103; "Configurator Description 4"; Text[80])
        {
        }
        field(110; Shape; Code[10])
        {
            TableRelation = "Configurator Shape";

            trigger OnValidate()
            begin
                GetShape;
                Material := ConfiguratorShape."Material Value";
                if ConfiguratorShape."Dimension 1 Rule" = ConfiguratorShape."dimension 1 rule"::Same then
                    "Dimension 1" := ConfiguratorShape."Dimension 1 Value";
                if ConfiguratorShape."Dimension 2 Rule" = ConfiguratorShape."dimension 2 rule"::Same then
                    "Dimension 2" := ConfiguratorShape."Dimension 2 Value";
                if ConfiguratorShape."Dimension 3 Rule" = ConfiguratorShape."dimension 3 rule"::Same then
                    "Dimension 3" := ConfiguratorShape."Dimension 3 Value";
                if ConfiguratorShape."Dimension 4 Rule" = ConfiguratorShape."dimension 4 rule"::Same then
                    "Dimension 4" := ConfiguratorShape."Dimension 4 Value";
                Specification := ConfiguratorShape."Specification Value";
                Grit := ConfiguratorShape."Grit Value";
                Joint := ConfiguratorShape."Joint Value";

                "Inventory Posting Group" := ConfiguratorShape."Inventory Posting Group";
                "Gen. Prod. Posting Group" := ConfiguratorShape."Gen. Prod. Posting Group";
                ConfiguratorShape.TestField("Base Unit of Measure");
                "Base Unit of Measure" := ConfiguratorShape."Base Unit of Measure";
                "Tax Bus. Posting Gr. (Price)" := ConfiguratorShape."Tax Bus. Posting Gr. (Price)";
                "Tax Group Code" := ConfiguratorShape."Tax Group Code";
                "Tax Prod. Posting Group" := ConfiguratorShape."Tax Prod. Posting Group";
                //>> VAR003
                //"Requisition Method Code" := ConfiguratorShape."Requisition Method Code";
                "Manufacturing Policy" := ConfiguratorShape."Manufacturing Policy";
                //<< VAR003
                "Requisition System" := ConfiguratorShape."Requisition System";
                //>> EC VAR003
                "Def. SKU Order Tracking Policy" := ConfiguratorShape."Def. SKU Order Tracking Policy";
                "Def. SKU Reordering Policy" := ConfiguratorShape."Def. SKU Reordering Policy";
                "Create SKU's" := ConfiguratorShape."Create SKU's";
                //<< EC VAR003
            end;
        }
        field(111; "Shape Description"; Text[30])
        {
            CalcFormula = lookup("Configurator Shape"."Item Description" where(Code = field(Shape)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(112; "Shape Description 2"; Text[30])
        {
            CalcFormula = lookup("Configurator Shape"."Item Description 2" where(Code = field(Shape)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(120; Material; Code[10])
        {
            TableRelation = "Configurator Material";
        }
        field(121; "Material Description"; Text[30])
        {
            CalcFormula = lookup("Configurator Material"."Item Description" where(Code = field(Material)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(122; "Material Description 2"; Text[30])
        {
            CalcFormula = lookup("Configurator Material"."Item Description 2" where(Code = field(Material)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(130; "Dimension 1"; Code[10])
        {
            CaptionClass = GetCaption(1);

            trigger OnValidate()
            begin
                //EC1.INV4.01
                //str-temp
                if not CheckDimValid("Dimension 1") then Error(ECL001);
                //str-temp
                //

                ConfiguratorSetup.Get;
                "Quantity 1" := ConfiguratorSetup.GetDecimal("Dimension 1");
                "Dim 1 Text" := ConfiguratorSetup.GetDecimalText("Dimension 1");
            end;
        }
        field(132; "Quantity 1"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(133; "UOM 1"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(134; "Dim 1 Text"; Text[20])
        {
            Editable = false;
        }
        field(140; "Dimension 2"; Code[10])
        {
            CaptionClass = GetCaption(2);

            trigger OnValidate()
            begin
                //EC1.INV4.01
                //str-temp
                if not CheckDimValid("Dimension 2") then Error(ECL001);
                //str-temp
                //

                ConfiguratorSetup.Get;
                "Quantity 2" := ConfiguratorSetup.GetDecimal("Dimension 2");
                "Dim 2 Text" := ConfiguratorSetup.GetDecimalText("Dimension 2");
            end;
        }
        field(142; "Quantity 2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(143; "UOM 2"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(144; "Dim 2 Text"; Text[20])
        {
            Editable = false;
        }
        field(150; "Dimension 3"; Code[10])
        {
            CaptionClass = GetCaption(3);

            trigger OnValidate()
            begin
                //EC1.INV4.01
                //str-temp
                if not CheckDimValid("Dimension 3") then Error(ECL001);
                //str-temp
                //

                ConfiguratorSetup.Get;
                "Quantity 3" := ConfiguratorSetup.GetDecimal("Dimension 3");
                "Dim 3 Text" := ConfiguratorSetup.GetDecimalText("Dimension 3");
            end;
        }
        field(152; "Quantity 3"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(153; "UOM 3"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(154; "Dim 3 Text"; Text[20])
        {
            Editable = false;
        }
        field(160; "Dimension 4"; Code[10])
        {
            CaptionClass = GetCaption(4);

            trigger OnValidate()
            begin
                //EC1.INV4.01
                //str-temp
                if not CheckDimValid("Dimension 4") then Error(ECL001);
                //str-temp
                //

                ConfiguratorSetup.Get;
                "Quantity 4" := ConfiguratorSetup.GetDecimal("Dimension 4");
                "Dim 4 Text" := ConfiguratorSetup.GetDecimalText("Dimension 4");
            end;
        }
        field(162; "Quantity 4"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(163; "UOM 4"; Code[10])
        {
            Caption = 'Base Unit of Measure';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(164; "Dim 4 Text"; Text[20])
        {
            Editable = false;
        }
        field(170; Specification; Code[10])
        {
            TableRelation = "Configurator Specification";
        }
        field(171; "Specification Description"; Text[30])
        {
            CalcFormula = lookup("Configurator Specification"."Item Description" where(Code = field(Specification)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(172; "Specification Description 2"; Text[30])
        {
            CalcFormula = lookup("Configurator Specification"."Item Description 2" where(Code = field(Specification)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(180; Grit; Code[10])
        {
            TableRelation = "Configurator Material-Grits"."Grit Code" where("Material Code" = field(Material));
        }
        field(181; "Grit Decription"; Text[30])
        {
            CalcFormula = lookup("Configurator Grit"."Item Description" where(Code = field(Grit)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(182; "Grit Decription 2"; Text[30])
        {
            CalcFormula = lookup("Configurator Grit"."Item Description" where(Code = field(Grit)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(190; Joint; Code[10])
        {
            TableRelation = "Configurator Shape-Joints".Joint where(Shape = field(Shape),
                                                                     "Material Filter" = field(Material));
        }
        field(191; "Joint Description"; Text[30])
        {
            CalcFormula = lookup("Configurator Joint"."Item Description" where(Code = field(Joint)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(192; "Joint Description 2"; Text[30])
        {
            CalcFormula = lookup("Configurator Joint"."Item Description 2" where(Code = field(Joint)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(200; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(201; "Location Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = Location;
        }
        field(202; "Qty. On Hand"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where(Open = const(true),
                                                                              Positive = const(true),
                                                                              "Item No." = field("Item No."),
                                                                              "Location Code" = field("Location Filter"),
                                                                              "Posting Date" = field("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "Def. SKU Reordering Policy"; Option)
        {
            Description = 'EC VAR003';
            OptionCaption = ' ,Fixed Reorder Qty,Maximum Qty,Order,Lot-for-Lot';
            OptionMembers = " ","Fixed Reorder Qty","Maximum Qty","Order","Lot-for-Lot";
        }
        field(50005; "Def. SKU Order Tracking Policy"; Option)
        {
            Description = 'EC VAR003';
            OptionCaption = 'None,Tracking Only,Tracking & Action Msg.';
            OptionMembers = "None","Tracking Only","Tracking & Action Msg.";
        }
        field(50006; "Create SKU's"; Boolean)
        {
            Description = 'EC VAR003';
        }
        field(50007; "Manufacturing Policy"; Option)
        {
            Description = 'EC VAR003';
            InitValue = "Make-to-Order";
            OptionCaption = 'Make-to-Stock,Make-to-Order';
            OptionMembers = "Make-to-Stock","Make-to-Order";
        }
        field(50008; "Include Inventory"; Boolean)
        {
            Description = 'UE-142';
            InitValue = true;
        }
        field(68400; "Catalog No."; Code[20])
        {
            CalcFormula = lookup("Item Catalog Table"."Catalog No." where("Item No." = field("Item No.")));
            Caption = 'Catalog No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85000; "Imported From"; Text[250])
        {
        }
        field(85001; "FilePro Price"; Decimal)
        {
        }
        field(85002; "FilePro Cost"; Decimal)
        {
        }
        field(85003; "FilePro Prefix"; Code[10])
        {
        }
        field(85004; "FilePro F1"; Integer)
        {
        }
        field(85005; "FilePro F2"; Integer)
        {
        }
        field(85006; "FilePro F3"; Decimal)
        {
            Enabled = false;
        }
        field(85007; "File Pro Currency"; Code[10])
        {
        }
        field(85008; "FilePro Width"; Code[5])
        {
        }
        field(85009; "FilePro Discount"; Decimal)
        {
        }
        field(85066; "Item Blocked"; Boolean)
        {
            CalcFormula = lookup(Item.Blocked where("No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85068; "Error Found"; Boolean)
        {
        }
        field(85097; "Material Type"; Option)
        {
            CalcFormula = lookup("Configurator Material"."Material Type" where(Code = field(Material)));
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = " ",Paper,Cloth,Combo,Film;
        }
        field(85100; "Last Modified On"; Date)
        {
        }
        field(85101; "Last Modified By"; Code[100])
        {
            TableRelation = User;
        }
        field(85105; "Last Batch Update On"; Date)
        {
        }
        field(85106; "Last Batch Update By"; Code[100])
        {
            TableRelation = User;
        }
    }

    keys
    {
        key(Key1; "Configurator No.")
        {
            Clustered = true;
        }
        key(Key2; "File Pro No.")
        {
        }
        key(Key3; "Item No.")
        {
        }
        key(Key4; Shape, Material, "Dimension 1", "Dimension 2", "Dimension 3", "Dimension 4", Specification, Grit, Joint)
        {
        }
        key(Key5; Material, Grit)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        if "Configurator No." = '' then begin
            ConfiguratorSetup.Get;
            ConfiguratorSetup.TestField("Prototype No. Series");
            NoSeriesMgt.InitSeries(
              ConfiguratorSetup."Prototype No. Series",
              xRec."Configurator No. Series",
              0D,
              "Configurator No.", "Configurator No. Series");
        end;
        "Last Modified On" := Today;
        "Last Modified By" := UserId;
    end;

    trigger OnModify()
    begin

        if Status <> Status::Prototype then
            if not Confirm(AG003, false) then
                Error(AG004);
        "Last Modified On" := Today;
        "Last Modified By" := UserId;
    end;

    trigger OnRename()
    begin

        // ERROR('Old= ' + xRec.GetConfiguratorNo + ' -- New= ' + Rec.GetConfiguratorNo );
        "Temp Configurator No." := GetConfiguratorNo;
        /*
        WITH SalesPriceUEI DO BEGIN
          RESET;
          SETCURRENTKEY("Item No.");
          SETRANGE("Item No.",Rec."Item No.");                             n
          IF FIND('-') THEN
            REPEAT
              "Configurator No." := Rec.GetConfiguratorNo;
              IF Item.GET("Item No.") THEN BEGIN
                "Configurator Search Desc." :=
                  COPYSTR(
                    "Configurator No." +
                    Item.Description +
                    Item."Description 2",1,100);
                MODIFY;
              END;
            UNTIL NEXT = 0;
        END;
         */

    end;

    var
        Item: Record Item;
        ConfiguratorSetup: Record "Configurator Setup";
        ConfiguratorItem: Record "Configurator Item";
        ConfiguratorShape: Record "Configurator Shape";
        ConfiguratorMaterial: Record "Configurator Material";
        ConfiguratorSpecification: Record "Configurator Specification";
        ConfiguratorGrit: Record "Configurator Grit";
        ConfiguratorJoint: Record "Configurator Joint";
        ConfiguratorMaterialGrit: Record "Configurator Material-Grits";
        Routing: Record "Routing Header";
        RoutingLines: Record "Routing Line";
        RoutingComp: Record "Routing Line";
        ProductionBOM: Record "Production BOM Header";
        ProductionBOMLines: Record "Production BOM Line";
        ProductionBOMComp: Record "Production BOM Line";
        ItemUOM: Record "Item Unit of Measure";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeries: Code[10];
        NextLineNo: Integer;
        AG001: label 'must be less than or equal to %1.';
        AG002: label 'must be greater than or equal to %1.';
        AG003: label 'You can not make changes to the Configurator Item uless it is in the Prototype Status. In this test company you may change the Card, do you wish to continue.';
        AG004: label 'The changes have not been saved.';
        AG005: label 'The dimension %1 (%2) can not contain more than %3 Characters.';
        AG006: label 'The configurator Item %1 already exists.';
        AG007: label '. This formula is not supported';
        ECL001: label 'Invalid Selection.  Dimensions must have values other than 0 to be valid.';
        StockkeepingUnit: Record "Stockkeeping Unit";
        Location: Record Location;
        ItemVar: Record "Item Variant";
        ProductionBOMVer: Record "Production BOM Version";
        RoutingVer: Record "Routing Version";
        DefaultDim: Record "Default Dimension";
        SalesPrice: Record "Sales Price";


    procedure AssistEdit(): Boolean
    begin
        ConfiguratorSetup.Get;
        ConfiguratorSetup.TestField("Prototype No. Series");
        if NoSeriesMgt.SelectSeries(
          ConfiguratorSetup."Prototype No. Series",
          xRec."Configurator No. Series",
          "Configurator No. Series") then begin
            NoSeriesMgt.SetSeries("Configurator No.");
            exit(true);
        end;
    end;


    procedure CfgAssistEdit(): Boolean
    begin
        ConfiguratorSetup.Get;
        ConfiguratorSetup.TestField("Configurator Item Nos.");
        if NoSeriesMgt.SelectSeries(
          ConfiguratorSetup."Configurator Item Nos.",
          xRec."Suffix No. Series",
          "Suffix No. Series") then begin
            NoSeriesMgt.SetSeries("Configurator Suffix");
            exit(true);
        end;
    end;


    procedure CreateCfgSeries()
    begin
        if "Configurator Suffix" = '' then begin
            ConfiguratorSetup.Get;
            ConfiguratorSetup.TestField("Configurator Item Nos.");
            NoSeriesMgt.InitSeries(
              ConfiguratorSetup."Configurator Item Nos.",
              xRec."Suffix No. Series",
              0D,
              "Configurator Suffix", "Suffix No. Series");
        end;
    end;


    procedure ConfiguratorNoParse(Shape: Code[10]; MaterialFound: Code[10]; Dim1Found: Code[10]; Dim2Found: Code[10]; Dim3Found: Code[10]; Dim4Found: Code[10]; SpecificationFound: Code[10]; GritFound: Code[10]; JointFound: Code[10]) Found: Boolean
    begin
    end;


    procedure CheckConfiguration()
    begin
        TestField(Shape);
        GetShape;

        if IsItemBlocked then
            ItemBlockedError;

        ConfiguratorSetup.Get;
        case ConfiguratorShape."Material Rule" of
            ConfiguratorShape."material rule"::Optional:
                begin
                    if Material <> '' then
                        ConfiguratorMaterial.Get(Material)
                    else
                        ConfiguratorMaterial.Init;
                end;
            ConfiguratorShape."material rule"::Blank:
                begin
                    TestField(Material, '');
                    ConfiguratorMaterial.Init;
                end;
            ConfiguratorShape."material rule"::Mandatory:
                begin
                    TestField(Material);
                    ConfiguratorMaterial.Get(Material);
                end;
            ConfiguratorShape."material rule"::Same:
                begin
                    TestField(Material, ConfiguratorShape."Material Value");
                    ConfiguratorMaterial.Get(Material);
                end;
            ConfiguratorShape."material rule"::"Less Than":
                begin
                    if Material > ConfiguratorShape."Material Value" then
                        FieldError(Material, AG001);
                end;
            ConfiguratorShape."material rule"::"Greater Than":
                begin
                    if Material < ConfiguratorShape."Material Value" then
                        FieldError(Material, AG002);
                end;
        end;

        Validate("Dimension 1");
        case ConfiguratorShape."Dimension 1 Rule" of
            ConfiguratorShape."dimension 1 rule"::Optional:
                begin
                    if "Dim 1 Text" = '' then
                        "Dim 1 Text" := '0';
                end;
            ConfiguratorShape."dimension 1 rule"::Blank:
                begin
                    TestField("Dimension 1", '');
                end;
            ConfiguratorShape."dimension 1 rule"::Mandatory:
                begin
                    TestField("Dimension 1");
                end;
            ConfiguratorShape."dimension 1 rule"::Same:
                begin
                    TestField("Dimension 1", ConfiguratorShape."Dimension 1 Value");
                end;
            ConfiguratorShape."dimension 1 rule"::"Less Than":
                begin
                    if "Dimension 1" > ConfiguratorShape."Dimension 1 Value" then
                        FieldError("Dimension 1", StrSubstNo(AG001, ConfiguratorShape."Dimension 1 Value"));
                end;
            ConfiguratorShape."dimension 1 rule"::"Greater Than":
                begin
                    if "Dimension 1" < ConfiguratorShape."Dimension 1 Value" then
                        FieldError("Dimension 1", StrSubstNo(AG002, ConfiguratorShape."Dimension 1 Value"));
                end;
        end;
        SetDimLen(
        "Dimension 1", ConfiguratorShape."Dimension 1 Code Length", "Dimension 1", ConfiguratorShape."Dimension 1 Rule");


        Validate("Dimension 2");
        case ConfiguratorShape."Dimension 2 Rule" of
            ConfiguratorShape."dimension 2 rule"::Optional:
                begin
                    if "Dim 2 Text" = '' then
                        "Dim 2 Text" := '0';
                end;
            ConfiguratorShape."dimension 2 rule"::Blank:
                begin
                    TestField("Dimension 2", '');
                end;
            ConfiguratorShape."dimension 2 rule"::Mandatory:
                begin
                    TestField("Dimension 2");
                end;
            ConfiguratorShape."dimension 2 rule"::Same:
                begin
                    TestField("Dimension 2", ConfiguratorShape."Dimension 2 Value");
                end;
            ConfiguratorShape."dimension 2 rule"::"Less Than":
                begin
                    if "Dimension 2" > ConfiguratorShape."Dimension 2 Value" then
                        FieldError("Dimension 2", StrSubstNo(AG001, ConfiguratorShape."Dimension 2 Value"));
                end;
            ConfiguratorShape."dimension 2 rule"::"Greater Than":
                begin
                    if "Dimension 2" < ConfiguratorShape."Dimension 2 Value" then
                        FieldError("Dimension 2", StrSubstNo(AG002, ConfiguratorShape."Dimension 2 Value"));
                end;
        end;
        SetDimLen(
          "Dimension 2", ConfiguratorShape."Dimension 2 Code Length", "Dimension 2", ConfiguratorShape."Dimension 2 Rule");

        Validate("Dimension 3");
        case ConfiguratorShape."Dimension 3 Rule" of
            ConfiguratorShape."dimension 3 rule"::Optional:
                begin
                    if "Dim 3 Text" = '' then
                        "Dim 3 Text" := '0';
                end;
            ConfiguratorShape."dimension 3 rule"::Blank:
                begin
                    TestField("Dimension 3", '');
                end;
            ConfiguratorShape."dimension 3 rule"::Mandatory:
                begin
                    TestField("Dimension 3");
                end;
            ConfiguratorShape."dimension 3 rule"::Same:
                begin
                    TestField("Dimension 3", ConfiguratorShape."Dimension 3 Value");
                end;
            ConfiguratorShape."dimension 3 rule"::"Less Than":
                begin
                    if "Dimension 3" > ConfiguratorShape."Dimension 3 Value" then
                        FieldError("Dimension 3", StrSubstNo(AG001, ConfiguratorShape."Dimension 3 Value"));
                end;
            ConfiguratorShape."dimension 3 rule"::"Greater Than":
                begin
                    if "Dimension 3" < ConfiguratorShape."Dimension 3 Value" then
                        FieldError("Dimension 3", StrSubstNo(AG002, ConfiguratorShape."Dimension 3 Value"));
                end;
        end;
        SetDimLen(
          "Dimension 3", ConfiguratorShape."Dimension 3 Code Length", "Dimension 3", ConfiguratorShape."Dimension 3 Rule");

        Validate("Dimension 4");
        case ConfiguratorShape."Dimension 4 Rule" of
            ConfiguratorShape."dimension 4 rule"::Optional:
                begin
                    if "Dim 4 Text" = '' then
                        "Dim 4 Text" := '0';
                end;
            ConfiguratorShape."dimension 4 rule"::Blank:
                begin
                    TestField("Dimension 4", '');
                end;
            ConfiguratorShape."dimension 4 rule"::Mandatory:
                begin
                    TestField("Dimension 4");
                end;
            ConfiguratorShape."dimension 4 rule"::Same:
                begin
                    TestField("Dimension 4", ConfiguratorShape."Dimension 4 Value");
                end;
            ConfiguratorShape."dimension 4 rule"::"Less Than":
                begin
                    if "Dimension 4" > ConfiguratorShape."Dimension 4 Value" then
                        FieldError("Dimension 4", StrSubstNo(AG001, ConfiguratorShape."Dimension 4 Value"));
                end;
            ConfiguratorShape."dimension 4 rule"::"Greater Than":
                begin
                    if "Dimension 4" < ConfiguratorShape."Dimension 4 Value" then
                        FieldError("Dimension 4", StrSubstNo(AG002, ConfiguratorShape."Dimension 4 Value"));
                end;
        end;
        SetDimLen(
          "Dimension 4", ConfiguratorShape."Dimension 4 Code Length", "Dimension 4", ConfiguratorShape."Dimension 4 Rule");

        case ConfiguratorShape."Specification Rule" of
            ConfiguratorShape."specification rule"::Optional:
                begin
                    if Specification <> '' then
                        ConfiguratorSpecification.Get(Specification)
                    else
                        ConfiguratorSpecification.Init;
                end;
            ConfiguratorShape."specification rule"::Blank:
                begin
                    TestField(Specification, '');
                    ConfiguratorSpecification.Init;
                end;
            ConfiguratorShape."specification rule"::Mandatory:
                begin
                    TestField(Specification);
                    ConfiguratorSpecification.Get(Specification);
                end;
            ConfiguratorShape."specification rule"::Same:
                begin
                    TestField(Specification, ConfiguratorShape."Specification Value");
                    ConfiguratorSpecification.Get(Specification);
                end;
            ConfiguratorShape."specification rule"::"Less Than":
                begin
                    if Specification > ConfiguratorShape."Specification Value" then
                        FieldError(Specification, AG001);
                end;
            ConfiguratorShape."specification rule"::"Greater Than":
                begin
                    if Specification < ConfiguratorShape."Specification Value" then
                        FieldError(Specification, AG002);
                end;
        end;

        case ConfiguratorShape."Grit Rule" of
            ConfiguratorShape."grit rule"::Optional:
                begin
                    if Grit <> '' then
                        ConfiguratorGrit.Get(Grit)
                    else
                        ConfiguratorGrit.Init;
                end;
            ConfiguratorShape."grit rule"::Blank:
                begin
                    TestField(Grit, '');
                    ConfiguratorGrit.Init;
                end;
            ConfiguratorShape."grit rule"::Mandatory:
                begin
                    TestField(Grit);
                    ConfiguratorGrit.Get(Grit);
                end;
            ConfiguratorShape."grit rule"::Same:
                begin
                    TestField(Grit, ConfiguratorShape."Grit Value");
                    ConfiguratorGrit.Get(Grit);
                end;
            ConfiguratorShape."grit rule"::"Less Than":
                begin
                    if Grit > ConfiguratorShape."Grit Value" then
                        FieldError(Grit, AG001);
                end;
            ConfiguratorShape."grit rule"::"Greater Than":
                begin
                    if Grit < ConfiguratorShape."Grit Value" then
                        FieldError(Grit, AG002);
                end;
        end;

        case ConfiguratorShape."Joint Rule" of
            ConfiguratorShape."joint rule"::Optional:
                begin
                    if Joint <> '' then
                        ConfiguratorJoint.Get(Joint)
                    else
                        Clear(ConfiguratorJoint);
                    // ConfiguratorJoint.INIT;
                end;
            ConfiguratorShape."joint rule"::Blank:
                begin
                    TestField(Joint, '');
                    Clear(ConfiguratorJoint);
                    // ConfiguratorJoint.INIT;
                end;
            ConfiguratorShape."joint rule"::Mandatory:
                begin
                    TestField(Joint);
                    ConfiguratorJoint.Get(Joint);
                end;
            ConfiguratorShape."joint rule"::Same:
                begin
                    TestField(Joint, ConfiguratorShape."Joint Value");
                    ConfiguratorJoint.Get(Joint);
                end;
            ConfiguratorShape."joint rule"::"Less Than":
                begin
                    if Joint > ConfiguratorShape."Joint Value" then
                        FieldError(Joint, AG001);
                end;
            ConfiguratorShape."joint rule"::"Greater Than":
                begin
                    if Joint < ConfiguratorShape."Joint Value" then
                        FieldError(Joint, AG002);
                end;
        end;


        "Temp Configurator No." := GetConfiguratorNo;

        if (Status <> Status::"Valid Item") and ("Configurator No." <> "Temp Configurator No.") then begin
            if ConfiguratorItem.Get("Temp Configurator No.") then
                Error(AG006, "Temp Configurator No.");
        end;

        if not "Description OK" then
            "Item Description" :=
              CopyStr(
              StrSubstNo(ConfiguratorShape."Rule - Description",
              ConfiguratorShape."Item Description",
              ConfiguratorMaterial."Item Description",
              "Dim 1 Text",
              "Dim 2 Text",
              "Dim 3 Text",
              "Dim 4 Text",
              ConfiguratorSpecification."Item Description",
              ConfiguratorGrit."Item Description",
              ConfiguratorJoint."Item Description"),
              //>> CAS-40665-Y3X3S1
              //1,30);
              1, 100);
        //<< CAS-40665-Y3X3S1
        if not "Description 2 OK" then
            "Item Description 2" :=
              CopyStr(
              StrSubstNo(ConfiguratorShape."Rule - Description 2",
              ConfiguratorShape."Item Description 2",
              ConfiguratorMaterial."Item Description 2",
              "Dim 1 Text",
              "Dim 2 Text",
              "Dim 3 Text",
              "Dim 4 Text",
              ConfiguratorSpecification."Item Description 2",
              ConfiguratorGrit."Item Description 2",
              ConfiguratorJoint."Item Description 2"),
              //>> CAS-40665-Y3X3S1
              //    1,30);
              1, 50);
        //<< CAS-40665-Y3X3S1
        // Create BOM
        CalcFields("Item Created");
        if "Item Created" then begin
            with Item do begin
                Get(Rec."Item No.");
                if "Configurator No." <> Rec."Configurator No." then begin
                    "Configurator No." := Rec."Configurator No.";
                    Modify;
                    Reset;
                    SetCurrentkey("Configurator No.");
                    SetRange("Configurator No.", Rec."Configurator No.");
                    SetFilter("No.", '<>%1', Rec."Item No.");
                    ModifyAll(Blocked, true);
                end;
            end;
        end;


        Modify;
    end;


    procedure CreateItem(var NewRecVal: Record "Configurator Item")
    var
        tempconfno: Code[100];
        ConfPAGE: Page UnknownPage85001;
        l_ItemTrackCode: Record "Item Tracking Code";
    begin
        if "Do Not Create Item" then
            exit;
        ConfiguratorSetup.Get;
        CheckConfiguration;
        ConfiguratorItem.Init;
        ConfiguratorItem.Copy(Rec);
        ConfiguratorItem.TestField("Temp Configurator No.");
        ConfiguratorItem."Configurator No." := ConfiguratorItem."Temp Configurator No.";
        //
        tempconfno := ConfiguratorItem."Configurator No.";
        ConfiguratorItem.Insert;

        if "Configurator Suffix" = '' then
            CreateCfgSeries;
        ConfiguratorItem."Configurator Suffix" := "Configurator Suffix";

        Item.Init;
        Item."No." := ConfiguratorSetup."Item Prefix" + "Configurator Suffix";
        //Item."Sales Qty. Disc. Code" := Item."No.";
        Item."Base Unit of Measure" := "Base Unit of Measure";
        ItemUOM."Item No." := Item."No.";
        ItemUOM.Code := "Base Unit of Measure";
        ItemUOM."Qty. per Unit of Measure" := 1;
        //ECL LOT
        // 100615
        if ConfiguratorItem.Shape <> '' then
            GetShape;
        if ConfiguratorShape."Auto Lot Tracking" then begin
            l_ItemTrackCode.SetRange(l_ItemTrackCode."Auto Track", true);
            if l_ItemTrackCode.FindFirst then
                Item."Item Tracking Code" := l_ItemTrackCode.Code;
        end;
        //


        if ItemUOM.Insert then
          ;

        Item.Insert(true);

        //>> UE-651 Create Item Default Dimension
        if Shape <> '' then begin
            ConfiguratorShape.Get(Shape);
            DefaultDim.Validate("Table ID", 27);
            DefaultDim.Validate("No.", Item."No.");
            DefaultDim.Validate("Dimension Code", ConfiguratorShape."Def. Shape Dimension Code");
            DefaultDim.Validate("Dimension Value Code", ConfiguratorShape."Def. Shape Dim. Value Code");
            DefaultDim."Value Posting" := DefaultDim."value posting"::"Same Code";
            DefaultDim.Insert(true);
        end;
        if Material <> '' then begin
            ConfiguratorMaterial.Get(Material);
            DefaultDim.Validate("Table ID", 27);
            DefaultDim.Validate("No.", Item."No.");
            DefaultDim.Validate("Dimension Code", ConfiguratorMaterial."Def. Mat. Dimension Code");
            DefaultDim.Validate("Dimension Value Code", ConfiguratorMaterial."Def. Mat. Dim. Value Code");
            DefaultDim."Value Posting" := DefaultDim."value posting"::"Same Code";
            DefaultDim.Insert(true);
        end;
        if Grit <> '' then begin
            ConfiguratorGrit.Get(Grit);
            DefaultDim.Validate("Table ID", 27);
            DefaultDim.Validate("No.", Item."No.");
            DefaultDim.Validate("Dimension Code", ConfiguratorGrit."Def. Grit Dimension Code");
            DefaultDim.Validate("Dimension Value Code", ConfiguratorGrit."Def. Grit Dim. Value Code");
            DefaultDim."Value Posting" := DefaultDim."value posting"::"Same Code";
            DefaultDim.Insert(true);
        end;
        if Specification <> '' then begin
            ConfiguratorSpecification.Get(Specification);
            DefaultDim.Validate("Table ID", 27);
            DefaultDim.Validate("No.", Item."No.");
            DefaultDim.Validate("Dimension Code", ConfiguratorSpecification."Def. Spec. Dimension Code");
            DefaultDim.Validate("Dimension Value Code", ConfiguratorSpecification."Def. Spec. Dim. Value Code");
            DefaultDim."Value Posting" := DefaultDim."value posting"::"Same Code";
            DefaultDim.Insert(true);
        end;
        if Joint <> '' then begin
            ConfiguratorJoint.Get(Joint);
            DefaultDim.Validate("Table ID", 27);
            DefaultDim.Validate("No.", Item."No.");
            DefaultDim.Validate("Dimension Code", ConfiguratorJoint."Def. Joint Dimension Code");
            DefaultDim.Validate("Dimension Value Code", ConfiguratorJoint."Def. Joint Dim. Value Code");
            DefaultDim."Value Posting" := DefaultDim."value posting"::"Same Code";
            DefaultDim.Insert(true);
        end;

        //<< UE-651

        if ConfiguratorItem."Create New Raw Material" then begin
            ConfiguratorMaterialGrit.Get(ConfiguratorItem.Material, ConfiguratorItem.Grit);
            ConfiguratorMaterialGrit.TestField("Creating Raw Material Item");
            ConfiguratorMaterialGrit."Material Item No." := Item."No.";
            ConfiguratorMaterialGrit."Material Configurator No." := ConfiguratorItem."Configurator No.";
            ConfiguratorMaterialGrit."Creating Raw Material Item" := false;
            ConfiguratorMaterialGrit.Modify;
            ConfiguratorItem."Create New Raw Material" := false;
            ConfiguratorItem."Raw Material Created" := true;
        end;

        BuildBOMandRouting(not "Routing OK", not "BOM OK");

        ConfiguratorItem."Production BOM No." := "Production BOM No.";
        ConfiguratorItem."Routing No." := "Routing No.";
        ItemUpdateFields(Item, ConfiguratorItem, true, false);

        //>> UNE-192
        SalesPrice.Init;
        SalesPrice."Sales Type" := SalesPrice."sales type"::"Customer Price Group";
        SalesPrice.Validate("Sales Code", 'SAMPLE');
        SalesPrice."Starting Date" := Today;
        SalesPrice.Validate("Item No.", Item."No.");
        SalesPrice.Validate("Unit of Measure Code", Item."Base Unit of Measure");
        SalesPrice.Validate("Unit Price", 0.1);
        SalesPrice.Insert(true);
        //<< UNE-192


        ConfiguratorItem."Item No." := Item."No.";
        //>> UNE-165
        //ConfiguratorItem.Status := ConfiguratorItem.Status::Item;
        ConfiguratorItem.Status := ConfiguratorSetup."Configurator Item Status";
        //<< UNE-165
        ConfiguratorItem.Modify;
        Delete;
        ConfiguratorItem.SetRange("Configurator No.", tempconfno);
        if ConfiguratorItem.FindFirst then begin
            // CLEAR(Rec);
            // CLEAR(ConfPAGE);
            // ConfPAGE.SETTABLEVIEW(ConfiguratorItem);
            // ConfPAGE.SETRECORD(ConfiguratorItem);
            // ConfPAGE.RUN;
            NewRecVal := ConfiguratorItem;
        end;
        //>> EC VAR003
        //IF Shape <> '' THEN BEGIN
        //  IF ConfiguratorShape.GET(Shape) THEN BEGIN
        //    IF ConfiguratorShape."Create SKU's" THEN BEGIN
        if "Create SKU's" then begin
            Location.SetRange("Create SKU's", true);
            if Location.FindSet then
                repeat
                    if not StockkeepingUnit.Get(Location.Code, Item."No.", '') then begin
                        ItemVar.SetRange("Item No.", Item."No.");
                        if ItemVar.FindSet then begin
                            repeat
                                StockkeepingUnit.Init;
                                StockkeepingUnit."Item No." := Item."No.";
                                StockkeepingUnit."Location Code" := Location.Code;
                                StockkeepingUnit."Variant Code" := ItemVar.Code;
                                StockkeepingUnit."Shelf No." := Item."Shelf No.";
                                StockkeepingUnit."Standard Cost" := Item."Standard Cost";
                                StockkeepingUnit."Last Direct Cost" := Item."Last Direct Cost";
                                StockkeepingUnit."Unit Cost" := Item."Unit Cost";
                                StockkeepingUnit."Vendor No." := Item."Vendor No.";
                                StockkeepingUnit."Vendor Item No." := Item."Vendor Item No.";
                                StockkeepingUnit."Lead Time Calculation" := Item."Lead Time Calculation";
                                StockkeepingUnit."Reorder Point" := Item."Reorder Point";
                                StockkeepingUnit."Maximum Inventory" := Item."Maximum Inventory";
                                StockkeepingUnit."Reorder Quantity" := Item."Reorder Quantity";
                                StockkeepingUnit."Lot Size" := Item."Lot Size";
                                StockkeepingUnit."Reordering Policy" := Item."Reordering Policy";
                                StockkeepingUnit."Include Inventory" := Item."Include Inventory";
                                StockkeepingUnit."Assembly Policy" := Item."Assembly Policy";
                                StockkeepingUnit."Manufacturing Policy" := Item."Manufacturing Policy";
                                StockkeepingUnit."Discrete Order Quantity" := Item."Discrete Order Quantity";
                                StockkeepingUnit."Minimum Order Quantity" := Item."Minimum Order Quantity";
                                StockkeepingUnit."Maximum Order Quantity" := Item."Maximum Order Quantity";
                                StockkeepingUnit."Safety Stock Quantity" := Item."Safety Stock Quantity";
                                StockkeepingUnit."Order Multiple" := Item."Order Multiple";
                                StockkeepingUnit."Safety Lead Time" := Item."Safety Lead Time";
                                StockkeepingUnit."Flushing Method" := Item."Flushing Method";
                                if Location."Def. SKU Replenishment System" <> 4 then
                                    StockkeepingUnit."Replenishment System" := Location."Def. SKU Replenishment System"
                                else
                                    StockkeepingUnit."Replenishment System" := Item."Replenishment System";
                                if Location."Def. SKU Transfer-from Code" <> '' then
                                    StockkeepingUnit."Transfer-from Code" := Location."Def. SKU Transfer-from Code";
                                StockkeepingUnit."Time Bucket" := Item."Time Bucket";
                                StockkeepingUnit."Rescheduling Period" := Item."Rescheduling Period";
                                StockkeepingUnit."Lot Accumulation Period" := Item."Lot Accumulation Period";
                                StockkeepingUnit."Dampener Period" := Item."Dampener Period";
                                StockkeepingUnit."Dampener Quantity" := Item."Dampener Quantity";
                                StockkeepingUnit."Overflow Level" := Item."Overflow Level";
                                StockkeepingUnit."Last Date Modified" := WorkDate;
                                StockkeepingUnit."Special Equipment Code" := Item."Special Equipment Code";
                                StockkeepingUnit."Put-away Template Code" := Item."Put-away Template Code";
                                StockkeepingUnit."Phys Invt Counting Period Code" :=
                                  Item."Phys Invt Counting Period Code";
                                StockkeepingUnit."Put-away Unit of Measure Code" :=
                                  Item."Put-away Unit of Measure Code";
                                StockkeepingUnit."Use Cross-Docking" := Item."Use Cross-Docking";
                                //       StockkeepingUnit."Reordering Policy" := ConfiguratorShape."Def. SKU Reordering Policy";
                                StockkeepingUnit."Reordering Policy" := "Def. SKU Reordering Policy";

                                StockkeepingUnit.Shape := Item.Shape;  // UE-438
                                StockkeepingUnit.Insert(true);
                            until ItemVar.Next = 0;
                        end else begin
                            StockkeepingUnit.Init;
                            StockkeepingUnit."Item No." := Item."No.";
                            StockkeepingUnit."Location Code" := Location.Code;
                            StockkeepingUnit."Variant Code" := '';
                            StockkeepingUnit."Shelf No." := Item."Shelf No.";
                            StockkeepingUnit."Standard Cost" := Item."Standard Cost";
                            StockkeepingUnit."Last Direct Cost" := Item."Last Direct Cost";
                            StockkeepingUnit."Unit Cost" := Item."Unit Cost";
                            StockkeepingUnit."Vendor No." := Item."Vendor No.";
                            StockkeepingUnit."Vendor Item No." := Item."Vendor Item No.";
                            StockkeepingUnit."Lead Time Calculation" := Item."Lead Time Calculation";
                            StockkeepingUnit."Reorder Point" := Item."Reorder Point";
                            StockkeepingUnit."Maximum Inventory" := Item."Maximum Inventory";
                            StockkeepingUnit."Reorder Quantity" := Item."Reorder Quantity";
                            StockkeepingUnit."Lot Size" := Item."Lot Size";
                            StockkeepingUnit."Reordering Policy" := Item."Reordering Policy";
                            StockkeepingUnit."Include Inventory" := Item."Include Inventory";
                            StockkeepingUnit."Assembly Policy" := Item."Assembly Policy";
                            StockkeepingUnit."Manufacturing Policy" := Item."Manufacturing Policy";
                            StockkeepingUnit."Discrete Order Quantity" := Item."Discrete Order Quantity";
                            StockkeepingUnit."Minimum Order Quantity" := Item."Minimum Order Quantity";
                            StockkeepingUnit."Maximum Order Quantity" := Item."Maximum Order Quantity";
                            StockkeepingUnit."Safety Stock Quantity" := Item."Safety Stock Quantity";
                            StockkeepingUnit."Order Multiple" := Item."Order Multiple";
                            StockkeepingUnit."Safety Lead Time" := Item."Safety Lead Time";
                            StockkeepingUnit."Flushing Method" := Item."Flushing Method";
                            if Location."Def. SKU Replenishment System" <> 4 then
                                StockkeepingUnit."Replenishment System" := Location."Def. SKU Replenishment System"
                            else
                                StockkeepingUnit."Replenishment System" := Item."Replenishment System";
                            if Location."Def. SKU Transfer-from Code" <> '' then
                                StockkeepingUnit."Transfer-from Code" := Location."Def. SKU Transfer-from Code";
                            StockkeepingUnit."Time Bucket" := Item."Time Bucket";
                            StockkeepingUnit."Rescheduling Period" := Item."Rescheduling Period";
                            StockkeepingUnit."Lot Accumulation Period" := Item."Lot Accumulation Period";
                            StockkeepingUnit."Dampener Period" := Item."Dampener Period";
                            StockkeepingUnit."Dampener Quantity" := Item."Dampener Quantity";
                            StockkeepingUnit."Overflow Level" := Item."Overflow Level";
                            StockkeepingUnit."Last Date Modified" := WorkDate;
                            StockkeepingUnit."Special Equipment Code" := Item."Special Equipment Code";
                            StockkeepingUnit."Put-away Template Code" := Item."Put-away Template Code";
                            StockkeepingUnit."Phys Invt Counting Period Code" :=
                              Item."Phys Invt Counting Period Code";
                            StockkeepingUnit."Put-away Unit of Measure Code" :=
                              Item."Put-away Unit of Measure Code";
                            StockkeepingUnit."Use Cross-Docking" := Item."Use Cross-Docking";
                            //    StockkeepingUnit."Reordering Policy" := ConfiguratorShape."Def. SKU Reordering Policy";
                            StockkeepingUnit."Reordering Policy" := "Def. SKU Reordering Policy";
                            StockkeepingUnit.Shape := Item.Shape;  // UE-438

                            StockkeepingUnit.Insert(true);
                        end;
                    end;
                until Location.Next = 0;
        end;
        //END;
        //END;
        //<< EC VAR003
    end;


    procedure ValidateItem()
    begin
        CheckConfiguration;
        CalcFields("Item Created");
        TestField("Item Created");
        Item.Get("Item No.");

        ItemUpdateFields(Item, Rec, false, true);

        Status := ConfiguratorItem.Status::"Valid Item";
        Modify;
    end;


    procedure IsItemBlocked(): Boolean
    begin
        if (Status >= Status::Item) and ("Configurator No." <> GetConfiguratorNo) then
            exit(true);
        CalcFields("Item Blocked", "Item Created");
        if "Item Blocked" or not "Item Created" then
            exit(true);
        if (Shape = '') then
            exit(true);
        if not GetShape or ConfiguratorShape.Blocked then
            exit(true);
        if (ConfiguratorShape."Material Rule" >= ConfiguratorShape."material rule"::Mandatory) and (Material = '') then
            exit(true);
        if (Material <> '') then
            if not GetMaterial or ConfiguratorMaterial.Blocked then
                exit(true);
        if (ConfiguratorShape."Specification Rule" >= ConfiguratorShape."specification rule"::Mandatory) and (Specification = '') then
            exit(true);
        if (Specification <> '') then
            if not GetSpec or ConfiguratorSpecification.Blocked then
                exit(true);
        if (ConfiguratorShape."Grit Rule" >= ConfiguratorShape."grit rule"::Mandatory) and (Grit = '') then
            exit(true);
        if (Grit <> '') then
            if not GetGrit or ConfiguratorGrit.Blocked then
                exit(true);
        if (ConfiguratorShape."Joint Rule" >= ConfiguratorShape."joint rule"::Mandatory) and (Joint = '') then
            exit(true);
        if (Joint <> '') then
            if not GetJoint or ConfiguratorJoint.Blocked then
                exit(true);
        if ((Material <> '') and (Grit <> '')) then
            if not GetMaterialGrit or ConfiguratorMaterialGrit.Blocked then
                exit(true);
        exit(false);
    end;


    procedure ItemBlockedError()
    begin
        if Status >= Status::Item then
            TestField("Configurator No.", GetConfiguratorNo);
        CalcFields("Item Blocked");
        TestField("Item Blocked", false);
        if ("Item No." <> '') then begin
            Item.Get("Item No.");
            Item.TestField(Blocked, false);
        end;
        if (Shape <> '') then begin
            ConfiguratorShape.Get(Shape);
            ConfiguratorShape.TestField(Blocked, false);
        end;
        if (Material <> '') then begin
            ConfiguratorMaterial.Get(Material);
            ConfiguratorMaterial.TestField(Blocked, false);
        end;
        if (Specification <> '') then begin
            ConfiguratorSpecification.Get(Specification);
            ConfiguratorSpecification.TestField(Blocked, false);
        end;
        if (Grit <> '') then begin
            ConfiguratorGrit.Get(Grit);
            ConfiguratorGrit.TestField(Blocked, false);
        end;
        if (Joint <> '') then begin
            ConfiguratorJoint.Get(Joint);
            ConfiguratorJoint.TestField(Blocked, false);
        end;
        if ((Material <> '') and (Grit <> '')) then begin
            ConfiguratorMaterialGrit.Get(Material, Grit);
            ConfiguratorMaterialGrit.TestField(Blocked, false);
        end;
    end;


    procedure ItemUpdateFields(var Item: Record Item; var SourceConfiguratorItem: Record "Configurator Item"; CreateNew: Boolean; UpdateHistory: Boolean)
    begin
        with SourceConfiguratorItem do begin
            //UNE-191
            Item.Validate("Configurator No.", "Configurator No.");
            Item.Validate(Description, "Item Description");
            Item.Validate("Description 2", "Item Description 2");




            ItemUOM."Item No." := Item."No.";
            ItemUOM.Code := "Base Unit of Measure";
            ItemUOM."Qty. per Unit of Measure" := 1;
            if ItemUOM.Insert then
              ;

            if CreateNew then begin
                Item."Inventory Posting Group" := "Inventory Posting Group";
                Item."Gen. Prod. Posting Group" := "Gen. Prod. Posting Group";
                //    Item."Tax Bus. Posting Gr. (Price)" := "Tax Bus. Posting Gr. (Price)";
                Item."Tax Group Code" := "Tax Group Code";
                //    Item."Tax Prod. Posting Group" := "Tax Prod. Posting Group";

                Item."Unit Price" := "Unit Price";
                Item."Unit Cost" := "Standard Cost";
                Item."Standard Cost" := "Standard Cost";
                Item."Last Direct Cost" := "Standard Cost";
                //UE-142 start
                Item."Include Inventory" := "Include Inventory";
                //UE-142 end
            end;

            if (not CreateNew) and UpdateHistory then
                if
                  (Item.Material <> Material) or
                  (Item.Specification <> Specification) or
                  (Item.Grit <> Grit) or
                  (Item.Joint <> Joint) then
                    UpdateILEHistory(Item, SourceConfiguratorItem);

            Item.Shape := Shape;
            Item.Material := Material;
            Item."Dimension 1" := "Dimension 1";
            Item."Dimension 2" := "Dimension 2";
            Item."Dimension 3" := "Dimension 3";
            //  Item."Dimension 4" := "Dimension 4";
            Item.Specification := Specification;
            Item.Grit := Grit;
            Item.Joint := Joint;
            Item."File Pro No." := "File Pro No.";
            Item."Routing No." := "Routing No.";
            Item."Production BOM No." := "Production BOM No.";
            // for raw materials craeted manually
            if not "Raw Material Created" then begin
                CalcFields("Item Created", "Raw Material Item No.");
                if "Item Created" and ("Raw Material Item No." = "Item No.") then
                    "Raw Material Created" := true;
            end;
            Item."Raw Material Roll" := "Raw Material Created";

            GetShape;
            //  Item."Requisition Method Code" := ConfiguratorShape."Requisition Method Code";
            //  Item."Requisition System" := ConfiguratorShape."Requisition System";
            //>> VAR003
            Item."Replenishment System" := ConfiguratorItem."Requisition System";
            Item."Manufacturing Policy" := ConfiguratorItem."Manufacturing Policy";
            //<< VAR003

            // ConfiguratorItem."Requisition Method Code" := ConfiguratorShape."Requisition Method Code";
            ConfiguratorItem."Manufacturing Policy" := ConfiguratorShape."Manufacturing Policy";

            ConfiguratorItem."Requisition System" := ConfiguratorShape."Requisition System";
            //>> VAR003
            //"Requisition Method Code" := ConfiguratorShape."Requisition Method Code";
            "Manufacturing Policy" := ConfiguratorShape."Manufacturing Policy";
            //<< VAR003
            "Requisition System" := ConfiguratorShape."Requisition System";

            //UE-193 start
            Item."Catalog No." := "Catalog No.";
            Item."Material Type" := "Material Type";
            Item."Quantity 1" := "Quantity 1";
            Item."Quantity 2" := "Quantity 2";
            Item."Quantity 3" := "Quantity 3";
            Item."Quantity 4" := "Quantity 4";
            Item."UOM 1" := "UOM 1";
            Item."UOM 2" := "UOM 2";
            Item."UOM 3" := "UOM 3";
            Item."UOM 4" := "UOM 4";
            //UE-192 end

            Item."Base Unit of Measure" := "Base Unit of Measure";
            Item."Sales Unit of Measure" := "Base Unit of Measure";
            Item."Purch. Unit of Measure" := "Base Unit of Measure";
            //EC1,01  08.31.15
            //Item.Reserve := Item.Reserve::Always;
            Item.Reserve := Item.Reserve::Optional;
            //EC1.01  08.31.15
            Item.Modify;
        end;
    end;


    procedure BuildBOMandRouting(BuildRouting: Boolean; BuildBOM: Boolean)
    begin
        GetShape;
        if ConfiguratorShape."BOM and Routing Required" then begin
            if BuildBOM then begin
                CreateBOM;
                CreateBOMLines;
            end;
            if BuildRouting then begin
                CreateRouting;
                CreateRoutingLines;
            end;
        end;
    end;


    procedure CreateBOM()
    begin
        ConfiguratorSetup.Get;
        if not ProductionBOM.Get("Production BOM No.") then begin
            ProductionBOM.Init;
            if "Configurator Suffix" = '' then
                CreateCfgSeries;
            ProductionBOM."No." := ConfiguratorSetup."BOM Prefix" + "Configurator Suffix";
            if ProductionBOM.Insert() then
              ;
            "Production BOM No." := ProductionBOM."No.";
        end;
        ProductionBOM."Unit of Measure Code" := "Base Unit of Measure";
        // there is a commit in here
        ProductionBOM.Validate(Status, ProductionBOM.Status::"Under Development");
        ProductionBOM.Description := "Item Description";
        ProductionBOM."Description 2" := "Item Description 2";
        ProductionBOM.Modify;
    end;


    procedure CreateBOMLines()
    begin
        if not "BOM OK" then
            with ProductionBOMLines do begin
                Reset;
                SetRange("Production BOM No.", ProductionBOM."No.");
                DeleteAll;
                NextLineNo := 10000;
                if GetMaterial then
                    if ConfiguratorMaterial."Default BOM No." <> '' then
                        AddBOMLines(ConfiguratorMaterial."Default BOM No.");
                if GetJoint then
                    if ConfiguratorJoint."Default BOM No." <> '' then
                        AddBOMLines(ConfiguratorJoint."Default BOM No.");
                if GetShape then
                    if ConfiguratorShape."BOM No." <> '' then
                        AddBOMLines(ConfiguratorShape."BOM No.");
                if GetSpec then
                    if ConfiguratorSpecification."Default BOM No." <> '' then
                        AddBOMLines(ConfiguratorSpecification."Default BOM No.");
                if Find('-') then begin
                    // skip message
                    //        ProductionBOM.SetHideStatus;
                    // there is a commit in here
                    ProductionBOM.Validate(Status, ProductionBOM.Status::Certified);

                    ProductionBOM.Modify;
                end else begin
                    ProductionBOM.Delete;
                    Rec."Production BOM No." := '';
                end;
            end;
    end;


    procedure AddBOMLines(BOMHeader: Code[20])
    begin
        ProductionBOMComp.Reset;
        ProductionBOMComp.SetRange("Production BOM No.", BOMHeader);
        ProductionBOMComp.SetFilter("Configurator Type", '<>%1', ProductionBOMComp."configurator type"::"BOM Line");
        if ProductionBOMComp.Find('-') then begin
            repeat
                with ProductionBOMLines do begin
                    Copy(ProductionBOMComp);
                    "Production BOM No." := Rec."Production BOM No.";
                    "Line No." := NextLineNo;
                    NextLineNo += 10000;
                    case "Configurator Type" of
                        "configurator type"::"Material-Grit":
                            begin
                                "Configurator Type" := "configurator type"::"BOM Line";
                                ConfiguratorMaterialGrit.Get(Rec.Material, Rec.Grit);
                                ConfiguratorMaterialGrit.TestField("Material Item No.");
                                Type := Type::Item;
                                Validate("No.", ConfiguratorMaterialGrit."Material Item No.");
                            end;
                        "configurator type"::Configurator:
                            begin
                                "Configurator Type" := "configurator type"::"BOM Line";
                            end;
                    end;

                    case "Configurator Calc. per Meter" of
                        "configurator calc. per meter"::" ":
                            ;
                        "configurator calc. per meter"::Factor:
                            "Quantity per" := ProductionBOMComp."Configurator Factor";
                        "configurator calc. per meter"::FactorxD1:
                            "Quantity per" := ProductionBOMComp."Configurator Factor" * "Quantity 1" / 39;
                        "configurator calc. per meter"::FactorxD2:
                            "Quantity per" := ProductionBOMComp."Configurator Factor" * "Quantity 2" / 39;
                        "configurator calc. per meter"::FactorxD1xD2:
                            "Quantity per" := ProductionBOMComp."Configurator Factor" * "Quantity 1" * "Quantity 2" / 39 / 39;
                        "configurator calc. per meter"::"FactorxD1^2":
                            "Quantity per" := ProductionBOMComp."Configurator Factor" * "Quantity 1" * "Quantity 1" / 39 / 39;
                        else
                            FieldError("Configurator Calc. per Meter", AG007);
                    end;
                    Validate("Unit of Measure Code");
                    Validate("Quantity per");
                    Quantity := "Quantity per";
                    "Calculation Formula" := "calculation formula"::" ";
                    Insert;
                end;
            until ProductionBOMComp.Next = 0
        end;
    end;


    procedure CreateRouting()
    begin
        ConfiguratorSetup.Get;
        if not Routing.Get("Routing No.") then begin
            if "Configurator Suffix" = '' then
                CreateCfgSeries;
            Routing.Init;
            Routing."No." := ConfiguratorSetup."Routing Prefix" + "Configurator Suffix";
            if Routing.Insert() then
              ;
            "Routing No." := Routing."No.";
        end;
        Routing.Description := "Item Description";
        Routing."Description 2" := "Item Description 2";
        // there is a commit in here
        Routing.Validate(Status, Routing.Status::"Under Development");
        GetShape;
        //Routing."Std. Production Run Qty." := ConfiguratorShape."Std. Production Run Qty.";
        Routing.Modify;
    end;


    procedure CreateRoutingLines()
    begin
        if not "Routing OK" then
            with RoutingLines do begin
                Reset;
                SetRange("Routing No.", Routing."No.");
                DeleteAll;
                NextLineNo := 10000;
                if ConfiguratorMaterial.Get(Material) then
                    if ConfiguratorMaterial."Default Routing No." <> '' then
                        AddRoutingLines(ConfiguratorMaterial."Default Routing No.");
                if ConfiguratorJoint.Get(Joint) then
                    if ConfiguratorJoint."Default Routing No." <> '' then
                        AddRoutingLines(ConfiguratorJoint."Default Routing No.");
                if GetShape then
                    if ConfiguratorShape."BOM No." <> '' then
                        AddRoutingLines(ConfiguratorShape."Routing No.");
                if ConfiguratorSpecification.Get(Specification) then
                    if ConfiguratorSpecification."Default Routing No." <> '' then
                        AddRoutingLines(ConfiguratorSpecification."Default Routing No.");
                if Find('-') then begin
                    // there is a commit in here
                    Routing.Validate(Status, Routing.Status::Certified);
                    Routing.Modify;
                end else begin
                    Routing.Delete;
                    Rec."Routing No." := '';
                end;
            end;
    end;


    procedure AddRoutingLines(RoutingHeader: Code[20])
    begin
        RoutingComp.Reset;
        RoutingComp.SetRange("Routing No.", RoutingHeader);
        if RoutingComp.Find('-') then begin
            repeat
                with RoutingLines do begin
                    Copy(RoutingComp);
                    "Routing No." := Rec."Routing No.";
                    "Operation No." := Format(NextLineNo);
                    NextLineNo += 10;
                    /* CASE Calculation OF
                       Calculation::Qty :
                         "Quantity per" := routingComp."Quantity per";
                       Calculation::QtyxD1 :
                         "Quantity per" := routingComp."Quantity per" * "Quantity 1";
                       Calculation::QtyxD2 :
                         "Quantity per" := routingComp."Quantity per" * "Quantity 2";
                       Calculation::QtyxD1xD2 :
                         "Quantity per" := routingComp."Quantity per" * "Quantity 1" * "Quantity 2";
                     END;*/
                    // Quantity := "Quantity per";
                    // "Calculation Formula" := "Calculation Formula"::" ";
                    Insert;
                end;
            until RoutingComp.Next = 0
        end;

    end;


    procedure SetDimLen(var Dimension: Code[10]; Length: Integer; FieldName: Text[50]; Rule: Option Optional,Blank,Mandatory,Same,"Less Than","Greater Than")
    begin
        if Length = 0 then
            exit;
        if (Rule = Rule::Optional) and (Dimension = '') then
            exit;
        if Length > 10 then
            Length := 10;
        if StrLen(Dimension) > Length then
            Error(AG005, FieldName, Dimension, Length);
        while StrLen(Dimension) < Length do
            Dimension := '0' + Dimension;
    end;


    procedure CopyNewConfigurator()
    begin
        with ConfiguratorItem do begin
            Init;
            "Configurator No." := '';
            Insert(true);
            Validate(Shape, Rec.Shape);
            Validate(Material, Rec.Material);
            Validate("Dimension 1", Rec."Dimension 1");
            Validate("Dimension 2", Rec."Dimension 2");
            Validate("Dimension 3", Rec."Dimension 3");
            Validate("Dimension 4", Rec."Dimension 4");
            Validate(Specification, Rec.Specification);
            Validate(Grit, Rec.Grit);
            Validate(Joint, Rec.Joint);
            Modify;
        end;
        Rec.Copy(ConfiguratorItem);
        Find;
    end;


    procedure UpdateILEHistory(Item: Record Item; ConfiguratorItem: Record "Configurator Item")
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
    end;


    procedure GetConfiguratorNo(): Code[100]
    begin
        exit(
          Shape +
          Material +
          "Dimension 1" +
          "Dimension 2" +
          "Dimension 3" +
          "Dimension 4" +
          Specification +
          Grit +
          Joint);
    end;


    procedure GetShape(): Boolean
    begin
        if (ConfiguratorShape.Code = Shape) and (Shape <> '') then
            exit(true);
        if ConfiguratorShape.Get(Shape) then
            if not ConfiguratorShape.Blocked then
                exit(true);
        ConfiguratorShape.Init;
        exit(false);
    end;


    procedure GetMaterial(): Boolean
    begin
        if (ConfiguratorMaterial.Code = Material) and (Material <> '') then
            exit(true);
        if ConfiguratorMaterial.Get(Material) then
            if not ConfiguratorMaterial.Blocked then
                exit(true);
        ConfiguratorMaterial.Init;
        exit(false);
    end;


    procedure GetSpec(): Boolean
    begin
        if (ConfiguratorSpecification.Code = Specification) and (Specification <> '') then
            exit(true);
        if ConfiguratorSpecification.Get(Specification) then
            if not ConfiguratorSpecification.Blocked then
                exit(true);
        ConfiguratorSpecification.Init;
        exit(false);
    end;


    procedure GetGrit(): Boolean
    begin
        if (ConfiguratorGrit.Code = Grit) and (Grit <> '') then
            exit(true);
        if ConfiguratorGrit.Get(Grit) then
            if not ConfiguratorGrit.Blocked then
                exit(true);
        ConfiguratorGrit.Init;
        exit(false);
    end;


    procedure GetJoint(): Boolean
    begin
        if (ConfiguratorJoint.Code = Joint) and (Joint <> '') then
            exit(true);
        if ConfiguratorJoint.Get(Joint) then
            if not ConfiguratorJoint.Blocked then
                exit(true);
        Clear(ConfiguratorJoint);
        // ConfiguratorJoint.INIT;
        exit(false);
    end;


    procedure GetMaterialGrit(): Boolean
    begin
        if (Material = '') or (Grit = '') then begin
            ConfiguratorMaterialGrit.Init;
            exit(false);
        end;
        if (ConfiguratorMaterialGrit."Material Code" = Material) and (ConfiguratorMaterialGrit."Grit Code" = Grit) then
            exit(true);
        if ConfiguratorMaterialGrit.Get(Material, Grit) then
            if not ConfiguratorMaterialGrit.Blocked then
                exit(true);
        ConfiguratorMaterialGrit.Init;
        exit(false);
    end;


    procedure ClearConfig()
    begin
        Clear(ConfiguratorItem);
        Clear(ConfiguratorShape);
        Clear(ConfiguratorMaterial);
        Clear(ConfiguratorSpecification);
        Clear(ConfiguratorGrit);
        Clear(ConfiguratorJoint);
        Clear(ConfiguratorMaterialGrit);
    end;

    local procedure CheckDimValid(DimString: Code[10]) isValid: Boolean
    begin
        if DimString = '' then exit(true);
        DimString := DelChr(DimString, '=', '0');
        if StrLen(DimString) = 0 then
            exit(false)
        else
            exit(true);
    end;

    local procedure GetCaption(Dimval: Integer) Captionval: Text[80]
    var
        LShapeREC: Record "Configurator Shape";
    begin
        exit(LShapeREC.ReturnCaptionVal(Shape, Dimval));
    end;


    procedure BuildBOMandRoutingVer(BuildRouting: Boolean; BuildBOM: Boolean)
    var
        ItemT: Record Item;
    begin
        //>>UE-619
        if ItemT.Get("Item No.") then
            CalcFields("Raw Material Item No.");
        if ItemT.Get("Raw Material Item No.") then begin
            GetShape;
            if ConfiguratorShape."BOM and Routing Required" then begin
                if BuildBOM then
                    if "Production BOM No." <> '' then begin
                        CreateBOMVer;
                        CreateBOMLinesVer;
                    end;
                if BuildRouting then
                    if "Routing No." <> '' then begin
                        CreateRoutingVer;
                        CreateRoutingLinesVer;
                    end;
            end;
        end;
    end;


    procedure CreateBOMVer()
    begin
        //>>UE-619
        ConfiguratorSetup.Get;
        ProductionBOM.Get("Production BOM No.");
        ProductionBOMVer.Init;
        ProductionBOMVer.SetRange("Production BOM No.", ProductionBOM."No.");
        if not ProductionBOMVer.FindLast then
            ProductionBOMVer."Version Code" := '1'
        else
            ProductionBOMVer."Version Code" := IncStr(ProductionBOMVer."Version Code");
        ProductionBOMVer."Production BOM No." := ProductionBOM."No.";
        if ProductionBOMVer.Insert() then;

        ProductionBOMVer."Unit of Measure Code" := ProductionBOM."Unit of Measure Code";
        ProductionBOMVer.Validate(Status, ProductionBOM.Status::"Under Development");
        ProductionBOMVer.Description := ProductionBOM.Description;
        ProductionBOMVer.Modify;
    end;


    procedure CreateBOMLinesVer()
    begin
        //>>UE-619
        if not "BOM OK" then
            with ProductionBOMLines do begin
                Reset;
                NextLineNo := 10000;
                ProductionBOMLines."Version Code" := ProductionBOMVer."Version Code";
                if GetMaterial then
                    if ConfiguratorMaterial."Default BOM No." <> '' then
                        AddBOMLinesVer(ConfiguratorMaterial."Default BOM No.", ProductionBOMLines."Version Code");
                if GetJoint then
                    if ConfiguratorJoint."Default BOM No." <> '' then
                        AddBOMLinesVer(ConfiguratorJoint."Default BOM No.", ProductionBOMLines."Version Code");
                if GetShape then
                    if ConfiguratorShape."BOM No." <> '' then
                        AddBOMLinesVer(ConfiguratorShape."BOM No.", ProductionBOMLines."Version Code");
                if GetSpec then
                    if ConfiguratorSpecification."Default BOM No." <> '' then
                        AddBOMLinesVer(ConfiguratorSpecification."Default BOM No.", ProductionBOMLines."Version Code");
                if Find('-') then
                    ProductionBOMVer.Validate(Status, ProductionBOMVer.Status::Certified);

                ProductionBOMVer.Modify;
            end;
    end;


    procedure AddBOMLinesVer(BOMHeader: Code[20]; BOMVer: Code[10])
    begin
        //>>UE-619
        ProductionBOMComp.Reset;
        ProductionBOMComp.SetRange("Production BOM No.", BOMHeader);
        //ProductionBOMComp.SETRANGE("Version Code",BOMVer);
        ProductionBOMComp.SetFilter("Configurator Type", '<>%1', ProductionBOMComp."configurator type"::"BOM Line");

        if ProductionBOMComp.Find('-') then begin
            repeat
                with ProductionBOMLines do begin
                    Copy(ProductionBOMComp);
                    "Production BOM No." := Rec."Production BOM No.";
                    "Version Code" := BOMVer;
                    "Line No." := NextLineNo;
                    NextLineNo += 10000;
                    case "Configurator Type" of
                        "configurator type"::"Material-Grit":
                            begin
                                "Configurator Type" := "configurator type"::"BOM Line";
                                ConfiguratorMaterialGrit.Get(Rec.Material, Rec.Grit);
                                ConfiguratorMaterialGrit.TestField("Material Item No.");
                                Type := Type::Item;
                                Validate("No.", ConfiguratorMaterialGrit."Material Item No.");
                            end;
                        "configurator type"::Configurator:
                            begin
                                "Configurator Type" := "configurator type"::"BOM Line";
                            end;
                    end;

                    case "Configurator Calc. per Meter" of
                        "configurator calc. per meter"::" ":
                            ;
                        "configurator calc. per meter"::Factor:
                            "Quantity per" := ProductionBOMComp."Configurator Factor";
                        "configurator calc. per meter"::FactorxD1:
                            "Quantity per" := ProductionBOMComp."Configurator Factor" * "Quantity 1" / 39;
                        "configurator calc. per meter"::FactorxD2:
                            "Quantity per" := ProductionBOMComp."Configurator Factor" * "Quantity 2" / 39;
                        "configurator calc. per meter"::FactorxD1xD2:
                            "Quantity per" := ProductionBOMComp."Configurator Factor" * "Quantity 1" * "Quantity 2" / 39 / 39;
                        "configurator calc. per meter"::"FactorxD1^2":
                            "Quantity per" := ProductionBOMComp."Configurator Factor" * "Quantity 1" * "Quantity 1" / 39 / 39;
                        else
                            FieldError("Configurator Calc. per Meter", AG007);
                    end;
                    Validate("Unit of Measure Code");
                    Validate("Quantity per");
                    Quantity := "Quantity per";
                    "Calculation Formula" := "calculation formula"::" ";
                    Insert;
                end;
            until ProductionBOMComp.Next = 0
        end;
    end;


    procedure CreateRoutingVer()
    begin
        //>>UE-619
        ConfiguratorSetup.Get;

        /*--->> 4/3/19
        IF NOT Routing.GET("Routing No.") THEN BEGIN
          IF "Configurator Suffix" = '' THEN
            CreateCfgSeries;
          Routing.INIT;
          Routing."No." := ConfiguratorSetup."Routing Prefix" + "Configurator Suffix";
          IF Routing.INSERT() THEN
            ;
          "Routing No." := Routing."No.";
        END;
        Routing.Description := "Item Description";
        Routing."Description 2" := "Item Description 2";
        // there is a commit in here
        Routing.VALIDATE(Status,Routing.Status::"Under Development");
        GetShape;
        //Routing."Std. Production Run Qty." := ConfiguratorShape."Std. Production Run Qty.";
        Routing.MODIFY;
        
        << 4/3/19---*/

        Routing.Get("Routing No.");
        RoutingVer.Init;
        RoutingVer.SetRange("Routing No.", Routing."No.");
        if not RoutingVer.FindLast then
            RoutingVer."Version Code" := '1'
        else
            RoutingVer."Version Code" := IncStr(RoutingVer."Version Code");
        RoutingVer."Routing No." := Routing."No.";
        if RoutingVer.Insert() then;
        RoutingVer.Validate(Status, RoutingVer.Status::"Under Development");
        RoutingVer.Modify;

    end;


    procedure CreateRoutingLinesVer()
    begin
        //>>UE-619
        RoutingLines.SetRange("Version Code", '');
        if not "Routing OK" then
            with RoutingLines do begin
                Reset;
                /*------>> 4/3/19
                      SETRANGE("Routing No.",Routing."No.");
                      DELETEALL;
                      NextLineNo := 10000;
                      IF ConfiguratorMaterial.GET(Material) THEN
                        IF ConfiguratorMaterial."Default Routing No." <> '' THEN
                          AddRoutingLines(ConfiguratorMaterial."Default Routing No.");
                      IF ConfiguratorJoint.GET(Joint) THEN
                        IF ConfiguratorJoint."Default Routing No." <> '' THEN
                          AddRoutingLines(ConfiguratorJoint."Default Routing No.");
                      IF GetShape THEN
                        IF ConfiguratorShape."BOM No." <> '' THEN
                          AddRoutingLines(ConfiguratorShape."Routing No.");
                      IF ConfiguratorSpecification.GET(Specification) THEN
                        IF ConfiguratorSpecification."Default Routing No." <> '' THEN
                          AddRoutingLines(ConfiguratorSpecification."Default Routing No.");
                      IF FIND('-') THEN BEGIN
                // there is a commit in here
                        Routing.VALIDATE(Status,Routing.Status::Certified);
                        Routing.MODIFY;
                      END ELSE BEGIN
                        Routing.DELETE;
                        Rec."Routing No." := '';
                      END;
                    END;
                <<-----*/

                NextLineNo := 10000;
                RoutingLines."Version Code" := RoutingVer."Version Code";
                if GetMaterial then
                    if ConfiguratorMaterial."Default Routing No." <> '' then
                        AddRoutingLinesVer(ConfiguratorMaterial."Default Routing No.", RoutingLines."Version Code");
                if GetJoint then
                    if ConfiguratorJoint."Default Routing No." <> '' then
                        AddRoutingLinesVer(ConfiguratorJoint."Default Routing No.", RoutingLines."Version Code");
                if GetShape then
                    if ConfiguratorShape."BOM No." <> '' then
                        AddRoutingLinesVer(ConfiguratorShape."Routing No.", RoutingLines."Version Code");
                if GetSpec then
                    if ConfiguratorSpecification."Default Routing No." <> '' then
                        AddRoutingLinesVer(ConfiguratorSpecification."Default Routing No.", RoutingLines."Version Code");
                if FindFirst then
                    RoutingVer.Validate(Status, RoutingVer.Status::Certified);
                RoutingVer.Modify;
            end;

    end;


    procedure AddRoutingLinesVer(RoutingHeader: Code[20]; RoutingVer: Code[10])
    begin
        //>> UE-619
        RoutingComp.Reset;
        RoutingComp.SetRange("Routing No.", RoutingHeader);
        RoutingComp.SetRange("Version Code", '');
        if RoutingComp.Find('-') then begin
            repeat
                with RoutingLines do begin
                    Copy(RoutingComp);
                    "Routing No." := Rec."Routing No.";
                    "Version Code" := RoutingVer;
                    "Operation No." := Format(NextLineNo);
                    NextLineNo += 10;
                    Insert;
                end;
            until RoutingComp.Next = 0
        end;
    end;
}

