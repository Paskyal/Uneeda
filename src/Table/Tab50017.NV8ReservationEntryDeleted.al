Table 50017 "NV8 ReservationEntry-Deleted"
{
    Caption = 'Reservation Entry - DELETED';
    DrillDownPageID = "Reservation Entries";
    LookupPageID = "Reservation Entries";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(4; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Quantity := CalcReservationQuantity();
                "Qty. to Handle (Base)" := "Quantity (Base)";
                "Qty. to Invoice (Base)" := "Quantity (Base)";
            end;
        }
        field(5; "Reservation Status"; Option)
        {
            Caption = 'Reservation Status';
            OptionCaption = 'Reservation,Tracking,Surplus,Prospect';
            OptionMembers = Reservation,Tracking,Surplus,Prospect;
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(8; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
        }
        field(9; "Transferred from Entry No."; Integer)
        {
            Caption = 'Transferred from Entry No.';
            TableRelation = "Reservation Entry";
        }
        field(10; "Source Type"; Integer)
        {
            Caption = 'Source Type';
        }
        field(11; "Source Subtype"; Option)
        {
            Caption = 'Source Subtype';
            OptionCaption = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(12; "Source ID"; Code[20])
        {
            Caption = 'Source ID';
        }
        field(13; "Source Batch Name"; Code[10])
        {
            Caption = 'Source Batch Name';
        }
        field(14; "Source Prod. Order Line"; Integer)
        {
            Caption = 'Source Prod. Order Line';
        }
        field(15; "Source Ref. No."; Integer)
        {
            Caption = 'Source Ref. No.';
        }
        field(16; "Item Ledger Entry No."; Integer)
        {
            Caption = 'Item Ledger Entry No.';
            Editable = false;
            TableRelation = "Item Ledger Entry";
        }
        field(22; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(23; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
        }
        field(24; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';
        }
        field(25; "Created By"; Code[50])
        {
            Caption = 'Created By';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            //TODO PAP
            // trigger OnLookup()
            // var
            //     UserMgt: Codeunit "User Management";
            // begin
            //     UserMgt.LookupUserID("Created By");
            // end;
        }
        field(27; "Changed By"; Code[50])
        {
            Caption = 'Changed By';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            // TODO PAP
            // trigger OnLookup()
            // var
            //     UserMgt: Codeunit "User Management";
            // begin
            //     UserMgt.LookupUserID("Changed By");
            // end;
        }
        field(28; Positive; Boolean)
        {
            Caption = 'Positive';
            Editable = false;
        }
        field(29; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;

            trigger OnValidate()
            begin
                Quantity := ROUND("Quantity (Base)" / "Qty. per Unit of Measure", 0.00001);
            end;
        }
        field(30; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(31; "Action Message Adjustment"; Decimal)
        {
            CalcFormula = sum("Action Message Entry".Quantity where("Reservation Entry" = field("Entry No."),
                                                                     Calculation = const(Sum)));
            Caption = 'Action Message Adjustment';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; Binding; Option)
        {
            Caption = 'Binding';
            Editable = false;
            OptionCaption = ' ,Order-to-Order';
            OptionMembers = " ","Order-to-Order";
        }
        field(33; "Suppressed Action Msg."; Boolean)
        {
            Caption = 'Suppressed Action Msg.';
        }
        field(34; "Planning Flexibility"; Option)
        {
            Caption = 'Planning Flexibility';
            OptionCaption = 'Unlimited,None';
            OptionMembers = Unlimited,"None";
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            Caption = 'Appl.-to Item Entry';
        }
        field(40; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
            Editable = false;
        }
        field(41; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            Editable = false;
        }
        field(50; "Qty. to Handle (Base)"; Decimal)
        {
            Caption = 'Qty. to Handle (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(51; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(53; "Quantity Invoiced (Base)"; Decimal)
        {
            Caption = 'Quantity Invoiced (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(80; "New Serial No."; Code[20])
        {
            Caption = 'New Serial No.';
            Editable = false;
        }
        field(81; "New Lot No."; Code[20])
        {
            Caption = 'New Lot No.';
            Editable = false;
        }
        field(900; "Disallow Cancellation"; Boolean)
        {
            Caption = 'Disallow Cancelation';
        }
        field(5400; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';
        }
        field(5401; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            Caption = 'Appl.-from Item Entry';
            MinValue = 0;
        }
        field(5817; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(6505; "New Expiration Date"; Date)
        {
            Caption = 'New Expiration Date';
            Editable = false;
        }
        field(6510; "Item Tracking"; Option)
        {
            Caption = 'Item Tracking';
            Editable = false;
            OptionCaption = 'None,Lot No.,Lot and Serial No.,Serial No.';
            OptionMembers = "None","Lot No.","Lot and Serial No.","Serial No.";
        }
    }

    keys
    {
        key(Key1; "Entry No.", Positive)
        {
            Clustered = true;
        }
        key(Key2; "Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Quantity (Base)", Quantity;
        }
        key(Key3; "Item No.", "Variant Code", "Location Code", "Reservation Status", "Shipment Date", "Expected Receipt Date", "Serial No.", "Lot No.")
        {
            MaintainSIFTIndex = false;
            SumIndexFields = "Quantity (Base)";
        }
        key(Key4; "Item No.", "Source Type", "Source Subtype", "Reservation Status", "Location Code", "Variant Code", "Shipment Date", "Expected Receipt Date", "Serial No.", "Lot No.")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Quantity (Base)", Quantity;
        }
        key(Key5; "Item No.", "Variant Code", "Location Code", "Item Tracking", "Reservation Status", "Lot No.", "Serial No.")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Quantity (Base)";
        }
        key(Key6; "Lot No.")
        {
            Enabled = false;
        }
        key(Key7; "Serial No.")
        {
            Enabled = false;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Positive, "Item No.", Description, Quantity)
        {
        }
    }

    trigger OnDelete()
    var
        ActionMessageEntry: Record "Action Message Entry";
    begin
        ActionMessageEntry.SetCurrentkey("Reservation Entry");
        ActionMessageEntry.SetRange("Reservation Entry", "Entry No.");
        ActionMessageEntry.DeleteAll();
    end;

    var
        Text001: label 'Line';


    procedure TextCaption(): Text[255]
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        SalesLine: Record "Sales Line";
        ReqLine: Record "Requisition Line";
        PurchLine: Record "Purchase Line";
        ItemJnlLine: Record "Item Journal Line";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderComp: Record "Prod. Order Component";
        AssemblyHeader: Record "Assembly Header";
        AssemblyLine: Record "Assembly Line";
        TransLine: Record "Transfer Line";
        ServLine: Record "Service Line";
        JobJnlLine: Record "Job Journal Line";
    begin
        case "Source Type" of
            Database::"Item Ledger Entry":
                exit(ItemLedgEntry.TableCaption);
            Database::"Sales Line":
                exit(SalesLine.TableCaption);
            Database::"Requisition Line":
                exit(ReqLine.TableCaption);
            Database::"Purchase Line":
                exit(PurchLine.TableCaption);
            Database::"Item Journal Line":
                exit(ItemJnlLine.TableCaption);
            Database::"Job Journal Line":
                exit(JobJnlLine.TableCaption);
            Database::"Prod. Order Line":
                exit(ProdOrderLine.TableCaption);
            Database::"Prod. Order Component":
                exit(ProdOrderComp.TableCaption);
            Database::"Assembly Header":
                exit(AssemblyHeader.TableCaption);
            Database::"Assembly Line":
                exit(AssemblyLine.TableCaption);
            Database::"Transfer Line":
                exit(TransLine.TableCaption);
            Database::"Service Line":
                exit(ServLine.TableCaption);
            else
                exit(Text001);
        end;
    end;


    procedure SummEntryNo(): Integer
    begin
        case "Source Type" of
            Database::"Item Ledger Entry":
                exit(1);
            Database::"Purchase Line":
                exit(11 + "Source Subtype");
            Database::"Requisition Line":
                exit(21);
            Database::"Sales Line":
                exit(31 + "Source Subtype");
            Database::"Item Journal Line":
                exit(41 + "Source Subtype");
            Database::"Job Journal Line":
                exit(51 + "Source Subtype");
            Database::"Prod. Order Line":
                exit(61 + "Source Subtype");
            Database::"Prod. Order Component":
                exit(71 + "Source Subtype");
            Database::"Transfer Line":
                exit(101 + "Source Subtype");
            Database::"Service Line":
                exit(110);
            Database::"Assembly Header":
                exit(141 + "Source Subtype");
            Database::"Assembly Line":
                exit(151 + "Source Subtype");
            else
                exit(0);
        end;
    end;


    procedure SetPointer(RowID: Text[250])
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        StrArray: array[6] of Text[100];
    begin
        ItemTrackingMgt.DecomposeRowID(RowID, StrArray);
        Evaluate("Source Type", StrArray[1]);
        Evaluate("Source Subtype", StrArray[2]);
        "Source ID" := StrArray[3];
        "Source Batch Name" := StrArray[4];
        Evaluate("Source Prod. Order Line", StrArray[5]);
        Evaluate("Source Ref. No.", StrArray[6]);
    end;


    procedure Lock()
    var
        Rec2: Record "Reservation Entry";
    begin
        Rec2.SetCurrentkey("Item No.");
        if "Item No." <> '' then
            Rec2.SetRange("Item No.", "Item No.");
        Rec2.LockTable();
        if Rec2.FindLast() then;
    end;


    procedure UpdateItemTracking()
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        // TODO PAP
        // "Item Tracking" := ItemTrackingMgt.ItemTrackingOption("Lot No.", "Serial No.");
    end;


    procedure ClearItemTrackingFields()
    begin
        "Lot No." := '';
        "Serial No." := '';
        UpdateItemTracking();
    end;


    procedure FilterLinesWithItemToPlan(var Item: Record Item; IsReceipt: Boolean)
    begin
        Reset();
        SetCurrentkey(
          "Item No.", "Variant Code", "Location Code", "Reservation Status", "Shipment Date", "Expected Receipt Date");
        SetRange("Item No.", Item."No.");
        SetFilter("Variant Code", Item.GetFilter("Variant Filter"));
        SetFilter("Location Code", Item.GetFilter("Location Filter"));
        SetRange("Reservation Status", "reservation status"::Reservation);
        SetFilter(Binding, '<>%1', Binding::"Order-to-Order");
        if IsReceipt then
            SetFilter("Expected Receipt Date", Item.GetFilter("Date Filter"))
        else
            SetFilter("Shipment Date", Item.GetFilter("Date Filter"));
        SetFilter("Quantity (Base)", '<>0');
    end;


    procedure FindLinesWithItemToPlan(var Item: Record Item; IsReceipt: Boolean): Boolean
    begin
        FilterLinesWithItemToPlan(Item, IsReceipt);
        exit(Find('-'));
    end;


    procedure LinesWithItemToPlanExist(var Item: Record Item; IsReceipt: Boolean): Boolean
    begin
        FilterLinesWithItemToPlan(Item, IsReceipt);
        exit(not IsEmpty);
    end;

    local procedure CalcReservationQuantity(): Decimal
    var
        ReservEntry: Record "Reservation Entry";
    begin
        if "Qty. per Unit of Measure" = 1 then
            exit("Quantity (Base)");

        ReservEntry.SetFilter("Entry No.", '<>%1', "Entry No.");
        ReservEntry.SetRange("Source ID", "Source ID");
        ReservEntry.SetRange("Source Batch Name", "Source Batch Name");
        ReservEntry.SetRange("Source Ref. No.", "Source Ref. No.");
        ReservEntry.SetRange("Source Type", "Source Type");
        ReservEntry.SetRange("Source Subtype", "Source Subtype");
        ReservEntry.SetRange("Source Prod. Order Line", "Source Prod. Order Line");
        ReservEntry.SetRange("Reservation Status", "reservation status"::Reservation);
        ReservEntry.CalcSums("Quantity (Base)", Quantity);
        exit(
          ROUND((ReservEntry."Quantity (Base)" + "Quantity (Base)") / "Qty. per Unit of Measure", 0.00001) -
          ReservEntry.Quantity);
    end;


    procedure ClearApplFromToItemEntry()
    begin
        if Positive then
            "Appl.-to Item Entry" := 0
        else
            "Appl.-from Item Entry" := 0;
    end;
}

