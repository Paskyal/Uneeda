Table 50025 "NV8 Allocation Entry"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Status; Option)
        {
            Description = 'Not used, but allow for future use';
            Enabled = false;
            OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished;
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Description = 'Currently support only Released';
            NotBlank = true;
            TableRelation = "Production Order"."No." where(Status = const(Released));

            trigger OnValidate()
            begin
                SetProdOrder();
                UpdateStatus(0);
            end;
        }
        field(3; "Prod. Order Line No."; Integer)
        {
            Description = 'Not used, currently just assign to header';
            Enabled = false;
        }
        field(4; "Initial Item Ledger Entry No."; Integer)
        {
            NotBlank = true;
            TableRelation = "Item Ledger Entry";

            trigger OnValidate()
            begin
                Validate("Item Ledger Entry No.", "Initial Item Ledger Entry No.");
            end;
        }
        field(5; "Item Ledger Entry No."; Integer)
        {
            NotBlank = true;
            TableRelation = "Item Ledger Entry";

            trigger OnValidate()
            begin
                SetItemEntry();
                UpdateStatus(0);
            end;
        }
        field(6; "Allocated ILE"; Integer)
        {
            NotBlank = true;
            TableRelation = "Item Ledger Entry";

            trigger OnValidate()
            begin
                SetItemEntry();
                UpdateStatus(0);
            end;
        }
        field(10; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(11; "Location Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(15; "Due Date"; Date)
        {
        }
        field(20; Quantity; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                "Quantity (Base)" := ROUND(Quantity * "Qty. per Unit of Measure", 0.00001);
            end;
        }
        field(21; "Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Quantity := ROUND("Quantity (Base)" / "Qty. per Unit of Measure", 0.00001);
            end;
        }
        field(22; "Qty. per Unit of Measure"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = true;
            InitValue = 1;

            trigger OnValidate()
            begin
                Quantity := ROUND("Quantity (Base)" / "Qty. per Unit of Measure", 0.00001);
            end;
        }
        field(30; "Material Needed"; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
        }
        field(31; "Grit Needed"; Code[10])
        {
            TableRelation = "NV8 Configurator Grit";
        }
        field(33; "Item Needed"; Code[20])
        {
            TableRelation = Item;
        }
        field(34; "Location Needed"; Code[10])
        {
            TableRelation = Location;
        }
        field(35; "Quantity Needed"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(37; "Reserved MFG"; Decimal)
        {
            CalcFormula = - sum("Reservation Entry".Quantity where("Reservation Status" = const(Reservation),
                                                                   "Source Type" = const(5407),
                                                                   "Source Subtype" = const(3),
                                                                   "Source ID" = field("Prod. Order No."),
                                                                   "Source Batch Name" = const(''),
                                                                   "Source Prod. Order Line" = filter(>= 0),
                                                                   "Source Ref. No." = filter(>= 0)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; "Reservation Status"; Option)
        {
            OptionMembers = " ","Wrong Location","Ready To Reserve","Reservation Created",Error,"Substituted Item";
        }
        field(39; "Reserved ILE"; Decimal)
        {
            CalcFormula = - sum("Reservation Entry".Quantity where("Reservation Status" = const(Reservation),
                                                                   "Source Type" = const(32),
                                                                   "Source Ref. No." = field("Allocated ILE")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Creation Date"; Date)
        {
        }
        field(41; "Created By"; Code[20])
        {
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;

            // TODO PAP
            // trigger OnLookup()
            // var
            //     LoginMgt: Codeunit "User Management";
            // begin
            //     LoginMgt.LookupUserID("Created By");
            // end;
        }
        field(45; Description; Text[50])
        {
        }
        field(5400; "Lot No."; Code[20])
        {
        }
        field(5401; "Variant Code"; Code[10])
        {
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(68110; "Roll ID"; Code[20])
        {
        }
        field(85010; "Created From Document Type"; Option)
        {
            OptionCaption = ' ,Sales Order,Sales Invoice,,,,Transfer Order';
            OptionMembers = " ","Sales Order","Sales Invoice",,,,"Transfer Order";
        }
        field(85011; "Created From Document No."; Code[20])
        {
            Editable = false;
        }
        field(85012; "Created From Line No."; Integer)
        {
            TableRelation = if ("Created From Document Type" = const("Sales Order")) "Sales Line"."Line No." where("Document Type" = field("Created From Document Type"),
                                                                                                                  "Document No." = field("Created From Document No."))
            else
            if ("Created From Document Type" = const("Transfer Order")) "Transfer Line"."Line No." where("Document No." = field("Created From Document No."));
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

            trigger OnValidate()
            var
                Temp: Integer;
            begin
            end;
        }
        field(85052; "Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
        }
        field(85055; "Unit Width Code"; Code[10])
        {
            CharAllowed = '09';
        }
        field(85058; "Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
        }
        field(85110; Shape; Code[10])
        {
            TableRelation = "NV8 Configurator Shape";
        }
        field(85120; Material; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
        }
        field(85180; Grit; Code[10])
        {
            TableRelation = "NV8 Configurator Grit";
        }
    }

    keys
    {
        key(Key1; "Prod. Order No.", "Initial Item Ledger Entry No.")
        {
            Clustered = true;
            SumIndexFields = Quantity, "Quantity Needed";
        }
        key(Key2; Material, Grit)
        {
            SumIndexFields = Quantity, "Quantity Needed";
        }
        key(Key3; "Initial Item Ledger Entry No.")
        {
            SumIndexFields = Quantity, "Quantity Needed";
        }
        key(Key4; "Item No.")
        {
            SumIndexFields = Quantity, "Quantity Needed";
        }
    }

    fieldgroups
    {
    }

    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        ProdOrder: Record "Production Order";
        ProdOrderComp: Record "Prod. Order Component";
        Item: Record Item;
        ReservEntry: Record "Reservation Entry";
        ReservMgt: Codeunit "Reservation Management";
        CreateReservEntry: Codeunit "Create Reserv. Entry";
        QtyToReserve: Decimal;
        UnitOfMeasureCode: Code[10];
        QtyReservedThisLine: Decimal;
        NewQtyReservedThisLine: Decimal;
        Text000: label 'Fully reserved.';
        Text002: label 'There is nothing available to reserve.';


    procedure SetProdOrder()
    begin
        ProdOrder.Get(ProdOrder.Status::Released, "Prod. Order No.");
        "Created From Document Type" := ProdOrder."NV8 Created From Document Type";
        "Created From Document No." := ProdOrder."NV8 Created From Document No.";
        "Created From Line No." := ProdOrder."NV8 Created From Line No.";

        "Due Date" := ProdOrder."Due Date";
        "Material Needed" := ProdOrder."NV8 Material";
        "Grit Needed" := ProdOrder."NV8 Grit";
        ProdOrderComp.Reset();
        ProdOrderComp.SetRange(Status, ProdOrder.Status::Released);
        ProdOrderComp.SetRange("Prod. Order No.", "Prod. Order No.");
        ProdOrderComp.SetRange("NV8 Material", "Material Needed");
        ProdOrderComp.SetRange("NV8 Grit", "Grit Needed");
        if ProdOrderComp.FindFirst() then begin
            "Quantity Needed" := ProdOrderComp."Expected Quantity";
            "Item Needed" := ProdOrderComp."Item No.";
        end;
    end;


    procedure SetItemEntry()
    begin
        ItemLedgerEntry.Get("Item Ledger Entry No.");
        "Item No." := ItemLedgerEntry."Item No.";
        "Qty. per Unit of Measure" := ItemLedgerEntry."Qty. per Unit of Measure";
        "Location Code" := ItemLedgerEntry."Location Code";
        "Variant Code" := ItemLedgerEntry."Variant Code";
        "Bin Location" := ItemLedgerEntry."NV8 Bin Location";
        "FIFO Code" := ItemLedgerEntry."NV8 FIFO Code";
        "FIFO Date" := ItemLedgerEntry."NV8 FIFO Date";
        "Unit Width Inches" := ItemLedgerEntry."NV8 Unit Width Inches";
        "Unit Length meters" := ItemLedgerEntry."NV8 Unit Length meters";
        "Unit Width Code" := ItemLedgerEntry."NV8 Unit Width Code";
        Shape := ItemLedgerEntry."NV8 Shape";
        Material := ItemLedgerEntry."NV8 Material";
        Grit := ItemLedgerEntry."NV8 Grit";

        if ItemLedgerEntry."Remaining Quantity" > "Quantity Needed" then
            Quantity := "Quantity Needed"
        else
            Quantity := ItemLedgerEntry."Remaining Quantity";

        /*
        Quantity
        Pieces
        "Total Length meters"
         */

    end;


    procedure ReserveFromAllocation()
    begin
        if "Location Needed" = '' then
            "Location Needed" := 'AA-FLOOR';
        if "Allocated ILE" = 0 then begin
            ItemLedgerEntry.Reset();
            ItemLedgerEntry.SetCurrentkey("Item No.", "Variant Code", "Drop Shipment", "Location Code");
            ItemLedgerEntry.SetRange("Item No.", "Item No.");
            ItemLedgerEntry.SetRange("Location Code", "Location Needed");
            ItemLedgerEntry.SetRange("NV8 Allocation ID", "Initial Item Ledger Entry No.");
            if ItemLedgerEntry.FindFirst() then
                "Allocated ILE" := ItemLedgerEntry."Entry No.";
            Modify();
            Commit();
        end;

        if "Item Needed" = '' then begin
            ProdOrderComp.Reset();
            ProdOrderComp.SetRange(Status, ProdOrder.Status::Released);
            ProdOrderComp.SetRange("Prod. Order No.", "Prod. Order No.");
            ProdOrderComp.SetRange("NV8 Material", "Material Needed");
            ProdOrderComp.SetRange("NV8 Grit", "Grit Needed");
            if ProdOrderComp.FindFirst() then
                "Item Needed" := ProdOrderComp."Item No.";
            Modify();
            Commit();
        end;

        CalcFields("Reserved ILE");
        if "Reserved ILE" <> 0 then begin
            "Reservation Status" := "reservation status"::"Substituted Item";
            Modify();
            exit;
        end;

        ProdOrderComp.Reset();
        ProdOrderComp.SetRange(Status, ProdOrder.Status::Released);
        ProdOrderComp.SetRange("Prod. Order No.", "Prod. Order No.");
        ProdOrderComp.SetRange("NV8 Material", "Material Needed");
        ProdOrderComp.SetRange("NV8 Grit", "Grit Needed");
        ProdOrderComp.FindFirst();
        ProdOrderComp.TestField("Due Date");
        ReservEntry."Source Type" := Database::"Prod. Order Component";
        ReservEntry."Source Subtype" := ProdOrderComp.Status;
        ReservEntry."Source ID" := ProdOrderComp."Prod. Order No.";
        ReservEntry."Source Prod. Order Line" := ProdOrderComp."Prod. Order Line No.";
        ReservEntry."Source Ref. No." := ProdOrderComp."Line No.";

        ReservEntry."Item No." := ProdOrderComp."Item No.";
        ReservEntry."Variant Code" := ProdOrderComp."Variant Code";
        ReservEntry."Location Code" := ProdOrderComp."Location Code";
        //ReservEntry."Bin Code" := '';
        ReservEntry."Lot No." := '';
        ReservEntry."Shipment Date" := ProdOrderComp."Due Date";
        UnitOfMeasureCode := ProdOrderComp."Unit of Measure Code";

        ReservEntry.LockTable();
        Clear(ReservMgt);
        // ReservMgt.SetProdOrderComponent(ProdOrderComp);//TODO PAP
        // get ILE
        // ItemLedgerEntry.GET("Item Ledger Entry No.");
        ItemLedgerEntry.Get("Allocated ILE");
        // rec --> ItemLedgerEntry
        // ReservMgt.ItemLedgEntryUpdateValues(ItemLedgerEntry, QtyToReserve, QtyReservedThisLine);// TODO PAP
        //ECL
        //NewQtyReservedThisLine := ReservMgt.CalculateRemainingQty;
        ReservMgt.CopySign(NewQtyReservedThisLine, QtyToReserve);
        if NewQtyReservedThisLine <> 0 then
            if Abs(NewQtyReservedThisLine) > Abs(QtyToReserve) then
                CreateReservation(QtyToReserve)
            else
                CreateReservation(NewQtyReservedThisLine)
        else
            Error(Text000);
    end;


    procedure CreateReservation(ReserveQuantity: Decimal)
    begin
        ItemLedgerEntry.TestField("Drop Shipment", false);
        ItemLedgerEntry.TestField("Item No.", ReservEntry."Item No.");
        ItemLedgerEntry.TestField("Variant Code", ReservEntry."Variant Code");
        ItemLedgerEntry.TestField("Location Code", ReservEntry."Location Code");
        //ECL
        //ItemLedgerEntry.TESTFIELD("Bin Code",ReservEntry."Bin Code");

        //UpdateReservMgt;
        Clear(ReservMgt);
        // ReservMgt.SetProdOrderComponent(ProdOrderComp);//TODO PAP

        //ECL
        //
        /*ReservMgt.CreateReservation(
          ReservEntry.Description,0D,ReserveQuantity,
          DATABASE::"Item Ledger Entry",0,'','',0,ItemLedgerEntry."Entry No.",
          ItemLedgerEntry."Variant Code",ItemLedgerEntry."Location Code",ItemLedgerEntry."Bin Code",'','',
          ItemLedgerEntry."Qty. per Unit of Measure");
        */

    end;


    procedure UpdateStatus(QtyReserved: Decimal)
    begin
        // see if location has been fixed
        if "Reservation Status" <= "reservation status"::"Wrong Location" then begin
            if
              ("Location Needed" = "Location Code") and
              ("Material Needed" = Material) and
              ("Grit Needed" = Grit) then
                "Reservation Status" := "reservation status"::"Ready To Reserve";
            if
              ("Location Needed" <> "Location Code") then
                "Reservation Status" := "reservation status"::"Wrong Location";
        end;



        // if the reserved quantity changed, then there must be some change in reservation, so reservation is possible
        CalcFields("Reserved MFG");
        if QtyReserved <> "Reserved MFG" then
            "Reservation Status" := "reservation status"::"Reservation Created";


        // If Material/Grit does not match then this is an error.
        if ("Material Needed" <> Material) or ("Grit Needed" <> Grit) then
            "Reservation Status" := "reservation status"::Error;
    end;


    procedure ShowProdOrder()
    begin
        with ProdOrder do begin
            Reset();
            SetRange("No.", Rec."Prod. Order No.");
            if ProdOrder.FindFirst() then begin
                case Status of
                    Status::Simulated:
                        Page.Run(Page::"Simulated Production Order", ProdOrder);
                    Status::Planned:
                        Page.Run(Page::"Planned Production Order", ProdOrder);
                    Status::"Firm Planned":
                        Page.Run(Page::"Firm Planned Prod. Order", ProdOrder);
                    Status::Released:
                        Page.Run(Page::"Released Production Order", ProdOrder);
                    Status::Finished:
                        Page.Run(Page::"Finished Production Order", ProdOrder);
                end;
            end;
        end;
    end;
}

