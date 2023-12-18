tableextension 50008 "NV8 Item Ledger Entry" extends "Item Ledger Entry" //32
{
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
        field(68056; "NV8 Jumbo Raw Material Status"; Option)
        {
            CalcFormula = lookup("Configurator Material-Grits"."Set Raw Material Status" where("Material Code" = field(Material),
                                                                                                "Grit Code" = field(Grit)));
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = Normal,Low,"Jumbo Out",Out,Discontinued;
        }
        field(68070; "NV8 Process Location"; Option)
        {
            CalcFormula = lookup("Production Order"."Process Location" where("No." = field("Order No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Waiting For Material,Ready To Allocate,Allocation,Slitting,External Contractor,,,,,,,,,,,,Partial,Green,Finished,Closed';
            OptionMembers = " ","Waiting For Material","Ready To Allocate",Allocation,Slitting,"External Contractor",,,,,,,,,,,,Partial,Green,Finished,Closed;
        }
        field(68100; "NV8 Floor Quantity"; Decimal)
        {
            CalcFormula = sum("Allocation Entry".Quantity where("Initial Item Ledger Entry No." = field("Entry No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68101; "NV8 Allocation ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(68102; "NV8 Allocated MFG"; Integer)
        {
            CalcFormula = count("Allocation Entry" where("Item Ledger Entry No." = field("Allocation ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68103; "NV8 Allocated UNY"; Integer)
        {
            CalcFormula = count("Allocation Entry" where("Item Ledger Entry No." = field("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(68110; "NV8 Roll ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(68111; "NV8 PIN"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(68115; "NV8 Multi Roll ID"; Integer)
        {
            TableRelation = "Item Ledger Entry";
            DataClassification = CustomerContent;
        }
        field(68120; "NV8 Pack Size"; Option)
        {
            OptionMembers = " ",,,"3",,"5",,,,,"10";
            DataClassification = CustomerContent;
        }
        field(68900; "NV8 OldInv"; Boolean)
        {
            Description = 'Entries prior to 2012 valuation';
            DataClassification = CustomerContent;
        }
        field(68901; "NV8 OldRes"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(68910; "NV8 Phy. Inv Error"; Option)
        {
            Description = ' ,Good,Low,High,Unknown,Changed';
            OptionCaption = ' ,Good,Low,High,Unknown,Changed';
            OptionMembers = " ",Good,Low,High,Unknown,Changed;
            DataClassification = CustomerContent;
        }
        field(71000; "NV8 Lot Group No. Series"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(84011; "NV8 Bin Type"; Option)
        {
            OptionMembers = PutAway,Staging,Inactive;
            DataClassification = CustomerContent;
        }
        field(85000; "NV8 Customer Name"; Text[30])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Source No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85001; "NV8 Customer Supply Location"; Code[20])
        {
            CalcFormula = lookup(Customer."Location Code" where("No." = field("Source No.")));
            FieldClass = FlowField;
            TableRelation = Location;
        }
        field(85003; "NV8 Skid No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(85005; "NV8 Vendor Name"; Text[30])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Source No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85006; "NV8 Transfer-Ship-From Name"; Text[50])
        {
            CalcFormula = lookup("Transfer Shipment Header"."Transfer-from Name" where("Transfer-from Code" = field("Location Code")));
            Description = 'UE-476';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85007; "NV8 Transfer-Ship-To Name"; Text[50])
        {
            CalcFormula = lookup("Transfer Shipment Header"."Transfer-to Name" where("Transfer-to Code" = field("Transfer-To Locaiton Code")));
            Description = 'UE-476';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85008; "NV8 Item Description"; Text[50])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Description = 'UE-MDFIX';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85009; "NV8 Item Source"; Text[50])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Source No.")));
            Description = 'UE-MDFIX';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85010; "NV8 Created From Document Type"; Option)
        {
            CalcFormula = lookup("Production Order"."Created From Document Type" where("No." = field("Order No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Sales Order,Sales Invoice,,,,Transfer Order';
            OptionMembers = " ","Sales Order","Sales Invoice",,,,"Transfer Order";
        }
        field(85011; "NV8 Created From Document No."; Code[20])
        {
            CalcFormula = lookup("Production Order"."Created From Document No." where("No." = field("Order No.")));
            FieldClass = FlowField;
            Numeric = false;
        }
        field(85012; "NV8 Created From Line No."; Integer)
        {
            CalcFormula = lookup("Production Order"."Created From Line No." where("No." = field("Order No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85015; "NV8 Item Description 2"; Text[50])
        {
            CalcFormula = lookup(Item."Description 2" where("No." = field("Item No.")));
            Description = 'UE-UE-651';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85016; "NV8 Jumbo Prod. Order"; Code[20])
        {
            TableRelation = "Production Order"."No." where(Status = const(Released));
            DataClassification = CustomerContent;
        }
        field(85017; "NV8 Jumbo Prod. Order Line No."; Integer)
        {
            TableRelation = "Prod. Order Line"."Line No." where(Status = const(Released),
                                                                 "Prod. Order No." = field("Jumbo Prod. Order"));
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
            TableRelation = "Bin Location".Code where("Location Code" = field("Location Code"));
            DataClassification = CustomerContent;
        }
        field(85021; "NV8 FIFO Code"; Code[7])
        {
            DataClassification = CustomerContent;
        }
        field(85022; "NV8 FIFO Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "FIFO Code" := AGGetFIFOCode("FIFO Date");
            end;
        }
        field(85023; "NV8 Sales Shipping Date"; Date)
        {
            CalcFormula = lookup("Sales Shipment Header"."Shipment Date" where("No." = field("Document No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "FIFO Code" := AGGetFIFOCode("FIFO Date");
            end;
        }
        field(85024; "NV8 Transfer Shipping Date"; Date)
        {
            CalcFormula = lookup("Transfer Shipment Header"."Shipment Date" where("No." = field("Document No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "FIFO Code" := AGGetFIFOCode("FIFO Date");
            end;
        }
        field(85025; "NV8 Transfer Receiving Date"; Date)
        {
            CalcFormula = lookup("Transfer Receipt Header"."Shipment Date" where("No." = field("Document No.")));
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                "FIFO Code" := AGGetFIFOCode("FIFO Date");
            end;
        }
        field(85027; "NV8 Jumbo Allowed Bin"; Boolean)
        {
            BlankZero = true;
            CalcFormula = lookup("Bin Location"."Jumbo Pull Not Required" where("Location Code" = field("Location Code"),
                                                                                 Code = field("Bin Location")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85030; "NV8 Original Box Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            MinValue = 0;
            DataClassification = CustomerContent;
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
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdatePieces;
            end;
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Temp: Integer;
            begin
                Temp := ROUND("Unit Width Inches", 1, '<') * 100;
                Temp := Temp + ROUND((("Unit Width Inches" MOD 1) * 64), 1, '<');

                Validate("Unit Width Code", Format(Temp, 5, '<integer>'));
            end;
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'Error on decimals';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Unit Length Inches" := ROUND("Unit Length meters" * 39, 0.00001);
                UpdatePieces;
            end;
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'Error on decimals';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Unit Length meters" := ROUND("Unit Length Inches" / 39, 0.00001);
                UpdatePieces;
            end;
        }
        field(85054; "NV8 Unit Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'Width / 36 x Length Error on decimals';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85055; "NV8 Unit Width Code"; Code[10])
        {
            CharAllowed = '09';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                ConfiguratorSetup.Get;
                ConfiguratorSetup.SetDimLen("Unit Width Code", 5, "Unit Width Code", 0);
                "Unit Width Inches" := ConfiguratorSetup.GetDecimal("Unit Width Code");
                "Unit Width Text" := ConfiguratorSetup.GetDecimalText("Unit Width Code");
                UpdatePieces;
            end;
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
            Description = 'Error on decimals';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField(Pieces);
                Validate("Unit Length meters", ROUND("Total Length meters" / Pieces, 0.00001));
            end;
        }
        field(85059; "NV8 Cost Per meter"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
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
            DecimalPlaces = 2 : 5;
            Description = 'Error on decimals';
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
            Description = 'UE-651';
            DataClassification = CustomerContent;
        }
        field(85067; "NV8 Rem. Area In Bin"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."Remaining Area m2" where(Open = const(true),
                                                                             Positive = const(true),
                                                                             "Location Code" = field("Location Code"),
                                                                             "Bin Location" = field("Bin Location")));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85068; "NV8 No. Of Bins"; Integer)
        {
            BlankZero = true;
            CalcFormula = count("Item Ledger Entry" where(Open = const(true),
                                                           Positive = const(true),
                                                           "Item No." = field("Item No."),
                                                           "Location Code" = field("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85069; "NV8 Allocator Comment"; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(85090; "NV8 Consignment Location"; Code[10])
        {
            CalcFormula = lookup("Transfer Shipment Header"."Transfer-to Code" where("No." = field("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85091; "NV8 Consignment Customer"; Code[20])
        {
            CalcFormula = lookup(Location."Consignment Customer Code" where(Code = field("Consignment Location")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Customer;
        }
        field(85092; "NV8 Consignment Reconciled"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85094; "NV8 Sales Price UEI"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 4;
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(85098; "NV8 Sales Reps (All)"; Code[50])
        {
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                SalesReps: Record "Salesperson/Purchaser";
            begin
                SalesReps.Reset();
                //SalesReps.SETFILTER(Code,STRSUBSTNO('%1',"Sales Reps (All)"));
                Page.RunModal(0, SalesReps);
            end;
        }
        field(85100; "NV8 Configurator No."; Code[100])
        {
            TableRelation = "Configurator Item";
            DataClassification = CustomerContent;
        }
        field(85110; "NV8 Shape"; Code[10])
        {
            TableRelation = "Configurator Shape";
            DataClassification = CustomerContent;
        }
        field(85120; "NV8 Material"; Code[10])
        {
            TableRelation = "Configurator Material";
            DataClassification = CustomerContent;
        }
        field(85121; "NV8 Original Material"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(85122; "NV8 Subst. Material"; Code[10])
        {
            TableRelation = "Configurator Material";
            DataClassification = CustomerContent;
        }
        field(85170; "NV8 Specification"; Code[10])
        {
            TableRelation = "Configurator Specification";
            DataClassification = CustomerContent;
        }
        field(85180; "NV8 Grit"; Code[10])
        {
            TableRelation = "Configurator Grit";
            DataClassification = CustomerContent;
        }
        field(85190; "NV8 Joint"; Code[10])
        {
            TableRelation = "Configurator Joint";
            DataClassification = CustomerContent;
        }
        field(85200; "NV8 Economy Material"; Code[10])
        {
            TableRelation = "Configurator Material";
            DataClassification = CustomerContent;
        }
        field(85201; "NV8 PO No."; Code[20])
        {
            CalcFormula = lookup("Purch. Rcpt. Header"."Order No." where("No." = field("Document No."),
                                                                          "Posting Date" = field("Posting Date")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85300; "NV8 Re-Cut"; Boolean)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Re-Cut" then begin
                    TestField("Remaining Quantity");
                    TestField(Positive, true);
                    "Re-Cut No." := UserId;
                    CalcFields("Reserved Quantity");
                    "Re-Cut Quantity" := "Remaining Quantity" - "Reserved Quantity";
                    "Re-Cut Pieces" := "Remaining Pieces";
                    "Re-Cut Width Inches" := "Unit Width Inches";
                    "Re-Cut Length Inches" := "Unit Length Inches";
                end else begin
                    "Re-Cut No." := '';
                    "Re-Cut Quantity" := 0;
                    "Re-Cut Pieces" := 0;
                    "Re-Cut Width Inches" := 0;
                    "Re-Cut Length Inches" := 0;
                end;
            end;
        }
        field(85301; "NV8 Re-Cut No."; Code[20])
        {
            TableRelation = User;
            DataClassification = CustomerContent;
        }
        field(85302; "NV8 Re-Cut Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(85303; "NV8 Re-Cut Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(85306; "NV8 Re-Cut Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Temp: Integer;
            begin
            end;
        }
        field(85308; "NV8 Re-Cut Length Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(85310; "NV8 Yield Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(85311; "NV8 Yield Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(85320; "NV8 Locked for Allocation"; Boolean)
        {
            CalcFormula = exist("Roll Allocator Line" where("Item Ledger Entry No." = field("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85321; "NV8 Allocated Quantity"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Roll Allocator Line"."Allocated Quantity" where("Item Ledger Entry No." = field("Entry No."),
                                                                                "Line No." = filter(> 0)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85322; "NV8 Allocated On"; Date)
        {
            CalcFormula = lookup("Roll Allocator Line"."Allocated On" where("Item Ledger Entry No." = field("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85323; "NV8 Allocated By"; Code[20])
        {
            CalcFormula = lookup("Roll Allocator Line"."Allocated By" where("Item Ledger Entry No." = field("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = User;
        }
        field(85325; "NV8 Allocated for Type"; Option)
        {
            OptionMembers = " ","Sale Order","Transfer Order";
            DataClassification = CustomerContent;
        }
        field(85326; "NV8 Allocated for Code"; Code[20])
        {
            TableRelation = if ("Allocated for Type" = const("Sale Order")) Customer."No."
            else
            if ("Allocated for Type" = const("Transfer Order")) Location.Code;
            DataClassification = CustomerContent;
        }
        field(85328; "NV8 Allocated for Order No"; Code[20])
        {
            TableRelation = if ("Allocated for Type" = const("Sale Order")) "Sales Header"."No." where("Document Type" = const(Order))
            else
            if ("Allocated for Type" = const("Transfer Order")) "Transfer Header"."No.";
            DataClassification = CustomerContent;
        }
        field(85410; "NV8 Split Roll"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85411; "NV8 Split Pieces"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Split Roll Details".Pieces where("Prod. Order No." = field("Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces;
            end;
        }
        field(85412; "NV8 Split Total Length meters"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Split Roll Details"."Total Length meters" where("Prod. Order No." = field("Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces;
            end;
        }
        field(85413; "NV8 Split Total Area m2"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Split Roll Details"."Total Area m2" where("Prod. Order No." = field("Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces;
            end;
        }
        field(85420; "NV8 Shipped Split Pieces"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Split Roll Details".Pieces where("Shipment No." = field("Document No."),
                                                                 "Item No." = field("Item No."),
                                                                 "Unit Width Code" = field("Unit Width Code")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                UpdatePieces;
            end;
        }
        field(85511; "FG Cost ($/UOM)"; Decimal)
        {
            CalcFormula = lookup(Item."FG Cost (/UOM)" where("No." = field("Item No.")));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(85550; "NV8 Found Partial Box"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85551; "NV8 Phys. Posting Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(90001; "NV8 Lot Group Code"; Code[20])
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
        }
        field(90002; "NV8 Lot Bin Code"; Code[20])
        {
            CalcFormula = lookup("Warehouse Entry"."Bin Code" where("Item No." = field("Item No."),
                                                                     "Lot No." = field("Lot No."),
                                                                     "Lot Open in Bin" = const(true)));
            Description = 'UE-407,changed 10 - 20 to match bin table DC062917';
            FieldClass = FlowField;
        }
        field(90003; "NV8 Exclude From Raw Mat Status"; Boolean)
        {
            CalcFormula = lookup(Bin."Exclude from RAW Mat Status" where("Location Code" = field("Location Code"),
                                                                          Code = field("Lot Bin Code")));
            Description = 'UNE-202';
            FieldClass = FlowField;
        }
    }
}
