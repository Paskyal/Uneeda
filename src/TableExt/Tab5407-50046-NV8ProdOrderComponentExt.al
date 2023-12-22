tableextension 50046 "NV8 Prod. Order Component" extends "Prod. Order Component" //5407
{
    fields
    {
        field(68090; "NV8 Allocated Raw Material Qty"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Allocation Entry".Quantity where("Prod. Order No." = field("Prod. Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68091; "NV8 Allocation Status"; Option)
        {
            OptionCaption = 'Unknown,Closed,Transition,Open,Ready To Finish,Allocation Wrong,Partial Output,Slit Roll,New Method,Error,RoutingNeeded,PSA,Tape,RawMissing,PSAOK,TapeOK';
            OptionMembers = Unknown,Closed,Transition,Open,"Ready To Finish","Allocation Wrong","Partial Output","Slit Roll","New Method",Error,RoutingNeeded,PSA,Tape,RawMissing,PSAOK,TapeOK;
            DataClassification = CustomerContent;
        }
        field(68092; "NV8 Allocated Item"; Code[20])
        {
            CalcFormula = lookup("NV8 Allocation Entry"."Item No." where("Prod. Order No." = field("Prod. Order No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Item;
        }
        field(68093; "NV8 Original Quantity"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(68094; "NV8 Allocated Line"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(68095; "NV8 Allocated ILE"; Integer)
        {
            CalcFormula = lookup("NV8 Allocation Entry"."Initial Item Ledger Entry No." where("Prod. Order No." = field("Prod. Order No."),
                                                                                           "Item No." = field("Item No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Item Ledger Entry";
        }
        field(68096; "NV8 Quantity On Hand"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."),
                                                                  "Location Code" = field("Location Code")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68100; "NV8 MFG Quantity"; Decimal)
        {
            CalcFormula = lookup("Prod. Order Line".Quantity where(Status = field(Status),
                                                                    "Prod. Order No." = field("Prod. Order No."),
                                                                    "Line No." = field("Prod. Order Line No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(68400; "NV8 Catalog No."; Code[20])
        {
            CalcFormula = lookup(Item."NV8 Catalog No." where("No." = field("Item No.")));
            Caption = 'Catalog No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85005; "NV8 Output Quantity"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Item Ledger Entry".Quantity where("Entry Type" = const(Output),
                                                                  "Order Type" = const(Production),
                                                                  "Order No." = field("Prod. Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
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
        field(85100; "NV8 Configurator No."; Code[100])
        {
            Description = 'EC1.MFG04.01';
            TableRelation = "NV8 Configurator Item" where(Status = filter(Item .. "Valid Item"),
                                                       "Location Filter" = field("Location Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(85101; "NV8 Shape"; Code[10])
        {
            Description = 'EC1.MFG04.01';
            Editable = false;
            TableRelation = "NV8 Configurator Shape";
            DataClassification = CustomerContent;
        }
        field(85102; "NV8 Material"; Code[10])
        {
            Description = 'EC1.MFG04.01';
            Editable = false;
            TableRelation = "NV8 Configurator Material";
            DataClassification = CustomerContent;
        }
        field(85108; "NV8 Grit"; Code[10])
        {
            Description = 'EC1.MFG04.01';
            Editable = false;
            TableRelation = "NV8 Configurator Grit";
            DataClassification = CustomerContent;
        }
        field(85120; "NV8 Substitute Material"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85121; "NV8 Ori. Shape"; Code[10])
        {
            TableRelation = "NV8 Configurator Shape";
            DataClassification = CustomerContent;
        }
        field(85122; "NV8 Ori. Material"; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
            DataClassification = CustomerContent;
        }
        field(85128; "NV8 Ori. Grit"; Code[10])
        {
            TableRelation = "NV8 Configurator Grit";
            DataClassification = CustomerContent;
        }
        field(85130; "NV8 Ori. Item No."; Code[20])
        {
            TableRelation = Item;
            DataClassification = CustomerContent;
            // TODO PAP Uncomment
            // trigger OnValidate()
            // begin
            //     WhseValidateSourceLine.ProdComponentVerifyChange(Rec, xRec);
            //     ReserveProdOrderComp.VerifyChange(Rec, xRec);
            //     CalcFields("Reserved Qty. (Base)");
            //     TestField("Reserved Qty. (Base)", 0);
            //     TestField("Remaining Qty. (Base)", "Expected Qty. (Base)");
            //     if "Item No." = '' then begin
            //         CreateDim(Database::Item, "Item No.",
            //                 Database::Location, "Location Code");  // UE-651
            //         exit;
            //     end;

            //     Item.Get("Item No.");
            //     Description := Item.Description;
            //     Item.TestField("Base Unit of Measure");
            //     Validate("Unit of Measure Code", Item."Base Unit of Measure");
            //     GetUpdateFromSKU;
            //     CreateDim(Database::Item, "Item No.",
            //               Database::Location, "Location Code");  // UE-651

            //     // >> Configurator
            //     UpdateConfiguration;
            // end;
        }
    }
}
