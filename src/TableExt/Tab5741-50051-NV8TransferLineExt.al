tableextension 50051 "NV8 Transfer Line" extends "Transfer Line" //5741
{
    // TODO PAP Uncomment triggers
    fields
    {
        field(50003; "NV8 Original Unit Length (Meters)"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Original Unit Length (Meters)';
        }
        field(50006; "NV8 Original Ordered Pieces"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Original Ordered Pieces';
        }
        field(50120; "NV8 Prod. Order Created"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prod. Order Created';
        }
        field(50125; "NV8 Prod. Order Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished;
            DataClassification = CustomerContent;
        }
        field(50130; "NV8 Prod. Order No."; Code[20])
        {
            Description = 'UNE-196';
            Editable = false;
            TableRelation = "Production Order"."No." where("No." = field("NV8 Prod. Order No."),
                                                            Status = filter("Firm Planned" | Released));
            DataClassification = CustomerContent;
            Caption = 'Prod. Order No.';
        }
        field(50200; "NV8 External Document No."; Code[35])
        {
            CalcFormula = lookup("Transfer Header"."External Document No." where("No." = field("Document No.")));
            Description = 'UNE-217';
            FieldClass = FlowField;
            Caption = 'External Document No.';
        }
        field(50202; "NV8 Prod Order Scheduled Date"; Date)
        {
            CalcFormula = lookup("Production Order"."NV8 Scheduled Date" where("No." = field("NV8 Prod. Order No.")));
            Description = 'UNE-217';
            FieldClass = FlowField;
            Caption = 'Prod Order Scheduled Date';
        }
        field(50203; "NV8 Created By"; Code[50])
        {
            // CalcFormula = lookup("Transfer Header"."Created By User ID" where("No." = field("Document No.")));// TODO PAP Addon field
            Description = 'UNE-217';
            FieldClass = FlowField;
            Caption = 'Created By';
        }
        field(68025; "NV8 Reserved Inventory"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 1;
            Description = 'Disabled';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Reserved Inventory';
        }
        field(68056; "NV8 Material Reviewed"; Boolean)
        {
            CalcFormula = lookup("Production Order"."NV8 Material Reviewed" where("No." = field("NV8 Prod. Order No.")));
            Description = 'UNE-195';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Production Order"."NV8 Material Reviewed" where("No." = field("NV8 Prod. Order No."));
            Caption = 'Material Reviewed';
        }
        field(68070; "NV8 Process Location"; Option)
        {
            CalcFormula = lookup("Production Order"."NV8 Process Location" where("No." = field("NV8 Production Order No.")));
            Description = ' ,Waiting For Material,Ready To Allocate,Allocation,Slitting,External Contractor,,,,,,,,,,,,Partial,Green,Finished,Closed';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Waiting For Material,Ready To Allocate,Allocation,Slitting,External Contractor,,,,,,,,,,,,Partial,Green,Finished,Closed';
            OptionMembers = " ","Waiting For Material","Ready To Allocate",Allocation,Slitting,"External Contractor",,,,,,,,,,,,Partial,Green,Finished,Closed;
            Caption = 'Process Location';
        }
        field(68081; "NV8 CNL"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CNL';
        }
        field(68082; "NV8 PSL Locked"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'PSL Locked';
        }
        field(68083; "NV8 Stagging"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Stagging';
        }
        field(68100; "NV8 Order Queue Status"; Option)
        {
            Description = ',Entering,,,,Ready To Plan,Planning,Planned,,,,Ready To Pick,Picking,Picked,,,,Ready To Ship,Shipping,Shipped,,,,Billing,,,Complete';
            OptionMembers = ,Entering,,,,"Ready To Plan",,Planned,,,,,Picking,Picked,CNL,,PSL,"Ready To Ship",Shipping,Shipped,"Back Ordered",,,Billing,,,Complete;
            DataClassification = CustomerContent;
            Caption = 'Order Queue Status';
        }
        field(68101; "NV8 Qty. on Prod. Order"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Prod. Order Line"."Remaining Qty. (Base)" where(Status = filter(Planned .. Released),
                                                                                "Item No." = field("Item No."),
                                                                                "Location Code" = field("Transfer-from Code")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Qty. on Prod. Order';
        }
        field(68110; "NV8 Sec. Territory Code"; Code[10])
        {
            CalcFormula = lookup("Transfer Header"."NV8 Sec. Territory Code" where("No." = field("Document No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Territory;
            Caption = 'Sec. Territory Code';
        }
        field(68120; "NV8 Pack Size"; Option)
        {
            OptionMembers = " ",,,"3",,"5",,,,,"10";
            DataClassification = CustomerContent;
            Caption = 'Pack Size';
        }
        field(68400; "NV8 Catalog No."; Code[20])
        {
            Caption = 'Catalog No.';
            DataClassification = CustomerContent;
            // TODO PAP Uncomment OnLookup
            // trigger OnLookup()
            // begin
            //     /*Item.RESET;
            //     Item.SETCURRENTKEY("Catalog No.");
            //     Item.SETRANGE("Catalog No.","Catalog No.");
            //     IF "Catalog No." <> '' THEN
            //       IF Item.FINDSET THEN
            //         ;
            //     Item.SETFILTER("Catalog No.",'<>%1','');  */
            //     if Page.RunModal(0, Item) = Action::LookupOK then begin
            //         Validate("Item No.", Item."No.");
            //     end;

            // end;

            trigger OnValidate()     // PAP do not uncomment - it was commented in source
            begin
                /*Item.RESET;
                Item.SETCURRENTKEY("Catalog No.");
                Item.SETRANGE("Catalog No.","Catalog No.");
                Item.FINDSET;
                VALIDATE("Item No.",Item."No.");
                 */

            end;
        }
        field(84000; "NV8 Unit Type"; Option)
        {
            OptionMembers = Each,Rolls,"Split Rolls";
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
        }
        field(84001; "NV8 Unit Qty."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Qty.';
        }
        field(84003; "NV8 Unit Qty. Allocated"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Qty. Allocated';
        }
        field(85003; "NV8 Skid No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Skid No.';
        }
        field(85011; "NV8 Fully Shipped"; Boolean)
        {
            Description = 'RSQ';
            DataClassification = CustomerContent;
            Caption = 'Fully Shipped';

            // trigger OnValidate()
            // begin
            //     //BEGIN
            //     //BEGIN
            //     if "Fully Shipped" then begin
            //         GetTransHeaderRSQ;
            //         if TransHeader.RSQ in [TransHeader.Rsq::Variable, TransHeader.Rsq::Exact, TransHeader.Rsq::"5",
            //           TransHeader.Rsq::"4", TransHeader.Rsq::"3"] then begin
            //             if TransHeader.Status <> TransHeader.Status::Open then begin
            //                 TransHeader.Status := TransHeader.Status::Open;
            //                 TransHeader.Modify();
            //             end;
            //             if "Original Ordered Quantity" = 0 then
            //                 "Original Ordered Quantity" := Quantity;
            //             Validate("Qty. to Ship");//LHR try?
            //             Validate(Quantity, "Qty. to Ship" + "Quantity Shipped");
            //             if "Unit Area m2" <> 0 then Validate(Pieces, (Quantity / "Unit Area m2"));  //Lhr *************
            //         end else
            //             "Fully Shipped" := false;
            //     end;

            //     if not "Fully Shipped" then begin
            //         GetTransHeaderRSQ;
            //         if TransHeader.RSQ in [TransHeader.Rsq::Variable, TransHeader.Rsq::Exact, TransHeader.Rsq::"5",
            //           TransHeader.Rsq::"4", TransHeader.Rsq::"3"] then begin
            //             if TransHeader.Status <> TransHeader.Status::Open then begin
            //                 TransHeader.Status := TransHeader.Status::Open;
            //                 TransHeader.Modify();
            //             end;
            //             Validate(Quantity, "Original Ordered Quantity");
            //         end;
            //     end;
            //     //END ELSE
            //     //"Fully Shipped" := FALSE;
            //     //END ELSE
            //     //"Fully Shipped" := FALSE;
            // end;
        }
        field(85012; "NV8 Original Ordered Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Original Ordered Quantity';
        }
        field(85013; "NV8 Qty. To Pick"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Qty. To Pick';
        }
        field(85014; "NV8 Pieces To Ship"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Pieces To Ship';

            // trigger OnValidate()
            // begin
            //     TestField(Pieces);
            //     Validate("Qty. to Ship", ROUND("Pieces To Ship" * Quantity / Pieces, 0.00001));
            // end;
        }
        field(85020; "NV8 From Bin Location"; Code[20])
        {
            TableRelation = "NV8 Bin Location".Code where("Location Code" = field("Transfer-from Code"));
            DataClassification = CustomerContent;
            Caption = 'From Bin Location';
        }
        field(85021; "NV8 To Bin Location"; Code[20])
        {
            TableRelation = "NV8 Bin Location".Code where("Location Code" = field("Transfer-to Code"));
            DataClassification = CustomerContent;
            Caption = 'To Bin Location';
        }
        field(85025; "NV8 Reserve"; Option)
        {
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
            DataClassification = CustomerContent;
            Caption = 'Reserve';

            // trigger OnValidate()
            // begin
            //     if (Reserve <> Reserve::Never) then begin
            //         TestField("Item No.");
            //     end;
            //     CalcFields("Reserved Qty. Outbnd. (Base)");
            //     if (Reserve = Reserve::Never) and ("Reserved Qty. Outbnd. (Base)" > 0) then
            //         TestField("Reserved Qty. Outbnd. (Base)", 0);

            //     if xRec.Reserve = Reserve::Always then begin
            //         GetItem;
            //         if Item.Reserve = Item.Reserve::Always then
            //             TestField(Reserve, Reserve::Always);
            //     end;
            // end;
        }
        field(85040; "NV8 Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
            Caption = 'Material Type';
        }
        field(85041; "NV8 Red Dot"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Red Dot';
        }
        field(85042; "NV8 Red Dot Level"; Option)
        {
            Description = 'Not used';
            OptionMembers = "1","2","3";
            DataClassification = CustomerContent;
            Caption = 'Red Dot Level';
        }
        field(85044; "NV8 Original Ship Date"; Date)
        {
            Caption = 'Original Ship Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(85046; "NV8 Created On"; Date)
        {
            CalcFormula = lookup("Transfer Header"."NV8 Created On" where("No." = field("Document No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Created On';
        }
        field(85049; "NV8 Exported On"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Exported On';
        }
        field(85050; "NV8 Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Pieces';

            // trigger OnValidate()
            // begin
            //     // RSQ mod LHR
            //     GetTransHeaderRSQ;
            //     if TransHeader.Status <> TransHeader.Status::Open then begin
            //         TransHeader.Status := TransHeader.Status::Open;
            //         TransHeader.Modify();
            //     end;
            //     UpdatePieces;
            // end;
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Unit Width Inches';

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
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
            Caption = 'Unit Length meters';

            // trigger OnValidate()
            // begin
            //     "Unit Length Inches" := ROUND("Unit Length meters" * 39, 0.00001);
            //     UpdatePieces;
            // end;
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Length Inches';

            // trigger OnValidate()
            // begin
            //     "Unit Length meters" := ROUND("Unit Length Inches" / 39, 0.00001);
            //     UpdatePieces;
            // end;
        }
        field(85054; "NV8 Unit Area m2"; Decimal)
        {
            Description = 'Width / 36 x Length';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Unit Area m2';
        }
        field(85055; "NV8 Unit Width Code"; Code[10])
        {
            CharAllowed = '09';
            DataClassification = CustomerContent;
            Caption = 'Unit Width Code';

            // trigger OnValidate()
            // begin
            //     ConfiguratorSetup.Get;
            //     ConfiguratorSetup.SetDimLen("Unit Width Code", 5, "Unit Width Code", 0);
            //     "Unit Width Inches" := ConfiguratorSetup.GetDecimal("Unit Width Code");
            //     "Unit Width Text" := ConfiguratorSetup.GetDecimalText("Unit Width Code");
            //     UpdatePieces;
            // end;
        }
        field(85056; "NV8 Unit Width Text"; Text[30])
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Unit Width Text';
        }
        field(85058; "NV8 Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Total Length meters';

            // trigger OnValidate()
            // begin
            //     TestField(Pieces);
            //     Validate("Unit Length meters", ROUND("Total Length meters" / Pieces, 0.00001));
            //     if "Original Total Length Meters" = 0 then "Original Total Length Meters" := "Total Length meters";
            //     if "Original Unit Length (Meters)" = 0 then "Original Unit Length (Meters)" := "Unit Length meters";
            //     if "Original Ordered Pieces" = 0 then "Original Ordered Pieces" := Pieces;
            // end;
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Total Area m2';
        }
        field(85080; "NV8 Qty. On Hand"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where(Open = const(true),
                                                                              Positive = const(true),
                                                                              "Item No." = field("Item No."),
                                                                              "Location Code" = field(filter("Transfer-from Code"))));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Qty. On Hand';
        }
        field(85090; "NV8 Consignment Location"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Consignment Location';
        }
        field(85091; "NV8 Consignment Customer"; Code[20])
        {
            TableRelation = Customer;
            DataClassification = CustomerContent;
            Caption = 'Consignment Customer';
        }
        field(85092; "NV8 Cross-Reference No."; Code[20])
        {
            TableRelation = "Item Reference"."Reference No." where("Reference Type" = const(Customer),
                                                                                "Reference Type No." = field("NV8 Consignment Customer"));
            DataClassification = CustomerContent;
            Caption = 'Cross-Reference No.';
            trigger OnValidate()
            var
                ReturnedCrossRef: Record "Item Reference";
            begin
                with ReturnedCrossRef do begin
                    Reset();
                    SetCurrentkey("Reference No.", "Reference Type", "Reference Type No.");
                    SetRange("Reference Type", "reference type"::Customer);
                    SetRange("Reference Type No.", Rec."NV8 Consignment Customer");
                    SetRange("Reference No.", Rec."NV8 Cross-Reference No.");
                    if Find('-') then begin
                        Rec.Validate("Item No.", "Item No.");
                        Rec.Validate("Variant Code", "Variant Code");
                        //rec."Unit of Measure":= ReturnedCrossRef."Unit of Measure";
                        Rec."NV8 Consignment Customer" := ReturnedCrossRef."Reference Type No.";
                        Rec."NV8 Cross-Reference No." := ReturnedCrossRef."Reference No.";
                    end;
                end;
            end;
        }
        field(85093; "NV8 Customer Name"; Text[50])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("NV8 Consignment Customer")));
            Description = 'UE-631';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Customer Name';
        }
        field(85094; "NV8 Sales Price UEI"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
            Caption = 'Sales Price UEI';
        }
        field(85100; "NV8 Configurator No."; Code[100])
        {
            TableRelation = "NV8 Configurator Item" where(Status = filter(Item .. "Valid Item"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Configurator No.';

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


            //     if not ConfiguratorFound then begin
            //         Commit();
            //         if Confirm(AG012, false) then begin
            //             ConfiguratorItem.Insert(true);
            //             Commit();

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
        field(85311; "NV8 Split Pieces"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details".Pieces where("Prod. Order No." = field("NV8 Production Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Split Pieces';
        }
        field(85312; "NV8 Split Total Length meters"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details"."Total Length meters" where("Prod. Order No." = field("NV8 Production Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Split Total Length meters';
        }
        field(85313; "NV8 Split Total Area m2"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details"."Total Area m2" where("Prod. Order No." = field("NV8 Production Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Split Total Area m2';
        }
        field(85511; "NV8 Rem. Split Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Rem. Split Pieces';
        }
        field(89100; "NV8 Pick List"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Pick List';
            trigger OnValidate()
            begin
                /*IF "Pick List" = '' THEN
                  EXIT;
                TransHeader.GET("Document No.");
                PickListHeader.GET("Pick List");
                TESTFIELD("Qty. to Ship");
                TransHeader.TESTFIELD("Transfer-from Code",PickListHeader."Location Code");
                TransHeader.TESTFIELD(Status,TransHeader.Status::Released);
                   */

            end;
        }
        field(89101; "NV8 Production Order Status"; Option)
        {
            OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished;
            DataClassification = CustomerContent;
            Caption = 'Production Order Status';
        }
        field(89102; "NV8 Production Order No."; Code[20])
        {
            TableRelation = "Production Order"."No." where(Status = field("NV8 Production Order Status"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Production Order No.';
        }
        field(89103; "NV8 Problem NOT resolved"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Problem NOT resolved';
        }
        field(89108; "NV8 Production Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Production Due Date';
        }
        field(89113; "NV8 Original Total Length Meters"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'RSQ';
            DataClassification = CustomerContent;
            Caption = 'Original Total Length Meters';
        }
        field(90041; "NV8 Scannded Work Center Desc"; Text[100])
        {
            CalcFormula = lookup("Work Center".Name where("No." = field("NV8 Scanned Work Center")));
            Description = 'UNE-152';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Scannded Work Center Desc';
        }
        field(90042; "NV8 Scanned Work Center"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'UNE-152';
            Editable = false;
            Caption = 'Scanned Work Center';
        }
        field(90043; "NV8 Material"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Material where("Configurator No." = field("NV8 Configurator No.")));
            Description = 'UNE-152';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Material";
            Caption = 'Material';
        }
        field(90044; "NV8 Grit"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Grit where("Configurator No." = field("NV8 Configurator No.")));
            Description = 'UNE-152';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Grit";
            Caption = 'Grit';
        }
        field(90045; "NV8 Jumbo Raw Material Status"; Option)
        {
            CalcFormula = lookup("NV8 Config Material-Grits"."Set Raw Material Status" where("Material Code" = field("NV8 Material"),
                                                                                                "Grit Code" = field("NV8 Grit")));
            Description = 'UNE-152';
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = ,Normal,Low,"Jumbo Out",Out,Discontinued;
            Caption = 'Jumbo Raw Material Status';
        }
        field(99000; "NV8 No. Of Ships"; Integer)
        {
            BlankZero = true;
            CalcFormula = count("Transfer Shipment Line" where("Transfer Order No." = field("Document No."),
                                                                "Line No." = field("Line No.")));
            Description = 'VJ';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'No. Of Ships';
        }
        field(99001; "NV8 No. Of Recs"; Integer)
        {
            BlankZero = true;
            CalcFormula = count("Transfer Receipt Line" where("Transfer Order No." = field("Document No."),
                                                               "Line No." = field("Line No.")));
            Description = 'VJ';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'No. Of Recs';
        }
        field(99002; "NV8 Qty. on Ships"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Transfer Shipment Line".Quantity where("Transfer Order No." = field("Document No."),
                                                                       "Line No." = field("Line No.")));
            Description = 'VJ';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Qty. on Ships';
        }
        field(99003; "NV8 Qty. on Rec"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Transfer Receipt Line".Quantity where("Transfer Order No." = field("Document No."),
                                                                      "Line No." = field("Line No.")));
            Description = 'VJ';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Qty. on Rec';
        }
        field(99004; "NV8 Original Ship Qty"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Transfer Shipment Line".Quantity where("Transfer Order No." = field("Document No."),
                                                                       "Line No." = field("Line No.")));
            Description = 'VJ';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Original Ship Qty';
        }
        field(99005; "NV8 Original Rec Qty"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Transfer Receipt Line".Quantity where("Transfer Order No." = field("Document No."),
                                                                      "Line No." = field("Line No.")));
            Description = 'VJ';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Original Rec Qty';
        }
        field(99006; "NV8 Header Exists"; Boolean)
        {
            CalcFormula = exist("Transfer Header" where("No." = field("Document No.")));
            Description = 'VJ';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Header Exists';
        }
    }
}
