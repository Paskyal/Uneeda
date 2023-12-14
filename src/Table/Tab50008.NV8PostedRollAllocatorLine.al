Table 50008 "NV8 Posted Roll Allocator Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item Ledger Entry No."; Integer)
        {
            TableRelation = "Item Ledger Entry";
        }
        field(2; "Entry No."; Integer)
        {
        }
        field(3; "Item No."; Code[20])
        {
        }
        field(4; "Posting Date"; Date)
        {

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(5; "Entry Type"; Option)
        {
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        }
        field(6; "Source No."; Code[20])
        {
            Editable = false;
            TableRelation = if ("Source Type" = const(Customer)) Customer
            else
            if ("Source Type" = const(Vendor)) Vendor
            else
            if ("Source Type" = const(Item)) Item;
        }
        field(7; "Document No."; Code[20])
        {
        }
        field(8; Description; Text[50])
        {
        }
        field(9; "Location Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(10; "Inv. Posting Gr."; Code[10])
        {
            Editable = false;
            TableRelation = "Inventory Posting Group";
        }
        field(13; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(14; "Allocated Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(15; "Invoiced Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(29; "Applies-to Entry"; Integer)
        {
        }
        field(39; "Source Type"; Option)
        {
            Editable = false;
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(42; "Reason Code"; Code[10])
        {
            TableRelation = "Reason Code";
        }
        field(49; "Country Code"; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(50; "New Location Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(57; "Gen. Bus. PostGr."; Code[10])
        {
            TableRelation = "Gen. Business Posting Group";
        }
        field(58; "Gen. Prod. PostGr."; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(60; "Document Date"; Date)
        {
        }
        field(68; "Reserved Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            TableRelation = "Production Order"."No." where(Status = const(Released));
        }
        field(5402; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Description = 'changed 10 - 20 to match bin table DC062917';
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5406; "New Bin Code"; Code[20])
        {
            Description = 'changed 10 - 20 to match bin table DC062917';
            TableRelation = Bin.Code where("Location Code" = field("New Location Code"));
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(5413; "Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(5415; "Invoiced Qty. (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5468; "Reserved Qty. (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5707; "Product Group Code"; Code[10])
        {
        }
        field(5806; "Partial Revaluation"; Boolean)
        {
            Editable = false;
        }
        field(5807; "Applies-from Entry"; Integer)
        {
            MinValue = 0;
        }
        field(5846; "Output Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(5856; "Output Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(5880; "Prod. Order Line No."; Integer)
        {
            TableRelation = "Prod. Order Line"."Line No." where(Status = const(Released),
                                                                 "Prod. Order No." = field("Prod. Order No."));
        }
        field(6600; "Return Reason Code"; Code[10])
        {
            TableRelation = "Return Reason";
        }
        field(68101; "Allocation ID"; Integer)
        {
        }
        field(68110; "Roll ID"; Code[20])
        {
        }
        field(68111; PIN; Code[10])
        {
        }
        field(68112; "Original Lot. No"; Code[20])
        {
        }
        field(68115; "Machine No."; Code[20])
        {
        }
        field(68120; "Pack Size"; Option)
        {
            OptionMembers = " ",,,"3",,"5",,,,,"10";
        }
        // field(68200; "Cons. Item No."; Code[20]) //TODO PAP Uncomment
        // {
        //     CalcFormula = lookup("Prod. Order Component"."Item No." where("Prod. Order No." = field("Prod. Order No."),
        //                                                                    Grit = filter(<> 0)));
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = Item;
        // }
        // field(68201; "Cons. Material"; Code[10])
        // {
        //     CalcFormula = lookup("Prod. Order Component".Material where("Prod. Order No." = field("Prod. Order No."),
        //                                                                  Grit = filter(<> 0)));
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = "Configurator Material";
        // }
        // field(68206; "Cons. Grit"; Code[10])
        // {
        //     CalcFormula = lookup("Prod. Order Component".Grit where("Prod. Order No." = field("Prod. Order No."),
        //                                                              Grit = filter(<> 0)));
        //     Editable = false;
        //     FieldClass = FlowField;
        //     TableRelation = "Configurator Grit";
        // }
        // field(68210; "Cons. Quantity (Base)"; Decimal)
        // {
        //     CalcFormula = lookup("Prod. Order Component"."Quantity (Base)" where("Prod. Order No." = field("Prod. Order No."),
        //                                                                           Grit = filter(<> 0)));
        //     DecimalPlaces = 0 : 5;
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        // field(68211; "Cons. Quantity"; Decimal)
        // {
        //     CalcFormula = lookup("Prod. Order Component".Quantity where("Prod. Order No." = field("Prod. Order No."),
        //                                                                  Grit = filter(<> 0)));
        //     DecimalPlaces = 0 : 5;
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(85001; "FilePro No."; Code[10])
        {
        }
        field(85003; "Skid No."; Text[30])
        {
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
        }
        field(85025; "New Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(85026; "FIFO Code"; Code[7])
        {
        }
        field(85027; "FIFO Date"; Date)
        {
        }
        // field(85028; "Bin Pieces Remaining"; Decimal)  //TODO PAP Uncomment
        // {
        //     BlankZero = true;
        //     CalcFormula = lookup("Item Ledger Entry"."Remaining Pieces" where("Entry No." = field("Applies-to Entry")));
        //     DecimalPlaces = 0 : 5;
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(85029; "Bin Quantity Remaining"; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup("Item Ledger Entry"."Remaining Quantity" where("Entry No." = field("Applies-to Entry")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
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
        }
        field(85051; "Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;
        }
        field(85052; "Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
        }
        field(85053; "Unit Length Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85054; "Unit Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Width / 36 x Length';
            Editable = false;
        }
        field(85055; "Unit Width Code"; Code[10])
        {
            CharAllowed = '09';
        }
        field(85056; "Unit Width Text"; Text[30])
        {
            Editable = false;
        }
        field(85058; "Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85059; "Cost Per meter"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85064; "Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
        }
        field(85066; "Description 2"; Text[30])
        {
        }
        field(85069; "Allocator Comment"; Text[80])
        {
        }
        field(85080; "Original Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
        }
        field(85081; "Overage Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
        }
        field(85082; "Original Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85083; "Overage Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85084; "Original Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField(Pieces);
                Validate("Unit Length meters", ROUND("Total Length meters" / Pieces, 0.00001));
            end;
        }
        field(85085; "Overage Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField(Pieces);
                Validate("Unit Length meters", ROUND("Total Length meters" / Pieces, 0.00001));
            end;
        }
        field(85100; "Configurator No."; Code[100])
        {
            // TableRelation = "Configurator Item" where(Status = filter(Item .. "Valid Item"));//TODO PAP Uncomment
            //This property is currently not supported
            //TestTableRelation = false;
            // ValidateTableRelation = false; //TODO PAP Uncomment
        }
        field(85110; Shape; Code[10])
        {
            // TableRelation = "Configurator Shape";//TODO PAP Uncomment
        }
        field(85120; Material; Code[10])
        {
            // TableRelation = "Configurator Material";//TODO PAP Uncomment
        }
        field(85122; "Subst. Material"; Code[10])
        {
            Editable = false;
            // TableRelation = "Configurator Material"; //TODO PAP Uncomment
        }
        field(85170; Specification; Code[10])
        {
            // TableRelation = "Configurator Specification"; //TODO PAP Uncomment
        }
        field(85180; Grit; Code[10])
        {
            // TableRelation = "Configurator Grit"; //TODO PAP Uncomment
        }
        field(85190; Joint; Code[10])
        {
            // TableRelation = "Configurator Joint"; //TODO PAP Uncomment
        }
        field(85200; "Reserved Output"; Decimal)
        {
            CalcFormula = sum("Reservation Entry".Quantity where("Reservation Status" = const(Reservation),
                                                                  "Source Type" = const(5406),
                                                                  "Source Subtype" = const(3),
                                                                  "Source ID" = field("Prod. Order No."),
                                                                  "Source Prod. Order Line" = field("Prod. Order Line No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85201; "Reservation Application"; Integer)
        {
            TableRelation = if ("Reservation Application" = filter(>= 0)) "Reservation Entry"."Entry No." where("Reservation Status" = const(Reservation),
                                                                                                              "Source Type" = const(5406),
                                                                                                              "Source Subtype" = const(3),
                                                                                                              "Source ID" = field("Prod. Order No."),
                                                                                                              "Source Prod. Order Line" = field("Prod. Order Line No."));
        }
        field(85202; "Reservation Applied Qty."; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup("Reservation Entry".Quantity where("Entry No." = field("Reservation Application"),
                                                                     Positive = const(true)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85300; "Re-Cut"; Boolean)
        {
        }
        field(85301; "Re-Cut No."; Code[20])
        {
            TableRelation = User;
        }
        field(85321; "Allocated Quantity (Total)"; Decimal)
        {
            // BlankZero = true; //TODO PAP Uncomment
            // CalcFormula = sum("Roll Allocator Line"."Allocated Quantity" where("Item Ledger Entry No." = field("Item Ledger Entry No."),
            //                                                                     "Line No." = filter(> 0)));
            // DecimalPlaces = 0 : 5;
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(85322; "Allocated On"; Date)
        {
        }
        field(85323; "Allocated By"; Code[200])
        {
            TableRelation = User;
        }
        field(85324; "Sort No."; Integer)
        {
        }
        field(85325; "Allocated for Type"; Option)
        {
            OptionMembers = " ","Sales Order","Sales Invoice",,,,"Transfer Order";
        }
        field(85326; "Allocated for Code"; Code[20])
        {
            TableRelation = if ("Allocated for Type" = const("Sales Order")) Customer."No."
            else
            if ("Allocated for Type" = const("Transfer Order")) Location.Code;
        }
        field(85328; "Allocated for Order No"; Code[20])
        {
            TableRelation = if ("Allocated for Type" = const("Sales Order")) "Sales Header"."No." where("Document Type" = const(Order))
            else
            if ("Allocated for Type" = const("Transfer Order")) "Transfer Header"."No.";
        }
        field(85330; "Allocation Type"; Option)
        {
            OptionMembers = " ","Transfer From Stock","Return To Stock","Jumbo Pull Request","Use In Manufacturing",Output,"Hold Remnant on Floor",Overage,Waste,"Positive Adjustment","Negative Adjustment","Pick-Not Used","Putaway-Not Used","Remnant to Stock","Re-Cut","Re-Use",Transfer,Slitting,Adjustments;
        }
        field(85331; "Allocation Description"; Text[80])
        {
        }
        field(85335; "Ready To Post"; Boolean)
        {
        }
        field(85336; "Transfer Whole Pieces"; Boolean)
        {
        }
        field(85340; "Do Not Print"; Boolean)
        {
        }
        field(85341; "No. Roll IDs Printed"; Integer)
        {
        }
        field(86000; "Supervisor Override"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Item Ledger Entry No.", "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Item Ledger Entry No.", "Sort No.")
        {
        }
        key(Key3; "Allocated By", "Item Ledger Entry No.", "Entry No.")
        {
        }
        key(Key4; "Document No.", "Posting Date")
        {
        }
        key(Key5; "Allocation Type", "Sort No.", "Posting Date")
        {
        }
        key(Key6; "Material Type", "Configurator No.", "Unit Width Inches", "Unit Length meters")
        {
        }
        key(Key7; "Allocation Type", "Sort No.", "Machine No.")
        {
        }
        key(Key8; "Item Ledger Entry No.", "Sort No.", "Material Type", "Configurator No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
    // ConfiguratorItem: Record "Configurator Item";//TODO PAP Uncomment

    //TODO PAP Uncomment
    // procedure GetConfiguration()
    // begin
    //     if ConfiguratorItem.Get("Configurator No.") then begin
    //         Shape := ConfiguratorItem.Shape;
    //         Material := ConfiguratorItem.Material;
    //         Specification := ConfiguratorItem.Specification;
    //         Grit := ConfiguratorItem.Grit;
    //         Joint := ConfiguratorItem.Joint;
    //         if Pieces = 0 then
    //             Pieces := 1;
    //     end;
    // end;


    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Posting Date", "Source No.");
        NavigateForm.Run;
    end;
}

