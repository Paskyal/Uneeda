Table 50009 "NV8 Roll Allocator Line"
{
    // EC1.MFG04.01 MD 5-14-15
    //  - In PostAllocation()
    //     - Add Code to update the Produciton Status for lines that are being posted.
    // 
    // 
    // UE-MISC - MD 12-1-15
    //   - Change the expected quantity updates to look for the item number instead of the first line
    // 
    // ECL1.01 - Remove code using the ILE in the SetUpNewLine since the entry no, no longer refers to the ILE its just a number series now and the validation happens later on
    // UE-270  DB  01/13/16  Populate Batch Reason Code
    // 
    // LOT1.02 1-19-16 MD
    //   - Call Calculate Jumbo when creating the new lot information card during the Reclass
    // 
    // GLEN01 MD-2-11-16
    //   - Use new report for put aways creation that does not have COMMIT statement in post report so we roll back all lines if error occurs
    // UE-489  DB  6/7/16  Change Consumption Document No. and add External Document No.
    //                     Don't create reservation entries for Source 5407
    // UE-499  DB  6/17/16 Assign Remnants to new Remnant bin
    // UE-520  DB  9/2/16  Stop creating Put Away documents
    // UE-606 MD 9-22-17 Add original lot number when reclass happens
    // UE-529 MD 10-12-17 Consume at external location
    // UE-489  DB  1/18/18 Changed Source No. to be the Prod. Order Line Item No.
    // UE-651  DB  6/18/20 Add validate for Location to call new dimension funtionality

    Permissions = TableData "Reservation Entry" = rimd,
                  TableData "Whse. Item Tracking Line" = rimd;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item Ledger Entry No."; Integer)
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Item No."; Code[20])
        {
            //TODO PAP Uncomment
            // trigger OnValidate()
            // begin
            //     if "Item No." <> xRec."Item No." then
            //         "Variant Code" := '';

            //     GetItem;
            //     ConfiguratorSetup.Get;
            //     Item.TestField(Blocked, false);
            //     Description := Item.Description;
            //     "Description 2" := Item."Description 2";
            //     "Inv. Posting Gr." := Item."Inventory Posting Group";
            //     //ENUPG
            //     //"Product Group Code" := Item."Product Group Code";
            //     "Product Group Code" := Item."Item Category Code";

            //     //>> AG Configurator
            //     //"Configurator No." := Item."Configurator No.";
            //     UpdateConfiguration;
            //     "New Item No." := "Item No.";
            //     //<< end


            //     if "Entry Type" <> "entry type"::Output then
            //         "Gen. Prod. PostGr." := Item."Gen. Prod. Posting Group";

            //     case "Entry Type" of
            //         "entry type"::Purchase:
            //             Validate("Unit of Measure Code", Item."Purch. Unit of Measure");
            //         "entry type"::Sale:
            //             Validate("Unit of Measure Code", Item."Sales Unit of Measure");
            //         "entry type"::Output:
            //             begin
            //                 SetFilterProdOrderLine;
            //                 ProdOrderLine.SetRange("Item No.", "Item No.");
            //                 ProdOrderLine.Find('-');
            //                 //"Routing No." := ProdOrderLine."Routing No.";
            //                 "Source Type" := "source type"::Item;
            //                 "Source No." := ProdOrderLine."Item No.";
            //                 if ProdOrderLine.Count = 1 then begin
            //                     Validate("Prod. Order Line No.", ProdOrderLine."Line No.");
            //                     //"Routing Reference No." := ProdOrderLine."Routing Reference No.";
            //                     Validate("Unit of Measure Code", ProdOrderLine."Unit of Measure Code");
            //                     Validate("Location Code", ProdOrderLine."Location Code");
            //                     "Bin Code" := ProdOrderLine."Bin Code";
            //                     "Variant Code" := ProdOrderLine."Variant Code";
            //                 end;
            //                 Validate("Unit of Measure Code", Item."Base Unit of Measure");
            //             end;
            //         else
            //             Validate("Unit of Measure Code", Item."Base Unit of Measure");
            //     end;

            //     //CheckItemAvailable(FIELDNO("Item No."));


            //     //ReserveItemJnlLine.VerifyChange(temprec,xtemprec);
            // end;
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

            trigger OnValidate()
            begin
                /*IF "Location Code" <> '' THEN BEGIN
                  Location.GET("Location Code");
                  IF Location."Allocator Bus. Posting Group" <> '' THEN
                    "Gen. Bus. PostGr." := Location."Allocator Bus. Posting Group";
                END ELSE BEGIN
                  "Gen. Bus. PostGr." := '';
                END;
                 */

            end;
        }
        field(10; "Inv. Posting Gr."; Code[10])
        {
            Editable = false;
            TableRelation = "Inventory Posting Group";
        }
        field(13; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Quantity (Base)" := CalcBaseQty(Quantity);
                if "Entry Type" = "entry type"::Output then
                    "Invoiced Quantity" := 0
                else
                    "Invoiced Quantity" := Quantity;
                "Invoiced Qty. (Base)" := CalcBaseQty("Invoiced Quantity");


                if "Entry Type" in ["entry type"::"Positive Adjmt.", "entry type"::Output] then
                    "Allocated Quantity" := -Quantity
                else
                    "Allocated Quantity" := Quantity;
            end;
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

            trigger OnLookup()
            begin
                SelectItemEntry(FieldNo("Applies-to Entry"));
            end;

            trigger OnValidate()
            begin

                //>> AG update bin and FIFO code
                CalcFields("From Bin Location", "From FIFO Code");
            end;
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

            trigger OnValidate()
            begin
                GetMfgSetup();
                if MfgSetup."Doc. No. Is Prod. Order No." then
                    "Document No." := "Prod. Order No.";
                ProdOrder.Get(ProdOrder.Status::Released, "Prod. Order No.");
                ProdOrder.TestField(Blocked, false);
                Description := ProdOrder.Description;

                "Gen. Bus. PostGr." := '';
                case true of
                    "Entry Type" = "entry type"::Output:
                        begin
                            "Inv. Posting Gr." := ProdOrder."Inventory Posting Group";
                            "Gen. Prod. PostGr." := ProdOrder."Gen. Prod. Posting Group";
                        end;
                    "Entry Type" = "entry type"::Consumption:
                        begin
                            SetFilterProdOrderLine();
                            ProdOrderLine.Find('-');
                            if ProdOrderLine.Count = 1 then begin
                                "Source Type" := "source type"::Item;
                                Validate("Source No.", ProdOrderLine."Item No.");
                            end;
                        end;
                end;
            end;
        }
        field(5402; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));

            trigger OnValidate()
            begin
                ItemVariant.Get("Item No.", "Variant Code");
                Description := ItemVariant.Description;
            end;
        }
        field(5403; "Bin Code"; Code[20])
        {
            Description = 'changed 10 - 20 to match bin table DC062917';
            TableRelation = Bin.Code where("Location Code" = field("Location Code"));

            trigger OnValidate()
            begin
                if "Bin Code" <> '' then
                    TestField("Location Code");

                //ReserveItemJnlLine.VerifyChange(temprec,xtemprec);
            end;
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

            trigger OnValidate()
            begin
                TestField("Entry Type", "entry type"::Transfer);

                TestField("New Location Code");

                //ReserveItemJnlLine.VerifyChange(temprec,xtemprec);
            end;
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
        field(5740; "Transfer Order No."; Code[20])
        {
            Editable = false;
        }
        field(5793; "Order Date"; Date)
        {
        }
        field(5806; "Partial Revaluation"; Boolean)
        {
            Editable = false;
        }
        field(5807; "Applies-from Entry"; Integer)
        {
            MinValue = 0;

            trigger OnLookup()
            begin
                SelectItemEntry(FieldNo("Applies-from Entry"));
            end;

            trigger OnValidate()
            begin
                if "Applies-from Entry" = 0 then
                    exit;

                case "Entry Type" of
                    "entry type"::Purchase,
                  "entry type"::"Positive Adjmt.",
                  "entry type"::Output,
                  "entry type"::Transfer:
                        if Quantity < 0 then
                            FieldError(Quantity, Text030);
                    "entry type"::Sale,
                  "entry type"::"Negative Adjmt.",
                  "entry type"::Consumption:
                        if Quantity > 0 then
                            FieldError(Quantity, Text029);
                end;

                ItemLedgEntry.Get("Applies-from Entry");
            end;
        }
        field(5846; "Output Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Entry Type", "entry type"::Output);
                "Output Quantity (Base)" := CalcBaseQty("Output Quantity");

                Validate(Quantity, "Output Quantity");
            end;
        }
        field(5856; "Output Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField("Qty. per Unit of Measure", 1);
                Validate("Output Quantity", "Output Quantity (Base)");
            end;
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
        field(68200; "Cons. Item No."; Code[20])//TODO PAP Uncomment
        {
            // CalcFormula = lookup("Prod. Order Component"."Item No." where("Prod. Order No." = field("Prod. Order No."),
            //                                                                Grit = filter(<> 0)));
            // Editable = false;
            // FieldClass = FlowField;
            // TableRelation = Item;
        }
        field(68201; "Cons. Material"; Code[10])//TODO PAP Uncomment
        {
            // CalcFormula = lookup("Prod. Order Component"."NV8 Material" where("Prod. Order No." = field("Prod. Order No."),
            //                                                              Grit = filter(<> 0)));
            // Editable = false;
            // FieldClass = FlowField;
            // TableRelation = "NV8 Configurator Material";
        }
        field(68206; "Cons. Grit"; Code[10])//TODO PAP Uncomment
        {
            // CalcFormula = lookup("Prod. Order Component"."NV8 Grit" where("Prod. Order No." = field("Prod. Order No."),
            //                                                          Grit = filter(<> 0)));
            // Editable = false;
            // FieldClass = FlowField;
            // TableRelation = "NV8 Configurator Grit";
        }
        field(68210; "Cons. Quantity"; Decimal)//TODO PAP Uncomment
        {
            // CalcFormula = lookup("Prod. Order Component"."Expected Quantity" where("Prod. Order No." = field("Prod. Order No."),
            //                                                                         Grit = filter(<> 0)));
            // DecimalPlaces = 0 : 5;
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(68211; "Cons. Remaining Quantity"; Decimal)//TODO PAP Uncomment
        {
            // CalcFormula = lookup("Prod. Order Component"."Remaining Quantity" where("Prod. Order No." = field("Prod. Order No."),
            //                                                                          Grit = filter(<> 0)));
            // DecimalPlaces = 0 : 5;
            // Editable = false;
            // FieldClass = FlowField;
        }
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
            // TableRelation = "Bin Location".Code where("Location Code" = field("Location Code"));//TODO PAP Uncomment

            // trigger OnValidate() //TODO PAP Uncomment
            // begin
            //     InvQty := Quantity;
            //     if "Entry Type" in ["entry type"::Sale, "entry type"::"Negative Adjmt.", "entry type"::Consumption] then
            //         InvQty := -Quantity;
            //     if InvQty < 0 then
            //         FieldError("Bin Location", 'please select the Bin Location either through the "Applies To ID" or by useing reservations.');
            // end;
        }
        field(85021; "New Bin Location"; Code[20])  //TODO PAP Uncomment
        {
            // TableRelation = "Bin Location".Code where("Location Code" = field("New Location Code"));
        }
        field(85022; "From Bin Location"; Code[20]) //TODO PAP Uncomment
        {
            // CalcFormula = lookup("Item Ledger Entry"."Bin Location" where("Entry No." = field("Applies-to Entry")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(85023; "From FIFO Code"; Code[20])  //TODO PAP Uncomment
        {
            // CalcFormula = lookup("Item Ledger Entry"."FIFO Code" where("Entry No." = field("Applies-to Entry")));
            // Editable = false;
            // FieldClass = FlowField;
        }
        field(85024; "From Skid No."; Text[30]) //TODO PAP Uncomment
        {
            // CalcFormula = lookup("Item Ledger Entry"."Skid No." where("Entry No." = field("Applies-to Entry")));
            // Editable = false;
            // FieldClass = FlowField;
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

            trigger OnValidate()
            begin
                "FIFO Code" := GetFIFOCode("FIFO Date");
            end;
        }
        field(85028; "Bin Pieces Remaining"; Decimal) //TODO PAP Uncomment
        {
            // BlankZero = true;
            // CalcFormula = lookup("Item Ledger Entry"."Remaining Pieces" where("Entry No." = field("Applies-to Entry")));
            // DecimalPlaces = 0 : 5;
            // Editable = false;
            // FieldClass = FlowField;
        }
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

            trigger OnValidate()
            begin
                "Unit Length Inches" := ROUND("Unit Length meters" * 39, 0.00001);
                UpdatePieces();
            end;
        }
        field(85053; "Unit Length Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Unit Length meters" := ROUND("Unit Length Inches" / 39, 0.00001);
                UpdatePieces();
            end;
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
            //TODO PAP Uncomment
            // trigger OnValidate()
            // begin
            //     ConfiguratorSetup.Get;
            //     ConfiguratorSetup.SetDimLen("Unit Width Code", 5, "Unit Width Code", 0);
            //     "NV8 Unit Width Inches" := ConfiguratorSetup.GetDecimal("Unit Width Code");
            //     "Unit Width Text" := ConfiguratorSetup.GetDecimalText("Unit Width Code");
            //     UpdatePieces;
            // end;
        }
        field(85056; "Unit Width Text"; Text[30])
        {
            Editable = false;
        }
        field(85058; "Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;

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

            trigger OnValidate()
            begin
                TestField(Pieces);
                Validate("Unit Length meters", ROUND("Total Length meters" / Pieces, 0.00001));
            end;
        }
        field(85083; "Overage Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                TestField(Pieces);
                Validate("Unit Length meters", ROUND("Total Length meters" / Pieces, 0.00001));
            end;
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
            // TableRelation = "Configurator Item" where(Status = filter(Item .. "Valid Item"));  //TODO PAP Uncomment
            // //This property is currently not supported
            // //TestTableRelation = false;
            // ValidateTableRelation = false;

            // trigger OnValidate()  //TODO PAP Uncomment
            // begin
            //     //>>AG003 - Start
            //     ConfiguratorFound := false;
            //     Found := false;
            //     if "Configurator No." = '' then
            //         exit;
            //     if (ConfiguratorItem.Get("Configurator No.")) then begin
            //         if ConfiguratorItem."Item No." <> '' then begin
            //             Validate("Item No.", ConfiguratorItem."Item No.");
            //             ConfiguratorFound := true;
            //         end;
            //     end;

            //     if not ConfiguratorFound then begin
            //         if (StrLen("Configurator No.") <= 20) then begin
            //             if (Item.Get("Configurator No.")) then begin
            //                 Validate("Item No.", Item."No.");
            //                 ConfiguratorFound := true;
            //             end;
            //         end;
            //     end;

            //     if not ConfiguratorFound then begin
            //         Component := CopyStr("Configurator No.", 1, 2);
            //         Remaining := CopyStr("Configurator No.", 3);

            //         ConfiguratorItem.Init;
            //         ConfiguratorItem."Configurator No." := '';
            //         ConfiguratorItem."Temp Configurator No." := "Configurator No.";
            //         if ConfiguratorShape.Get(Component) then begin
            //             ConfiguratorItem.Validate(Shape, Component);
            //             Component := '';
            //             if StrLen(Remaining) > 2 then
            //                 repeat
            //                     Component := Component + CopyStr(Remaining, 1, 1);
            //                     if StrLen(Remaining) > 1 then
            //                         Remaining := CopyStr(Remaining, 2)
            //                     else
            //                         Remaining := '';
            //                     if ConfiguratorMaterial.Get(Component) then begin
            //                         ConfiguratorItem.Validate(Material, Component);
            //                         Found := true;
            //                     end;
            //                 until Found or (StrLen(Component) >= 10) or (StrLen(Remaining) = 0);
            //             if not Found then
            //                 Remaining := Component + Remaining;
            //         end;
            //     end;

            //     if Found and (StrLen(Remaining) >= 3) then begin
            //         Found := false;
            //         Component := CopyStr(Remaining, StrLen(Remaining) - 2);
            //         if ConfiguratorJoint.Get(Component) then begin
            //             ConfiguratorItem.Validate(Joint, Component);
            //             if StrLen(Remaining) > 3 then
            //                 Remaining := CopyStr(Remaining, 1, StrLen(Remaining) - 3)
            //             else
            //                 Remaining := '';
            //         end;
            //         Component := '';
            //         if StrLen(Remaining) > 1 then
            //             repeat
            //                 Component := CopyStr(Remaining, StrLen(Remaining), 1) + Component;
            //                 if StrLen(Remaining) > 1 then
            //                     Remaining := CopyStr(Remaining, 1, StrLen(Remaining) - 1)
            //                 else
            //                     Remaining := '';
            //                 if ConfiguratorMaterialGrit.Get(ConfiguratorItem."NV8 Material", Component) then begin
            //                     ConfiguratorItem.Validate(Grit, Component);
            //                     Found := true;
            //                 end;
            //             until Found or (StrLen(Component) >= 10) or (StrLen(Remaining) < 1);
            //         if not Found then
            //             Remaining := Component + Remaining;
            //     end;

            //     if Found and (StrLen(Remaining) >= 10) then begin
            //         Found := false;
            //         ConfiguratorItem.Validate("Dimension 1", CopyStr(Remaining, 1, 5));
            //         ConfiguratorItem.Validate("Dimension 2", CopyStr(Remaining, 6, 5));
            //         // Remaining := COPYSTR(Remaining,10);
            //     end;


            //     if not ConfiguratorFound then begin
            //         ///  COMMIT;
            //         if Confirm(AG012, false) then begin
            //             ConfiguratorItem.Insert(true);
            //             //  COMMIT;
            //             if Page.RunModal(Page::"Configurator Item Card", ConfiguratorItem) = Action::LookupOK then begin
            //                 Validate("Item No.", ConfiguratorItem."Item No.");
            //                 ConfiguratorFound := true;
            //             end;
            //         end;
            //     end;

            //     // UpdateConfiguration;
            //     //IF NOT ConfiguratorFound THEN
            //     //  ERROR(AG013);
            // end;
        }
        field(85110; Shape; Code[10])
        {
            // TableRelation = "Configurator Shape";  //TODO PAP Uncomment
        }
        field(85120; Material; Code[10])
        {
            // TableRelation = "NV8 Configurator Material";  v
        }
        field(85122; "Subst. Material"; Code[10])
        {
            Editable = false;
            // TableRelation = "NV8 Configurator Material"; //TODO PAP Uncomment
        }
        field(85170; Specification; Code[10])
        {
            // TableRelation = "Configurator Specification";  //TODO PAP Uncomment
        }
        field(85180; Grit; Code[10])
        {
            // TableRelation = "NV8 Configurator Grit";  //TODO PAP Uncomment
        }
        field(85190; Joint; Code[10])
        {
            // TableRelation = "Configurator Joint";  //TODO PAP Uncomment
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
            // BlankZero = true;  //TODO PAP Uncomment
            // CalcFormula = sum("Roll Allocator Line"."NV8 Allocated Quantity" where("NV8 Item Ledger Entry No." = field("NV8 Item Ledger Entry No."),
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

            trigger OnValidate()
            begin
                ValidateReadyToPost(true);
            end;
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
        key(Key1; "Item Ledger Entry No.", "Line No.")
        {
            Clustered = true;
            SumIndexFields = Quantity, "Quantity (Base)", "Allocated Quantity";
        }
        key(Key2; "Entry Type", "Item No.", "Variant Code", "Location Code", "Bin Code", "Posting Date")
        {
            SumIndexFields = "Quantity (Base)", "Allocated Quantity";
        }
        key(Key3; "Entry Type", "Item No.", "Variant Code", "New Location Code", "New Bin Code", "Posting Date")
        {
            SumIndexFields = "Quantity (Base)", "Allocated Quantity";
        }
        key(Key4; "Allocated By", "Sort No.")
        {
            SumIndexFields = Quantity, "Quantity (Base)", Pieces, "Allocated Quantity";
        }
        key(Key5; "Allocated By", "Configurator No.", "Sort No.")
        {
            SumIndexFields = Quantity, "Quantity (Base)", Pieces, "Allocated Quantity";
        }
        key(Key6; "Unit Width Inches", "Unit Length meters")
        {
        }
        key(Key7; "Roll ID")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label '%1 must be reduced.';
        Text002: label 'You cannot change %1 when %2 is %3.';
        Text003: label 'You cannot change %3 when %2 is %1.';
        Text005: label 'Change %1 from %2 to %3?';
        Text006: label 'You must not enter %1 in a revaluation sum line.';
        Text007: label 'New ';
        Text010: label 'You cannot revalue outputs manually.';
        Text012: label 'Please choose another unit cost';
        Text029: label 'must be positive';
        Text030: label 'must be negative';
        AG012: label 'Do you wish to configure this item?';
        AG013: label 'The Configurator Item was not found.';
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlLine: Record "Item Journal Line";
        JumboPullList: Record "Item Journal Line";
        Item: Record Item;
        InventorySetup: Record "Inventory Setup";
        ItemLedgEntry: Record "Item Ledger Entry";
        FoundILE: Record "Item Ledger Entry";
        ItemVariant: Record "Item Variant";
        TaxPostingSetup: Record "VAT Posting Setup";
        GLSetup: Record "General Ledger Setup";
        SKU: Record "Stockkeeping Unit";
        MfgSetup: Record "Manufacturing Setup";
        ProdOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderComp: Record "Prod. Order Component";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        WorkCenter: Record "Work Center";
        MachineCenter: Record "Machine Center";
        Reservation: Page Reservation;
        ItemAvailByDate: Page "Item Availability by Periods";
        ItemAvailByVar: Page "Item Availability by Variant";
        ItemAvailByLoc: Page "Item Availability by Location";
        ItemTrackingLines: Page "Item Tracking Summary";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
        ReserveItemJnlLine: Codeunit "Item Jnl. Line-Reserve";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UOMMgt: Codeunit "Unit of Measure Management";
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        DimMgt: Codeunit DimensionManagement;
        UserMgt: Codeunit "User Setup Management";
        CalendarMgt: Codeunit "Shop Calendar Management";
        CostCalcMgt: Codeunit "Cost Calculation Management";
        PositiveSourceLine: Boolean;
        PhysInvtEntered: Boolean;
        GLSetupRead: Boolean;
        MfgSetupRead: Boolean;
        ConfiguratorSetup: Record "NV8 Configurator Setup";
        ConfiguratorItem: Record "NV8 Configurator Item";
        ConfiguratorMaterial: Record "NV8 Configurator Material";
        ConfiguratorFound: Boolean;
        ConfiguratorShape: Record "NV8 Configurator Shape";
        ConfiguratorJoint: Record "NV8 Configurator Joint";
        ConfiguratorGrit: Record "NV8 Configurator Grit";
        ConfiguratorMaterialGrit: Record "NV8 Config Material-Grits";
        Found: Boolean;
        Component: Code[100];
        Remaining: Code[100];
        Temp: Integer;
        InvQty: Decimal;
        RollAllocatorLine: Record "NV8 Roll Allocator Line";
        ZeroLine: Record "NV8 Roll Allocator Line";
        ZeroLineFound: Boolean;
        PostedRollAllocatorLine: Record "NV8 Posted Roll Allocator Line";
        ModifyItemLedgerEntry: Record "Item Ledger Entry";
        ModifyEntry: Codeunit "Item Jnl.-Post Line";
        NextLineNo: Integer;
        NextEntryNo: Integer;
        Location: Record Location;
        BinLocation: Record "NV8 Bin Location";
        Window: Dialog;
        UserSetup: Record "User Setup";
        NewLotNo: Code[20];
        ConsumptionLocation: Code[20];

    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        TestField("Qty. per Unit of Measure");
        exit(ROUND(Qty * "Qty. per Unit of Measure", 0.00001));
    end;

    local procedure SelectItemEntry(CurrentFieldNo: Integer)
    begin
        ItemLedgEntry.Reset();
        ItemLedgEntry.SetCurrentkey("Item No.", "Variant Code", Open, Positive);
        ItemLedgEntry.SetRange("Item No.", "Item No.");

        begin
            if (CurrentFieldNo <> FieldNo("Applies-from Entry")) then
                ItemLedgEntry.SetRange(Open, true);
            if Quantity <> 0 then begin
                if CurrentFieldNo = FieldNo("Applies-from Entry") then
                    ItemLedgEntry.SetRange(Positive, Quantity > 0)
                else
                    if "Entry Type" in ["entry type"::Sale, "entry type"::"Negative Adjmt.", "entry type"::Transfer] then
                        ItemLedgEntry.SetRange(Positive, Quantity > 0)
                    else
                        ItemLedgEntry.SetRange(Positive, Quantity < 0);
            end;
        end
        // ItemLedgEntry.SETRANGE(Positive,TRUE);
    end;

    local procedure GetItem()
    begin
        if Item."No." <> "Item No." then
            Item.Get("Item No.");
    end;


    procedure Signed(Value: Decimal): Decimal
    begin
        case "Entry Type" of
            "entry type"::Purchase,
          "entry type"::"Positive Adjmt.",
          "entry type"::Output,
          "entry type"::Transfer:
                exit(Value);
            "entry type"::Sale,
          "entry type"::"Negative Adjmt.",
          "entry type"::Consumption:
                exit(-Value);
        end;
    end;


    procedure ItemAvailability(AvailabilityType: Option Date,Variant,Location,Bin)
    begin
        TestField("Item No.");
        Item.Reset();
        Item.Get("Item No.");
        Item.SetRange("No.", "Item No.");
        Item.SetRange("Date Filter", 0D, "Posting Date");

        case AvailabilityType of
            Availabilitytype::Date:
                begin
                    Item.SetRange("Variant Filter", "Variant Code");
                    Item.SetRange("Location Filter", "Location Code");
                    Item.SetRange("Bin Filter", "Bin Code");
                    Clear(ItemAvailByDate);
                    ItemAvailByDate.LookupMode(true);
                    ItemAvailByDate.SetRecord(Item);
                    ItemAvailByDate.SetTableview(Item);
                    if ItemAvailByDate.RunModal() = Action::LookupOK then
                        if "Posting Date" <> ItemAvailByDate.GetLastDate() then
                            if Confirm(
                                 Text005, true, FieldCaption("Posting Date"), "Posting Date",
                                 ItemAvailByDate.GetLastDate())
                            then begin
                                Validate("Posting Date", ItemAvailByDate.GetLastDate());
                                Modify();
                            end;
                end;
            Availabilitytype::Variant:
                begin
                    Item.SetRange("Location Filter", "Location Code");
                    Item.SetRange("Bin Filter", "Bin Code");
                    Clear(ItemAvailByVar);
                    ItemAvailByVar.LookupMode(true);
                    ItemAvailByVar.SetRecord(Item);
                    ItemAvailByVar.SetTableview(Item);
                    if ItemAvailByVar.RunModal() = Action::LookupOK then
                        if "Variant Code" <> ItemAvailByVar.GetLastVariant() then
                            if Confirm(
                                 Text005, true, FieldCaption("Variant Code"), "Variant Code",
                                 ItemAvailByVar.GetLastVariant())
                            then begin
                                Validate("Variant Code", ItemAvailByVar.GetLastVariant());
                                Modify();
                            end;
                end;
            Availabilitytype::Location:
                begin
                    Item.SetRange("Variant Filter", "Variant Code");
                    Item.SetRange("Bin Filter", "Bin Code");
                    Clear(ItemAvailByLoc);
                    ItemAvailByLoc.LookupMode(true);
                    ItemAvailByLoc.SetRecord(Item);
                    ItemAvailByLoc.SetTableview(Item);
                    if ItemAvailByLoc.RunModal() = Action::LookupOK then
                        if "Location Code" <> ItemAvailByLoc.GetLastLocation() then
                            if Confirm(
                                 Text005, true, FieldCaption("Location Code"), "Location Code",
                                 ItemAvailByLoc.GetLastLocation())
                            then begin
                                Validate("Location Code", ItemAvailByLoc.GetLastLocation());
                                Modify();
                            end;
                end;
        end;
    end;


    procedure SetFilterProdOrderLine()
    begin
        ProdOrderLine.Reset();
        ProdOrderLine.SetCurrentkey(Status, "Prod. Order No.", "Item No.");
        ProdOrderLine.SetRange(Status, ProdOrderLine.Status::Released);
        ProdOrderLine.SetRange("Prod. Order No.", "Prod. Order No.");
    end;

    local procedure ReadGLSetup()
    begin
        if not GLSetupRead then begin
            GLSetup.Get();
            GLSetupRead := true;
        end;
    end;

    local procedure GetSKU(): Boolean
    begin
        if (SKU."Location Code" = "Location Code") and
           (SKU."Item No." = "Item No.") and
           (SKU."Variant Code" = "Variant Code")
        then
            exit(true);
        if SKU.Get("Location Code", "Item No.", "Variant Code") then
            exit(true)
        else
            exit(false);
    end;


    procedure GetMfgSetup()
    begin
        if not MfgSetupRead then
            MfgSetup.Get();
        MfgSetupRead := true;
    end;


    procedure UpdateConfiguration()  //TODO PAP Uncomment
    begin
        // if (ConfiguratorItem.Get(Item."Configurator No.")) then begin
        //     "Configurator No." := Item."Configurator No.";
        //     ConfiguratorShape.Get(ConfiguratorItem."NV8 Shape");
        //     if ConfiguratorShape."Dimensioned Roll" then begin
        //         if ConfiguratorMaterial.Get(ConfiguratorItem."NV8 Material") then begin
        //             case true of
        //                 ("NV8 Unit Width Inches" >= ConfiguratorMaterial."Jumbo Min. Width") and
        //               ("NV8 Unit Length meters" >= ConfiguratorMaterial."Jumbo Min. Length"):
        //                     "Material Type" := "material type"::Jumbo;
        //                 ("NV8 Unit Width Inches" >= ConfiguratorMaterial."Narrow Remnant Min. Width") and
        //               ("NV8 Unit Length meters" >= ConfiguratorMaterial."Narrow Remnant Min. Length"):
        //                     "Material Type" := "material type"::"Narrow Remnant";
        //                 ("NV8 Unit Width Inches" >= ConfiguratorMaterial."Short Remnant Min. Width") and
        //               ("NV8 Unit Length meters" >= ConfiguratorMaterial."Short Remnant Min. Length"):
        //                     "Material Type" := "material type"::"Short Remnant";
        //                 else
        //                     "Material Type" := "material type"::Scrap;
        //             end;
        //         end;
        //     end else begin
        //         "NV8 Unit Width Inches" := ConfiguratorItem."Quantity 1";
        //         "NV8 Unit Length meters" := ROUND(ConfiguratorItem."Quantity 2" / 39, 0.00001);
        //         "Unit Length Inches" := ConfiguratorItem."Quantity 2";
        //     end;
        // end;
    end;


    procedure UpdatePieces()
    begin
        // TODO PAP Uncomment
        // UpdateConfiguration;
        // "Unit Area m2" := ROUND("NV8 Unit Width Inches" * "NV8 Unit Length meters" / 39, 0.00001);
        // "Total Area m2" := Pieces * "Unit Area m2";
        // "Total Length meters" := Pieces * "NV8 Unit Length meters";

        // if "Entry Type" <> "entry type"::Output then begin
        //     if "Material Type" = "material type"::" " then begin
        //         Validate(Quantity, Pieces);
        //     end else begin
        //         Validate(Quantity, "Total Area m2");
        //     end;
        // end else begin
        //     if "Material Type" = "material type"::" " then begin
        //         Validate("Output Quantity", Pieces);
        //     end else begin
        //         Validate("Output Quantity", "Total Area m2");
        //     end;
        // end;

        // InventorySetup.Get;
        // "Jumbo Pull" := false;
        // if
        //  ((UserSetup.Get(UserId)) and (UserSetup."Warehouse Location" = "Location Code")) or
        //  ((InventorySetup."Warehouse Location" = "Location Code")) then begin
        //     if
        //       ("Material Type" = "material type"::Jumbo) and
        //       ("Entry Type" = "entry type"::Transfer) then begin
        //         // only for normal pull locations.
        //         CalcFields("From Bin Location");
        //         if (not BinLocation.Get("Location Code", "From Bin Location")) or (not BinLocation."Jumbo Pull Not Required") then
        //             "Jumbo Pull" := true;
        //     end;
        // end;
    end;


    procedure UpdateQuantity()
    begin
        exit;
        "Unit Area m2" := ROUND("Unit Width Inches" * "Unit Length meters" / 39, 0.00001);
        "Total Area m2" := Pieces * "Unit Area m2";
        "Total Length meters" := Pieces * "Unit Length meters";

        if "Material Type" = "material type"::" " then begin
            Validate(Quantity, Pieces);
        end else begin
            Validate(Quantity, Pieces * "Unit Area m2");
        end;


        if "Material Type" = "material type"::" " then begin
            Pieces := Quantity;
        end else begin
            if "Unit Area m2" <> 0 then
                // ERROR(AG014);
                Pieces := ROUND(Quantity / "Unit Area m2");
        end;

        "Unit Area m2" := ROUND("Unit Width Inches" * "Unit Length meters" / 39, 0.00001);
        "Total Area m2" := Pieces * "Unit Area m2";
        "Total Length meters" := Pieces * "Unit Length meters";
    end;


    procedure GetFIFOCode(Date: Date): Code[7]
    begin
        exit(Format(
          Date2dwy(Date, 3) * 1000 +
          Date2dwy(Date, 2) * 10 +
          Date2dwy(Date, 1)));
    end;


    procedure GetFIFODate(FIFOCode: Code[20]): Date
    var
        Wday: Integer;
        Week: Integer;
        Year: Integer;
    begin
        if FIFOCode = '' then
            exit(0D);
        if not Evaluate(Wday, CopyStr(FIFOCode, 7, 1)) then
            exit(0D);
        if not Evaluate(Week, CopyStr(FIFOCode, 5, 2)) then
            exit(0D);
        if not Evaluate(Year, CopyStr(FIFOCode, 1, 4)) then
            exit(0D);
        exit(Dwy2Date(Wday, Week, Year));
    end;


    procedure SetUpNewLine(var EntryNo: Integer; SetUser: Code[200]; SetDate: Date)
    begin
        //EC1.01
        //"Entry no" no longer refers to the ILE since we can have multiple lines for one ILE now that we are using lots
        //IF NOT ItemLedgEntry.GET(EntryNo) THEN
        //  EXIT;

        "Entry Type" := "entry type"::"Positive Adjmt.";
        //VALIDATE("Item No.",ItemLedgEntry."Item No.");
        //VALIDATE("Location Code",ItemLedgEntry."Location Code");
        // "Unit Cost" :=
        //VALIDATE("NV8 Unit Width Inches",ItemLedgEntry."NV8 Unit Width Inches");
        //"NV8 Unit Length meters" := ItemLedgEntry."NV8 Unit Length meters";
        //VALIDATE("Unit Length Inches",ItemLedgEntry."Unit Length Inches");
        //"Unit Area m2" := ItemLedgEntry."Unit Area m2";
        //"Unit Width Code" := ItemLedgEntry."Unit Width Code";
        // IF "Line No." = 0 THEN BEGIN
        //  VALIDATE(Pieces,-ItemLedgEntry."Remaining Pieces");
        Validate(Pieces, 0);
        "Allocated By" := SetUser;
        "Allocated On" := SetDate;
        "Allocation Type" := "allocation type"::" ";
        "Allocation Description" := 'Allocated Entry';
        //"Re-Cut" := ItemLedgEntry."Re-Cut";
        //"Re-Cut No." := ItemLedgEntry."Re-Cut No.";
    end;


    procedure ValidateReadyToPost(CalledLocal: Boolean)
    begin
        if CalledLocal then begin
            RollAllocatorLine.Reset();
            RollAllocatorLine.SetRange("Item Ledger Entry No.", "Item Ledger Entry No.");
            RollAllocatorLine.SetFilter("Line No.", '<>%1', "Line No.");
            if RollAllocatorLine.Find('-') then
                repeat
                    RollAllocatorLine."Ready To Post" := "Ready To Post";
                    RollAllocatorLine.ValidateReadyToPost(false);
                    RollAllocatorLine.Modify();
                until RollAllocatorLine.Next() = 0;
        end;
    end;


    procedure CalcYield(var rec: Record "Item Ledger Entry"; WidthFilter: Decimal; LengthFilter: Decimal)
    begin
        // TODO PAP Uncomment
        // ModifyItemLedgerEntry.Reset();
        // ModifyItemLedgerEntry.Copy(rec);
        // ModifyItemLedgerEntry.Find('-');
        // repeat
        //     ModifyItemLedgerEntry.Validate("Re-Cut", true);
        //     if WidthFilter <> 0 then
        //         "Re-Cut Width Inches" := WidthFilter;
        //     if LengthFilter <> 0 then
        //         "Re-Cut Length Inches" := LengthFilter;
        //     ModifyEntry.EditConfiguration(ModifyItemLedgerEntry);
        // until ModifyItemLedgerEntry.Next() = 0;
        // // CurrForm.UPDATE;
    end;


    procedure GetLine(ItemLedgEntry: Record "Item Ledger Entry"; var ItemJnlLine: Record "Item Journal Line"; TemplateName: Code[10]; BatchName: Code[10])
    var
        TmpJnlLine: Record "Item Journal Line";
    begin
        ItemJnlLine.Init();
        TmpJnlLine.Init();
        ItemJnlLine."Journal Template Name" := TemplateName;
        ItemJnlLine."Journal Batch Name" := BatchName;
        ItemJnlLine.SetUpNewLine(TmpJnlLine);
        ItemJnlLine.Validate("Posting Date", Today);
        ItemJnlLine.Validate("Entry Type", ItemJnlLine."entry type"::Transfer);
        ItemJnlLine.Validate("Item No.", ItemLedgEntry."Item No.");
        ItemJnlLine.Validate("Applies-to Entry", ItemLedgEntry."Entry No.");
        ItemJnlLine.Validate("Location Code", ItemLedgEntry."Location Code");
        ItemJnlLine.Validate("NV8 Pieces", ItemLedgEntry."NV8 Remaining Pieces");
        ItemJnlLine.Validate("NV8 Unit Width Inches", ItemLedgEntry."NV8 Unit Width Inches");
        ItemJnlLine.Validate("NV8 Unit Length meters", ItemLedgEntry."NV8 Unit Length meters");
        ItemJnlLine.Validate(Quantity, ItemLedgEntry."Remaining Quantity");
    end;


    procedure SelectAllocRoll(rec: Record "Item Ledger Entry"; RollFound: Boolean; LoggedUser: Code[200]; LockDate: Date)
    begin
    end;


    procedure LockRoll(EntryNo: Integer; SetUser: Code[200]; SetDate: Date)
    begin
        RollAllocatorLine.Init();
        RollAllocatorLine."Item Ledger Entry No." := EntryNo;
        RollAllocatorLine."Line No." := 0;
        RollAllocatorLine.SetUpNewLine(EntryNo, SetUser, SetDate);
        RollAllocatorLine."Allocation Type" := RollAllocatorLine."allocation type"::"Transfer From Stock";
        if RollAllocatorLine.Insert() then
          ;
    end;


    procedure CutSlice()
    begin
        /*
        IF NOT CONFIRM('Do you wnat to post these lines.',FALSE) THEN
          EXIT;
        Window.OPEN('Posting line #1##########');
        WITH RollAllocatorLine DO BEGIN
          RESET;
          SETRANGE("NV8 Item Ledger Entry No.",Rec."Entry No.");
          SETFILTER("Line No.",'>0');
          FIND('-');
          REPEAT
            Window.UPDATE(1,"Line No.");
            ItemJnlLine.INIT;
            ItemJnlLine.VALIDATE("Item No.","Item No.");
            ItemJnlLine.VALIDATE("Posting Date",TODAY);
            ItemJnlLine.VALIDATE("Entry Type","Entry Type");
            ItemJnlLine."Document No." := STRSUBSTNO('ALLOC-%1',WORKDATE);
              ItemJnlLine."External Document No." := STRSUBSTNO('ALLOC-%1',COPYSTR(USERID,1,14));
            if "entry type" = "entry type"::transfer then begin
              ItemJnlLine.validate("Location Code",rec."Location Code");
              ItemJnlLine."New Location Code" := "Location Code";
              ItemJnlLine."Bin Location" := Rec."Bin Location";
              ItemJnlLine."New Bin Location" := "Bin Location";
              IF ItemJnlLine."New Bin Location" = '' THEN
                ItemJnlLine."New Bin Location" := Rec."Bin Location";
            end else beginItemJnlLine."Location Code" := Rec."Location Code";
              ItemJnlLine."Location Code" := rec."Location Code";
              ItemJnlLine."New Location Code" := '';
              ItemJnlLine."Bin Location" := rec."Bin Location";
              ItemJnlLine."New Bin Location" := ;
            end;
            itemjnlline."roll id" := "roll id";
        
            ItemJnlLine."Applies-to Entry" := "Entry No.";
            ItemJnlLine.VALIDATE("NV8 Unit Width Inches","NV8 Unit Width Inches");
            ItemJnlLine.VALIDATE("NV8 Unit Length meters","NV8 Unit Length meters");
            ItemJnlLine.VALIDATE(Pieces,Pieces);
            ModifyEntry.RUN(ItemJnlLine);
          UNTIL NEXT = 0;
          SETRANGE("Line No.");
          DELETEALL;
        END;
        Window.CLOSE;
         */

    end;


    procedure CheckLedgerBalance(CheckRollAllocationLine: Record "NV8 Roll Allocator Line")
    begin
    end;


    procedure CheckLine(ItemLedgerEntry: Record "Item Ledger Entry"; CheckRollAllocationLine: Record "NV8 Roll Allocator Line")
    begin
        // Check if item ledger entry is open
        // Only if not positive.....
        //ItemLedgerEntry.TESTFIELD(Open,TRUE);
        //ItemLedgerEntry.TESTFIELD(Positive,TRUE);
        // Test if this is a valid roll - these tests are not critical
        ConfiguratorShape.Get(ItemLedgerEntry."NV8 Shape");
        ConfiguratorMaterial.Get(ItemLedgerEntry."NV8 Material");
        ConfiguratorMaterialGrit.Get(ItemLedgerEntry."NV8 Material", ItemLedgerEntry."NV8 Grit");

        // Check the type of line to create
        if "Allocation Type" in
          ["allocation type"::"Transfer From Stock", "allocation type"::"Return To Stock", "allocation type"::"Jumbo Pull Request"] then begin
            if Abs(ItemLedgerEntry."NV8 Unit Width Inches" - "Unit Width Inches") > 0.0001 then
                ItemLedgerEntry.TestField("NV8 Unit Width Inches", "Unit Width Inches");
            if Abs(ItemLedgerEntry."NV8 Unit Length meters" - "Unit Length meters") > 0.0001 then
                ItemLedgerEntry.TestField("NV8 Unit Length meters", "Unit Length meters");
            if Pieces <> ROUND(Pieces, 1) then
                Error('You can only Transfer whole pieces. %1 is not allowed', Pieces);
            if ItemLedgerEntry."NV8 Remaining Pieces" > 0 then
                if Pieces > ItemLedgerEntry."NV8 Remaining Pieces" then
                    Error('You can not transfer more than %1 pieces', ItemLedgerEntry."NV8 Remaining Pieces");
        end;

        CheckRollAllocationLine.TestField("Allocated Quantity");

        case "Allocation Type" of
            "allocation type"::"Transfer From Stock":
                begin
                end;
            "allocation type"::"Return To Stock":
                begin
                end;
            "allocation type"::"Jumbo Pull Request":
                begin
                    TestField("Location Code");
                    // TESTFIELD("New Location Code");
                end;
            "allocation type"::"Use In Manufacturing":
                begin
                    if "Prod. Order No." = '' then
                        Error('You must specify the Production Order No. for consumption of Raw Material.');
                end;
            "allocation type"::"Hold Remnant on Floor":
                begin
                end;
            "allocation type"::"Remnant to Stock":
                begin
                end;
            "allocation type"::Waste:
                begin
                end;
            "allocation type"::Overage:
                begin
                end;
            "allocation type"::"Positive Adjustment":
                begin
                end;
            "allocation type"::"Negative Adjustment":
                begin
                end;
            else
                Error('%1 type transactions are not supported', "Allocation Type");
        end;
    end;


    procedure CreateJournalLine(RollAllocatorLine_: Record "NV8 Roll Allocator Line")
    begin
        /*WITH RollAllocatorLine DO BEGIN
          IF NOT ItemLedgEntry.GET("NV8 Item Ledger Entry No.") THEN
            ItemLedgEntry.INIT;
          ItemJnlLine.INIT;
          ItemJnlLine.VALIDATE("Item No.","Item No.");
          ItemJnlLine.VALIDATE("Posting Date","Posting Date");
          ItemJnlLine.VALIDATE("Entry Type","Entry Type");
          ItemJnlLine."Document No." := "Document No.";
          ItemJnlLine."Gen. Bus. Posting Group" := "Gen. Bus. PostGr.";
          ItemJnlLine.VALIDATE("FIFO Date","FIFO Date");
          CASE "Entry Type" OF
            "Entry Type"::"Positive Adjmt.":
              BEGIN
                ItemJnlLine.VALIDATE("Location Code",ItemLedgEntry."Location Code");
                ItemJnlLine."New Location Code" := '';
                ItemJnlLine."Bin Location" := "Bin Location";
                ItemJnlLine."New Bin Location" := '';
                ItemJnlLine."Applies-to Entry" := 0
              END;
            "Entry Type"::Transfer:
              BEGIN
                ItemJnlLine.VALIDATE("Location Code",ItemLedgEntry."Location Code");
                ItemJnlLine."New Location Code" := "Location Code";
                ItemJnlLine."Bin Location" := '';
                ItemJnlLine."New Bin Location" := "Bin Location";
                ItemJnlLine."Applies-to Entry" := "NV8 Item Ledger Entry No.";
              END;
            "Entry Type"::Consumption:
              BEGIN
                ItemJnlLine.VALIDATE("Location Code",ItemLedgEntry."Location Code");
                ItemJnlLine."New Location Code" := '';
                ItemJnlLine."Bin Location" := '';
                ItemJnlLine."New Bin Location" := '';
                ItemJnlLine."Applies-to Entry" := "NV8 Item Ledger Entry No.";
                ItemJnlLine.VALIDATE("Order No.","Prod. Order No.");
              END;
            ELSE
              BEGIN
                ItemJnlLine.VALIDATE("Location Code",ItemLedgEntry."Location Code");
                ItemJnlLine."New Location Code" := '';
                ItemJnlLine."Bin Location" := ''; // "Bin Location";
                ItemJnlLine."New Bin Location" := '';
                ItemJnlLine."Applies-to Entry" := "NV8 Item Ledger Entry No.";
              END;
          END;
          ItemJnlLine."External Document No." := STRSUBSTNO('ALLOC-%1',COPYSTR(USERID,1,14));
          // Check if this is the text we want...
          // ItemJnlLine."Description 2" := Description;
          ItemJnlLine."Allocator Comment" := "Allocator Comment";
          // ItemJnlLine."NV8 Unit Width Inches" := "NV8 Unit Width Inches";
          // ItemJnlLine."NV8 Unit Length meters" := "NV8 Unit Length meters";
          ItemJnlLine.VALIDATE("NV8 Unit Length meters","NV8 Unit Length meters"); // fix wid len error
          ItemJnlLine.Pieces := Pieces;
          ItemJnlLine.VALIDATE("NV8 Unit Width Inches","NV8 Unit Width Inches");
          ItemJnlLine.Quantity := Quantity;
          IF "Allocation Type" IN ["Allocation Type"::"Negative Adjustment","Allocation Type"::Waste,"Allocation Type"::Overage] THEN
            ItemJnlLine.VALIDATE(Quantity)
          ELSE
            ItemJnlLine.VALIDATE(Pieces);
          IF
            "Transfer Whole Pieces" AND
            (ItemJnlLine.Pieces = ItemLedgEntry."Remaining Pieces") AND
            (ItemJnlLine.Quantity <> ItemLedgEntry."Remaining Quantity") THEN BEGIN
              ItemJnlLine.VALIDATE(Quantity,ItemLedgEntry."Remaining Quantity");
          END;
        
          //>> waste and overage
          IF ("Overage Area m2" <> 0) AND (ItemJnlLine.Quantity <> Quantity) THEN
            ItemJnlLine.VALIDATE(Quantity,Quantity);
          //<<
          // ItemJnlLine."source type" := ItemJnlLine."source type::item;
          // ItemJnlLine."source no." := ItemJnlLine."Item No.";
          // ItemJnlLine.VALIDATE("Prod. Order No.","Prod. Order No.");
          ItemJnlLine."Order No." := "Prod. Order No.";
          ItemJnlLine."Roll Allocation Line" := TRUE;
          // for allocation entry reservations
          ItemJnlLine."Allocation ID" := "Allocation ID";
          ItemJnlLine."Allocated for Type" := "Allocated for Type";
          ItemJnlLine."Allocated for Code" := "Allocated for Code";
          ItemJnlLine."Allocated for Order No" := "Allocated for Order No";
          ItemJnlLine."Re-Cut" := "Re-Cut";
          ItemJnlLine."Re-Cut No." := "Re-Cut No.";
          ItemJnlLine."Roll ID" := "Roll ID";
          ItemJnlLine."Subst. Material" := "Subst. Material";
        
        END;
          */

    end;


    procedure OpenHoldingJnl()
    var
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlLine: Record "Item Journal Line";
        JnlSelected: Boolean;
    begin
        ConfiguratorSetup.Get();
        ItemJnlTemplate.Reset();
        ItemJnlTemplate.Get(ConfiguratorSetup."Allocation Template");
        ItemJnlLine.Reset();
        ItemJnlLine.FilterGroup := 2;
        ItemJnlLine.SetRange("Journal Template Name", ItemJnlTemplate.Name);
        ItemJnlLine.SetRange("Journal Batch Name", ConfiguratorSetup."Jumbo Pull Request");
        ItemJnlLine.Find('-');
        ItemJnlLine.FilterGroup := 0;
        Page.RunModal(ItemJnlTemplate."Page ID", ItemJnlLine);
    end;


    procedure PostJournalLine(RollAllocatorLine_: Record "NV8 Roll Allocator Line")
    begin
        CreateJournalLine(RollAllocatorLine);
        if RollAllocatorLine_."Allocation Type" = "allocation type"::"Jumbo Pull Request" then begin
            ConfiguratorSetup.Get();
            ConfiguratorSetup.TestField("Allocation Template");
            ConfiguratorSetup.TestField("Jumbo Pull Request");
            JumboPullList.LockTable();
            JumboPullList.Reset();
            JumboPullList.SetRange("Journal Template Name", ConfiguratorSetup."Allocation Template");
            JumboPullList.SetRange("Journal Batch Name", ConfiguratorSetup."Jumbo Pull Request");
            if JumboPullList.Find('+') then
                NextLineNo := JumboPullList."Line No." + 10000
            else
                NextLineNo := 10000;
            JumboPullList.Copy(ItemJnlLine);
            JumboPullList."Journal Template Name" := ConfiguratorSetup."Allocation Template";
            JumboPullList."Journal Batch Name" := ConfiguratorSetup."Jumbo Pull Request";
            JumboPullList."Line No." := NextLineNo;
            JumboPullList.Insert();
        end else begin
            ModifyEntry.Run(ItemJnlLine);
        end;
    end;


    procedure MoveJournalBatch(SrcJnlTemp: Code[10]; SrcJnlBatch: Code[10]; var NewJnlLine: Record "Item Journal Line"; DeleteOld: Boolean; FilterLines: Boolean)
    var
        SrcJnlLine: Record "Item Journal Line";
    begin
        SrcJnlLine.Reset();
        SrcJnlLine.SetRange("Journal Template Name", SrcJnlTemp);
        SrcJnlLine.SetRange("Journal Batch Name", SrcJnlBatch);
        // Filter lines not used, can be used to set a flag ont he Src jnl line to selectively move/copy
        // if filterlines then
        // SrcJnlLine.setrange something....
        SrcJnlLine.Find('-'); // std error message if there are no lines to move
        ItemJnlLine.Init();
        ItemJnlLine."Journal Template Name" := SrcJnlTemp;
        ItemJnlLine."Journal Batch Name" := SrcJnlBatch;
        ItemJnlLine.Description := 'Jumbo Pull :' + Format(SrcJnlLine."Posting Date");
        // ItemJnlLine."Description 2" := SrcJnlLine."External Document No.";
        MoveJournalLine(ItemJnlLine, NewJnlLine."Journal Template Name", NewJnlLine."Journal Batch Name", false);
        repeat
            MoveJournalLine(SrcJnlLine, NewJnlLine."Journal Template Name", NewJnlLine."Journal Batch Name", true);
        until SrcJnlLine.Next() = 0;

        NewJnlLine.Reset();
        NewJnlLine.SetRange("Journal Template Name", NewJnlLine."Journal Template Name");
        NewJnlLine.SetRange("Journal Batch Name", NewJnlLine."Journal Batch Name");
        if NewJnlLine.Find('+') then
          ;
    end;


    procedure MoveJournalLine(SrcJnlLine: Record "Item Journal Line"; NewJnlTemp: Code[10]; NewJnlBatch: Code[10]; DeleteOld: Boolean)
    var
        NextInsLineNo: Integer;
    begin
        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", NewJnlTemp);
        ItemJnlLine.SetRange("Journal Batch Name", NewJnlBatch);
        if ItemJnlLine.Find('+') then
            NextInsLineNo := ItemJnlLine."Line No." + 10000
        else
            NextInsLineNo := 10000;
        ItemJnlLine.Copy(SrcJnlLine);
        ItemJnlLine."Journal Template Name" := NewJnlTemp;
        ItemJnlLine."Journal Batch Name" := NewJnlBatch;
        ItemJnlLine."Line No." := NextInsLineNo;
        ItemJnlLine.CalcFields("NV8 From Bin Location", "NV8 From FIFO Code");
        ItemJnlLine."NV8 Bin Sorting" := ItemJnlLine."NV8 From Bin Location";

        ItemJnlLine.Insert(true);
        if DeleteOld then
            SrcJnlLine.Delete(true);
    end;


    procedure CreateWasteLine(CheckRollAllocationLine: Record "NV8 Roll Allocator Line")
    begin
        ItemLedgEntry.Get(CheckRollAllocationLine."Item Ledger Entry No.");
        ItemLedgEntry.CalcFields("NV8 Allocated Quantity");
    end;


    procedure PostAllocation(LoggedUser: Code[200]; PostAll: Boolean; EntryNo: Integer)
    var
        l_ProdOrder: Record "Production Order";
    begin
        SelectLatestVersion();
        Reset();
        SetCurrentkey("Allocated By");
        //TESTING Remove temporarily
        //SETRANGE("Allocated By",LoggedUser);
        SetRange("Item Ledger Entry No.", EntryNo);
        if not Find('-') then
            Error('There are no lines in the selected range that are Marked to Post.');
        if not Confirm('Do you want to process the Allocation Lines?', false) then
            exit;
        Window.Open(
          'Checking Line    #1######\' +
          'Processing Line  #2######');

        PostedRollAllocatorLine.Reset();
        SetFilter("Line No.", '<>%1', 0);
        /* SETFILTER("Entry Type",'<>%1',"Entry Type"::Transfer);   */
        //Dont reclass first because lot no will be different and lot info will not exist
        Find('-');
        repeat
            Window.Update(2, RollAllocatorLine."Line No.");
            PostJournalLineROLL(RollAllocatorLine);
            SelectLatestVersion();
            PostedRollAllocatorLine.TransferFields(RollAllocatorLine);
            PostedRollAllocatorLine.Insert();
            // EC1.MFG04.01 Update Status on the Production Order
            l_ProdOrder.SetRange(l_ProdOrder."No.", RollAllocatorLine."Prod. Order No.");
            if l_ProdOrder.FindFirst() then begin
                l_ProdOrder."NV8 production status" := l_ProdOrder."NV8 production status"::"In Progress";
                l_ProdOrder.Modify();

            end;
            //

            Delete();

        until Next() = 0;


        SetRange("Line No.", 0);
        if Delete() then;
        /*
          SETRANGE("Entry Type","Entry Type"::Transfer);
          FIND('-');
          REPEAT
            Window.UPDATE(2,RollAllocatorLine."Line No.");
            PostJournalLineROLL(RollAllocatorLine);
            PostedRollAllocatorLine.TRANSFERFIELDS(RollAllocatorLine);
            PostedRollAllocatorLine.INSERT;
        // EC1.MFG04.01 Update Status on the Production Order
            l_ProdOrder.SETRANGE(l_ProdOrder."No.",RollAllocatorLine."Prod. Order No.");
            IF l_ProdOrder.FINDFIRST THEN
            BEGIN
             l_ProdOrder."NV8 production status" := l_ProdOrder."NV8 production status"::"In Progress";
             l_ProdOrder.MODIFY;

            END;
          //

            DELETE;

          UNTIL NEXT = 0;

        */
        Window.Close();

    end;


    procedure PostSingleAllocation(RollAllocline: Record "NV8 Roll Allocator Line"; LoggedUser: Code[200]; PostAll: Boolean; EntryNo: Integer)
    var
        l_ProdOrder: Record "Production Order";
    begin
        SelectLatestVersion();
        PostedRollAllocatorLine.Reset();
        PostJournalLineROLL(RollAllocline);
        PostedRollAllocatorLine.TransferFields(RollAllocline);
        PostedRollAllocatorLine.Insert();
        // EC1.MFG04.01 Update Status on the Production Order
        l_ProdOrder.SetRange(l_ProdOrder."No.", RollAllocline."Prod. Order No.");
        if l_ProdOrder.FindFirst() then begin
            l_ProdOrder."NV8 production status" := l_ProdOrder."NV8 production status"::"In Progress";
            l_ProdOrder.Modify();

        end;


        Delete();
    end;


    procedure CreateRollID(): Boolean
    var
        NoSeries: Code[20];
    begin
        if "Material Type" = "material type"::" " then
            exit;
        InventorySetup.Get();
        InventorySetup.TestField("NV8 Roll ID Nos.");
        NoSeriesMgt.InitSeries(InventorySetup."NV8 Roll ID Nos.", '', 0D, "Roll ID", NoSeries);
    end;


    procedure GetConfiguration()
    begin
        if ConfiguratorItem.Get("Configurator No.") then begin
            Shape := ConfiguratorItem.Shape;
            Material := ConfiguratorItem.Material;
            Specification := ConfiguratorItem.Specification;
            Grit := ConfiguratorItem.Grit;
            Joint := ConfiguratorItem.Joint;
            if Pieces = 0 then
                Pieces := 1;
        end;
    end;


    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Posting Date", "Source No.");
        NavigateForm.Run();
    end;


    procedure CheckRollIDinUSE(l_RollID: Code[20]): Boolean
    var
        l_RaLine: Record "NV8 Roll Allocator Line";
    begin
        l_RaLine.SetCurrentkey(l_RaLine."Roll ID");
        l_RaLine.SetRange(l_RaLine."Roll ID", l_RollID);
        exit(l_RaLine.FindFirst());
    end;


    procedure CreateLineROLL(RollSelectorLine: Record "NV8 Roll Selector Line"; AllocationType: Option " ","Transfer From Stock","Return To Stock","Jumbo Pull Request","Send To Production","Production Returns-Not Used","Hold on Floor",Overage,Waste,"Positive Adjustment","Negative Adjustment","Pick-Not Used","Putaway-Not Used"; LocationCode: Code[10]; BinLocation: Code[10]; AllocateQuantity: Decimal; AllocatePieces: Decimal; AllocateWidth: Decimal; AllocateLength: Decimal; MFGOrderNo: Code[20]; AllocType: Option " ","Sales Order","Transfer Order"; AllocCode: Code[20]; AllocOrderNo: Code[20]; AllocText: Text[80]; SetUser: Code[200]; SetPin: Code[10]; SetOpId: Code[20])
    var
        RollSelectorLine2: Record "NV8 Roll Selector Line";
        NextSortingNo: Integer;
    begin
        Reset();
        SetCurrentkey("Item Ledger Entry No.");
        SetRange("Item Ledger Entry No.", RollSelectorLine."Entry No.");
        NextSortingNo := Count;
        Reset();

        ZeroLineFound := ZeroLine.Get(RollSelectorLine."Entry No.", 0);
        // UE-529
        //This should not be needed problem is solved before passing the entry
        // Issue was with entries that were not allocated through the allocator but manually transfered where no allocation ID exists on the lot card
        /*
        IF RollSelectorLine."Entry No." = 0 THEN BEGIN
          RollAllocatorLine.RESET;
          IF RollAllocatorLine.FIND('-') AND (RollAllocatorLine."NV8 Item Ledger Entry No." < 0) THEN
        
           //Original passed by VAR which would cause page to close randomly
            RollSelectorLine."Entry No." := RollAllocatorLine."NV8 Item Ledger Entry No." - 1
        
          ELSE
            RollAllocatorLine."NV8 Item Ledger Entry No." := -1;
        END;
         */





        SetRange("Item Ledger Entry No.", RollSelectorLine."Entry No.");
        if not Find('+') then begin
            LockRoll(RollSelectorLine."Entry No.", SetUser, WorkDate());
            NextLineNo := 10000;
        end else
            NextLineNo := "Line No." + 10000;

        // Set up the new line
        Init();
        "Item Ledger Entry No." := RollSelectorLine."Entry No.";
        // for reservation oif allocation entry.
        "Allocation ID" := RollSelectorLine."Entry No.";
        "Line No." := NextLineNo;
        "Sort No." := NextSortingNo;
        "Posting Date" := WorkDate();
        Validate("Item No.", RollSelectorLine."Item No.");
        "Document No." := StrSubstNo('ALLOC-%1', GetFIFOCode(WorkDate()));
        "Allocator Comment" := AllocText;
        Validate("Location Code", LocationCode);
        "Bin Location" := BinLocation;
        Quantity := AllocateQuantity;

        Validate("Unit Length meters", AllocateLength); // fix the issue with no length and width
        Pieces := AllocatePieces;
        Validate("Unit Width Inches", AllocateWidth);  // fix the issue with no length and width
        "FIFO Date" := RollSelectorLine."FIFO Date";

        "Allocated By" := SetUser;
        "Allocated On" := WorkDate();
        "Allocation Type" := AllocationType;

        "Allocated for Type" := AllocType;
        "Allocated for Code" := AllocCode;
        "Allocated for Order No" := AllocOrderNo;
        "Roll ID" := RollSelectorLine."Roll ID";
        PIN := SetPin;
        "Machine No." := SetOpId;

        ProdOrderLine.Reset();
        ProdOrderLine.SetCurrentkey(Status, "Prod. Order No.");
        ProdOrderLine.SetRange(Status, ProdOrderLine.Status::Released);
        ProdOrderLine.SetRange("Prod. Order No.", MFGOrderNo);
        if ProdOrderLine.FindFirst() then
            if ProdOrderLine."NV8 Material" <> RollSelectorLine.Material then begin
                "Subst. Material" := ProdOrderLine."NV8 Material";
                ProdOrderComp.Reset();
                ProdOrderComp.SetCurrentkey(Status, "Prod. Order No.", "Prod. Order Line No.");
                ProdOrderComp.SetRange(Status, ProdOrderLine.Status::Released);
                ProdOrderComp.SetRange("Prod. Order No.", MFGOrderNo);
                ProdOrderComp.SetFilter("NV8 Grit", '<>%1', '');
                if ProdOrderComp.FindFirst() then
                    if ProdOrderComp."Item No." <> RollSelectorLine."Item No." then begin
                        ProdOrderComp."NV8 Substitute Material" := true;
                        ProdOrderComp."NV8 Ori. Shape" := ProdOrderComp."NV8 Shape";
                        ProdOrderComp."NV8 Ori. Material" := ProdOrderComp."NV8 Material";
                        ProdOrderComp."NV8 Ori. Grit" := ProdOrderComp."NV8 Grit";
                        ProdOrderComp."NV8 Ori. Item No." := ProdOrderComp."Item No.";
                        ProdOrderComp.Validate("Item No.", RollSelectorLine."Item No.");
                        ProdOrderComp.Modify();
                    end;
            end;

        case "Allocation Type" of
            "allocation type"::"Transfer From Stock":
                begin
                    "Entry Type" := "entry type"::Transfer;
                    "Allocation Description" := StrSubstNo('Transfer %1 Roll(s) to Production Floor', AllocatePieces);
                    "Transfer Whole Pieces" := true;
                    "Prod. Order No." := MFGOrderNo;
                    Validate(Pieces);
                    if ZeroLineFound and (ZeroLine."Allocation Type" <> ZeroLine."allocation type"::Transfer) then begin
                        ZeroLine."Allocation Type" := ZeroLine."allocation type"::Transfer;
                        ZeroLine.Modify();
                    end;
                end;
            "allocation type"::"Return To Stock":
                begin
                    "Entry Type" := "entry type"::Transfer;
                    "Allocation Description" := StrSubstNo('Return %1 Roll(s) to Stock', AllocatePieces);
                    "Transfer Whole Pieces" := true;
                    "Prod. Order No." := '';
                    Validate(Pieces);
                    if ZeroLineFound and (ZeroLine."Allocation Type" <> ZeroLine."allocation type"::Transfer) then begin
                        ZeroLine."Allocation Type" := ZeroLine."allocation type"::Transfer;
                        ZeroLine.Modify();
                    end;
                end;
            "allocation type"::"Jumbo Pull Request":
                begin
                    "Entry Type" := "entry type"::Transfer;
                    if ConfiguratorShape.Get(RollSelectorLine.Shape) then
                        "Allocation Description" := StrSubstNo('Add %1 %2 to Requested Pull List', AllocatePieces, ConfiguratorShape.Description)
                    else
                        "Allocation Description" := StrSubstNo('Add %1 %2 to Requested Pull List', AllocatePieces, RollSelectorLine."Item No.");
                    "Transfer Whole Pieces" := true;
                    "Prod. Order No." := MFGOrderNo;
                    Validate(Pieces);
                    if ZeroLineFound and (ZeroLine."Allocation Type" <> ZeroLine."allocation type"::Transfer) then begin
                        ZeroLine."Allocation Type" := ZeroLine."allocation type"::Transfer;
                        ZeroLine.Modify();
                    end;
                end;
            "allocation type"::"Use In Manufacturing":
                begin
                    "Entry Type" := "entry type"::Consumption;
                    "Allocation Description" := StrSubstNo('Send %1 Piece(s) to production', AllocatePieces);
                    "Transfer Whole Pieces" := false;
                    "Prod. Order No." := MFGOrderNo;
                    Validate(Pieces);
                    if ZeroLineFound and (ZeroLine."Allocation Type" <> ZeroLine."allocation type"::Slitting) then begin
                        ZeroLine."Allocation Type" := ZeroLine."allocation type"::Slitting;
                        ZeroLine.Modify();
                    end;
                end;
            "allocation type"::"Hold Remnant on Floor":
                begin
                    "Entry Type" := "entry type"::Transfer;
                    "Allocation Description" := StrSubstNo('Hold %1 Roll(s) on the floor after cutting or slicing', AllocatePieces);
                    "Transfer Whole Pieces" := false;
                    "Prod. Order No." := MFGOrderNo;
                    Validate(Pieces);
                end;
            "allocation type"::"Remnant to Stock":
                begin
                    "Entry Type" := "entry type"::Transfer;
                    "Allocation Description" := StrSubstNo('Remnant %1 Roll(s) returned to stock', AllocatePieces);
                    "Transfer Whole Pieces" := false;
                    "Prod. Order No." := MFGOrderNo;
                    Validate(Pieces);
                end;
            "allocation type"::Waste:
                begin
                    "Entry Type" := "entry type"::"Negative Adjmt.";
                    "Allocation Description" := StrSubstNo('Create waste.', AllocatePieces);
                    "Transfer Whole Pieces" := false;
                    "Prod. Order No." := MFGOrderNo;
                    // >> doesnt work - VALIDATE(Quantity);
                    Validate(Quantity, AllocateQuantity);
                end;
            "allocation type"::Overage:
                begin
                    "Entry Type" := "entry type"::"Positive Adjmt.";
                    "Allocation Description" := StrSubstNo('Create overage.', AllocatePieces);
                    "Transfer Whole Pieces" := false;
                    "Prod. Order No." := '';
                    // >> doesnt work - VALIDATE(Quantity);
                    Validate(Quantity, AllocateQuantity);
                end;
            "allocation type"::"Negative Adjustment":
                begin
                    "Entry Type" := "entry type"::"Negative Adjmt.";
                    "Allocation Description" := StrSubstNo('Negative Adjustment', AllocatePieces);
                    "Transfer Whole Pieces" := false;
                    "Prod. Order No." := '';
                    Validate(Quantity);
                    if ZeroLineFound and (ZeroLine."Allocation Type" <> ZeroLine."allocation type"::Adjustments) then begin
                        ZeroLine."Allocation Type" := ZeroLine."allocation type"::Adjustments;
                        ZeroLine.Modify();
                    end;
                end;
            "allocation type"::"Positive Adjustment":
                begin
                    "Entry Type" := "entry type"::"Positive Adjmt.";
                    "Allocation Description" := StrSubstNo('Positive Adjustment', AllocatePieces);
                    "Transfer Whole Pieces" := false;
                    "Prod. Order No." := '';
                    Validate(Pieces);
                    if ZeroLineFound and (ZeroLine."Allocation Type" <> ZeroLine."allocation type"::Adjustments) then begin
                        ZeroLine."Allocation Type" := ZeroLine."allocation type"::Adjustments;
                        ZeroLine.Modify();
                    end;
                end;
        end;

        if
          (Abs("Unit Width Inches" - RollSelectorLine."Unit Width Inches") > 0.0001) or
          (Abs("Unit Length meters" - RollSelectorLine."Unit Length meters") > 0.0001) then
            "Transfer Whole Pieces" := false;

        "Re-Cut" := RollSelectorLine."Re-Cut";
        "Re-Cut No." := RollSelectorLine."Re-Cut No.";

        Validate("Ready To Post", false);


        //>>
        case "Allocation Type" of
            "allocation type"::"Transfer From Stock":
                begin
                    if RollSelectorLine."Roll ID" = '' then begin
                        "Roll ID" := '';
                        //     CreateRollID;
                        "Do Not Print" := false;
                    end else begin
                        //        "Roll ID" := RollSelectorLine."Roll ID";
                        "Do Not Print" := true;
                    end;
                end;
            "allocation type"::"Return To Stock":
                begin
                    //      "Roll ID" := RollSelectorLine."Roll ID";
                    "Do Not Print" := true;
                end;
            "allocation type"::"Jumbo Pull Request":
                begin
                    "Do Not Print" := false;
                    //      CreateRollID;
                end;
            "allocation type"::"Use In Manufacturing":
                begin
                    "Do Not Print" := true; // for now we dont want to print but will later
                                            //      CreateRollID;
                end;
            "allocation type"::"Hold Remnant on Floor":
                begin
                    //      CreateRollID;
                    "Do Not Print" := false;
                end;
            "allocation type"::"Remnant to Stock":
                begin
                    //      "Roll ID" := RollSelectorLine."Roll ID";
                    "Do Not Print" := false;
                end;
            "allocation type"::Waste:
                begin
                    "Do Not Print" := true;
                    //     "Roll ID" := '';
                end;
            "allocation type"::Overage:
                begin
                    "Do Not Print" := true;
                    //      "Roll ID" := '';
                end;
            "allocation type"::"Negative Adjustment":
                begin
                    "Do Not Print" := true;
                    //      "Roll ID" := '';
                end;
            "allocation type"::"Positive Adjustment":
                begin
                    //     CreateRollID;
                    "Do Not Print" := false;
                end;
        end;

        //<<

        Insert(true);

    end;

    local procedure PostJournalLineROLL(RollAlloc: Record "NV8 Roll Allocator Line")
    begin

        case "Allocation Type" of
            "allocation type"::"Transfer From Stock":
                begin
                end;
            "allocation type"::"Return To Stock":
                begin
                end;
            "allocation type"::"Jumbo Pull Request":
                begin
                end;
            "allocation type"::"Use In Manufacturing":
                begin
                    //Create Consumption Jnl
                    CreateConsumption(RollAlloc);
                end;
            "allocation type"::"Hold Remnant on Floor":
                begin
                    //Reclass Jnl into new lot no
                    CreateReclass(RollAlloc);

                end;
            "allocation type"::"Remnant to Stock":
                begin
                    //Reclass Jnl into new lot no
                    CreateReclass(RollAlloc);
                    //IF Return to Stock then Put Away
                    //  PutAwayWorkSheet(RollAlloc);
                    //  CreateInternalPutAway(RollAlloc);     //UE-520
                end;
            "allocation type"::Waste:
                begin
                    //Create Negative Adjustment to Original Lot
                    CreateNegAdjust(RollAlloc);
                end;
            "allocation type"::Overage:
                begin
                end;
            "allocation type"::"Negative Adjustment":
                begin
                end;
            "allocation type"::"Positive Adjustment":
                begin
                end;
        end;
    end;

    local procedure CreateConsumption(RollAlloc: Record "NV8 Roll Allocator Line")
    var
        l_WhseItemJnl: Record "Warehouse Journal Line";
        l_WhseItemTrack: Record "Whse. Item Tracking Line";
        l_WhseSetup: Record "Warehouse Setup";
        l_ItemJnl: Record "Item Journal Line";
        l_ReservationEntry: Record "Reservation Entry";
        l_Item: Record Item;
        l_InvSetup: Record "Inventory Setup";
        l_LotNoInfo: Record "Lot No. Information";
        Eno: Integer;
        l_lineno: Integer;
        ItemJnlPostLineCU: Codeunit "Item Jnl.-Post Line";
        // RollLabelAlloc: Report UnknownReport50026; // PAP report is missing
        ProdOrderComp_: Record "Prod. Order Component";
        ProdOrderL: Record "Prod. Order Line";
    begin
        //CLEAR THE BLANK LINE
        l_ItemJnl.SetRange(l_ItemJnl."Journal Template Name", l_WhseSetup."NV8 Consumption Template Name");
        l_ItemJnl.SetRange(l_ItemJnl."Journal Batch Name", l_WhseSetup."NV8 Consumption Worksheet Name");
        l_ItemJnl.SetFilter(l_ItemJnl."Item No.", '=''''');
        l_ItemJnl.DeleteAll();


        AdjustComponentLine(RollAlloc);


        l_WhseSetup.FindFirst();
        l_WhseSetup.TestField(l_WhseSetup."NV8 Consumption Template Name");
        l_WhseSetup.TestField(l_WhseSetup."NV8 Consumption Worksheet Name");

        l_InvSetup.FindFirst();
        l_Item.Get(RollAlloc."Item No.");


        l_LotNoInfo.SetRange(l_LotNoInfo."Item No.", RollAlloc."Item No.");
        l_LotNoInfo.SetRange(l_LotNoInfo."Variant Code", RollAlloc."Variant Code");
        l_LotNoInfo.SetRange(l_LotNoInfo."Lot No.", RollAlloc."Roll ID");
        l_LotNoInfo.FindFirst();


        if l_LotNoInfo."NV8 PIN" = '' then begin
            l_LotNoInfo."NV8 PIN" := RollAlloc.PIN;
            l_LotNoInfo.Modify();
        end;

        Clear(l_ItemJnl);
        l_ItemJnl.SetRange(l_ItemJnl."Journal Template Name", l_WhseSetup."NV8 Consumption Template Name");
        l_ItemJnl.SetRange(l_ItemJnl."Journal Batch Name", l_WhseSetup."NV8 Consumption Worksheet Name");
        if l_ItemJnl.FindLast() then
            l_lineno := l_ItemJnl."Line No." + 10000
        else
            l_lineno := 10000;


        Clear(l_ItemJnl);
        l_ItemJnl.Validate(l_ItemJnl."Journal Template Name", l_WhseSetup."NV8 Consumption Template Name");
        l_ItemJnl.Validate(l_ItemJnl."Journal Batch Name", l_WhseSetup."NV8 Consumption Worksheet Name");
        l_ItemJnl."Entry Type" := l_ItemJnl."entry type"::Consumption;

        l_ItemJnl."NV8 SkipCheck"();

        l_ItemJnl."Order Type" := l_ItemJnl."order type"::Production;
        l_ItemJnl."Order No." := RollAlloc."Prod. Order No.";
        l_ItemJnl."Order Line No." := 10000;

        //l_ItemJnl."Line No." := l_lineno;
        l_ItemJnl.Validate(l_ItemJnl."Item No.", RollAlloc."Item No.");
        //l_ItemJnl."Bin Code" :=  FindLotBin(RollAlloc."Location Code",RollAlloc."Item No.",RollAlloc."Roll ID",'');    //Move after Location validate
        l_ItemJnl."Posting Date" := WorkDate();
        //>> UE-489
        //l_ItemJnl."Document No." := RollAlloc."Document No.";
        l_ItemJnl."Document No." := RollAlloc."Prod. Order No.";
        l_ItemJnl."External Document No." := RollAlloc."Document No.";
        //<< UE-489

        //>> UE-651
        //l_ItemJnl."Location Code" := RollAlloc."Location Code";
        l_ItemJnl.Validate("Location Code", RollAlloc."Location Code");
        l_ItemJnl."Bin Code" := FindLotBin(RollAlloc."Location Code", RollAlloc."Item No.", RollAlloc."Roll ID", '');
        //<< UE-651

        l_ItemJnl."Document Date" := WorkDate();
        l_ItemJnl.Validate(l_ItemJnl.Quantity, RollAlloc.Quantity);

        //l_ItemJnl.Quantity := RollAlloc.Quantity;
        //l_ItemJnl."Quantity (Base)" := RollAlloc.Quantity;
        //l_ItemJnl."Invoiced Qty. (Base)" := RollAlloc.Quantity;
        //l_ItemJnl."Invoiced Quantity" := RollAlloc.Quantity;


        //l_ItemJnl."Source Type" := l_ItemJnl."Source Type"::Item;


        l_ItemJnl.Description := 'Consumption for Order: ' + RollAlloc."Prod. Order No.";
        l_ItemJnl."Order Type" := l_ItemJnl."order type"::Production;
        l_ItemJnl."Order No." := RollAlloc."Prod. Order No.";
        l_ItemJnl."Order Line No." := 10000;

        l_ItemJnl."Source Type" := l_ItemJnl."source type"::Item;
        //l_ItemJnl."Source No." := RollAlloc."Item No.";  // UE-489 01/18/18

        ///ue-601
        ProdOrderComp_.SetRange("Prod. Order No.", RollAlloc."Prod. Order No.");
        ProdOrderComp_.SetRange("Item No.", "Item No.");
        if ProdOrderComp_.FindFirst() then
            l_ItemJnl."Prod. Order Comp. Line No." := ProdOrderComp_."Line No."
             //>> 01/31/18
             ;
        //ELSE
        // l_ItemJnl."Prod. Order Comp. Line No." := 10000;
        //<< 01/31/18

        //>> UE-489  1/18/18
        //>> 01/31/18
        //ProdOrderL.SETRANGE(Status,ProdOrderComp.Status);
        ProdOrderL.SetRange(Status, ProdOrderL.Status::Released);
        //ProdOrderL.SETRANGE("Prod. Order No.",ProdOrderComp."Prod. Order No.");
        ProdOrderL.SetRange("Prod. Order No.", RollAlloc."Prod. Order No.");
        //ProdOrderL.SETRANGE("Line No.",ProdOrderComp."Prod. Order Line No.");
        //<< 01/31/18
        if ProdOrderL.FindFirst() then
            l_ItemJnl."Source No." := ProdOrderL."Item No.";

        //<< UE-489  1/18/18

        l_ItemJnl."NV8 Pieces" := RollAlloc.Pieces;
        l_ItemJnl."NV8 Unit Width Inches" := RollAlloc."Unit Width Inches";
        l_ItemJnl."NV8 Unit Length meters" := RollAlloc."Unit Length meters";
        l_ItemJnl."NV8 Unit Length Inches" := RollAlloc."Unit Length Inches";
        l_ItemJnl."NV8 Unit Area m2" := RollAlloc."Unit Area m2";
        l_ItemJnl."NV8 Total Length meters" := RollAlloc."Total Length meters";
        l_ItemJnl."NV8 Total Area m2" := RollAlloc."Total Area m2";
        l_ItemJnl."NV8 Configurator No." := RollAlloc."Configurator No.";
        l_ItemJnl."NV8 Shape" := RollAlloc.Shape;
        l_ItemJnl."NV8 Material" := RollAlloc.Material;
        l_ItemJnl."NV8 Grit" := RollAlloc.Grit;
        l_ItemJnl."NV8 Lot Group Code" := l_LotNoInfo."NV8 Lot Group Code";


        l_ReservationEntry.LockTable();

        //>> UE-489

        /*--- eliminate this
       //Make Item Tracking 2
       CLEAR(l_ReservationEntry);
       IF l_ReservationEntry.FINDLAST THEN
        Eno := l_ReservationEntry."Entry No."
       ELSE
        Eno := 0;

       CLEAR(l_ReservationEntry);
       l_ReservationEntry."Entry No." := Eno + 1;
       l_ReservationEntry."Item No." := RollAlloc."Item No.";
       l_ReservationEntry."Location Code" := RollAlloc."Location Code";
       l_ReservationEntry."Variant Code" := RollAlloc."Variant Code";
       l_ReservationEntry."Creation Date" := WORKDATE;
       //
       l_ReservationEntry."Reservation Status" := l_ReservationEntry."Reservation Status"::Surplus;
       l_ReservationEntry."Source Type" := 5407;
       l_ReservationEntry."Source Subtype" := 3;

       //
       l_ReservationEntry."Source Batch Name" :=  l_ItemJnl."Journal Batch Name";
       l_ReservationEntry."Source ID" :=  RollAlloc."Prod. Order No.";
       l_ReservationEntry."Source Prod. Order Line" := 10000;

       //UE-601
       //l_ReservationEntry."Source Ref. No." := 10000;
       l_ReservationEntry."Source Ref. No." := l_ItemJnl."Prod. Order Comp. Line No.";
       //END


       l_ReservationEntry."Created By" := USERID;

       l_ReservationEntry."Qty. per Unit of Measure" := l_ItemJnl."Qty. per Unit of Measure";
       l_ReservationEntry."Lot No." := RollAlloc."Roll ID";
       l_ReservationEntry.Quantity := -l_ItemJnl.Quantity;
       l_ReservationEntry."Quantity (Base)" := -l_ItemJnl.Quantity;
       l_ReservationEntry."Qty. to Handle (Base)" := -l_ItemJnl."Quantity (Base)";
       l_ReservationEntry."Qty. to Invoice (Base)" := -l_ItemJnl."Quantity (Base)";
       l_ReservationEntry."Lot No." := l_LotNoInfo."Lot No.";
       l_ReservationEntry."Item Tracking" := l_ReservationEntry."Item Tracking"::"Lot No.";


       l_ReservationEntry.INSERT;

       ------*/
        //<< UE-489

        //Make Item Tracking
        Clear(l_ReservationEntry);
        if l_ReservationEntry.FindLast() then
            Eno := l_ReservationEntry."Entry No."
        else
            Eno := 0;


        Clear(l_ReservationEntry);
        l_ReservationEntry."Entry No." := Eno + 1;
        l_ReservationEntry."Item No." := RollAlloc."Item No.";
        l_ReservationEntry."Location Code" := RollAlloc."Location Code";
        l_ReservationEntry."Variant Code" := RollAlloc."Variant Code";
        l_ReservationEntry."Creation Date" := WorkDate();

        //
        l_ReservationEntry."Reservation Status" := l_ReservationEntry."reservation status"::Prospect;
        l_ReservationEntry."Source Type" := 83;
        l_ReservationEntry."Source Subtype" := 5;

        //
        l_ReservationEntry."Source Batch Name" := l_ItemJnl."Journal Batch Name";
        l_ReservationEntry."Source ID" := l_ItemJnl."Journal Template Name";
        l_ReservationEntry."Source Ref. No." := l_ItemJnl."Line No.";

        l_ReservationEntry."Created By" := UserId;
        l_ReservationEntry."Qty. per Unit of Measure" := l_ItemJnl."Qty. per Unit of Measure";
        l_ReservationEntry."Lot No." := RollAlloc."Roll ID";
        l_ReservationEntry.Quantity := -l_ItemJnl.Quantity;
        l_ReservationEntry."Quantity (Base)" := -l_ItemJnl.Quantity;
        l_ReservationEntry."Qty. to Handle (Base)" := -l_ItemJnl."Quantity (Base)";
        l_ReservationEntry."Qty. to Invoice (Base)" := -l_ItemJnl."Quantity (Base)";
        l_ReservationEntry."Lot No." := l_LotNoInfo."Lot No.";
        l_ReservationEntry."Item Tracking" := l_ReservationEntry."item tracking"::"Lot No.";


        l_ReservationEntry.Insert();



        //Post
        //l_ItemJnl.INSERT;

        Clear(ItemJnlPostLineCU);
        // ItemJnlPostLineCU.BypassPickCheck;//TODO PAP Uncomment
        ItemJnlPostLineCU.Run(l_ItemJnl);



        if not RollAlloc."Do Not Print" then begin
            l_LotNoInfo.SetRange("Lot No.", l_LotNoInfo."Lot No.");
            //TODO PAP Uncomment
            // Clear(RollLabelAlloc);
            // RollLabelAlloc.SetNoOfLabels(1);
            // RollLabelAlloc.SetTableview(l_LotNoInfo);
            // RollLabelAlloc.UseRequestPage(false);

            // RollLabelAlloc.Run;

        end;


        //CODEUNIT.RUN(CODEUNIT::"Item Jnl.-Post Line",l_ItemJnl);
        //TESTING

    end;

    local procedure CreateReclass(var RollAlloc: Record "NV8 Roll Allocator Line")
    var
        l_WhseItemJnl: Record "Warehouse Journal Line";
        l_WhseItemTrack: Record "Whse. Item Tracking Line";
        l_WhseSetup: Record "Warehouse Setup";
        l_Item: Record Item;
        l_InvSetup: Record "Inventory Setup";
        l_LotNoInfo: Record "Lot No. Information";
        Eno: Integer;
        l_lineno: Integer;
        // RollLabelAlloc: Report UnknownReport50026; //TODO PAP uncomment
        l_WhseRegister: Codeunit "Whse. Jnl.-Register Line";
        l_ItemJnlLine: Record "Item Journal Line";
        ItemJnlPostLineCU: Codeunit "Item Jnl.-Post Line";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        ReservEntry: Record "Reservation Entry";
        l_Location: Record Location;
        OldLotNo: Code[20];
    begin




        NewLotNo := '';
        //Make the remnant into fresh Lot no.

        l_WhseSetup.FindFirst();
        l_WhseSetup.TestField(l_WhseSetup."NV8 Auto Reclass Template");
        l_WhseSetup.TestField(l_WhseSetup."NV8 Auto Reclass Batch");

        l_InvSetup.FindFirst();
        l_Item.Get(RollAlloc."Item No.");


        Clear(l_WhseItemJnl);
        l_WhseItemJnl.SetRange(l_WhseItemJnl."Journal Template Name", l_WhseSetup."NV8 Auto Reclass Template");
        l_WhseItemJnl.SetRange(l_WhseItemJnl."Journal Batch Name", l_WhseSetup."NV8 Auto Reclass Batch");
        if l_WhseItemJnl.FindLast() then
            l_lineno := l_WhseItemJnl."Line No." + 10000
        else
            l_lineno := 10000;



        //Make Reclass Jnl
        Clear(l_WhseItemJnl);
        l_WhseItemJnl.Validate(l_WhseItemJnl."Journal Template Name", l_WhseSetup."NV8 Auto Reclass Template");
        l_WhseItemJnl.Validate(l_WhseItemJnl."Journal Batch Name", l_WhseSetup."NV8 Auto Reclass Batch");
        //Testing
        //l_WhseItemJnl."Line No." := l_lineno;
        l_WhseItemJnl."Registering Date" := WorkDate();
        l_WhseItemJnl."Location Code" := RollAlloc."Location Code";
        l_WhseItemJnl.Validate(l_WhseItemJnl."Item No.", RollAlloc."Item No.");
        l_WhseItemJnl."Whse. Document No." := RollAlloc."Document No.";
        l_WhseItemJnl."From Zone Code" := l_WhseSetup."NV8 Floor Zone";
        l_WhseItemJnl."From Bin Code" := FindLotBin(RollAlloc."Location Code", RollAlloc."Item No.", RollAlloc."Roll ID", '');
        l_WhseItemJnl."To Zone Code" := l_WhseSetup."NV8 Floor Zone";
        //>> UE-499
        l_Location.Get(RollAlloc."Location Code");
        //l_WhseItemJnl."To Bin Code" := l_WhseItemJnl."From Bin Code";
        if l_Location."NV8 Remnant Bin Code" <> '' then
            l_WhseItemJnl."To Bin Code" := l_Location."NV8 Remnant Bin Code";
        //<< UE-499

        l_WhseItemJnl.Description := 'Remnant Reclass for: ' + RollAlloc."Prod. Order No.";
        l_WhseItemJnl.Validate(l_WhseItemJnl.Quantity, RollAlloc."Allocated Quantity");

        l_WhseItemJnl."Whse. Document Type" := l_WhseItemJnl."whse. document type"::"Whse. Journal";


        l_WhseItemJnl."NV8 Pieces" := RollAlloc.Pieces;
        l_WhseItemJnl."NV8 Unit Width Inches" := RollAlloc."Unit Width Inches";
        l_WhseItemJnl."NV8 Unit Length meters" := RollAlloc."Unit Length meters";
        l_WhseItemJnl."NV8 Unit Length Inches" := RollAlloc."Unit Length Inches";
        l_WhseItemJnl."NV8 Unit Area m2" := RollAlloc."Unit Area m2";
        l_WhseItemJnl."NV8 Total Length meters" := RollAlloc."Total Length meters";
        l_WhseItemJnl."NV8 Total Area m2" := RollAlloc."Total Area m2";
        l_WhseItemJnl."NV8 Configurator No." := RollAlloc."Configurator No.";
        l_WhseItemJnl."NV8 Shape" := RollAlloc."Shape";
        l_WhseItemJnl."NV8 Material" := RollAlloc."Material";
        l_WhseItemJnl."NV8 Grit" := RollAlloc.Grit;
        l_WhseItemJnl."NV8 Lot Group Code" := l_LotNoInfo."NV8 Lot Group Code";
        l_WhseItemJnl."Entry Type" := l_WhseItemJnl."entry type"::Movement;
        l_WhseItemJnl."User ID" := UserId;
        l_WhseItemJnl."Lot No." := RollAlloc."Roll ID";


        l_WhseItemJnl."NV8 Pieces" := RollAlloc.Pieces;
        l_WhseItemJnl."NV8 Unit Width Inches" := RollAlloc."Unit Width Inches";
        l_WhseItemJnl."NV8 Unit Length meters" := RollAlloc."Unit Length meters";
        l_WhseItemJnl."NV8 Unit Length Inches" := RollAlloc."Unit Length Inches";
        l_WhseItemJnl."NV8 Unit Area m2" := RollAlloc."Unit Area m2";
        l_WhseItemJnl."NV8 Total Length meters" := RollAlloc."Total Length meters";
        l_WhseItemJnl."NV8 Configurator No." := RollAlloc."Configurator No.";
        l_WhseItemJnl."NV8 Shape" := RollAlloc.Shape;
        l_WhseItemJnl."NV8 Material" := RollAlloc.Material;
        l_WhseItemJnl."NV8 Grit" := RollAlloc.Grit;





        //Make Item Tracking
        Clear(l_WhseItemTrack);
        if l_WhseItemTrack.FindLast() then
            Eno := l_WhseItemTrack."Entry No."
        else
            Eno := 0;
        Clear(l_WhseItemTrack);
        l_WhseItemTrack."Entry No." := Eno + 1;


        l_WhseItemTrack."Source Type" := 7311;
        l_WhseItemTrack."Item No." := RollAlloc."Item No.";
        l_WhseItemTrack."Location Code" := RollAlloc."Location Code";
        l_WhseItemTrack."Variant Code" := RollAlloc."Variant Code";
        l_WhseItemTrack."Source Batch Name" := l_WhseItemJnl."Journal Template Name";
        l_WhseItemTrack."Source ID" := l_WhseItemJnl."Journal Batch Name";
        l_WhseItemTrack."Source Ref. No." := l_WhseItemJnl."Line No.";
        l_WhseItemTrack."Qty. per Unit of Measure" := l_WhseItemJnl."Qty. per Unit of Measure";
        l_WhseItemTrack."Lot No." := RollAlloc."Roll ID";
        l_WhseItemTrack."Quantity (Base)" := l_WhseItemJnl."Qty. (Base)";
        l_WhseItemTrack.Validate("Qty. to Handle (Base)", l_WhseItemJnl."Qty. (Base)");




        //Create New Lot no. and Lot no. Information Card



        l_LotNoInfo.SetRange(l_LotNoInfo."Item No.", RollAlloc."Item No.");
        l_LotNoInfo.SetRange(l_LotNoInfo."Variant Code", RollAlloc."Variant Code");
        l_LotNoInfo.SetRange(l_LotNoInfo."Lot No.", RollAlloc."Roll ID");
        l_LotNoInfo.FindFirst();
        l_LotNoInfo."NV8 PIN" := RollAlloc.PIN;
        l_LotNoInfo.Modify();

        //UE-606
        if l_LotNoInfo."NV8 Original Lot No." <> '' then
            OldLotNo := l_LotNoInfo."NV8 Original Lot No."
        else
            OldLotNo := l_LotNoInfo."Lot No.";
        //
        l_LotNoInfo."Lot No." := NoSeriesMgt.GetNextNo(l_InvSetup."NV8 Auto Lot No. Series", WorkDate(), true);
        NewLotNo := l_LotNoInfo."Lot No.";
        //l_LotNoInfo."Lot Group Code" := NoSeriesMgt.GetNextNo(l_InvSetup."Lot Group No. Series",WORKDATE,TRUE);
        l_WhseItemTrack."New Lot No." := l_LotNoInfo."Lot No.";
        l_WhseItemJnl."New Lot No." := l_LotNoInfo."Lot No.";



        /*RollAlloc."Original Lot. No" := RollAlloc."Roll ID";
        RollAlloc."Roll ID" := l_WhseItemTrack."New Lot No.";
        RollAlloc.MODIFY;
         */
        l_InvSetup."NV8 Allocation Entry No." += 1;
        l_InvSetup.Modify();




        //Insert lot info with new lot number;
        l_LotNoInfo."NV8 Unit Length meters" := RollAlloc."Unit Length meters";
        l_LotNoInfo."NV8 Unit Width Inches" := RollAlloc."Unit Width Inches";
        l_LotNoInfo."NV8 Unit Length Inches" := RollAlloc."Unit Length Inches";
        l_LotNoInfo."NV8 Unit Area m2" := RollAlloc."Unit Area m2";
        l_LotNoInfo."NV8 Total Length meters" := RollAlloc."Total Length meters";
        l_LotNoInfo."NV8 Total Area m2" := RollAlloc."Total Area m2";
        l_LotNoInfo."NV8 Unit Width Code" := RollAlloc."Unit Width Code";
        l_LotNoInfo."NV8 Unit Width Text" := RollAlloc."Unit Width Text";
        //UE222
        //l_LotNoInfo."Label Printed" := FALSE;
        l_LotNoInfo."NV8 Label Printed" := true;
        //
        l_LotNoInfo."NV8 Locked" := l_LotNoInfo."NV8 Locked"::None;
        l_LotNoInfo."NV8 Locked By" := '';
        l_LotNoInfo."NV8 Pick No." := '';
        l_LotNoInfo."NV8 Allocator Comment" := '';
        l_LotNoInfo."NV8 Pieces" := RollAlloc.Pieces;
        l_LotNoInfo."NV8 FIFO Code" := RollAlloc."FIFO Code";
        l_LotNoInfo."NV8 FIFO Date" := RollAlloc."FIFO Date";
        l_LotNoInfo."NV8 PIN" := RollAlloc.PIN;
        l_LotNoInfo."NV8 Lot Group Code" := NoSeriesMgt.GetNextNo(l_InvSetup."NV8 Lot Group No. Series", WorkDate(), true);
        //UE-606
        if l_LotNoInfo."NV8 Original Lot No." = '' then
            l_LotNoInfo."NV8 Original Lot No." := OldLotNo;



        l_LotNoInfo."NV8 Jumbo Pull" := false;

        //LOT1.02
        // l_LotNoInfo.CalcJumbo(l_LotNoInfo);//TODO PAP Uncomment
        //END

        l_LotNoInfo."NV8 Allocation Entry No." := l_InvSetup."NV8 Allocation Entry No.";
        l_LotNoInfo.Insert();




        l_WhseItemTrack.Insert();


        //Post it

        //CLEAR THE BLANK LINE
        l_WhseItemJnl.SetRange(l_WhseItemJnl."Journal Template Name", l_WhseSetup."NV8 Auto Reclass Template");
        l_WhseItemJnl.SetRange(l_WhseItemJnl."Journal Batch Name", l_WhseSetup."NV8 Auto Reclass Batch");
        l_WhseItemJnl.SetFilter(l_WhseItemJnl."Item No.", '=''''');
        l_WhseItemJnl.DeleteAll();

        //Testing
        //l_WhseItemJnl.INSERT;
        l_WhseRegister.Run(l_WhseItemJnl);
        //CODEUNIT.RUN(CODEUNIT::"Whse. Jnl.-Register",l_WhseItemJnl);


        //Post the Item Side

        l_ItemJnlLine.Init();
        l_ItemJnlLine."Line No." := 0;
        l_ItemJnlLine.Validate("Entry Type", l_ItemJnlLine."entry type"::Transfer);
        l_ItemJnlLine."Document No." := l_WhseItemJnl."Whse. Document No.";
        l_ItemJnlLine.Validate("Posting Date", l_WhseItemJnl."Registering Date");
        l_ItemJnlLine.Validate("Item No.", l_WhseItemJnl."Item No.");
        l_ItemJnlLine.Validate("Variant Code", l_WhseItemJnl."Variant Code");
        l_ItemJnlLine.Validate("Location Code", l_WhseItemJnl."Location Code");
        l_ItemJnlLine.Validate("Unit of Measure Code", l_WhseItemJnl."Unit of Measure Code");
        l_ItemJnlLine.Validate(Quantity, l_WhseItemJnl.Quantity);
        l_ItemJnlLine.Description := Description;
        l_ItemJnlLine."Source Type" := l_ItemJnlLine."source type"::Item;
        l_ItemJnlLine."Source No." := l_WhseItemJnl."Item No.";
        l_ItemJnlLine."Source Code" := l_WhseItemJnl."Source Code";
        l_ItemJnlLine."Reason Code" := l_WhseItemJnl."Reason Code";
        //l_ItemJnlLine."Line No." := l_WhseItemJnl."Line No.";

        // TODO PAP
        // CreateReservEntry.CreateReservEntryFor(
        //   Database::"Item Journal Line",
        //   l_ItemJnlLine."Entry Type",
        //   '',
        //   '',
        //   0,
        //   l_WhseItemJnl."Line No.",
        //   l_WhseItemTrack."Qty. per Unit of Measure",
        //   Abs(l_WhseItemTrack."Qty. to Handle"),
        //   Abs(l_WhseItemTrack."Qty. to Handle (Base)"),
        //   l_WhseItemTrack."Serial No.",
        //   l_WhseItemTrack."Lot No.");
        // CreateReservEntry.SetNewSerialLotNo(l_WhseItemTrack."New Serial No.", l_WhseItemTrack."New Lot No.");//TODO PAP Uncomment
        CreateReservEntry.SetDates(l_WhseItemTrack."Warranty Date", l_WhseItemTrack."Expiration Date");
        CreateReservEntry.SetNewExpirationDate(l_WhseItemTrack."New Expiration Date");
        CreateReservEntry.CreateEntry(
          l_WhseItemJnl."Item No.",
          l_WhseItemJnl."Variant Code",
          l_WhseItemJnl."Location Code",
          l_WhseItemJnl.Description,
          0D,
          0D,
          0,
          ReservEntry."reservation status"::Prospect);



        Clear(ItemJnlPostLineCU);
        //ItemJnlPostLineCU.BypassPickCheck;
        ItemJnlPostLineCU.Run(l_ItemJnlLine);



        /*  Removed for testing no local printer to use    */
        // Print label with new lot/rollID

        l_LotNoInfo.SetRange("Lot No.", l_LotNoInfo."Lot No.");
        // TODO PAP UNcomment
        // Clear(RollLabelAlloc);
        // RollLabelAlloc.SetNoOfLabels(1);
        // RollLabelAlloc.SetTableview(l_LotNoInfo);
        // RollLabelAlloc.UseRequestPage(false);

        // RollLabelAlloc.Run;

        //TESTING

    end;

    local procedure CreateNegAdjust(RollAlloc: Record "NV8 Roll Allocator Line")
    var
        l_WhseItemJnl: Record "Warehouse Journal Line";
        l_WhseItemTrack: Record "Whse. Item Tracking Line";
        l_WhseSetup: Record "Warehouse Setup";
        l_Item: Record Item;
        l_InvSetup: Record "Inventory Setup";
        l_LotNoInfo: Record "Lot No. Information";
        Eno: Integer;
        l_lineno: Integer;
        l_Location: Record Location;
        l_Bin: Record Bin;
        l_WhseRegister: Codeunit "Whse. Jnl.-Register Line";
        l_WhseJrnlBatch: Record "Warehouse Journal Batch";
    begin
        //CLEAR THE BLANK LINE
        l_WhseItemJnl.SetRange(l_WhseItemJnl."Journal Template Name", l_WhseSetup."NV8 Waste Adj. Template Name");
        l_WhseItemJnl.SetRange(l_WhseItemJnl."Journal Batch Name", l_WhseSetup."NV8 Waste Adj. Template Name");
        l_WhseItemJnl.SetFilter(l_WhseItemJnl."Item No.", '=''''');
        l_WhseItemJnl.DeleteAll();



        l_WhseSetup.FindFirst();
        l_WhseSetup.TestField(l_WhseSetup."NV8 Waste Adj. Template Name");
        l_WhseSetup.TestField(l_WhseSetup."NV8 Waste Adj. Batch Name");

        l_InvSetup.FindFirst();
        l_Item.Get(RollAlloc."Item No.");
        l_Location.Get(RollAlloc."Location Code");


        l_LotNoInfo.SetRange(l_LotNoInfo."Item No.", RollAlloc."Item No.");
        l_LotNoInfo.SetRange(l_LotNoInfo."Variant Code", RollAlloc."Variant Code");
        l_LotNoInfo.SetRange(l_LotNoInfo."Lot No.", RollAlloc."Roll ID");
        l_LotNoInfo.FindFirst();

        if l_LotNoInfo."NV8 PIN" = '' then begin
            l_LotNoInfo."NV8 PIN" := RollAlloc.PIN;
            l_LotNoInfo.Modify();
        end;

        Clear(l_WhseItemJnl);
        l_WhseItemJnl.SetRange(l_WhseItemJnl."Journal Template Name", l_WhseSetup."NV8 Waste Adj. Template Name");
        l_WhseItemJnl.SetRange(l_WhseItemJnl."Journal Batch Name", l_WhseSetup."NV8 Waste Adj. Template Name");
        if l_WhseItemJnl.FindLast() then
            l_lineno := l_WhseItemJnl."Line No." + 10000
        else
            l_lineno := 10000;




        Clear(l_WhseItemJnl);
        l_WhseItemJnl.Validate(l_WhseItemJnl."Journal Template Name", l_WhseSetup."NV8 Waste Adj. Template Name");
        l_WhseItemJnl.Validate(l_WhseItemJnl."Journal Batch Name", l_WhseSetup."NV8 Waste Adj. Batch Name");
        //TESTING
        //l_WhseItemJnl."Line No." := l_lineno ;
        l_WhseItemJnl."Whse. Document Type" := l_WhseItemJnl."whse. document type"::"Whse. Journal";
        l_WhseItemJnl.Validate(l_WhseItemJnl."Whse. Document No.", RollAlloc."Prod. Order No.");
        l_WhseItemJnl."Location Code" := RollAlloc."Location Code";
        l_WhseItemJnl.Validate(l_WhseItemJnl."Item No.", RollAlloc."Item No.");
        l_WhseItemJnl."Registering Date" := WorkDate();
        l_WhseItemJnl.Validate(l_WhseItemJnl.Quantity, RollAlloc."Allocated Quantity");
        //l_WhseItemJnl."Whse. Document Line No." := 10000;
        l_WhseItemJnl."Entry Type" := l_WhseItemJnl."entry type"::"Negative Adjmt.";
        l_WhseItemJnl.Description := 'Waste Adjustment for: ' + RollAlloc."Prod. Order No.";
        l_WhseItemJnl."User ID" := UserId;

        l_WhseItemJnl."From Zone Code" := l_WhseSetup."NV8 Floor Zone";
        l_WhseItemJnl."From Bin Code" := FindLotBin(RollAlloc."Location Code", RollAlloc."Item No.", RollAlloc."Roll ID", '');
        l_WhseItemJnl."Zone Code" := l_WhseItemJnl."From Zone Code";
        l_WhseItemJnl."Bin Code" := l_WhseItemJnl."From Bin Code";

        l_WhseItemJnl."Lot No." := RollAlloc."Roll ID";

        l_WhseItemJnl."NV8 Pieces" := RollAlloc.Pieces;
        l_WhseItemJnl."NV8 Unit Width Inches" := RollAlloc."Unit Width Inches";
        l_WhseItemJnl."NV8 Unit Length meters" := RollAlloc."Unit Length meters";
        l_WhseItemJnl."NV8 Unit Length Inches" := RollAlloc."Unit Length Inches";
        l_WhseItemJnl."NV8 Unit Area m2" := RollAlloc."Unit Area m2";
        l_WhseItemJnl."NV8 Total Length meters" := RollAlloc."Total Length meters";
        l_WhseItemJnl."NV8 Configurator No." := RollAlloc."Configurator No.";
        l_WhseItemJnl."NV8 Shape" := RollAlloc.Shape;
        l_WhseItemJnl."NV8 Material" := RollAlloc.Material;
        l_WhseItemJnl."NV8 Grit" := RollAlloc.Grit;


        l_Bin.SetRange(l_Bin."Location Code", l_Location.Code);
        l_Bin.SetRange(l_Bin.Code, l_Location."Adjustment Bin Code");
        l_Bin.FindFirst();

        l_WhseItemJnl."To Zone Code" := l_Bin."Zone Code";
        l_WhseItemJnl."To Bin Code" := l_Location."Adjustment Bin Code";


        l_WhseItemJnl."NV8 Pieces" := RollAlloc.Pieces;
        l_WhseItemJnl."NV8 Unit Width Inches" := RollAlloc."Unit Width Inches";
        l_WhseItemJnl."NV8 Unit Length meters" := RollAlloc."Unit Length meters";
        l_WhseItemJnl."NV8 Unit Length Inches" := RollAlloc."Unit Length Inches";
        l_WhseItemJnl."NV8 Unit Area m2" := RollAlloc."Unit Area m2";
        l_WhseItemJnl."NV8 Total Length meters" := RollAlloc."Total Length meters";
        l_WhseItemJnl."NV8 Total Area m2" := RollAlloc."Total Area m2";
        l_WhseItemJnl."NV8 Configurator No." := RollAlloc."Configurator No.";
        l_WhseItemJnl."NV8 Shape" := RollAlloc.Shape;
        l_WhseItemJnl."NV8 Material" := RollAlloc.Material;
        l_WhseItemJnl."NV8 Grit" := RollAlloc.Grit;
        l_WhseItemJnl."NV8 Lot Group Code" := l_LotNoInfo."NV8 Lot Group Code";
        //>> UE-270
        l_WhseJrnlBatch.Get(l_WhseItemJnl."Journal Template Name", l_WhseItemJnl."Journal Batch Name", l_WhseItemJnl."Location Code");
        l_WhseItemJnl."Reason Code" := l_WhseJrnlBatch."Reason Code";
        //<< UE-270


        //Make Item Tracking
        Clear(l_WhseItemTrack);
        if l_WhseItemTrack.FindLast() then
            Eno := l_WhseItemTrack."Entry No."
        else
            Eno := 0;
        Clear(l_WhseItemTrack);
        l_WhseItemTrack."Entry No." := Eno + 1;


        l_WhseItemTrack."Source Type" := 7311;
        l_WhseItemTrack."Item No." := RollAlloc."Item No.";
        l_WhseItemTrack."Location Code" := RollAlloc."Location Code";
        l_WhseItemTrack."Variant Code" := RollAlloc."Variant Code";
        l_WhseItemTrack."Source Batch Name" := l_WhseItemJnl."Journal Template Name";
        l_WhseItemTrack."Source ID" := l_WhseItemJnl."Journal Batch Name";
        l_WhseItemTrack."Source Ref. No." := l_WhseItemJnl."Line No.";
        l_WhseItemTrack."Qty. per Unit of Measure" := l_WhseItemJnl."Qty. per Unit of Measure";
        l_WhseItemTrack."Lot No." := RollAlloc."Roll ID";
        l_WhseItemTrack."Quantity (Base)" := l_WhseItemJnl."Qty. (Base)";
        l_WhseItemTrack."Qty. to Handle (Base)" := l_WhseItemJnl."Qty. (Base)";
        l_WhseItemTrack.Insert();

        //TESTing
        //Testing
        //l_WhseItemJnl.INSERT;
        //CODEUNIT.RUN(CODEUNIT::"Whse. Jnl.-Register",l_WhseItemJnl);
        l_WhseRegister.Run(l_WhseItemJnl);
    end;


    procedure FindLotBin(FLoc: Code[20]; FItem: Code[20]; FLot: Code[20]; FZone: Code[20]): Code[10]
    var
        l_BinContents: Record "Bin Content";
    begin
        l_BinContents.SetRange(l_BinContents."Location Code", FLoc);
        l_BinContents.SetRange(l_BinContents."Item No.", FItem);
        l_BinContents.SetFilter(l_BinContents."Lot No. Filter", FLot);
        if FZone <> '' then
            l_BinContents.SetRange(l_BinContents."Zone Code", FZone);
        if l_BinContents.FindSet() then
            repeat
                l_BinContents.CalcFields(l_BinContents."Quantity (Base)");
                if l_BinContents."Quantity (Base)" > 0 then
                    exit(l_BinContents."Bin Code");
            until (l_BinContents.Next() = 0);
    end;

    local procedure PutAwayWorkSheet(RollAlloc: Record "NV8 Roll Allocator Line")
    var
        l_WhseWksht: Record "Whse. Worksheet Line";
        l_WhseWksht2: Record "Whse. Worksheet Line";
        l_WhseItemTrack: Record "Whse. Item Tracking Line";
        l_WhseSetup: Record "Warehouse Setup";
        l_Item: Record Item;
        l_InvSetup: Record "Inventory Setup";
        l_LotNoInfo: Record "Lot No. Information";
        l_Location: Record Location;
        Eno: Integer;
        l_ProdHeader: Record "Production Order";
    begin

        l_WhseSetup.FindFirst();
        l_WhseSetup.TestField(l_WhseSetup."NV8 Put-Away Template");
        l_WhseSetup.TestField(l_WhseSetup."NV8 Put-Away Worksheet Name");

        l_InvSetup.FindFirst();
        l_Item.Get(RollAlloc."Item No.");

        l_Location.Get(RollAlloc."Location Code");


        l_LotNoInfo.SetRange(l_LotNoInfo."Item No.", RollAlloc."Item No.");
        l_LotNoInfo.SetRange(l_LotNoInfo."Variant Code", RollAlloc."Variant Code");
        l_LotNoInfo.SetRange(l_LotNoInfo."Lot No.", RollAlloc."Roll ID");
        l_LotNoInfo.FindFirst();

        l_ProdHeader.Get(l_ProdHeader.Status::Released, RollAlloc."Prod. Order No.");

        l_InvSetup.FindFirst();
        l_Item.Get(l_LotNoInfo."Item No.");

        l_Location.Get(l_ProdHeader."Location Code");


        Clear(l_WhseWksht);
        l_WhseWksht."Worksheet Template Name" := l_WhseSetup."NV8 Put-Away Template";
        l_WhseWksht.Name := l_WhseSetup."NV8 Put-Away Worksheet Name";
        l_WhseWksht."Whse. Document Line No." := 10000;

        l_WhseWksht2.SetRange("Worksheet Template Name", l_WhseWksht."Worksheet Template Name");
        l_WhseWksht2.SetRange(Name, l_WhseWksht.Name);
        if l_WhseWksht2.FindLast() then
            l_WhseWksht."Line No." := l_WhseWksht2."Line No." + 10000
        else
            l_WhseWksht."Line No." := 10000;



        //l_WhseWksht."Whse. Document Type" := l_WhseWksht."Whse. Document Type"::"Internal Put-away";
        l_WhseWksht."Whse. Document Type" := l_WhseWksht."whse. document type"::Production;
        l_WhseWksht.Validate("Item No.", RollAlloc."Item No.");
        l_WhseWksht.Validate(l_WhseWksht."Whse. Document No.", RollAlloc."Prod. Order No.");
        l_WhseWksht.Validate(l_WhseWksht.Quantity, RollAlloc."Allocated Quantity");

        l_WhseWksht."Whse. Document Line No." := 10000;



        //
        l_WhseWksht."Location Code" := l_Location.Code;
        //l_WhseWksht."Unit of Measure Code" := l_Item."Base Unit of Measure";
        l_WhseWksht."Source Type" := 5407;
        l_WhseWksht."Source Subtype" := 3;
        l_WhseWksht."Source No." := l_ProdHeader."No.";
        l_WhseWksht."Source Subline No." := 10000;
        l_WhseWksht."Source Line No." := 10000;
        //



        l_WhseWksht.Description := RollAlloc.Description;
        l_WhseWksht."From Zone Code" := l_WhseSetup."NV8 Floor Zone";
        l_WhseWksht."From Bin Code" := FindLotBin(RollAlloc."Location Code", RollAlloc."Item No.", RollAlloc."Roll ID", l_WhseSetup."NV8 Floor Zone");
        l_WhseWksht."To Zone Code" := l_WhseSetup."NV8 Warehouse Zone";
        l_WhseWksht."To Bin Code" := l_Location."From-Assembly Bin Code"; //Hope thats the right one
        l_WhseWksht."NV8 Pieces" := RollAlloc.Pieces;
        l_WhseWksht."NV8 Unit Width Inches" := RollAlloc."Unit Width Inches";
        l_WhseWksht."NV8 Unit Length meters" := RollAlloc."Unit Length meters";
        l_WhseWksht."NV8 Unit Length Inches" := RollAlloc."Unit Length Inches";
        l_WhseWksht."NV8 Unit Area m2" := RollAlloc."Unit Area m2";
        l_WhseWksht."NV8 Total Length meters" := RollAlloc."Total Length meters";
        l_WhseWksht."NV8 Total Area m2" := RollAlloc."Total Area m2";
        l_WhseWksht."NV8 Configurator No." := RollAlloc."Configurator No.";
        l_WhseWksht."NV8 Shape" := RollAlloc.Shape;
        l_WhseWksht."NV8 Material" := RollAlloc.Material;
        l_WhseWksht."NV8 Grit" := RollAlloc.Grit;
        //l_WhseWksht."Lot Group Code" := l_LotNoInfo."Lot Group Code";
        l_WhseWksht."Qty. (Base)" := RollAlloc."Allocated Quantity";
        l_WhseWksht."Qty. to Handle" := RollAlloc."Allocated Quantity";
        l_WhseWksht."Qty. to Handle (Base)" := RollAlloc."Allocated Quantity";
        ;


        l_WhseWksht.Insert();

        //Make Item Tracking


        Clear(l_WhseItemTrack);
        if l_WhseItemTrack.FindLast() then
            Eno := l_WhseItemTrack."Entry No."
        else
            Eno := 0;
        Clear(l_WhseItemTrack);

        l_WhseItemTrack."Entry No." := Eno + 1;
        //l_WhseItemTrack."Source Type" := 7326;
        l_WhseItemTrack."Source Type" := 5407;
        l_WhseItemTrack."Item No." := RollAlloc."Item No.";
        l_WhseItemTrack."Location Code" := RollAlloc."Location Code";
        l_WhseItemTrack."Variant Code" := RollAlloc."Variant Code";
        l_WhseItemTrack."Source Batch Name" := ''; //l_WhseWksht."Worksheet Template Name";
        //l_WhseItemTrack."Source ID" := l_WhseWksht.Name;
        l_WhseItemTrack."Source ID" := l_ProdHeader."No.";
        l_WhseItemTrack."Source Subtype" := 3;
        l_WhseItemTrack."Source Ref. No." := 10000;  //Component line
        l_WhseItemTrack."Source Prod. Order Line" := 10000;

        l_WhseItemTrack."Qty. per Unit of Measure" := l_WhseWksht."Qty. per Unit of Measure";
        //l_WhseItemTrack."Lot No." := RollAlloc."Roll ID";


        l_WhseItemTrack."Lot No." := NewLotNo;
        l_WhseItemTrack."Qty. to Invoice (Base)" := l_WhseWksht."Qty. (Base)";
        l_WhseItemTrack."Qty. to Handle (Base)" := l_WhseWksht."Qty. (Base)";
        l_WhseItemTrack."Quantity (Base)" := l_WhseWksht."Qty. (Base)";
        l_WhseItemTrack."Qty. to Handle" := l_WhseWksht."Qty. (Base)";


        l_WhseItemTrack.Insert();
    end;

    local procedure CreateInternalPutAway(RollAlloc: Record "NV8 Roll Allocator Line")
    var
        l_Item: Record Item;
        l_LotNoInfo: Record "Lot No. Information";
        l_Location: Record Location;
        l_IntPickHead: Record "Whse. Internal Put-away Header";
        l_IntPickLine: Record "Whse. Internal Put-away Line";
        l_WhseItemTrack: Record "Whse. Item Tracking Line";
        l_WhseSetup: Record "Warehouse Setup";
        // l_CreatePick: Report UnknownReport50043;//TODO PAP Uncomment
        Eno: Integer;
    begin

        l_WhseSetup.FindFirst();

        l_Item.Get(RollAlloc."Item No.");

        l_LotNoInfo.SetRange(l_LotNoInfo."Item No.", RollAlloc."Item No.");
        l_LotNoInfo.SetRange(l_LotNoInfo."Variant Code", RollAlloc."Variant Code");
        l_LotNoInfo.SetRange(l_LotNoInfo."Lot No.", NewLotNo);
        l_LotNoInfo.FindFirst();

        //Create Header

        Clear(l_IntPickHead);
        l_IntPickHead."No." := NoSeriesMgt.GetNextNo(l_WhseSetup."Whse. Internal Put-away Nos.", WorkDate(), true);
        l_IntPickHead."Location Code" := RollAlloc."Location Code";
        ;
        l_IntPickHead."No. Series" := l_WhseSetup."Whse. Internal Put-away Nos.";
        l_IntPickHead.Status := l_IntPickHead.Status::Released;
        l_IntPickHead.Insert();



        //Create Lines
        Clear(l_IntPickLine);
        l_IntPickLine."No." := l_IntPickHead."No.";
        l_IntPickLine."Line No." := 10000;
        l_IntPickLine."Location Code" := l_IntPickHead."Location Code";
        l_IntPickLine."Item No." := RollAlloc."Item No.";
        //l_IntPickLine.VALIDATE(l_IntPickLine."Item No.",RollAlloc."Item No.");
        //l_IntPickLine.VALIDATE(l_IntPickLine.Quantity,RollAlloc."NV8 Allocated Quantity");
        l_IntPickLine.Quantity := RollAlloc."Allocated Quantity";
        l_IntPickLine."From Zone Code" := l_WhseSetup."NV8 Floor Zone";
        l_IntPickLine."From Bin Code" := FindLotBin(RollAlloc."Location Code", RollAlloc."Item No.", l_LotNoInfo."Lot No.", l_WhseSetup."NV8 Floor Zone");
        l_IntPickLine.Description := 'Internal Put away for Lot: ' + l_LotNoInfo."Lot No.";


        /*Maybe, maybe not */
        l_IntPickLine."Qty. (Base)" := RollAlloc."Allocated Quantity";
        l_IntPickLine."Qty. Outstanding" := RollAlloc."Allocated Quantity";
        l_IntPickLine."Qty. Outstanding (Base)" := RollAlloc."Allocated Quantity";



        l_IntPickLine."NV8 Material Type" := RollAlloc."Material Type";
        l_IntPickLine."NV8 Pieces" := RollAlloc.Pieces;
        l_IntPickLine."NV8 Unit Width Inches" := RollAlloc."Unit Width Inches";
        l_IntPickLine."NV8 Unit Length meters" := RollAlloc."Unit Length meters";
        l_IntPickLine."NV8 Unit Length Inches" := RollAlloc."Unit Length Inches";
        l_IntPickLine."NV8 Unit Area m2" := RollAlloc."Unit Area m2";
        l_IntPickLine."NV8 Total Length meters" := RollAlloc."Total Length meters";
        l_IntPickLine."NV8 Total Area m2" := RollAlloc."Total Area m2";
        l_IntPickLine."NV8 Configurator No." := RollAlloc."Configurator No.";
        l_IntPickLine."NV8 Shape" := RollAlloc.Shape;
        l_IntPickLine."NV8 Material" := RollAlloc.Material;
        l_IntPickLine."NV8 Subst. Material" := RollAlloc."Subst. Material";
        l_IntPickLine."NV8 Specification" := RollAlloc.Specification;
        l_IntPickLine."NV8 Grit" := RollAlloc.Grit;
        l_IntPickLine."NV8 Joint" := RollAlloc.Joint;
        l_IntPickLine."NV8 Slitting Put/Pick" := true;


        l_IntPickLine."Unit of Measure Code" := l_Item."Base Unit of Measure";
        l_IntPickLine."Sorting Sequence No." := 5000;
        l_IntPickLine.Insert();


        //Create Tracking
        Clear(l_WhseItemTrack);
        if l_WhseItemTrack.FindLast() then
            Eno := l_WhseItemTrack."Entry No."
        else
            Eno := 0;
        Clear(l_WhseItemTrack);



        l_WhseItemTrack."Entry No." := Eno + 1;
        l_WhseItemTrack."Item No." := l_IntPickLine."Item No.";
        l_WhseItemTrack."Location Code" := l_IntPickLine."Location Code";
        l_WhseItemTrack."Quantity (Base)" := l_IntPickLine."Qty. (Base)";
        l_WhseItemTrack."Source Type" := 7332;
        l_WhseItemTrack."Source ID" := l_IntPickLine."No.";
        l_WhseItemTrack."Source Ref. No." := l_IntPickLine."Line No.";
        l_WhseItemTrack."Qty. per Unit of Measure" := l_IntPickLine."Qty. per Unit of Measure";
        l_WhseItemTrack."Qty. to Handle (Base)" := l_IntPickLine."Qty. (Base)";
        l_WhseItemTrack."Qty. to Handle" := l_IntPickLine.Quantity;
        //l_WhseItemTrack."Buffer Status2" := l_WhseItemTrack."Buffer Status2"::"ljl";
        l_WhseItemTrack."Created by Whse. Activity Line" := false;
        l_WhseItemTrack."Lot No." := l_LotNoInfo."Lot No.";
        l_WhseItemTrack.Insert();

        ///
        //Auto Generate Pick
        // TODO PAP
        // Clear(l_CreatePick);
        // l_CreatePick.SetWhseInternalPutAway(l_IntPickHead);
        // l_CreatePick.Initialize('INTERNAL\BFUCHS', 0, false, false, false);
        // l_CreatePick.UseRequestPage(false);
        // l_CreatePick.Run;

    end;

    local procedure ReturnTotalConsumptionQty(l_RollSel: Record "NV8 Roll Allocator Line") TtlQty: Decimal
    var
        l_RollSel2: Record "NV8 Roll Allocator Line";
    begin

        TtlQty := 0;
        l_RollSel2.SetRange(l_RollSel2."Item Ledger Entry No.", l_RollSel."Item Ledger Entry No.");
        l_RollSel2.SetRange(l_RollSel2."Entry Type", l_RollSel2."entry type"::Consumption);
        if l_RollSel2.FindSet then
            repeat
                TtlQty += l_RollSel2.Quantity;

            until l_RollSel2.Next = 0;

        exit(TtlQty);
    end;

    local procedure AdjustComponentLine(RollAlloc: Record "NV8 Roll Allocator Line")
    var
        l_ProdComponent: Record "Prod. Order Component";
        l_TotalConQty: Decimal;
        l_Difference: Decimal;
    begin
        l_ProdComponent.SetRange(l_ProdComponent."Prod. Order No.", RollAlloc."Prod. Order No.");

        //UE-MISC
        //l_ProdComponent.SETRANGE(l_ProdComponent."Prod. Order Line No.",10000);
        l_ProdComponent.SetRange(l_ProdComponent."Item No.", RollAlloc."Item No.");
        //

        if l_ProdComponent.FindFirst() then begin
            l_TotalConQty := ReturnTotalConsumptionQty(RollAlloc);
            if l_ProdComponent."Expected Quantity" < l_TotalConQty then   //Adjust it up if actual consumption is greater than the component line
             begin
                l_Difference := l_TotalConQty - l_ProdComponent."Expected Quantity";
                l_ProdComponent.Quantity := l_TotalConQty;
                l_ProdComponent."Expected Quantity" := l_TotalConQty;
                l_ProdComponent."Remaining Quantity" := l_TotalConQty;
                l_ProdComponent."Remaining Qty. (Base)" := l_TotalConQty;
                l_ProdComponent."Quantity (Base)" := l_TotalConQty;
                l_ProdComponent."Expected Qty. (Base)" := l_TotalConQty;
                l_ProdComponent.Modify();
            end;

            // Make sure the pick quantities match the expected quantity
            if l_ProdComponent."Qty. Picked" < l_ProdComponent."Expected Quantity" then
                l_ProdComponent."Qty. Picked" := l_ProdComponent."Expected Quantity";

            if l_ProdComponent."Qty. Picked (Base)" < l_ProdComponent."Expected Qty. (Base)" then
                l_ProdComponent."Qty. Picked (Base)" := l_ProdComponent."Expected Qty. (Base)";
            l_ProdComponent.Modify();

        end;
    end;
}

