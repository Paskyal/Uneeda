tableextension 50017 "NV8 Item Journal Line" extends "Item Journal Line" //83
{
    // TODO PAP Uncomment all OnValidate triggers
    fields
    {
        field(50050; "NV8 Your Reference"; Text[35])
        {
            Caption = 'Customer PO No.';
            Description = 'UE-657';
            DataClassification = CustomerContent;
        }
        field(51002; "NV8 Web"; Boolean)
        {
            Description = 'UE-657';
            DataClassification = CustomerContent;
        }
        field(55000; "NV8 Partial"; Boolean)
        {
            Description = 'ECL';
            DataClassification = CustomerContent;
            // TODO PAP
            // trigger OnValidate() 
            // begin
            //     if Partial then Complete := false;
            // end;
        }
        field(55001; "NV8 Complete"; Boolean)
        {
            Description = 'ECL';
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     if Complete then Partial := false;
            // end;
        }
        field(68000; "NV8 Output Prod. Order No."; Code[20])
        {
            Caption = 'Output Prod. Order No.';
            TableRelation = "Production Order"."No." where(Status = const(Released));
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     SetUpNewLine(xRec);
            //     Validate("Entry Type", "entry type"::Output);

            //     Validate("FIFO Date", WorkDate());
            //     ProdOrder.Get(ProdOrder.Status::Released, "Output Prod. Order No.");
            //     Validate("Order No.", "Output Prod. Order No.");
            //     ProdOrderLine.Reset;
            //     ProdOrderLine.SetCurrentkey(Status, "Prod. Order No.", "Line No.");
            //     ProdOrderLine.SetRange(Status, ProdOrder.Status);
            //     ProdOrderLine.SetRange("Prod. Order No.", ProdOrder."No.");
            //     ProdOrderLine.FindLast;
            //     Validate("Routing No.", ProdOrderLine."Routing No.");
            //     Validate("Item No.", ProdOrderLine."Item No.");

            //     "Routing No." := ProdOrderLine."Routing No.";
            //     "Routing Reference No." := ProdOrderLine."Routing Reference No.";

            //     ProdOrderRtngLine.Reset;
            //     ProdOrderRtngLine.SetCurrentkey(Status, "Prod. Order No.");
            //     ProdOrderRtngLine.SetRange(Status, ProdOrder.Status);
            //     ProdOrderRtngLine.SetRange("Prod. Order No.", ProdOrder."No.");
            //     ProdOrderRtngLine.SetRange("Routing No.", ProdOrderLine."Routing No.");
            //     ProdOrderRtngLine.SetRange("Routing Reference No.", ProdOrderLine."Routing Reference No.");
            //     ProdOrderRtngLine.FindLast;
            //     Validate("Operation No.", ProdOrderRtngLine."Operation No.");
            //     Validate("Item No.", ProdOrderLine."Item No.");
            // end;
        }
        field(68050; "NV8 Remaining On Hand"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where("Item No." = field("Item No."),
                                                                              "Location Code" = field("Location Code"),
                                                                              Open = const(true)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68051; "NV8 Quantity On Journal"; Decimal)
        {
            CalcFormula = sum("Item Journal Line"."Quantity (Base)" where("Journal Template Name" = field("Journal Template Name"),
                                                                           "Journal Batch Name" = field("Journal Batch Name"),
                                                                           "Item No." = field("Item No."),
                                                                           "Location Code" = field("Location Code")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68052; "NV8 Quantity After Post"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(68053; "NV8 Quantity On Hand"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."),
                                                                  "Location Code" = field("Location Code")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68060; "NV8 FG Unit Width Inches"; Decimal)
        {
            CalcFormula = lookup("Production Order"."NV8 Unit Width Inches" where("No." = field("Order No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68061; "NV8 FG Qty"; Decimal)
        {
            CalcFormula = lookup("Production Order".Quantity where("No." = field("Order No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68062; "NV8 FG Config"; Code[100])
        {
            CalcFormula = lookup("Production Order"."NV8 Configurator No." where("No." = field("Order No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68090; "NV8 Allocated Raw Material Qty"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Allocation Entry".Quantity where("Prod. Order No." = field("Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68100; "NV8 Green To Follow"; Boolean)
        {
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     if "Green To Follow" then
            //         Finished := false;
            // end;
        }
        field(68101; "NV8 Allocation ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(68110; "NV8 Roll ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(68901; "NV8 OldRes"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(68902; "NV8 MFG Raw Material"; Code[20])
        {
            TableRelation = "Production Order"."No." where(Status = const(Released));
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // var
            //     ItemJnlLine: Record "Item Journal Line";
            //     ProdOrderComp: Record "Prod. Order Component";
            // begin
            //     if "Line No." = 0 then begin
            //         ItemJnlLine.Reset();
            //         ItemJnlLine.SetRange("Journal Template Name", "Journal Template Name");
            //         ItemJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
            //         if ItemJnlLine.FindLast() then
            //             "Line No." := ItemJnlLine."Line No." + 10000
            //         else
            //             "Line No." := 10000;
            //     end;
            //     ItemJnlLine.Copy(Rec);
            //     ProdOrder.Get(ProdOrder.Status::Released, "MFG Raw Material");
            //     Description := ProdOrder.Description;
            //     ProdOrderComp.Reset();
            //     ProdOrderComp.SetCurrentkey(Status, "Prod. Order No.");
            //     ProdOrderComp.SetRange(Status, ProdOrderLine.Status::Released);
            //     ProdOrderComp.SetRange("Prod. Order No.", "MFG Raw Material");
            //     ProdOrderComp.Find('-');
            //     repeat
            //         ItemJnlLine.Validate("Item No.", ProdOrderComp."Item No.");
            //         ItemJnlLine.Validate(Quantity, ProdOrderComp."Expected Quantity");
            //         if not ItemJnlLine.Insert() then
            //             ItemJnlLine.Modify();
            //         ItemJnlLine."Line No." += 10000;
            //     until ProdOrderComp.Next() = 0;
            //     Rec.Find(); //COPY(ItemJnlLine);
            // end;
        }
        field(68904; "NV8 From Entry Type"; Option)
        {
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
            DataClassification = CustomerContent;
        }
        field(84011; "NV8 Bin Type"; Option)
        {
            OptionMembers = PutAway,Staging,Inactive;
            DataClassification = CustomerContent;
        }
        field(85001; "NV8 FilePro No."; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(85003; "NV8 Skid No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(85008; "NV8 Bin Sorting"; Code[30])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85016; "NV8 Jumbo Prod. Order"; Code[20])
        {
            TableRelation = "Production Order"."No." where(Status = const(Released));
            DataClassification = CustomerContent;
        }
        field(85017; "NV8 Jumbo Prod. Order Line No."; Integer)
        {
            BlankZero = true;
            TableRelation = "Prod. Order Line"."Line No." where(Status = const(Released),
                                                                 "Prod. Order No." = field("NV8 Jumbo Prod. Order"));
            DataClassification = CustomerContent;
        }
        field(85018; "NV8 Jumbo Comment"; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(85019; "NV8 Jumbo Pull"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85020; "NV8 Bin Location"; Code[20])
        {
            TableRelation = "NV8 Bin Location".Code where("Location Code" = field("Location Code"));
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     InvQty := Quantity;
            //     if "Entry Type" in ["entry type"::Sale, "entry type"::"Negative Adjmt.", "entry type"::Consumption] then
            //         InvQty := -Quantity;
            //     if InvQty < 0 then
            //         FieldError("Bin Location", 'please select the Bin Location either through the "Applies To ID" or by useing reservations.');
            // end;
        }
        field(85021; "NV8 New Bin Location"; Code[20])
        {
            TableRelation = "NV8 Bin Location".Code where("Location Code" = field("New Location Code"));
            DataClassification = CustomerContent;
        }
        field(85022; "NV8 From Bin Location"; Code[20])
        {
            CalcFormula = lookup("Item Ledger Entry"."NV8 Bin Location" where("Entry No." = field("Applies-to Entry")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85023; "NV8 From FIFO Code"; Code[20])
        {
            CalcFormula = lookup("Item Ledger Entry"."NV8 FIFO Code" where("Entry No." = field("Applies-to Entry")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85024; "NV8 From Skid No."; Text[30])
        {
            CalcFormula = lookup("Item Ledger Entry"."NV8 Skid No." where("Entry No." = field("Applies-to Entry")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85025; "NV8 New Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
        }
        field(85026; "NV8 FIFO Code"; Code[7])
        {
            DataClassification = CustomerContent;
        }
        field(85027; "NV8 FIFO Date"; Date)
        {
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     "NV8 FIFO Code" := AGGetFIFOCode("FIFO Date");
            // end;
        }
        field(85028; "NV8 Bin Pieces Remaining"; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup("Item Ledger Entry"."NV8 Remaining Pieces" where("Entry No." = field("Applies-to Entry")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85029; "NV8 Bin Quantity Remaining"; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup("Item Ledger Entry"."Remaining Quantity" where("Entry No." = field("Applies-to Entry")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85030; "NV8 From FIFO Date"; Date)
        {
            CalcFormula = lookup("Item Ledger Entry"."NV8 FIFO Date" where("Entry No." = field("Applies-to Entry")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85031; "NV8 Transfer-To Locaiton Code"; Code[10])
        {
            Description = 'UE-476';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(85040; "NV8 Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
        }
        field(85050; "NV8 Pieces"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     if "Phys. Inventory" then
            //         if CurrFieldNo = FieldNo("NV8 Pieces") then
            //             TestField("Phys. Inventory", false);

            //     UpdatePieces;
            // end;
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     Temp := ROUND("Unit Width Inches", 1, '<') * 100;
            //     Temp := Temp + ROUND((("Unit Width Inches" MOD 1) * 64), 1, '<');

            //     Validate("Unit Width Code", Format(Temp, 5, '<integer>'));

            //     UpdatePieces;
            // end;
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;

            //     trigger OnValidate()
            //     begin
            //         "Unit Length Inches" := ROUND("Unit Length meters" * 39, 0.00001);
            //         UpdatePieces;
            //     end;
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            BlankZero = true;
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     "Unit Length meters" := ROUND("Unit Length Inches" / 39, 0.00001);
            //     UpdatePieces;
            // end;
        }
        field(85054; "NV8 Unit Area m2"; Decimal)
        {
            BlankZero = true;
            Description = 'Width / 36 x Length';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85055; "NV8 Unit Width Code"; Code[10])
        {
            CharAllowed = '09';
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     ConfiguratorSetup.Get;
            //     ConfiguratorSetup.SetDimLen("Unit Width Code", 5, "Unit Width Code", 0);
            //     "Unit Width Inches" := ConfiguratorSetup.GetDecimal("Unit Width Code");
            //     "Unit Width Text" := ConfiguratorSetup.GetDecimalText("Unit Width Code");
            //     if "Unit Width Inches" <> 0 then
            //         Validate("Unit Cost", "Cost Per meter" / "Unit Width Inches" * 39);
            //     UpdatePieces;
            // end;
        }
        field(85056; "NV8 Unit Width Text"; Text[30])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85058; "NV8 Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField("NV8 Pieces");
                Validate("NV8 Unit Length meters", ROUND("NV8 Total Length meters" / "NV8 Pieces", 0.00001));
            end;
        }
        field(85059; "NV8 Cost Per meter"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "NV8 Unit Width Inches" <> 0 then
                    "Unit Cost" := "NV8 Cost Per meter" / "NV8 Unit Width Inches" * 39;
                //UpdatePieces;
            end;
        }
        field(85060; "NV8 Remaining Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(85062; "NV8 Remaining Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Error on decimals';
            DataClassification = CustomerContent;
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85065; "NV8 Remaining Area m2"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'Error on decimals';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85066; "NV8 Description 2"; Text[50])
        {
            Description = 'UE-443';
            DataClassification = CustomerContent;
        }
        field(85069; "NV8 Allocator Comment"; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(85100; "NV8 Configurator No."; Code[100])
        {
            TableRelation = "NV8 Configurator Item" where(Status = filter(Item .. "Valid Item"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            // trigger OnValidate()
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
            //                 if ConfiguratorMaterialGrit.Get(ConfiguratorItem.Material, Component) then begin
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

            //     /* remove as copied from T37)
            //     IF NOT ConfiguratorFound THEN BEGIN
            //       COMMIT;
            //       IF CONFIRM(AG012,FALSE) THEN BEGIN
            //         ConfiguratorItem.INSERT(TRUE);
            //         COMMIT;

            //         IF FORM.RUNMODAL(FORM::"Configurator Item Card",ConfiguratorItem) = ACTION::LookupOK THEN BEGIN
            //           VALIDATE("Item No.",ConfiguratorItem."Item No.");
            //           ConfiguratorFound := TRUE;
            //         END;
            //       END;
            //     END;
            //     */

            //     // UpdateConfiguration;
            //     //IF NOT ConfiguratorFound THEN
            //     //  ERROR(AG013);

            // end;
        }
        field(85110; "NV8 Shape"; Code[10])
        {
            TableRelation = "NV8 Configurator Shape";
            DataClassification = CustomerContent;
        }
        field(85120; "NV8 Material"; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
            DataClassification = CustomerContent;
        }
        field(85121; "NV8 Original Material"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(85122; "NV8 Subst. Material"; Code[10])
        {
            Editable = false;
            TableRelation = "NV8 Configurator Material";
            DataClassification = CustomerContent;
        }
        field(85170; "NV8 Specification"; Code[10])
        {
            TableRelation = "NV8 Configurator Specification";
            DataClassification = CustomerContent;
        }
        field(85180; "NV8 Grit"; Code[10])
        {
            TableRelation = "NV8 Configurator Grit";
            DataClassification = CustomerContent;
        }
        field(85190; "NV8 Joint"; Code[10])
        {
            TableRelation = "NV8 Configurator Joint";
            DataClassification = CustomerContent;
        }
        field(85200; "NV8 Reserved Output"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85201; "NV8 Reservation Application"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(85202; "NV8 Reservation Applied Qty."; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup("Reservation Entry".Quantity where("Entry No." = field("NV8 Reservation Application"),
                                                                     Positive = const(true)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85250; "NV8 Apply Only To Correct Width"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85251; "NV8 Apply Only To Correct Length"; Boolean)
        {
            Description = 'Not used';
            DataClassification = CustomerContent;
        }
        field(85290; "NV8 Re-Cut"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85291; "NV8 Re-Cut No."; Code[20])
        {
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(85300; "NV8 Roll Allocation Line"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85310; "NV8 Rem. Split Roll"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85311; "NV8 Rem. Split Pieces"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details".Pieces where("Prod. Order No." = field("Order No."),
                                                                 Shipped = const(false)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            // trigger OnValidate()
            // begin
            //     UpdatePieces;
            // end;
        }
        field(85312; "NV8 Rem. Split Total Length meters"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details"."Total Length meters" where("Prod. Order No." = field("Order No."),
                                                                                Shipped = const(false)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            // trigger OnValidate()
            // begin
            //     UpdateConfiguration;
            // end;
        }
        field(85313; "NV8 Rem. Split Total Area m2"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details"."Total Area m2" where("Prod. Order No." = field("Order No."),
                                                                          Shipped = const(false)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            // trigger OnValidate()
            // begin
            //     UpdatePieces;
            // end;
        }
        field(85325; "NV8 Allocated for Type"; Option)
        {
            OptionMembers = " ","Sale Order","Transfer Order";
            DataClassification = CustomerContent;
        }
        field(85326; "NV8 Allocated for Code"; Code[20])
        {
            TableRelation = if ("NV8 Allocated for Type" = const("Sale Order")) Customer."No."
            else
            if ("NV8 Allocated for Type" = const("Transfer Order")) Location.Code;
            DataClassification = CustomerContent;
        }
        field(85328; "NV8 Allocated for Order No"; Code[20])
        {
            TableRelation = if ("NV8 Allocated for Type" = const("Sale Order")) "Sales Header"."No." where("Document Type" = const(Order))
            else
            if ("NV8 Allocated for Type" = const("Transfer Order")) "Transfer Header"."No.";
            DataClassification = CustomerContent;
        }
        field(85411; "NV8 FG Cost ($/UOM)"; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup(Item."NV8 FG Cost (/UOM)" where("No." = field("Item No.")));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85500; "NV8 Pieces (Calculated)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Validate("NV8 Pieces (Phys. Inventory)");
            end;
        }
        field(85501; "NV8 Pieces (Phys. Inventory)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "NV8 Roll ID" <> '' then
                    if Abs("NV8 Pieces (Phys. Inventory)") > 1 then
                        FieldError("NV8 Pieces (Phys. Inventory)", 'must not be greater than 1 when a Roll ID exists');

                if "NV8 Pieces (Phys. Inventory)" >= "NV8 Pieces (Calculated)" then
                    Validate("NV8 Pieces", "NV8 Pieces (Phys. Inventory)" - "NV8 Pieces (Calculated)")
                else
                    Validate("NV8 Pieces", "NV8 Pieces (Calculated)" - "NV8 Pieces (Phys. Inventory)");
            end;
        }
        field(85550; "NV8 Found Partial Box"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85551; "NV8 Phys. Posting Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(85552; "NV8 Found Item"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85553; "NV8 Recounted by Supervisor"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85554; "NV8 Team #"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(90001; "NV8 Lot Group Code"; Code[20])
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
        }
    }
    procedure "NV8 SkipCheck"()
    begin
        G_SkipCheck := true;
    end;

    var
        G_SkipCheck: Boolean;
}
