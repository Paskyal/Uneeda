Table 85002 "NV8 Configurator Shape"
{
    // EC VAR003  08.25.15  BJM Added fields 50004..50006
    //            09.02.15  DB  Add field 50007
    // EC Lot  10/6/15 DB  Add field "Auto Lot Tracking"
    // UE-438  5/6/16  DB  Add Reorder Calculation Options
    // UE-415  5/9/16  DB  Add Past Due Date Filter
    // UE-651  2/28/20 DB  Add Def. Shape Dimension Code
    // UE-651  DB  66/13/20  Expand Item Description and Item Description 2 to 50
    // UE-683  DB  12/9/20 Change Option from Both to All(S-T-AC)
    // UNE-158 DB  11/17/21  Add Current  Production  Date field
    // UNE-174 DB  11/18/21  Add "Shape Production Area" field
    // TODO PAP
    // DrillDownPageID = UnknownPage85004;
    // LookupPageID = UnknownPage85004;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(10; Description; Text[30])
        {
        }
        field(11; "Description 2"; Text[30])
        {
        }
        field(30; "Item Description"; Text[50])
        {
            Description = 'UE-651';
        }
        field(31; "Item Description 2"; Text[50])
        {
            Description = 'UE-651';
        }
        field(35; "Rule - Description"; Text[80])
        {
        }
        field(36; "Rule - Description 2"; Text[80])
        {
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
            Description = '****';
        }
        field(44; "Tax Group Code"; Code[10])
        {
            TableRelation = "Tax Group";
        }
        field(45; "Tax Prod. Posting Group"; Code[10])
        {
            Description = '****';
        }
        field(46; "Requisition Method Code"; Code[10])
        {
            Description = '*****';
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
        field(55; "BOM No."; Code[20])
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
        field(100; "Dimensioned Roll"; Boolean)
        {
            Description = 'This Shape may be used as a raw material for manufacturing';
        }
        field(102; "Dimensioned Length"; Boolean)
        {
            Description = 'Indicates that Length should be reserved';
        }
        field(103; "Length Tollerance %"; Decimal)
        {
            DecimalPlaces = 1 : 1;
            MaxValue = 100;
            MinValue = 0;
        }
        field(110; "BOM and Routing Required"; Boolean)
        {
        }
        field(120; "Material Rule"; Option)
        {
            OptionCaption = 'Optional,Blank,Mandatory,Same,Less Than,Greater Than';
            OptionMembers = Optional,Blank,Mandatory,Same,"Less Than","Greater Than";
        }
        field(121; "Material Value"; Code[10])
        {
        }
        field(122; "Material List"; Integer)
        {
            CalcFormula = count("NV8 Configurator Material");
            Description = 'Drill down to table';
            Editable = false;
            FieldClass = FlowField;
        }
        field(125; "Material Code Length"; Integer)
        {
            MaxValue = 10;
            MinValue = 0;
        }
        field(126; "Material BOM Required"; Boolean)
        {
        }
        field(130; "Dimension 1 Rule"; Option)
        {
            OptionCaption = 'Optional,Blank,Mandatory,Same,Less Than,Greater Than';
            OptionMembers = Optional,Blank,Mandatory,Same,"Less Than","Greater Than";
        }
        field(131; "Dimension 1 Value"; Code[10])
        {
        }
        field(132; "Dimension 1 List"; Integer)
        {
            Description = 'Drill down to table';
        }
        field(135; "Dimension 1 Code Length"; Integer)
        {
            MaxValue = 10;
            MinValue = 0;
        }
        field(136; "Dimension 1 Caption"; Text[30])
        {
            Description = 'EC1.INV4.01';
        }
        field(140; "Dimension 2 Rule"; Option)
        {
            OptionCaption = 'Optional,Blank,Mandatory,Same,Less Than,Greater Than';
            OptionMembers = Optional,Blank,Mandatory,Same,"Less Than","Greater Than";
        }
        field(141; "Dimension 2 Value"; Code[10])
        {
        }
        field(142; "Dimension 2 List"; Integer)
        {
            Description = 'Drill down to table';
        }
        field(145; "Dimension 2 Code Length"; Integer)
        {
            MaxValue = 10;
            MinValue = 0;
        }
        field(146; "Dimension 2 Caption"; Text[30])
        {
            Description = 'EC1.INV4.01';
        }
        field(150; "Dimension 3 Rule"; Option)
        {
            OptionCaption = 'Optional,Blank,Mandatory,Same,Less Than,Greater Than';
            OptionMembers = Optional,Blank,Mandatory,Same,"Less Than","Greater Than";
        }
        field(151; "Dimension 3 Value"; Code[10])
        {
        }
        field(152; "Dimension 3 List"; Integer)
        {
            Description = 'Drill down to table';
        }
        field(155; "Dimension 3 Code Length"; Integer)
        {
            MaxValue = 10;
            MinValue = 0;
        }
        field(156; "Dimension 3 Caption"; Text[30])
        {
            Description = 'EC1.INV4.01';
        }
        field(160; "Dimension 4 Rule"; Option)
        {
            OptionCaption = 'Optional,Blank,Mandatory,Same,Less Than,Greater Than';
            OptionMembers = Optional,Blank,Mandatory,Same,"Less Than","Greater Than";
        }
        field(161; "Dimension 4 Value"; Code[10])
        {
        }
        field(162; "Dimension 4 List"; Integer)
        {
            Description = 'Drill down to table';
        }
        field(165; "Dimension 4 Code Length"; Integer)
        {
            MaxValue = 10;
            MinValue = 0;
        }
        field(166; "Dimension 4 Caption"; Text[30])
        {
            Description = 'EC1.INV4.01';
        }
        field(170; "Specification Rule"; Option)
        {
            OptionCaption = 'Optional,Blank,Mandatory,Same,Less Than,Greater Than';
            OptionMembers = Optional,Blank,Mandatory,Same,"Less Than","Greater Than";
        }
        field(171; "Specification Value"; Code[10])
        {
        }
        field(172; "Specification List"; Integer)
        {
            CalcFormula = count("NV8 Configurator Specification");
            Description = 'Drill down to table';
            Editable = false;
            FieldClass = FlowField;
        }
        field(175; "Specification Code Length"; Integer)
        {
            MaxValue = 10;
            MinValue = 0;
        }
        field(176; "Specification BOM Required"; Boolean)
        {
        }
        field(180; "Grit Rule"; Option)
        {
            OptionCaption = 'Optional,Blank,Mandatory,Same,Less Than,Greater Than';
            OptionMembers = Optional,Blank,Mandatory,Same,"Less Than","Greater Than";
        }
        field(181; "Grit Value"; Code[10])
        {
        }
        field(182; "Grit List"; Integer)
        {
            CalcFormula = count("NV8 Configurator Grit");
            Description = 'Drill down to table';
            Editable = false;
            FieldClass = FlowField;
        }
        field(185; "Grit Code Length"; Integer)
        {
            MaxValue = 10;
            MinValue = 0;
        }
        field(186; "Grit BOM Required"; Boolean)
        {
        }
        field(190; "Joint Rule"; Option)
        {
            OptionCaption = 'Optional,Blank,Mandatory,Same,Less Than,Greater Than';
            OptionMembers = Optional,Blank,Mandatory,Same,"Less Than","Greater Than";
        }
        field(191; "Joint Value"; Code[10])
        {
        }
        field(192; "Joint List"; Integer)
        {
            CalcFormula = count("NV8 Configurator Shape-Joints" where(Shape = field(Code)));
            Description = 'Drill down to table';
            Editable = false;
            FieldClass = FlowField;
        }
        field(195; "Joint Code Length"; Integer)
        {
            MaxValue = 10;
            MinValue = 0;
        }
        field(196; "Joint BOM Required"; Boolean)
        {
        }
        field(200; "Std. Production Run Qty."; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
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
        field(50020; "Total ILE Qty."; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("NV8 Shape" = field(Code),
                                                                  "Posting Date" = field("ILE Date Filter"),
                                                                  "Entry Type" = field("Entry Type Filter")));
            Description = 'UE-624';
            FieldClass = FlowField;
        }
        field(50021; "Entry Type Filter"; Option)
        {
            Description = 'UE-624';
            FieldClass = FlowFilter;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(50022; "ILE Date Filter"; Date)
        {
            Description = 'UE-624';
            FieldClass = FlowFilter;
        }
        field(50023; "ILE Qty."; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("NV8 Shape" = field(Code),
                                                                  "Posting Date" = field("Date Filter"),
                                                                  "Entry Type" = field("Entry Type Filter")));
            Description = 'UE-624';
            FieldClass = FlowField;
        }
        field(50060; "Def.Reorder Calculation Option"; Option)
        {
            Description = 'UE-438';
            OptionCaption = 'All(S-T-AC),Sale,Transfer';
            OptionMembers = "All(S-T-AC)",Sale,Transfer;
        }
        field(52000; "Scheduled Qty."; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Prod. Order Line"."Remaining Qty. (Base)" where("NV8 Shape" = field(Code),
                                                                                Status = field("Status Filter"),
                                                                                "NV8 Scheduled Date" = field("Scheduled Date Filter")));
            DecimalPlaces = 0 : 5;
            Description = 'UNE-173';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52001; "Total Qty."; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Prod. Order Line"."Remaining Qty. (Base)" where("NV8 Shape" = field(Code),
                                                                                Status = field("Status Filter")));
            DecimalPlaces = 0 : 5;
            Description = 'UNE-173';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52002; "Scheduled Blank Qty"; Decimal)
        {
            CalcFormula = sum("Prod. Order Line"."Remaining Qty. (Base)" where("NV8 Shape" = field(Code),
                                                                                Status = field("Status Filter"),
                                                                                "NV8 Scheduled Date" = field("Scheduled Blank Date Filter")));
            Description = 'UNE-173';
            FieldClass = FlowField;
        }
        field(52003; "Scheduled Date Filter"; Date)
        {
            Description = 'UNE-173';
            FieldClass = FlowFilter;
        }
        field(52004; "Scheduled Blank Date Filter"; Date)
        {
            Description = 'UNE-173';
            FieldClass = FlowFilter;
        }
        field(52005; "Scheduled Past Due Qty"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Prod. Order Line"."Remaining Qty. (Base)" where("NV8 Shape" = field(Code),
                                                                                Status = field("Status Filter"),
                                                                                "NV8 Scheduled Date" = field("Scheduled Past Date Filter")));
            DecimalPlaces = 0 : 5;
            Description = 'UNE-173';
            Editable = false;
            FieldClass = FlowField;
        }
        field(52006; "Scheduled Past Date Filter"; Date)
        {
            Description = 'UNE-173';
            FieldClass = FlowFilter;
        }
        field(68001; "Def. Safety Stock Formula"; DateFormula)
        {
        }
        field(68003; "Def. Reorder Point Formula"; DateFormula)
        {
            Description = 'Planning Window';
        }
        field(68030; "Def. Planning Window Formula"; DateFormula)
        {
            Description = 'Planning Window';
        }
        field(68047; "Past Due Qty."; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Prod. Order Line"."Remaining Qty. (Base)" where("NV8 Shape" = field(Code),
                                                                                Status = field("Status Filter"),
                                                                                "Due Date" = field("Past Due Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68048; "Total Due Qty."; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Prod. Order Line"."Remaining Qty. (Base)" where("NV8 Shape" = field(Code),
                                                                                Status = field("Status Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68049; "Production Qty"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Prod. Order Line"."Remaining Qty. (Base)" where("NV8 Shape" = field(Code),
                                                                                Status = field("Status Filter"),
                                                                                "Due Date" = field("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68050; "Qty. On Production"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Prod. Order Line"."Quantity (Base)" where("NV8 Shape" = field(Code),
                                                                          Status = field("Status Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68051; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(68052; "Status Filter"; Option)
        {
            Caption = 'Status';
            FieldClass = FlowFilter;
            OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished;
        }
        field(68053; "Due Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(68200; "Scrap % of cost"; Decimal)
        {
        }
        field(68300; "Roll Dimenisons Required"; Option)
        {
            Description = 'EC1.INV4.01';
            OptionCaption = 'Pieces,Pieces+Length,Pieces+Width+Length';
            OptionMembers = Pieces,"Pieces+Length","Pieces+Width+Length";
        }
        field(68301; "Current  Production  Date"; Date)
        {
            Description = 'UNE-158';
        }
        field(85066; Blocked; Boolean)
        {
        }
        field(85067; "Auto Lot Tracking"; Boolean)
        {
            Description = 'EC Lot';
        }
        field(85068; "Past Due Date Filter"; Date)
        {
            Description = 'UE-415';
            FieldClass = FlowFilter;
        }
        field(85069; "Def. Shape Dimension Code"; Code[20])
        {
            Description = 'UE-651';
            TableRelation = Dimension;
        }
        field(85070; "Def. Shape Dim. Value Code"; Code[20])
        {
            Description = 'UE-651';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Def. Shape Dimension Code"));
        }
        field(85071; "Shape Production Area"; Code[20])
        {
            Description = 'UNE-174';
            TableRelation = "NV8 Shape Production Area";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ConfiguratorItem: Record "NV8 Configurator Item";
        UEI001: label 'You can not rename the components of a Configurator Item';
        UEI002: label 'You can not delete %1, %2 because it is used in %3, %4';


    procedure ReturnCaptionVal(ShapeVal: Code[20]; DimNo: Integer) CaptionVal: Text[80]
    var
        ShapeREC: Record "NV8 Configurator Shape";
    begin
        if ShapeREC.Get(ShapeVal) then begin
            case DimNo of
                1:
                    exit(ShapeREC."Dimension 1 Caption");
                2:
                    exit(ShapeREC."Dimension 2 Caption");
                3:
                    exit(ShapeREC."Dimension 3 Caption");
                4:
                    exit(ShapeREC."Dimension 4 Caption");
            end;
        end else
            exit('');
    end;
}

