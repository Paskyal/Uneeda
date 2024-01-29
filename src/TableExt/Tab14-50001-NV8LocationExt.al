tableextension 50001 "NV8 Location" extends Location //14
{
    fields
    {
        field(50000; "NV8 Consignment Location"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Consignment Location';
        }
        field(50001; "NV8 Consignment Customer Code"; Code[20])
        {
            Description = 'EC1.SAL1.01';
            TableRelation = Customer;
            DataClassification = CustomerContent;
            Caption = 'Consignment Customer Code';
            trigger OnValidate()
            var
                Cust: Record Customer;
            begin
                //EC1.SAL1.01
                if Cust.Get(xRec."NV8 Consignment Customer Code") then begin
                    Cust."NV8 Consignment Location Code" := '';
                    Cust."NV8 Consignment Customer" := false;
                    Cust.Modify();
                end;
                "NV8 Consignment Location" :=
                  Cust.Get("NV8 Consignment Customer Code");
                if "NV8 Consignment Location" then begin
                    Cust."NV8 Consignment Location Code" := Code;
                    Cust."NV8 Consignment Customer" := true;
                    Cust.Modify();
                    "NV8 Salesperson Code" := Cust."Salesperson Code";
                end else
                    "NV8 Salesperson Code" := '';

                //EC1.SAL1.01
            end;
        }
        field(50002; "NV8 Contract Expiry Date"; Date)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Contract Expiry Date';
        }
        field(50003; "NV8 Salesperson Code"; Code[20]) //PAP was 10
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
            DataClassification = CustomerContent;
            Caption = 'Salesperson Code';
        }
        field(50004; "NV8 Def. SKU Reordering Policy"; Option)
        {
            Description = 'EC VAR003';
            OptionCaption = ' ,Fixed Reorder Qty,Maximum Qty,Order,Lot-for-Lot';
            OptionMembers = " ","Fixed Reorder Qty","Maximum Qty","Order","Lot-for-Lot";
            DataClassification = CustomerContent;
            Caption = 'Def. SKU Reordering Policy';
        }
        field(50006; "NV8 Create SKU's"; Boolean)
        {
            Description = 'EC VAR003';
            DataClassification = CustomerContent;
            Caption = 'Create SKU''s';
        }
        field(50007; "NV8 Def. SKU Replenishment Sys"; Option)
        {
            Description = 'EC VAR003';
            InitValue = Transfer;
            OptionCaption = 'Purchase,Prod. Order,Transfer,Assembly';
            OptionMembers = Purchase,"Prod. Order",Transfer,Assembly;
            DataClassification = CustomerContent;
            Caption = 'Def. SKU Replenishment Sys';
        }
        field(50008; "NV8 Def.SKU Transfer-from Code"; Code[10])
        {
            Description = 'EC VAR003';
            TableRelation = Location where("Use As In-Transit" = const(false));
            DataClassification = CustomerContent;
            Caption = 'Def.SKU Transfer-from Code';
            trigger OnValidate()
            begin
                //>> VAR003
                TestField("NV8 Def. SKU Replenishment Sys", "NV8 Def. SKU Replenishment Sys"::Transfer);
                if "NV8 Def.SKU Transfer-from Code" = Code then
                    Error('Transfer from Code cannot equal %1', Code);
                //<< VAR003
                //>>EC-Jira119
                if "NV8 Def. SKU Replenishment Sys" <> "NV8 Def. SKU Replenishment Sys"::Transfer then
                    "NV8 Def.SKU Transfer-from Code" := '';
                //<< EC-Jira119
            end;
        }
        field(50012; "NV8 Floor Zone Filter"; Code[250])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = Zone.Code where("Location Code" = field(Code));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Floor Zone Filter';
        }
        field(50013; "NV8 Warehouse Zone Filter"; Code[250])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = Zone.Code where("Location Code" = field(Code));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Warehouse Zone Filter';
        }
        field(68102; "NV8 Bulk Ship"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Bulk Ship';
        }
        field(68110; "NV8 Sec. Territory Code"; Code[10])
        {
            TableRelation = Territory;
            DataClassification = CustomerContent;
            Caption = 'Sec. Territory Code';
        }
        field(68120; "NV8 Allocator Bus. Posting Gr"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
        field(68200; "NV8 Manufacturing Allowed"; Boolean)
        {
            Description = 'EC1.MISC4.01';
            DataClassification = CustomerContent;
            Caption = 'Manufacturing Allowed';
        }
        field(68201; "NV8 Consumption Allowed"; Boolean)
        {
            Description = 'EC1.MISC4.01';
            DataClassification = CustomerContent;
            Caption = 'Consumption Allowed';
        }
        field(85000; "NV8 Item Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Item;
            Caption = 'Item Filter';
        }
        field(85001; "NV8 Date Filter 1"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Filter 1';
        }
        field(85002; "NV8 Date Filter 2"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Filter 2';
        }
        field(85003; "NV8 Date Filter 3"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Filter 3';
        }
        field(85010; "NV8 Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
            Caption = 'Type Filter';
        }
        field(85011; "NV8 Quantity 1"; Decimal)
        {
            BlankZero = true;
            CalcFormula = - sum("Item Ledger Entry".Quantity where("Entry Type" = field("NV8 Type Filter"),
                                                                   "Item No." = field("NV8 Item Filter"),
                                                                   "Location Code" = field(Code),
                                                                   "Location Code" = field(filter("NV8 Totaling")),
                                                                   "Posting Date" = field("NV8 Date Filter 1")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Quantity 1';
        }
        field(85012; "NV8 Quantity 2"; Decimal)
        {
            BlankZero = true;
            CalcFormula = - sum("Item Ledger Entry".Quantity where("Entry Type" = field("NV8 Type Filter"),
                                                                   "Item No." = field("NV8 Item Filter"),
                                                                   "Location Code" = field(Code),
                                                                   "Location Code" = field(filter("NV8 Totaling")),
                                                                   "Posting Date" = field("NV8 Date Filter 2")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Quantity 2';
        }
        field(85013; "NV8 Quantity 3"; Decimal)
        {
            BlankZero = true;
            CalcFormula = - sum("Item Ledger Entry".Quantity where("Entry Type" = field("NV8 Type Filter"),
                                                                   "Item No." = field("NV8 Item Filter"),
                                                                   "Location Code" = field(Code),
                                                                   "Location Code" = field(filter("NV8 Totaling")),
                                                                   "Posting Date" = field("NV8 Date Filter 3")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Quantity 3';
        }
        field(85020; "NV8 Bin Location Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Bin Location Mandatory';
        }
        field(85021; "NV8 Allocation Bin Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation Bin Mandatory';
        }
        field(85022; "NV8 Remnant Bin Code"; Code[20])
        {
            Description = 'UE-499';
            TableRelation = Bin.Code where("Location Code" = field(Code));
            DataClassification = CustomerContent;
            Caption = 'Remnant Bin Code';
        }
        field(85023; "NV8 Allocation  Bin Code"; Code[20])
        {
            Description = 'UE-540';
            TableRelation = Bin.Code where("Location Code" = field(Code));
            DataClassification = CustomerContent;
            Caption = 'Allocation  Bin Code';
        }
        field(85024; "NV8 Allocation Pick No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'UNE-35';
            TableRelation = "No. Series";
            Caption = 'Allocation Pick No. Series';
        }
        field(85025; "NV8 Totaling"; Text[250])
        {
            TableRelation = Location;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Totaling';
        }
        field(85030; "NV8 Cycle Count Rate"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Cycle Count Rate';
        }
        field(85031; "NV8 Last Cycle Count"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Cycle Count';
        }
        field(85040; "NV8 Out Bound Reserve"; Option)
        {
            InitValue = Optional;
            OptionCaption = 'Never,Optional,Always';
            OptionMembers = Never,Optional,Always;
            DataClassification = CustomerContent;
            Caption = 'Out Bound Reserve';
        }
        field(85057; "NV8 Sales Reps (All)"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Reps (All)';
            trigger OnLookup()
            var
                SalesReps: Record "Salesperson/Purchaser";
                SalesRepsAllLbl: Label '%1', Comment = '%1="NV8 Sales Reps (All)"';
            begin
                SalesReps.Reset();
                SalesReps.SetFilter(Code, StrSubstNo(SalesRepsAllLbl, "NV8 Sales Reps (All)"));
                if Action::LookupOK = Page.RunModal(0, SalesReps) then
                  ;
            end;
        }
        field(85062; "NV8 Meters on Hand"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Remaining Length meters" where("Item No." = field("NV8 Item Filter"),
                                                                                   "Location Code" = field(Code),
                                                                                   "Location Code" = field(filter("NV8 Totaling"))));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Meters on Hand';
        }
        field(85064; "NV8 Jumbo Meters on Hand"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Remaining Length meters" where("Item No." = field("NV8 Item Filter"),
                                                                                   "Location Code" = field(Code),
                                                                                   "Location Code" = field(filter("NV8 Totaling")),
                                                                                   "NV8 Material Type" = const(Jumbo)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Jumbo Meters on Hand';
        }
        field(85100; "NV8 Reserved Quantity"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Reservation Entry"."Quantity (Base)" where("Reservation Status" = const(Reservation),
                                                                           "Item No." = field("NV8 Item Filter"),
                                                                           "Location Code" = field(Code),
                                                                           "Location Code" = field(filter("NV8 Totaling")),
                                                                           Positive = const(true)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Reserved Quantity';
        }
        field(85101; "NV8 Qty. on Prod. Order"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Prod. Order Line"."Remaining Qty. (Base)" where(Status = filter(Planned .. Released),
                                                                                "Item No." = field("NV8 Item Filter"),
                                                                                "Location Code" = field(Code),
                                                                                "Location Code" = field(filter("NV8 Totaling"))));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Qty. on Prod. Order';
        }
        field(85120; "NV8 Laste Receipt Date"; Date)
        {
            CalcFormula = max("Transfer Receipt Header"."Posting Date" where("Transfer-to Code" = field(Code)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Laste Receipt Date';
        }
        field(85140; "NV8 Hide Blank Lines"; Boolean)
        {
            InitValue = true;
            DataClassification = CustomerContent;
            Caption = 'Hide Blank Lines';
        }
        field(85150; "NV8 Warehouse Fee %"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Warehouse Fee %';
        }
        field(85160; "NV8 User Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "User Setup";
            Caption = 'User Filter';
        }
        field(85260; "NV8 Include InMin.Qty.Forecast"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Include InMin.Qty.Forecast';
        }
    }
}
