Table 50011 "NV8 Split Roll Details"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Status; Option)
        {
            OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished;
        }
        field(2; "Prod. Order No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "Production Order"."No.";
        }
        field(3; "Line No."; Integer)
        {
            NotBlank = true;
        }
        field(4; "Entry No."; Integer)
        {
        }
        field(5; "Usage Type"; Option)
        {
            OptionMembers = " ","Sales Order","Sales Invoice",,,,"Transfer Order";
        }
        field(6; "Document No."; Code[20])
        {
            Description = '20';
            TableRelation = if ("Usage Type" = const("Sales Order")) "Sales Header"."No." where("Document Type" = const(Order))
            else
            if ("Usage Type" = const("Transfer Order")) "Transfer Header"."No.";
        }
        field(7; "Document Line No."; Integer)
        {
            TableRelation = if ("Usage Type" = const("Sales Order")) "Sales Line"."Line No." where("Document Type" = const(Order),
                                                                                                  "Document No." = field("Document No."))
            else
            if ("Usage Type" = const("Transfer Order")) "Transfer Line"."Line No." where("Document No." = field("Prod. Order No."));
        }
        field(10; Description; Text[30])
        {
        }
        field(11; "Description 2"; Text[30])
        {
        }
        field(100; "Item No."; Code[20])
        {
            Editable = false;
            TableRelation = Item;
        }
        field(102; "Location Code"; Code[10])
        {
            Editable = false;
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(103; "Shipment Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(200; Shipped; Boolean)
        {
        }
        field(201; "Invoiced or Received"; Boolean)
        {
        }
        field(210; "Ship Type"; Option)
        {
            OptionMembers = " ",Sales,,,,,Transfer;
        }
        field(212; "Shipment No."; Code[20])
        {
            Description = '20';
            TableRelation = if ("Ship Type" = const(Sales)) "Sales Shipment Header"."No."
            else
            if ("Ship Type" = const(Transfer)) "Transfer Shipment Header"."No.";
        }
        field(213; "Shipment Line No."; Integer)
        {
            TableRelation = if ("Ship Type" = const(Sales)) "Sales Shipment Line"."Line No." where("Document No." = field("Shipment No."))
            else
            if ("Ship Type" = const(Transfer)) "Transfer Shipment Line"."Line No." where("Document No." = field("Shipment No."));
        }
        field(220; "Invoice or Receipt No."; Code[20])
        {
            Description = '20';
            TableRelation = if ("Ship Type" = const(Sales)) "Sales Invoice Header"."No."
            else
            if ("Ship Type" = const(Transfer)) "Transfer Receipt Header"."No.";
        }
        field(10050; "Original Pieces"; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup("Production Order"."NV8 Pieces" where("No." = field("Prod. Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(10051; "Original Width Inches"; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup("Production Order"."NV8 Unit Width Inches" where("No." = field("Prod. Order No.")));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(10058; "Original Total Length Meters"; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup("Production Order"."NV8 Total Length meters" where("No." = field("Prod. Order No.")));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(10064; "Original Total M2"; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup("Production Order"."NV8 Total Area m2" where("No." = field("Prod. Order No.")));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(10150; "Split Pieces"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details".Pieces where("Prod. Order No." = field("Prod. Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(10151; "Split Width Inches"; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup("NV8 Split Roll Details"."Unit Width Inches" where("Prod. Order No." = field("Prod. Order No.")));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(10158; "Split Total Length Meters"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details"."Total Length meters" where("Prod. Order No." = field("Prod. Order No.")));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(10164; "Split Total M2"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details"."Total Area m2" where("Prod. Order No." = field("Prod. Order No.")));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(10250; "Rem. Split Pieces"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details".Pieces where("Prod. Order No." = field("Prod. Order No."),
                                                                 Shipped = const(false)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(10251; "Rem. Split Width Inches"; Decimal)
        {
            BlankZero = true;
            CalcFormula = lookup("NV8 Split Roll Details"."Unit Width Inches" where("Prod. Order No." = field("Prod. Order No."),
                                                                                 Shipped = const(false)));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(10258; "Rem. Split Total Length Meters"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details"."Total Length meters" where("Prod. Order No." = field("Prod. Order No."),
                                                                                Shipped = const(false)));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
        }
        field(10264; "Rem. Split Total M2"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details"."Total Area m2" where("Prod. Order No." = field("Prod. Order No."),
                                                                          Shipped = const(false)));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces();
            end;
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

            trigger OnValidate()
            begin
                "Unit Length meters" := ROUND("Unit Length Inches" / 39, 0.00001);
                UpdatePieces();
            end;
        }
        field(85054; "Unit Area m2"; Decimal)
        {
            BlankZero = true;
            Description = 'Width / 36 x Length';
            Editable = false;
        }
        field(85055; "Unit Width Code"; Code[10])
        {
            CharAllowed = '09';

            trigger OnValidate()
            begin
                ConfiguratorSetup.Get;
                ConfiguratorSetup.SetDimLen("Unit Width Code", 5, "Unit Width Code", 0);
                "Unit Width Inches" := ConfiguratorSetup.GetDecimal("Unit Width Code");
                "Unit Width Text" := ConfiguratorSetup.GetDecimalText("Unit Width Code");
                // IF "Unit Width Inches" <> 0 THEN
                //   VALIDATE("Unit Cost","Cost Per meter" / "Unit Width Inches" * 39);
                UpdatePieces();
            end;
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
        field(85064; "Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
        }
        field(85100; "Configurator No."; Code[100])
        {
            TableRelation = "NV8 Configurator Item" where(Status = filter(Item .. "Valid Item"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1; "Prod. Order No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Entry No.")
        {
        }
        key(Key3; Status)
        {
        }
        key(Key4; "Usage Type", "Document No.", "Document Line No.")
        {
        }
        key(Key5; Shipped)
        {
        }
        key(Key6; "Shipment No.", "Item No.", "Unit Width Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Item: Record Item;
        ProdOrder: Record "Production Order";
        ConfiguratorSetup: Record "NV8 Configurator Setup";
        ConfiguratorItem: Record "NV8 Configurator Item";
        ConfiguratorShape: Record "NV8 Configurator Shape";
        ConfiguratorMaterial: Record "NV8 Configurator Material";
        ConfiguratorJoint: Record "NV8 Configurator Joint";
        ConfiguratorGrit: Record "NV8 Configurator Grit";
        ConfiguratorMaterialGrit: Record "NV8 Config Material-Grits";
        Temp: Integer;


    procedure UpdateConfiguration()
    begin
    end;


    procedure UpdatePieces()
    begin
        UpdateConfiguration();
        "Unit Area m2" := ROUND("Unit Width Inches" * "Unit Length meters" / 39, 0.00001);
        "Total Area m2" := Pieces * "Unit Area m2";
        "Total Length meters" := Pieces * "Unit Length meters";
    end;


    procedure GetProdOrder()
    begin
        ProdOrder.Reset();
        ProdOrder.SetRange("No.", "Prod. Order No.");
        ProdOrder.Find('-');
        Status := ProdOrder.Status;

        "Usage Type" := ProdOrder."NV8 Created From Document Type";
        "Document No." := ProdOrder."NV8 Created From Document No.";
        "Document Line No." := ProdOrder."NV8 Created From Line No.";
        "Item No." := ProdOrder."Source No.";
        "Location Code" := ProdOrder."Location Code";
        "Shipment Date" := ProdOrder."Due Date";
    end;


    procedure SetupNewLine()
    begin
        if "Prod. Order No." = '' then
            exit;
        GetProdOrder();
        Validate("Unit Width Code", ProdOrder."NV8 Unit Width Code");
    end;


    procedure SetSalesShipment(var ShipmentLine: Record "Sales Shipment Line")
    var
        NextEntryNo: Integer;
    begin
        Reset();
        SetCurrentkey("Prod. Order No.");
        SetRange("Prod. Order No.", ShipmentLine."NV8 Production Order No.");
        SetRange(Shipped, false);
        if not Find('-') then
            exit;
        NextEntryNo := GetLastEntryNo();
        repeat
            NextEntryNo += 1;
            "Entry No." := NextEntryNo;
            "Item No." := ShipmentLine."No.";
            "Location Code" := ShipmentLine."Location Code";
            "Shipment Date" := ShipmentLine."Shipment Date";
            Shipped := true;
            "Ship Type" := "ship type"::Sales;
            "Shipment No." := ShipmentLine."Document No.";
            "Shipment Line No." := ShipmentLine."Line No.";
            Modify();
        until Next() = 0;
    end;


    procedure SetTransferShipment(var ShipmentLine: Record "Transfer Shipment Line")
    var
        NextEntryNo: Integer;
    begin
        Reset();
        SetCurrentkey("Prod. Order No.");
        SetRange("Prod. Order No.", ShipmentLine."NV8 Production Order No.");
        SetRange(Shipped, false);
        if not Find('-') then
            exit;
        NextEntryNo := GetLastEntryNo();
        repeat
            NextEntryNo += 1;
            "Entry No." := NextEntryNo;
            "Item No." := ShipmentLine."Item No.";
            "Location Code" := ShipmentLine."Transfer-from Code";
            "Shipment Date" := ShipmentLine."Shipment Date";
            Shipped := true;
            "Ship Type" := "ship type"::Transfer;
            "Shipment No." := ShipmentLine."Document No.";
            "Shipment Line No." := ShipmentLine."Line No.";
            Modify();
        until Next() = 0;
    end;


    procedure GetLastEntryNo(): Integer
    var
        SplitRollLine: Record "NV8 Split Roll Details";
    begin
        with SplitRollLine do begin
            Reset();
            SetCurrentkey("Entry No.");
            if Find('+') then
                exit("Entry No.")
            else
                exit(0);
        end;
    end;


    procedure SetSalesInvoice(var ShipmentLine: Record "Sales Invoice Line")
    var
        NextEntryNo: Integer;
    begin
        Reset();
        SetCurrentkey("Prod. Order No.");
        SetRange("Prod. Order No.", ShipmentLine."NV8 Production Order No.");
        SetRange("Invoiced or Received", false);
        if not Find('-') then
            exit;
        NextEntryNo := GetLastEntryNo();
        repeat
            NextEntryNo += 1;
            "Entry No." := NextEntryNo;
            "Invoiced or Received" := true;
            "Invoice or Receipt No." := ShipmentLine."Document No.";
            Modify();
        until Next() = 0;
    end;


    procedure SetTransferReceipt(var ShipmentLine: Record "Transfer Receipt Line")
    var
        NextEntryNo: Integer;
    begin
        Reset();
        SetCurrentkey("Prod. Order No.");
        SetRange("Prod. Order No.", ShipmentLine."NV8 Production Order No.");
        SetRange(Shipped, false);
        if not Find('-') then
            exit;
        NextEntryNo := GetLastEntryNo();
        repeat
            NextEntryNo += 1;
            "Entry No." := NextEntryNo;
            "Invoiced or Received" := true;
            "Invoice or Receipt No." := ShipmentLine."Document No.";
            Modify();
        until Next() = 0;
    end;
}

