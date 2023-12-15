tableextension 50045 "NV8 Prod. Order Line" extends "Prod. Order Line" //5406
{
    fields
    {
        field(50200; "NV8 Source Doc No."; Code[20])
        {
            Description = 'UE-446';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50205; "NV8 Source Doc Type"; Option)
        {
            Description = 'UE-446';
            Editable = false;
            OptionCaption = ',Transfer Order,Sales Order';
            OptionMembers = ,"Transfer Order","Sales Order";
            DataClassification = CustomerContent;
        }
        field(50210; "NV8 Source Doc Line No."; Integer)
        {
            Description = 'UE-446';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(52000; "NV8 Scheduled Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-173';
        }
        field(52001; "NV8 Created On Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-213';
            InitValue = 02"/";
        }
        field(68010; "NV8 Production Status"; Option)
        {
            CalcFormula = lookup("Production Order"."Production Status" where(Status = field(Status),
                                                                               "No." = field("Prod. Order No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Planned,In Progress,Finished';
            OptionMembers = " ",Planned,"In Progress",Finished;
        }
        field(68055; "NV8 Jumbo Raw Material Status"; Option)
        {
            CalcFormula = lookup("Configurator Material-Grits"."Set Raw Material Status" where("Material Code" = field(Material),
                                                                                                "Grit Code" = field(Grit)));
            Editable = false;
            FieldClass = FlowField;
            OptionMembers = Normal,Low,"Jumbo Out",Out,Discontinued;
        }
        field(68070; "NV8 Process Location"; Option)
        {
            CalcFormula = lookup("Production Order"."Process Location" where(Status = field(Status),
                                                                              "No." = field("Prod. Order No.")));
            Description = ' ,Waiting For Material,Ready To Allocate,Allocation,Slitting,External Contractor,,,,,,,,,,,,Partial,Green,Finished,Closed';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Waiting For Material,Ready To Allocate,Allocation,Slitting,External Contractor,,,,,,,,,,,,Partial,Green,Finished,Closed';
            OptionMembers = " ","Waiting For Material","Ready To Allocate",Allocation,Slitting,"External Contractor",,,,,,,,,,,,Partial,Green,Finished,Closed;
        }
        field(68120; "NV8 Pack Size"; Option)
        {
            OptionMembers = " ",,,"3",,"5",,,,,"10";
            DataClassification = CustomerContent;
        }
        field(68200; "NV8 Cons. Item No."; Code[20])
        {
            CalcFormula = lookup("Prod. Order Component"."Item No." where("Prod. Order No." = field("Prod. Order No."),
                                                                           Grit = filter(<> '0')));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Item;
        }
        field(68201; "NV8 Cons. Material"; Code[10])
        {
            CalcFormula = lookup("Prod. Order Component".Material where("Prod. Order No." = field("Prod. Order No."),
                                                                         Grit = filter(<> '0')));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Configurator Material";
        }
        field(68211; "NV8 Cons. Expected Quantity"; Decimal)
        {
            CalcFormula = lookup("Prod. Order Component"."Expected Quantity" where("Prod. Order No." = field("Prod. Order No."),
                                                                                    Grit = filter(<> '0')));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68370; "NV8 Ignore Variant Description"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(68400; "NV8 Catalog No."; Code[20])
        {
            CalcFormula = lookup("Item Catalog Table"."Catalog No." where("Item No." = field("Item No.")));
            Caption = 'Catalog No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(81100; "NV8 Must Ship"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85010; "NV8 Created From Document Type"; Option)
        {
            CalcFormula = lookup("Production Order"."Created From Document Type" where(Status = field(Status),
                                                                                        "No." = field("Prod. Order No.")));
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Sales Order,Sales Invoice,,,,Transfer Order';
            OptionMembers = " ","Sales Order","Sales Invoice",,,,"Transfer Order";
        }
        field(85011; "NV8 Created From Document No."; Code[200])
        {
            CalcFormula = lookup("Production Order"."Created From Document No." where(Status = field(Status),
                                                                                       "No." = field("Prod. Order No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = if ("Created From Document Type" = filter("Sales Order")) "Sales Header"."No." where("Document Type" = field("Created From Document Type"))
            else
            if ("Created From Document Type" = filter("Transfer Order")) "Transfer Header"."No.";
        }
        field(85012; "NV8 Created From Line No."; Integer)
        {
            CalcFormula = lookup("Production Order"."Created From Line No." where(Status = field(Status),
                                                                                   "No." = field("Prod. Order No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85017; "NV8 Must Have By (NOT USED)"; Date)
        {
            Description = 'Manual field to indicate when the order must be ready by';
            DataClassification = CustomerContent;
        }
        field(85020; "NV8 Sell-to Name"; Text[50])
        {
            CalcFormula = lookup("Sales Header"."Sell-to Customer Name" where("No." = field("Source Doc No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85021; "NV8 Transfer-to Name"; Text[50])
        {
            CalcFormula = lookup("Transfer Header"."Transfer-to Name" where("No." = field("Source Doc No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(85040; "NV8 Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
        }
        field(85041; "NV8 Red Dot"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85042; "NV8 Red Dot Level"; Option)
        {
            Description = 'Not used';
            OptionMembers = "1","2","3";
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
            begin
                Temp := ROUND("Unit Width Inches", 1, '<') * 100;
                Temp := Temp + ROUND((("Unit Width Inches" MOD 1) * 64), 1, '<');

                Validate("Unit Width Code", Format(Temp, 5, '<integer>'));
                UpdatePieces;
            end;
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
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
            Description = 'Width / 36 x Length';
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
                UpdatePieces;
            end;
        }
        field(85058; "NV8 Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField(Pieces);
                Validate("Unit Length meters", ROUND("Total Length meters" / Pieces, 0.00001));
            end;
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85100; "NV8 Configurator No."; Code[100])
        {
            TableRelation = "Configurator Item" where(Status = filter(Item .. "Valid Item"),
                                                       "Location Filter" = field("Location Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdatePieces;
            end;
        }
        field(85101; "NV8 Shape"; Code[10])
        {
            Editable = false;
            TableRelation = "Configurator Shape";
            DataClassification = CustomerContent;
        }
        field(85102; "NV8 Material"; Code[10])
        {
            Editable = false;
            TableRelation = "Configurator Material";
            DataClassification = CustomerContent;
        }
        field(85103; "NV8 Dimension 1"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(85104; "NV8 Dimension 2"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(85105; "NV8 Dimension 3"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(85106; "NV8 Dimension 4"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(85107; "NV8 Specification"; Code[10])
        {
            Editable = false;
            TableRelation = "Configurator Specification";
            DataClassification = CustomerContent;
        }
        field(85108; "NV8 Grit"; Code[10])
        {
            Editable = false;
            TableRelation = "Configurator Grit";
            DataClassification = CustomerContent;
        }
        field(85109; "NV8 Joint"; Code[10])
        {
            Editable = false;
            TableRelation = "Configurator Joint";
            DataClassification = CustomerContent;
        }
        field(85122; "NV8 Subst. Material"; Code[10])
        {
            CalcFormula = lookup("Prod. Order Component".Material where("Prod. Order No." = field("Prod. Order No."),
                                                                         Grit = filter(<> ''),
                                                                         "Substitute Material" = const(true)));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Configurator Material";
        }
        field(85201; "NV8 Reservation Application"; Integer)
        {
            TableRelation = "Reservation Entry"."Entry No." where("Reservation Status" = const(Reservation),
                                                                   "Source Type" = const(5406),
                                                                   "Source Subtype" = field(Status),
                                                                   "Source ID" = field("Prod. Order No."),
                                                                   "Source Prod. Order Line" = field("Line No."));
            DataClassification = CustomerContent;
        }
    }
}
