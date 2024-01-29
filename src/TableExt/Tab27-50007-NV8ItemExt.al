tableextension 50007 "NV8 Item" extends Item //27
{
    fields
    {
        field(50000; "NV8 Last Activity Date"; Date)
        {
            CalcFormula = max("Item Ledger Entry"."Posting Date" where("Item No." = field("No."),
                                                                        "Entry Type" = filter(Sale | Transfer),
                                                                        Nonstock = filter(true | false)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Last Activity Date';
        }
        field(50001; "NV8 Standard Material"; Boolean)
        {
            Description = 'Used for running No Material Report # 50524';
            DataClassification = CustomerContent;
            Caption = 'Standard Material';
        }
        field(50002; "NV8 Print Receipt Labels"; Boolean)
        {
            Description = 'EC1.01';
            DataClassification = CustomerContent;
            Caption = 'Print Receipt Labels';
        }
        field(50003; "NV8 Prod. Forecast Quantity"; Decimal)
        {
            CalcFormula = sum("Production Forecast Entry"."Forecast Quantity" where("Item No." = field("No."),
                                                                                     "Production Forecast Name" = field("Production Forecast Name"),
                                                                                     "Forecast Date" = field("Date Filter"),
                                                                                     "Location Code" = field("Location Filter"),
                                                                                     "Component Forecast" = field("Component Forecast")));
            Description = 'EC-Var11';
            FieldClass = FlowField;
            Caption = 'Prod. Forecast Quantity';
        }
        field(50004; "NV8 Cust Stocking Agreements"; Decimal)
        {
            CalcFormula = sum("NV8 Customer Stocking Agr".Quantity where("Item No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Cust Stocking Agreements';
        }
        field(50020; "NV8 Reason Code Filter"; Code[10])
        {
            Description = 'UE-507';
            FieldClass = FlowFilter;
            TableRelation = "Reason Code";
            Caption = 'Reason Code Filter';
        }
        field(50021; "NV8 Sales (Qty.) ILE"; Decimal)
        {
            CalcFormula = - sum("Item Ledger Entry".Quantity where("Entry Type" = const(Sale),
                                                                   "Item No." = field("No."),
                                                                   "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                   "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                   "Location Code" = field("Location Filter"),
                                                                   "Drop Shipment" = field("Drop Shipment Filter"),
                                                                   "Variant Code" = field("Variant Filter"),
                                                                   "Posting Date" = field("Date Filter"),
                                                                   "Lot No." = field("Lot No. Filter"),
                                                                   "Serial No." = field("Serial No. Filter")));
            Caption = 'Sales (Qty.) ILE';
            DecimalPlaces = 0 : 5;
            Description = 'UE-460';
            Editable = false;
            FieldClass = FlowField;
        }
        field(68001; "NV8 Safety stock Formula"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Safety stock Formula';
        }
        field(68002; "NV8 Reorder Point Formula"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Reorder Point Formula';
        }
        field(68003; "NV8 Planning Window Formula"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Planning Window Formula';
        }
        field(68005; "NV8 Def. Safety Stock Formula"; DateFormula)
        {
            CalcFormula = lookup("NV8 Configurator Shape"."Def. Safety Stock Formula" where(Code = field("NV8 Shape")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Def. Safety Stock Formula';
        }
        field(68006; "NV8 Def. Reorder Point Formula"; DateFormula)
        {
            CalcFormula = lookup("NV8 Configurator Shape"."Def. Reorder Point Formula" where(Code = field("NV8 Shape")));
            Description = 'Planning Window';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Def. Reorder Point Formula';
        }
        field(68007; "NV8 Def. Planning Window Formula"; DateFormula)
        {
            CalcFormula = lookup("NV8 Configurator Shape"."Def. Planning Window Formula" where(Code = field("NV8 Shape")));
            Description = 'Planning Window';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Def. Planning Window Formula';
        }
        field(68009; "NV8 Last Planning Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Planning Date';
        }
        field(68020; "NV8 Vendor Classification"; Option)
        {
            Editable = false;
            OptionMembers = " ",A,B,C;
            DataClassification = CustomerContent;
            Caption = 'Vendor Classification';
        }
        field(68021; "NV8 Item Classification"; Option)
        {
            OptionMembers = " ",A,B,C;
            DataClassification = CustomerContent;
            Caption = 'Item Classification';
        }
        field(68022; "NV8 WIP Qty."; Decimal)
        {
            CalcFormula = sum("Prod. Order Line"."Remaining Qty. (Base)" where(Status = filter("Firm Planned" .. Released),
                                                                                "Item No." = field("No."),
                                                                                "Location Code" = field("Location Filter"),
                                                                                "Variant Code" = field("Variant Filter"),
                                                                                "Due Date" = field("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'WIP Qty.';
        }
        field(68023; "NV8 Output Physical"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Entry Type" = const(Output),
                                                                  "Item No." = field("No."),
                                                                  "Location Code" = field("Location Filter"),
                                                                  "Drop Shipment" = field("Drop Shipment Filter"),
                                                                  "Variant Code" = field("Variant Filter"),
                                                                  "Posting Date" = field("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Output Physical';
        }
        field(68025; "NV8 Sales Red Dot"; Boolean)
        {
            CalcFormula = exist("Sales Line" where(Type = const(Item),
                                                    "No." = field("No."),
                                                    "Document Type" = const(Order),
                                                    "Outstanding Quantity" = filter(<> 0)));
            Enabled = false;
            FieldClass = FlowField;
            Caption = 'Sales Red Dot';
        }
        field(68026; "NV8 Transfer Red Dot"; Boolean)
        {
            CalcFormula = exist("Transfer Line" where("Item No." = field("No."),
                                                       "NV8 Red Dot" = const(true),
                                                       "Outstanding Qty. (Base)" = filter(<> 0)));
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
            Caption = 'Transfer Red Dot';
        }
        field(68056; "NV8 Jumbo Raw Material Status"; Option)
        {
            CalcFormula = lookup("NV8 Config Material-Grits"."Set Raw Material Status" where("Material Code" = field("NV8 Material"),
                                                                                                "Grit Code" = field("NV8 Grit")));
            Description = 'UNE-151';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Normal,Low,Jumbo Out,Out,Discontinued';
            OptionMembers = " ",Normal,Low,"Jumbo Out",Out,Discontinued;
            Caption = 'Jumbo Raw Material Status';
        }
        field(68110; "NV8 Sec. Territory Code"; Code[10])
        {
            TableRelation = Territory;
            DataClassification = CustomerContent;
            Caption = 'Sec. Territory Code';
        }
        field(68200; "NV8 Sales Median"; Decimal)
        {
            DecimalPlaces = 4 : 4;
            DataClassification = CustomerContent;
            Caption = 'Sales Median';
        }
        field(68201; "NV8 Sales Max"; Decimal)
        {
            DecimalPlaces = 4 : 4;
            DataClassification = CustomerContent;
            Caption = 'Sales Max';
        }
        field(68202; "NV8 Sales Min"; Decimal)
        {
            DecimalPlaces = 4 : 4;
            DataClassification = CustomerContent;
            Caption = 'Sales Min';
        }
        field(68203; "NV8 Sales Mean"; Decimal)
        {
            DecimalPlaces = 4 : 4;
            DataClassification = CustomerContent;
            Caption = 'Sales Mean';
        }
        field(68204; "NV8 Sales Mode"; Decimal)
        {
            DecimalPlaces = 4 : 4;
            DataClassification = CustomerContent;
            Caption = 'Sales Mode';
        }
        field(68205; "NV8 Web Commerce Status"; Option)
        {
            OptionMembers = "Not Available",Overstocked," Standard";
            DataClassification = CustomerContent;
            Caption = 'Web Commerce Status';
        }
        field(68210; "NV8 Total Sales (Integer)"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Sales (Integer)';
        }
        field(68300; "NV8 Quantity At Date"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                  "Location Code" = field("Location Filter"),
                                                                  "Drop Shipment" = const(false),
                                                                  "Posting Date" = field("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Quantity At Date';
        }
        field(68400; "NV8 Catalog No."; Code[20])
        {
            CalcFormula = lookup("NV8 Item Catalog Table"."Catalog No." where("Item No." = field("No.")));
            Caption = 'Catalog No.';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Item Catalog Table";
        }
        field(75000; "NV8 Item Qty. Usage"; Decimal)
        {
            CalcFormula = - sum("Item Ledger Entry".Quantity where("Item No." = field("No."),
                                                                   "Entry Type" = filter(Sale | Transfer),
                                                                   "Location Code" = field("Location Filter"),
                                                                   Positive = const(false),
                                                                   "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
            Caption = 'Item Qty. Usage';
        }
        field(76000; "NV8 End User Box Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'End User Box Quantity';
        }
        field(76001; "NV8 Distributor Box Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Distributor Box Quantity';
        }
        field(84000; "NV8 Unit Type"; Option)
        {
            OptionMembers = Each,Rolls,"Split Rolls";
            DataClassification = CustomerContent;
            Caption = 'Unit Type';
        }
        field(84002; "NV8 Unit Qty. Avail. In Whse."; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Physically on hand, or allocated to a sales order.';
            Editable = false;
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Unit Qty. Avail. In Whse.';
        }
        field(84003; "NV8 Unit Qty. Avail. To Ship"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Actuall allocated to manufacture or sell';
            Editable = false;
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'Unit Qty. Avail. To Ship';
        }
        field(84004; "NV8 Unit Qty. For Planning"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Used in planning calculations to determine what needs to be produced';
            Editable = false;
            Enabled = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
            Caption = 'Unit Qty. For Planning';
        }
        field(84009; "NV8 Requires Planning"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Requires Planning';
        }
        field(84020; "NV8 On Hand Inventory"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
            Enabled = false;
            DataClassification = CustomerContent;
            Caption = 'On Hand Inventory';
        }
        field(84021; "NV8 Allocated Inventory"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Allocated Inventory';
        }
        field(84022; "NV8 Planned Availability"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Planned Availability';
        }
        field(84023; "NV8 Free Inventory"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Free Inventory';
        }
        field(84052; "NV8 Length m Filter"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            FieldClass = FlowFilter;
            Caption = 'Length m Filter';
        }
        field(84055; "NV8 Width in Filter"; Code[10])
        {
            CharAllowed = '09';
            FieldClass = FlowFilter;
            Caption = 'Width in Filter';
        }
        field(85010; "NV8 Vendor Name"; Text[30])
        {
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Vendor Name';
        }
        field(85015; "NV8 Sales Type"; Option)
        {
            Description = 'UE-462';
            OptionCaption = 'Revenue,Freight,Surcharge,,Other';
            OptionMembers = Revenue,Freight,Surcharge,,Other;
            DataClassification = CustomerContent;
            Caption = 'Sales Type';
        }
        field(85017; "NV8 Exclude From Sales Stats."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Exclude From Sales Stats.';
        }
        field(85020; "NV8 Bin Location Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "NV8 Bin Location".Code where("Location Code" = field("Location Filter"));
            Caption = 'Bin Location Filter';
        }
        field(85021; "NV8 Bin Location Qty."; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where(Open = const(true),
                                                                              Positive = const(true),
                                                                              "Item No." = field("No."),
                                                                              "Location Code" = field("Location Filter"),
                                                                              "NV8 Bin Location" = field("NV8 Bin Location Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Bin Location Qty.';
        }
        field(85025; "NV8 Customer Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Customer;
            Caption = 'Customer Filter';
        }
        field(85026; "NV8 Cust. Forecast Min. Qty."; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
            Caption = 'Cust. Forecast Min. Qty.';
        }
        field(85027; "NV8 Min. Qty. Forecast"; Boolean)
        {
            Editable = false;
            FieldClass = FlowFilter;
            Caption = 'Min. Qty. Forecast';
        }
        field(85030; "NV8 Include in Purchase Forecast"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Include in Purchase Forecast';
        }
        field(85031; "NV8 Do not update Min/max"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Do not update Min/max';
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Width Inches';
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            DecimalPlaces = 2 : 4;
            DataClassification = CustomerContent;
            Caption = 'Unit Length meters';
            trigger OnValidate()
            begin
                //"Unit Length Inches" := ROUND("Unit Length Yards" / 36,0.00001);
                //UpdateArea;
            end;
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Length Inches';
            trigger OnValidate()
            begin
                //"Unit Length Yards" := ROUND("Unit Length Inches" * 36,0.00001);
                //UpdateArea;
            end;
        }
        field(85054; "NV8 Unit Area m2"; Decimal)
        {
            DecimalPlaces = 5 : 5;
            Description = 'Width / 39 x Length';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Unit Area m2';
        }
        field(85060; "NV8 Meters on Purch. Order"; Decimal)
        {//TODO PAP
            // CalcFormula = sum("Purchase Line".Field9586804 where("Document Type" = const(Order),
            //                                                       Type = const(Item),
            //                                                       "No." = field("No."),
            //                                                       "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
            //                                                       "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
            //                                                       "Location Code" = field("Location Filter"),
            //                                                       "Drop Shipment" = field("Drop Shipment Filter"),
            //                                                       "Variant Code" = field("Variant Filter"),
            //                                                       "Bin Code" = field("Bin Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
            Caption = 'Meters on Purch. Order';
        }
        field(85061; "NV8 Meters on Sales Order"; Decimal)
        {
            CalcFormula = sum("Sales Line"."NV8 Total Length meters" where("Document Type" = const(Order),
                                                                        Type = const(Item),
                                                                        "No." = field("No."),
                                                                        "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                        "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                        "Location Code" = field("Location Filter"),
                                                                        "Drop Shipment" = field("Drop Shipment Filter"),
                                                                        "Variant Code" = field("Variant Filter"),
                                                                        "Bin Code" = field("Bin Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Meters on Sales Order';
        }
        field(85062; "NV8 Meters on Hand"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Remaining Length meters" where("Item No." = field("No."),
                                                                                   "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                                   "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                                   "Location Code" = field("Location Filter"),
                                                                                   "Drop Shipment" = field("Drop Shipment Filter"),
                                                                                   "Variant Code" = field("Variant Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Meters on Hand';
        }
        field(85063; "NV8 Rolls on Hand"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Pieces" where("Item No." = field("No."),
                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                "Location Code" = field("Location Filter"),
                                                                "Drop Shipment" = field("Drop Shipment Filter"),
                                                                "Variant Code" = field("Variant Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            Enabled = false;
            FieldClass = FlowField;
            Caption = 'Rolls on Hand';
        }
        field(85064; "NV8 Jumbo Meters on Hand (UNY)"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Unit Length meters" where("Item No." = field("No."),
                                                                              "Location Code" = const('AA-UNY'),
                                                                              "Drop Shipment" = const(false),
                                                                              "Variant Code" = field("Variant Filter"),
                                                                              "NV8 Material Type" = const(Jumbo),
                                                                              Open = filter(true)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Jumbo Meters on Hand (UNY)';
        }
        field(85065; "NV8 Jumbo Rolls on Hand (UNY)"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."NV8 Pieces" where("Item No." = field("No."),
                                                                "Location Code" = const('AA-UNY'),
                                                                "Drop Shipment" = const(false),
                                                                "Variant Code" = field("Variant Filter"),
                                                                "NV8 Material Type" = const(Jumbo),
                                                                Open = filter(true)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Jumbo Rolls on Hand (UNY)';
        }
        field(85066; "NV8 Jumbo Qty. on Hand (UNY)"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry"."Remaining Quantity" where("Item No." = field("No."),
                                                                              "Location Code" = const('AA-UNY'),
                                                                              "Drop Shipment" = const(false),
                                                                              "Variant Code" = field("Variant Filter"),
                                                                              "NV8 Material Type" = const(Jumbo),
                                                                              Open = filter(true)));
            DecimalPlaces = 0 : 5;
            Description = 'UE-327';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Jumbo Qty. on Hand (UNY)';
        }
        field(85067; "NV8 Jumbo Meters on Hand (OCEAN)"; Decimal)
        {
            CalcFormula = sum("Warehouse Entry"."NV8 Unit Length meters" where("Item No." = field("No."),
                                                                            "Bin Code" = const('OCEAN'),
                                                                            "NV8 Material Type" = const(Jumbo),
                                                                            "NV8 Lot Open in Bin" = const(true)));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Jumbo Meters on Hand (OCEAN)';
        }
        field(85068; "NV8 Jumbo Meters on PO"; Decimal)
        {
            CalcFormula = sum("Purchase Line"."Outstanding Quantity" where("Document Type" = const(Order),
                                                                            Type = const(Item),
                                                                            "No." = field("No."),
                                                                            "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                            "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                            "Drop Shipment" = field("Drop Shipment Filter"),
                                                                            "Variant Code" = field("Variant Filter"),
                                                                            "Expected Receipt Date" = field("Date Filter"),
                                                                            "NV8 Shape" = filter('RO' | 'PR' | 'VR')));
            DecimalPlaces = 0 : 0;
            Description = 'UE-287';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Jumbo Meters on PO';
        }
        field(85069; "NV8 Do Not Reserve Length"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Do Not Reserve Length';
        }
        field(85070; "NV8 Jumbo Meters Avail"; Decimal)
        {
            CalcFormula = sum("Warehouse Entry"."NV8 Unit Length meters" where("Item No." = field("No."),
                                                                            "Bin Code" = field("Bin Filter"),
                                                                            "NV8 Lot Open in Bin" = const(true),
                                                                            "Location Code" = field("Location Filter"),
                                                                            "Zone Code" = filter('WHSEDW' | 'WHSEUP' | 'WHSE' | 'REMNANT' | 'WHSEOUT' | 'CLEANUP' | 'PROJECT'),
                                                                            "NV8 Material Type" = const(Jumbo)));
            DecimalPlaces = 0 : 0;
            Description = 'UE-407';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Jumbo Meters Avail';
        }
        field(85071; "NV8 Zone Filter"; Code[10])
        {
            Description = 'UE-407';
            FieldClass = FlowFilter;
            TableRelation = Zone.Code where("Location Code" = field("Location Filter"));
            Caption = 'Zone Filter';
        }
        field(85080; "NV8 Material Sales"; Decimal)
        {
            BlankZero = true;
            CalcFormula = - sum("Item Ledger Entry"."NV8 Total Area m2" where("Entry Type" = const(Sale),
                                                                          "NV8 Material" = field("NV8 Material"),
                                                                          "NV8 Grit" = field("NV8 Grit"),
                                                                          "Posting Date" = field("Date Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Material Sales';
        }
        field(85090; "NV8 Raw Material Obsolete"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Raw Material Obsolete';
        }
        field(85091; "NV8 Raw Material Substitute For"; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
            Caption = 'Raw Material Substitute For';
        }
        field(85096; "NV8 Raw Material Roll"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Raw Material Roll';
        }
        field(85097; "NV8 Material Type"; Option)
        {
            CalcFormula = lookup("NV8 Configurator Material"."Material Type" where(Code = field("NV8 Material")));
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = " ",Paper,Cloth,Combo,Film;
            Caption = 'Material Type';
        }
        field(85100; "NV8 Configurator No."; Code[100])
        {
            TableRelation = "NV8 Configurator Item";
            DataClassification = CustomerContent;
            Caption = 'Configurator No.';
        }
        field(85101; "NV8 File Pro No."; Code[35])
        {
            Description = 'This is for the existing part number in the FIle Pro System';
            DataClassification = CustomerContent;
            Caption = 'File Pro No.';
        }
        field(85110; "NV8 Shape"; Code[10])
        {
            TableRelation = "NV8 Configurator Shape";
            DataClassification = CustomerContent;
            Caption = 'Shape';
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     //>> UE-648
            //     SKU.SetCurrentkey("Item No.", "Location Code", "Variant Code");
            //     SKU.SetRange("Item No.", "No.");
            //     if SKU.FindSet then
            //         repeat
            //             SKU.Shape := Shape;
            //             SKU.Modify;
            //         until SKU.Next = 0;
            //     //<< UE-648
            // end;
        }
        field(85111; "NV8 Shape Production Area"; Code[20])
        {
            CalcFormula = lookup("NV8 Configurator Shape"."Shape Production Area" where(Code = field("NV8 Shape")));
            Description = 'UNE-174';
            FieldClass = FlowField;
            TableRelation = "NV8 Shape Production Area";
            Caption = 'Shape Production Area';
        }
        field(85120; "NV8 Material"; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
            DataClassification = CustomerContent;
            Caption = 'Material';
        }
        field(85130; "NV8 Dimension 1"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 1';
        }
        field(85132; "NV8 Quantity 1"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Quantity 1';
        }
        field(85133; "NV8 UOM 1"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));
            DataClassification = CustomerContent;
            Caption = 'UOM 1';

            // TODO PAP
            // trigger OnValidate()
            // begin
            //     TestNoOpenEntriesExist(FieldCaption("Base Unit of Measure"));

            //     "Sales Unit of Measure" := "Base Unit of Measure";
            //     "Purch. Unit of Measure" := "Base Unit of Measure";
            //     if "Base Unit of Measure" <> '' then begin
            //         ItemUnitOfMeasure.Get("No.", "Base Unit of Measure");
            //         ItemUnitOfMeasure.TestField("Qty. per Unit of Measure", 1);
            //     end;
            //     if CurrFieldNo <> 0 then
            //         Modify(true);
            // end;
        }
        field(85140; "NV8 Dimension 2"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 2';
        }
        field(85142; "NV8 Quantity 2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Quantity 2';
        }
        field(85143; "NV8 UOM 2"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));
            DataClassification = CustomerContent;
            Caption = 'UOM 2';
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     TestNoOpenEntriesExist(FieldCaption("Base Unit of Measure"));

            //     "Sales Unit of Measure" := "Base Unit of Measure";
            //     "Purch. Unit of Measure" := "Base Unit of Measure";
            //     if "Base Unit of Measure" <> '' then begin
            //         ItemUnitOfMeasure.Get("No.", "Base Unit of Measure");
            //         ItemUnitOfMeasure.TestField("Qty. per Unit of Measure", 1);
            //     end;
            //     if CurrFieldNo <> 0 then
            //         Modify(true);
            // end;
        }
        field(85150; "NV8 Dimension 3"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 3';
        }
        field(85152; "NV8 Quantity 3"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Quantity 3';
        }
        field(85153; "NV8 UOM 3"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));
            DataClassification = CustomerContent;
            Caption = 'UOM 3';
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     TestNoOpenEntriesExist(FieldCaption("Base Unit of Measure"));

            //     "Sales Unit of Measure" := "Base Unit of Measure";
            //     "Purch. Unit of Measure" := "Base Unit of Measure";
            //     if "Base Unit of Measure" <> '' then begin
            //         ItemUnitOfMeasure.Get("No.", "Base Unit of Measure");
            //         ItemUnitOfMeasure.TestField("Qty. per Unit of Measure", 1);
            //     end;
            //     if CurrFieldNo <> 0 then
            //         Modify(true);
            // end;
        }
        field(85160; "NV8 Dimension 4"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension 4';
        }
        field(85162; "NV8 Quantity 4"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Quantity 4';
        }
        field(85163; "NV8 UOM 4"; Code[10])
        {
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));
            DataClassification = CustomerContent;
            Caption = 'UOM 4';
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     TestNoOpenEntriesExist(FieldCaption("Base Unit of Measure"));

            //     "Sales Unit of Measure" := "Base Unit of Measure";
            //     "Purch. Unit of Measure" := "Base Unit of Measure";
            //     if "Base Unit of Measure" <> '' then begin
            //         ItemUnitOfMeasure.Get("No.", "Base Unit of Measure");
            //         ItemUnitOfMeasure.TestField("Qty. per Unit of Measure", 1);
            //     end;
            //     if CurrFieldNo <> 0 then
            //         Modify(true);
            // end;
        }
        field(85170; "NV8 Specification"; Code[10])
        {
            TableRelation = "NV8 Configurator Specification";
            DataClassification = CustomerContent;
            Caption = 'Specification';
        }
        field(85180; "NV8 Grit"; Code[10])
        {
            TableRelation = "NV8 Configurator Grit";
            DataClassification = CustomerContent;
            Caption = 'Grit';
        }
        field(85190; "NV8 Joint"; Code[10])
        {
            TableRelation = "NV8 Configurator Joint";
            DataClassification = CustomerContent;
            Caption = 'Joint';
        }
        field(85220; "NV8 Hidden"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Hidden';
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
        field(85250; "NV8 Std. Cost Update By"; Code[20])
        {
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'Std. Cost Update By';
        }
        field(85251; "NV8 Std. Cost Update On"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Std. Cost Update On';
        }
        field(85299; "NV8 Qty. On Transfer Order"; Decimal)
        {
            CalcFormula = sum("Transfer Line"."Outstanding Qty. (Base)" where("Item No." = field("No."),
                                                                               "Variant Code" = field("Variant Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Qty. On Transfer Order';
        }
        field(85300; "NV8 Standard Box Quantity"; Decimal)
        {
            Description = 'AG046 vmj 07.09.02';
            DataClassification = CustomerContent;
            Caption = 'Standard Box Quantity';
        }
        field(85310; "NV8 Carton Quantity"; Decimal)
        {
            Description = 'AG046 vmj 07.09.02';
            DataClassification = CustomerContent;
            Caption = 'Carton Quantity';
        }
        field(85320; "NV8 Tolerance Percent"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'AG060 vmj 07.15.02';
            DataClassification = CustomerContent;
            Caption = 'Tolerance Percent';
        }
        field(85321; "NV8 Transfer Out Qty."; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Entry Type" = const(Transfer),
                                                                  "Item No." = field("No.")));
            FieldClass = FlowField;
            Caption = 'Transfer Out Qty.';
        }
        field(85400; "NV8 Estimated Cost"; Decimal)
        {
            DecimalPlaces = 5 : 5;
            DataClassification = CustomerContent;
            Caption = 'Estimated Cost';
        }
        field(85403; "NV8 Routing Cost per"; Decimal)
        {
            CalcFormula = sum("Routing Line"."Unit Cost per" where("Routing No." = field("Routing No.")));
            DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Routing Cost per';
        }
        field(85406; "NV8 BOM Cost per"; Decimal)
        {// TODO PAP
            // CalcFormula = sum("Production BOM Line"."Standard Cost per" where("Production BOM No." = field("Production BOM No.")));
            // DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'BOM Cost per';
        }
        field(85410; "NV8 Abrasive Cost (/m2)"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
            Caption = 'Abrasive Cost (/m2)';
        }
        field(85411; "NV8 FG Cost (/UOM)"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
            Caption = 'FG Cost (/UOM)';
        }
        field(85412; "NV8 Raw Material Cost (/UOM)"; Decimal)
        {
            // TODO PAP
            // CalcFormula = sum("Production BOM Line"."Raw Material Cost (/UOM)" where("Production BOM No." = field("Production BOM No.")));
            // DecimalPlaces = 2 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Raw Material Cost (/UOM)';
        }
    }
}
