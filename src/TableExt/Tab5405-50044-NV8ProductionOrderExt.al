tableextension 50044 "NV8 Production Order" extends "Production Order" //5405
{
    // TODO PAP Uncomment OnValidate triggers
    fields
    {
        field(50200; "NV8 Source Doc No."; Code[20])
        {
            Editable = false;
            TableRelation = if ("NV8 Source Doc Type" = const("Transfer Order")) "Transfer Header"."No."
            else
            if ("NV8 Source Doc Type" = const("Sales Order")) "Sales Header"."No.";
            DataClassification = CustomerContent;
            Caption = 'Source Doc No.';
        }
        field(50205; "NV8 Source Doc Type"; Option)
        {
            Editable = false;
            OptionCaption = ',Transfer Order,Sales Order';
            OptionMembers = ,"Transfer Order","Sales Order";
            DataClassification = CustomerContent;
            Caption = 'Source Doc Type';
        }
        field(50210; "NV8 Source Doc Line No."; Integer)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Source Doc Line No.';
        }
        field(51100; "NV8 Original Schedule Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-183';
            Caption = 'Original Schedule Date';
        }
        field(51101; "NV8 Material Reviewed"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-195';
            Caption = 'Material Reviewed';
            trigger OnValidate()
            begin


                //>> UNE-195
                if "NV8 Material Reviewed" then begin
                    "NV8 Material Reviewed By" := UserId;
                    "NV8 Material Reviewed Date" := WorkDate();
                    Modify();

                end;
                //<< UNE-195
            end;
        }
        field(51102; "NV8 Material Reviewed Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-195';
            Caption = 'Material Reviewed Date';
        }
        field(51103; "NV8 Material Reviewed By"; Code[100])
        {
            DataClassification = CustomerContent;
            Description = 'UNE-195';
            Caption = 'Material Reviewed By';
        }
        field(55000; "NV8 Scanned Machine Center"; Code[20])
        {
            Description = 'ECL';
            DataClassification = CustomerContent;
            Caption = 'Scanned Machine Center';
        }
        field(55001; "NV8 Scanned Work Center"; Code[20])
        {
            Description = 'ECL';
            DataClassification = CustomerContent;
            Caption = 'Scanned Work Center';
        }
        field(55002; "NV8 Partial Quantity"; Decimal)
        {
            Description = 'ECL';
            DataClassification = CustomerContent;
            Caption = 'Partial Quantity';
        }
        field(56000; "NV8 Subcontract Vendor No."; Code[20])
        {
            Description = 'ECL';
            TableRelation = Vendor."No.";
            DataClassification = CustomerContent;
            Caption = 'Subcontract Vendor No.';
        }
        field(68000; "NV8 Reopened Finished Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Reopened Finished Order';
        }
        field(68001; "NV8 Demand Total Qty."; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Sales + Transfers';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Demand Total Qty.';
        }
        field(68002; "NV8 Expected Qty."; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Production + Purchase';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Expected Qty.';
        }
        field(68003; "NV8 Production Qty."; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Production (Firm and Released)';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Production Qty.';
        }
        field(68004; "NV8 Required Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Qty required for stock';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Required Quantity';
        }
        field(68008; "NV8 Qty. On Hand"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Qty. On Hand';
        }
        field(68009; "NV8 Forecast Qty."; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Qty forcast for customers';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Forecast Qty.';
        }
        field(68010; "NV8 Production Status"; Option)
        {
            OptionCaption = ',Ready to Allocate,In Progress,Waiting for Material,Partial,Complete';
            OptionMembers = ,"Ready to Allocate","In Progress","Waiting for Material",Partial,Complete;
            DataClassification = CustomerContent;
            Caption = 'Production Status';
        }
        field(68015; "NV8 Qty. On External Locations"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Qty. On External Locations';
        }
        field(68020; "NV8 Planned Order Status"; Option)
        {
            Editable = false;
            OptionMembers = "Create New","Add To Existing","More Than One Order","Reduce Existing Qty.";
            DataClassification = CustomerContent;
            Caption = 'Planned Order Status';
        }
        field(68021; "NV8 Planned Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Planned Quantity';
        }
        field(68022; "NV8 Planned Due Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Planned Due Date';
        }
        field(68023; "NV8 Planning Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Planning Date';
        }
        field(68024; "NV8 Start Planning Window"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Start Planning Window';
        }
        field(68025; "NV8 End Planning Window"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'End Planning Window';
        }
        field(68026; "NV8 Reorder Point Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Reorder Point Date';
        }
        field(68027; "NV8 Safety Stock Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Safety Stock Date';
        }
        field(68028; "NV8 Reorder Point Formula"; DateFormula)
        {
            Description = 'The period of time for a planning window for reordering';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Reorder Point Formula';
        }
        field(68029; "NV8 Safety Stock Formula"; DateFormula)
        {
            Description = 'The period of time for a planning window for reordering';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Safety Stock Formula';
        }
        field(68030; "NV8 Planning Window"; DateFormula)
        {
            Description = 'The period of time for a planning window for reordering';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Planning Window';
        }
        field(68031; "NV8 Current Demand"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Qty. on Current sales and transfers in planning window';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Current Demand';
        }
        field(68033; "NV8 Reorder Point Sales"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Sales and transfer in the Reorder poitn Window';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Reorder Point Sales';
        }
        field(68034; "NV8 Safety Stock Sales"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Safety Stock Sales';
        }
        field(68035; "NV8 No. Days to Next Production"; Integer)
        {
            Description = 'The number of days between the Demand window, and the date when the last order will be needed.';
            DataClassification = CustomerContent;
            Caption = 'No. Days to Next Production';
        }
        field(68036; "NV8 Reorder Point Transfer"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Sales and transfer in the Reorder poitn Window';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Reorder Point Transfer';
        }
        field(68037; "NV8 Safety Stock Transfer"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Safety Stock Transfer';
        }
        field(68040; "NV8 Priority"; Option)
        {
            OptionMembers = "Over Due",Rush,"-";
            DataClassification = CustomerContent;
            Caption = 'Priority';
        }
        field(68050; "NV8 Requisition Method Code"; Code[10])
        {
            Caption = 'Requisition Method Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(68051; "NV8 Vendor Classification"; Option)
        {
            Editable = false;
            OptionMembers = " ",A,B,C;
            DataClassification = CustomerContent;
            Caption = 'Vendor Classification';
        }
        field(68052; "NV8 Item Classification"; Option)
        {
            OptionMembers = " ",A,B,C;
            DataClassification = CustomerContent;
            Caption = 'Item Classification';
        }
        field(68055; "NV8 Jumbo Raw Material Status"; Option)
        {
            CalcFormula = lookup("NV8 Config Material-Grits"."Set Raw Material Status" where("Material Code" = field("NV8 Material"),
                                                                                                "Grit Code" = field("NV8 Grit")));
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = ,Normal,Low,"Jumbo Out",Out,Discontinued;
            Caption = 'Jumbo Raw Material Status';
        }
        field(68056; "NV8 Locked For Planning"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Locked For Planning';
        }
        field(68057; "NV8 Release To Production"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Release To Production';
        }
        field(68059; "NV8 Planning status"; Option)
        {
            OptionMembers = " ",New,Locked,Modified,Reviewed,"Change Status";
            DataClassification = CustomerContent;
            Caption = 'Planning status';
        }
        field(68070; "NV8 Process Location"; Option)
        {
            OptionCaption = ' ,Waiting For Material,Ready To Allocate,Allocation,Slitting,External Contractor,,,,,,,,,,,,Partial,Green,Finished,Closed';
            OptionMembers = " ","Waiting For Material","Ready To Allocate",Allocation,Slitting,"External Contractor",,,,,,,,,,,,Partial,Green,Finished,Closed;
            DataClassification = CustomerContent;
            Caption = 'Process Location';
        }
        field(68071; "NV8 Backflush Original Quantity"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Backflush Original Quantity';
        }
        field(68090; "NV8 Allocated Raw Material Qty"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Allocation Entry".Quantity where("Prod. Order No." = field("No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Allocated Raw Material Qty';
        }
        field(68091; "NV8 Allocation Status"; Option)
        {
            OptionCaption = 'Unknown,Closed,Transition,Open,Ready To Finish,Allocation Wrong,Partial Output,Slit Roll,New Method,Error,RoutingNeeded,PSA,Tape,RawMissing,PSAOK,TapeOK';
            OptionMembers = Unknown,Closed,Transition,Open,"Ready To Finish","Allocation Wrong","Partial Output","Slit Roll","New Method",Error,RoutingNeeded,PSA,Tape,RawMissing,PSAOK,TapeOK;
            DataClassification = CustomerContent;
            Caption = 'Allocation Status';
        }
        field(68092; "NV8 Dup Out"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Dup Out';
        }
        field(68093; "NV8 Dup Cap"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Dup Cap';
        }
        field(68100; "NV8 No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Description = 'UEI131';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(68400; "NV8 Catalog No."; Code[20])
        {
            CalcFormula = lookup(Item."NV8 Catalog No." where("No." = field("Source No.")));
            Caption = 'Catalog No.';
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
        }
        field(81199; "NV8 End-------"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'End-------';
        }
        field(81200; "NV8 Must Ship Sale"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Must Ship Sale';
        }
        field(85000; "NV8 xRemaining Quantity"; Decimal)
        {
            Description = 'AG001';
            DataClassification = CustomerContent;
            Caption = 'xRemaining Quantity';
        }
        field(85001; "NV8 Finished Quantity"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Prod. Order Line"."Finished Quantity" where(Status = field(Status),
                                                                            "Prod. Order No." = field("No."),
                                                                            "Item No." = field("Source No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Finished Quantity';
        }
        field(85002; "NV8 Remaining Quantity"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Prod. Order Line"."Remaining Quantity" where(Status = field(Status),
                                                                             "Prod. Order No." = field("No."),
                                                                             "Item No." = field("Source No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Remaining Quantity';
        }
        field(85006; "NV8 First Output Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'First Output Date';
        }
        field(85007; "NV8 Last Output Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Output Date';
        }
        field(85009; "NV8 Old Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Old Order';
        }
        field(85010; "NV8 Created From Document Type"; Option)
        {
            OptionCaption = ' ,Sales Order,Sales Invoice,,,,Transfer Order';
            OptionMembers = " ","Sales Order","Sales Invoice",,,,"Transfer Order";
            DataClassification = CustomerContent;
            Caption = 'Created From Document Type';
        }
        field(85011; "NV8 Created From Document No."; Code[150])
        {
            TableRelation = if ("NV8 Created From Document Type" = filter("Sales Order")) "Sales Header"."No." where("Document Type" = field("NV8 Created From Document Type"))
            else
            if ("NV8 Created From Document Type" = filter("Transfer Order")) "Transfer Header"."No.";
            DataClassification = CustomerContent;
            Caption = 'Created From Document No.';
        }
        field(85012; "NV8 Created From Line No."; Integer)
        {
            TableRelation = if ("NV8 Created From Document Type" = const("Sales Order")) "Sales Line"."Line No." where("Document Type" = field("NV8 Created From Document Type"),
                                                                                                                  "Document No." = field("NV8 Created From Document No."))
            else
            if ("NV8 Created From Document Type" = const("Transfer Order")) "Transfer Line"."Line No." where("Document No." = field("NV8 Created From Document No."));
            DataClassification = CustomerContent;
            Caption = 'Created From Line No.';
        }
        field(85013; "NV8 Pro No."; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Sales Header"."No." where("Document Type" = const(Order));
            Caption = 'Pro No.';
        }
        field(85014; "NV8 Pro Quantity"; Integer)
        {
            FieldClass = FlowFilter;
            Caption = 'Pro Quantity';
        }
        field(85015; "NV8 Pro No. Line"; Integer)
        {
            FieldClass = FlowFilter;
            Caption = 'Pro No. Line';
        }
        field(85016; "NV8 Pro Res Qty"; Decimal)
        {
            FieldClass = FlowFilter;
            Caption = 'Pro Res Qty';
        }
        field(85018; "NV8 Demand Due date"; Date)
        {
            Description = 'Original Due date prior to editiing';
            DataClassification = CustomerContent;
            Caption = 'Demand Due date';
            trigger OnValidate()
            begin
                // Update lines
                // ProdOrderLine.RESET;
                // ProdOrderLine.SETRANGE(Status,Status);
                // ProdOrderLine.SETRANGE("Prod. Order No.","No.");
                // ProdOrderLine.MODIFYALL("Must Have By","Must Have By");
            end;
        }
        field(85026; "NV8 Cust. Forecast Min. Qty."; Decimal)
        {
            CalcFormula = sum("Production Forecast Entry"."Forecast Quantity (Base)" where("Item No." = field("Source No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Cust. Forecast Min. Qty.';
        }
        field(85038; "NV8 RSQ"; Option)
        {
            Description = 'UE-525';
            Editable = false;
            OptionCaption = ' ,Variable,Exact';
            OptionMembers = " ",Variable,Exact;
            DataClassification = CustomerContent;
            Caption = 'RSQ';
        }
        field(85040; "NV8 Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
            Caption = 'Material Type';
        }
        field(85042; "NV8 Red Dot Level"; Option)
        {
            Description = 'Not used';
            OptionMembers = "1","2","3";
            DataClassification = CustomerContent;
            Caption = 'Red Dot Level';
        }
        field(85043; "NV8 Red Dot Transfer"; Boolean)
        {
            CalcFormula = exist("Transfer Line" where("Document No." = field("NV8 Created From Document No."),
                                                       "Line No." = field("NV8 Created From Line No."),
                                                       "NV8 Red Dot" = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Red Dot Transfer';
        }
        field(85050; "NV8 Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Pieces';

            // trigger OnValidate()
            // begin
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
            Caption = 'Unit Width Inches';

            // trigger OnValidate()
            // begin
            //     Temp := ROUND("Unit Width Inches", 1, '<') * 100;
            //     Temp := Temp + ROUND((("Unit Width Inches" MOD 1) * 64), 1, '<');

            //     Validate("Unit Width Code", Format(Temp, 5, '<integer>'));
            // end;
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
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
            BlankZero = true;
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
            BlankZero = true;
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
            //     if "Unit Width Inches" <> 0 then
            //         Validate("Unit Cost", "Cost Per meter" / "Unit Width Inches" * 39);
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
            trigger OnValidate()
            begin
                TestField("NV8 Pieces");
                Validate("NV8 Unit Length meters", ROUND("NV8 Total Length meters" / "NV8 Pieces", 0.00001));
            end;
        }
        field(85059; "NV8 Cost Per meter"; Decimal)
        {
            AutoFormatType = 2;
            BlankZero = true;
            DataClassification = CustomerContent;
            Caption = 'Cost Per meter';

            // trigger OnValidate()
            // begin
            //     if "NV8 Unit Width Inches" <> 0 then
            //         Validate("Unit Cost", "NV8 Cost Per meter" / "NV8 Unit Width Inches" * 39);
            //     UpdatePieces;
            // end;
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Total Area m2';
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
            // var
            //     ConfiguratorFound: Boolean;
            //     Component: Code[100];
            //     Remaining: Code[100];
            // begin
            //     //>>AG003 - Start
            //     ConfiguratorFound := false;
            //     Found := false;
            //     if "Configurator No." = '' then
            //         exit;
            //     if (ConfiguratorItem.Get("Configurator No.")) then begin
            //         if ConfiguratorItem."Item No." <> '' then begin
            //             Validate("Source Type", "source type"::Item);
            //             Validate("Source No.", ConfiguratorItem."Item No.");
            //             ConfiguratorFound := true;
            //         end;
            //     end;
            // end;
        }
        field(85101; "NV8 Shape"; Code[10])
        {
            Editable = false;
            TableRelation = "NV8 Configurator Shape";
            DataClassification = CustomerContent;
            Caption = 'Shape';
        }
        field(85102; "NV8 Material"; Code[10])
        {
            Editable = false;
            TableRelation = "NV8 Configurator Material";
            DataClassification = CustomerContent;
            Caption = 'Material';
        }
        field(85103; "NV8 Dimension 1"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 1';
        }
        field(85104; "NV8 Dimension 2"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 2';
        }
        field(85105; "NV8 Dimension 3"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 3';
        }
        field(85106; "NV8 Dimension 4"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 4';
        }
        field(85107; "NV8 Specification"; Code[10])
        {
            Editable = false;
            TableRelation = "NV8 Configurator Specification";
            DataClassification = CustomerContent;
            Caption = 'Specification';
        }
        field(85108; "NV8 Grit"; Code[10])
        {
            Editable = false;
            TableRelation = "NV8 Configurator Grit";
            DataClassification = CustomerContent;
            Caption = 'Grit';
        }
        field(85109; "NV8 Joint"; Code[10])
        {
            Editable = false;
            TableRelation = "NV8 Configurator Joint";
            DataClassification = CustomerContent;
            Caption = 'Joint';
        }
        field(85111; "NV8 Shape Production Area"; Code[20])
        {
            CalcFormula = lookup("NV8 Configurator Shape"."Shape Production Area" where(Code = field("NV8 Shape")));
            Description = 'UNE-174';
            FieldClass = FlowField;
            TableRelation = "NV8 Shape Production Area";
            Caption = 'Shape Production Area';
        }
        field(85112; "NV8 Scheduled Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-158';
            Caption = 'Scheduled Date';

            // trigger OnValidate()
            // begin

            //     //>>CAS-40377-V0H3X3
            //     //IF Rec."Scheduled Date" = 0D THEN EXIT ;
            //     if ("NV8 Scheduled Date" = 0D) and ("NV8 Original Schedule Date" <> 0D) then
            //         if Confirm('Do you want to update the Original Scheduled Date?') then
            //             "NV8 Original Schedule Date" := "NV8 Scheduled Date";
            //     //<<CAS-40377-V0H3X3
            //     if "NV8 Scheduled Date" = "NV8 Original Schedule Date" then exit;
            //     if "NV8 Original Schedule Date" = 0D then
            //         "NV8 Original Schedule Date" := "NV8 Scheduled Date"
            //     else
            //         if Confirm('Do you want to update the Original Scheduled Date?') then
            //             "NV8 Original Schedule Date" := "NV8 Scheduled Date";

            //     //<<UNE-173
            //     Clear(ProdOrderLine);
            //     ProdOrderLine.SetRange(Status, Rec.Status);
            //     ProdOrderLine.SetRange("Prod. Order No.", Rec."No.");
            //     if ProdOrderLine.FindLast() then
            //         repeat
            //             ProdOrderLine."Scheduled Date" := Rec."Scheduled Date";
            //             ProdOrderLine.Modify(false);
            //         until ProdOrderLine.Next() = 0;
            //     //>> UNE-173



            // end;
        }
        field(85245; "NV8 Created By"; Code[100])
        {
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }
        field(85246; "NV8 Created On"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Created On';
        }
        field(85247; "NV8 Edited By"; Code[100])
        {
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'Edited By';
        }
        field(85248; "NV8 Edited On"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Edited On';
        }
        field(85249; "NV8 Status Changed By"; Code[100])
        {
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'Status Changed By';
        }
        field(90040; "NV8 Scanned Machine Center Desc"; Text[100])
        {
            CalcFormula = lookup("Machine Center".Name where("No." = field("NV8 Scanned Machine Center")));
            FieldClass = FlowField;
            Caption = 'Scanned Machine Center Desc';
        }
        field(90041; "NV8 Scannded Work Center Desc"; Text[100])
        {
            CalcFormula = lookup("Work Center".Name where("No." = field("NV8 Scanned Work Center")));
            FieldClass = FlowField;
            Caption = 'Scannded Work Center Desc';
        }
        field(90045; "NV8 Source Sell-to Code"; Code[20])
        {
            CalcFormula = lookup("Sales Header"."Sell-to Customer No." where("No." = field("NV8 Source Doc No.")));
            Description = 'UE-581';
            FieldClass = FlowField;
            Caption = 'Source Sell-to Code';
        }
        field(90046; "NV8 Source Sell-to Name"; Text[50])
        {
            CalcFormula = lookup("Sales Header"."Sell-to Customer Name" where("No." = field("NV8 Source Doc No.")));
            Description = 'UE-581';
            FieldClass = FlowField;
            Caption = 'Source Sell-to Name';
        }
        field(90047; "NV8 Source Transfer-to Code"; Code[20])
        {
            CalcFormula = lookup("Transfer Header"."Transfer-to Code" where("No." = field("NV8 Source Doc No.")));
            Description = 'UE-581';
            FieldClass = FlowField;
            Caption = 'Source Transfer-to Code';
        }
        field(90048; "NV8 Soruce Transfer-to Name"; Text[50])
        {
            CalcFormula = lookup("Transfer Header"."Transfer-to Name" where("No." = field("NV8 Source Doc No.")));
            Description = 'UE-581';
            FieldClass = FlowField;
            Caption = 'Soruce Transfer-to Name';
        }
    }
}
