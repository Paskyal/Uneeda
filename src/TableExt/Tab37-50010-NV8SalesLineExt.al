tableextension 50010 "NV8 Sales Line" extends "Sales Line" //37
{
    fields
    {
        field(50000; "NV8 No Charge (Sample)"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'No Charge (Sample)';
            trigger OnValidate()
            begin
                if "NV8 No Charge (Sample)" = true then
                    Validate("Unit Price", 0)
                else
                    UpdateUnitPrice(FieldNo("NV8 No Charge (Sample)"));
            end;
        }
        field(50001; "NV8 Sales Type"; Option)
        {
            Description = 'EC1.SAL1.01,UE-462';
            InitValue = Other;
            OptionCaption = 'Revenue,Freight,Surcharge,Minimum Charge,Other';
            OptionMembers = Revenue,Freight,Surcharge,"Minimum Charge",Other;
            DataClassification = CustomerContent;
            Caption = 'Sales Type';
        }
        field(50002; "NV8 Sales Price Code"; Code[10])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Sales Price Code';
            trigger OnValidate()
            begin
                UpdateUnitPrice(FieldNo("NV8 Sales Price Code"));
            end;
        }
        field(50003; "NV8 Catalog No."; Code[20])
        {
            Description = 'EC1.SAL1.01';
            TableRelation = "NV8 Item Catalog Table"."Catalog No.";
            DataClassification = CustomerContent;
            Caption = 'Catalog No.';
            trigger OnValidate()
            var
                ItemCatalog: Record "NV8 Item Catalog Table";
            begin
                if ItemCatalog.Get("NV8 Catalog No.") then begin
                    Type := Type::Item;
                    Validate("No.", ItemCatalog."Item No.");
                end;
            end;
        }
        field(50004; "NV8 Configurator No."; Code[100])
        {
            Description = 'EC1.SAL1.01';
            TableRelation = "NV8 Configurator Item"."Configurator No.";
            DataClassification = CustomerContent;
            Caption = 'Configurator No.';
            trigger OnValidate()
            var
                ConfigItem: Record "NV8 Configurator Item";
                Item: Record Item;
            begin
                /*IF ConfigItem.GET("Configurator No.") THEN BEGIN
                  Type := Type::Item;
                  VALIDATE("No.",ConfigItem."Item No.");
                  Description := ConfigItem."Item Description";
                  "Description 2" := ConfigItem."Item Description 2";
                END;
                 */

                //>>AG003 - Start
                // TODO PAP
                //     ConfiguratorFound := false;
                //     Found := false;
                //     if "Configurator No." = '' then
                //         exit;
                //     if (ConfiguratorItem.Get("Configurator No.")) then begin
                //         if ConfiguratorItem."Item No." <> '' then begin
                //             Validate(Type, Type::Item);
                //             Validate("No.", ConfiguratorItem."Item No.");
                //             ConfiguratorFound := true;
                //         end;
                //     end;

                //     if not ConfiguratorFound then begin
                //         if (StrLen("Configurator No.") <= 20) then begin
                //             if (Item.Get("Configurator No.")) then begin
                //                 Validate(Type, Type::Item);
                //                 Validate("No.", Item."No.");
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

            end;
        }
        field(50005; "NV8 Original Ordered Quantity"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Original Ordered Quantity';
            trigger OnValidate()
            begin
                //>>UE-105
                Validate("NV8 Original Ordered Amount", "NV8 Original Ordered Quantity" * "Unit Price");
                //<<UE-105
            end;
        }
        field(50006; "NV8 Original Ordered Pieces"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Original Ordered Pieces';
        }
        field(50007; "NV8 Original Unit Length (Meters)"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Original Unit Length (Meters)';
        }
        field(50008; "NV8 Pieces"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces';
            // TODO PAP
            // trigger OnValidate()
            // begin

            //     UpdatePieces;
            // end;
        }
        field(50009; "NV8 Unit Length (Meters)"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Unit Length (Meters)';
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     //VALIDATE(Quantity,Pieces);  //EC1.SAL1.01

            //     "NV8 Unit Length Inches" := ROUND("NV8 Unit Length meters" * 39, 0.00001);
            //     UpdatePieces;
            // end;
        }
        field(50010; "NV8 Price Type"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = 'Manual,List,Valid';
            OptionMembers = Manual,List,Valid;
            DataClassification = CustomerContent;
            Caption = 'Price Type';
            trigger OnValidate()
            begin
                //IF "Price Type" = "Price Type"::Manual THEN
                //  "Add Sales Price to Customer" := TRUE;
            end;
        }
        field(50011; "NV8 Manual Price Entered By"; Code[50])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Manual Price Entered By';
        }
        field(50012; "NV8 Manual Discount %"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Manual Discount %';
            trigger OnValidate()
            begin
                if "Allow Line Disc." then
                    Validate("Line Discount %", "NV8 Manual Discount %");
            end;
        }
        field(50013; "NV8 Exclude from Sales Stats"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Exclude from Sales Stats';
        }
        field(50014; "NV8 Pieces to Ship"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces to Ship';
            trigger OnValidate()
            begin
                //UE-282
                TestField("NV8 Pieces");
                Validate("Qty. to Ship", ROUND("NV8 Pieces to Ship" * Quantity / "NV8 Pieces", 0.00001));
            end;
        }
        field(50015; "NV8 Pieces to Invoice"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces to Invoice';
            trigger OnValidate()
            begin
                //UE-282
                TestField("NV8 Pieces");
                Validate("Qty. to Invoice", ROUND("NV8 Pieces to Invoice" * Quantity / "NV8 Pieces", 0.00001));
            end;
        }
        field(50016; "NV8 Pieces Shipped"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces Shipped';
        }
        field(50017; "NV8 Pieces Invoiced"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces Invoiced';
        }
        field(50018; "NV8 Meters Shipped"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Meters Shipped';
        }
        field(50019; "NV8 Meters Invoiced"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Meters Invoiced';
        }
        field(50020; "NV8 Fully Shipped"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Fully Shipped';
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     //>>EC1.SAL1.01
            //     /*
            //     //When field is checked, the system process the RSQ rules and if okay
            //     //changes the quantity field to match the Qty shipped + Qty to Ship
            //     //If uncehcekd then the Quantity changed back to Orig Qty value
            //     */
            //     if "NV8 Fully Shipped" = true then begin
            //         CheckRSQ;
            //         Quantity := ("Quantity Shipped" + "Qty. to Ship");
            //         "Quantity (Base)" := CalcBaseQty(Quantity);
            //         "Std. Pack Quantity" := CalcStdPackQty("Quantity (Base)");
            //         "Package Quantity" := CalcPackageQty("Std. Pack Quantity");
            //         UpdateUnitPrice(FieldNo(Quantity));
            //     end else begin
            //         Quantity := "Original Ordered Quantity";
            //         "Quantity (Base)" := CalcBaseQty(Quantity);
            //         "Std. Pack Quantity" := CalcStdPackQty("Quantity (Base)");
            //         "Package Quantity" := CalcPackageQty("Std. Pack Quantity");
            //         UpdateUnitPrice(FieldNo(Quantity));
            //     end;

            // end;
        }
        field(50021; "NV8 On Hold"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'On Hold';
        }
        field(50022; "NV8 Consignment Order Line"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Consignment Order Line';
        }
        field(50023; "NV8 Consignment Quantity"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Consignment Quantity';
        }
        field(50024; "NV8 Consignment Pieces"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Consignment Pieces';
        }
        field(50025; "NV8 Consignment Length (Meters)"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Consignment Length (Meters)';
        }
        field(50027; "NV8 Ignore Shipping Advice"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Ignore Shipping Advice';
        }
        field(50028; "NV8 Price Hold"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Price Hold';
        }
        field(50029; "NV8 Item Hold"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Item Hold';
        }
        field(50030; "NV8 Special Price Code"; Code[10])
        {
            Description = 'Jira-59';
            DataClassification = CustomerContent;
            Caption = 'Special Price Code';
            trigger OnValidate()
            begin
                //EC1.01  Jira 131
                UpdateUnitPrice(FieldNo("NV8 Special Price Code"));
            end;
        }
        field(50031; "NV8 Return Pieces to Receive"; Decimal)
        {
            Description = 'UE-482';
            DataClassification = CustomerContent;
            Caption = 'Return Pieces to Receive';
            trigger OnValidate()
            begin
                //>> UE-482
                if "NV8 Pieces" <> 0 then
                    //  TESTFIELD(Pieces);
                    Validate("Return Qty. to Receive", ROUND("NV8 Return Pieces to Receive" * Quantity / "NV8 Pieces", 0.00001));
                //<< UE-482
            end;
        }
        field(50033; "NV8 Return Pieces Received"; Decimal)
        {
            Description = 'UE-482';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Return Pieces Received';
        }
        field(50035; "NV8 Return Meters Received"; Decimal)
        {
            Description = 'UE-482';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Return Meters Received';
        }
        field(50040; "NV8 Original Ordered Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            Description = 'UE-105';
            DataClassification = CustomerContent;
            Caption = 'Original Ordered Amount';
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     //>>UE-105
            //     SalesHeader.Validate("NV8 Original Ordered Amount");
            //     //<<UE-105
            // end;
        }
        field(50065; "NV8 Blanket"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'CAS-37795-W2P2K8';
            Caption = 'Blanket';
        }
        field(50120; "NV8 Prod. Order Created"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prod. Order Created';
        }
        field(50125; "NV8 Prod. Order Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = " ",Simulated,Planned,"Firm Planned",Released,Finished;
            DataClassification = CustomerContent;
        }
        field(50130; "NV8 Prod. Order No."; Code[20])
        {
            Editable = false;
            TableRelation = "Production Order"."No." where("No." = field("NV8 Prod. Order No."),
                                                            Status = filter("Firm Planned" | Released));
            DataClassification = CustomerContent;
            Caption = 'Prod. Order No.';
        }
        field(50200; "NV8 External Document No."; Code[35])
        {
            CalcFormula = lookup("Sales Header"."External Document No." where("Document Type" = field("Document Type"),
                                                                               "No." = field("Document No.")));
            Description = 'UNE-217';
            FieldClass = FlowField;
            Caption = 'External Document No.';
        }
        field(50201; "NV8 Created On"; Date)
        {
            CalcFormula = lookup("Sales Header"."NV8 Created On" where("Document Type" = field("Document Type"),
                                                                    "No." = field("Document No.")));
            Description = 'UNE-217';
            FieldClass = FlowField;
            Caption = 'Created On';
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
            CalcFormula = lookup("Sales Header"."NV8 Created By" where("Document Type" = field("Document Type"),
                                                                    "No." = field("Document No.")));
            Description = 'UNE-217';
            FieldClass = FlowField;
            Caption = 'Created By';
        }
        field(68055; "NV8 Jumbo Raw Material Status"; Option)
        {
            CalcFormula = lookup("NV8 Config Material-Grits"."Set Raw Material Status" where("Material Code" = field("NV8 Material"),
                                                                                                "Grit Code" = field("NV8 Grit")));
            Description = 'UNE-152';
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = ,Normal,Low,"Jumbo Out",Out,Discontinued;
            Caption = 'Jumbo Raw Material Status';
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
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Unit Width Inches';
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     TEMP := ROUND("NV8 Unit Width Inches", 1, '<') * 100;
            //     TEMP := TEMP + ROUND((("NV8 Unit Width Inches" MOD 1) * 64), 1, '<');

            //     Validate("Unit Width Code", Format(TEMP, 5, '<integer>'));

            //     UpdatePieces;
            // end;
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
            Caption = 'Unit Length meters';
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     GetSalesHeader();
            //     "NV8 Unit Length Inches" := ROUND("Unit Length meters" * 39, 0.00001);
            //     UpdatePieces;
            // end;
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            BlankZero = true;
            DataClassification = CustomerContent;
            Caption = 'Unit Length Inches';
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     "NV8 Unit Length meters" := ROUND("NV8 Unit Length Inches" / 39, 0.00001);
            //     UpdatePieces;
            // end;
        }
        field(85054; "NV8 Unit Area m2"; Decimal)
        {
            BlankZero = true;
            Description = 'Width / 39 x Length';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Unit Area m2';
        }
        field(85055; "NV8 Unit Width Code"; Code[10])
        {
            CharAllowed = '09';
            DataClassification = CustomerContent;
            Caption = 'Unit Width Code';
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     ConfiguratorSetup.Get;
            //     ConfiguratorSetup.SetDimLen("Unit Width Code", 5, "Unit Width Code", 0);
            //     "Unit Width Inches" := ConfiguratorSetup.GetDecimal("Unit Width Code");
            //     "Unit Width Text" := ConfiguratorSetup.GetDecimalText("Unit Width Code");
            //     if "Unit Width Inches" <> 0 then
            //         Validate("Unit Price", "Price Per meter" / "Unit Width Inches" * 39);
            //     // UpdateUnitPrice;
            //     UpdatePieces;
            //     //DistIntegration.EnterSalesItemWidth(Rec);
            //     // Error in pulling list and not validating on unit price change
            //     Validate("Unit Price");
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
            trigger OnValidate()
            begin
                TestField("NV8 Pieces");
                Validate("NV8 Unit Length meters", ROUND("NV8 Total Length meters" / "NV8 Pieces", 0.00001));
                if "NV8 Original Total Length Meters" = 0 then "NV8 Original Total Length Meters" := "NV8 Total Length meters";
                if "NV8 Original Unit LengthMeters_old" = 0 then "NV8 Original Unit LengthMeters_old" := "NV8 Unit Length meters";
                if "NV8 Original Ordered Pieces" = 0 then "NV8 Original Ordered Pieces" := "NV8 Pieces";
            end;
        }
        field(85059; "NV8 Price Per meter"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            BlankZero = true;
            DataClassification = CustomerContent;
            Caption = 'Price Per meter';
            trigger OnValidate()
            begin
                if "NV8 Unit Width Inches" <> 0 then
                    Validate("Unit Price", ROUND("NV8 Price Per meter" / "NV8 Unit Width Inches" * 39, 0.00001, '<'));
            end;
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Total Area m2';
        }
        field(85101; "NV8 Shape"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Shape where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Shape";
            Caption = 'Shape';
        }
        field(85102; "NV8 Material"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Material where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Material";
            Caption = 'Material';
        }
        field(85107; "NV8 Specification"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Specification where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Specification";
            Caption = 'Specification';
        }
        field(85108; "NV8 Grit"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Grit where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Grit";
            Caption = 'Grit';
        }
        field(85109; "NV8 Joint"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Joint where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Joint";
            Caption = 'Joint';
        }
        field(89113; "NV8 Original Total Length Meters"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'RSQ';
            DataClassification = CustomerContent;
            Caption = 'Original Total Length Meters';
        }
        field(89114; "NV8 Original Unit LengthMeters_old"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'RSQ';
            DataClassification = CustomerContent;
            Caption = 'Original Unit LengthMeters_old';
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
    }
}
