tableextension 50064 "NV8 Lot No. Information" extends "Lot No. Information" //6505
{
    // TODO PAP Uncomment triggers
    fields
    {
        field(50000; "NV8 External Document No."; Code[35])
        {
            CalcFormula = lookup("Warehouse Entry"."NV8 External Document No." where("Item No." = field("Item No."),
                                                                                  "Lot No." = field("Lot No."),
                                                                                  "Reference Document" = const("Put-away")));
            Caption = 'External Document No.';
            Description = 'UE-524';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "NV8 Current Bin Code"; Code[20])
        {
            CalcFormula = lookup("Warehouse Entry"."Bin Code" where("Item No." = field("Item No."),
                                                                     "Lot No." = field("Lot No."),
                                                                     "NV8 Lot Open in Bin" = const(true)));
            Caption = 'Bin Code';
            Description = 'UE-550';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50004; "NV8 Configurator No."; Code[100])
        {
            Description = 'EC1.SAL1.01';
            TableRelation = "NV8 Configurator Item"."Configurator No.";
            DataClassification = CustomerContent;
            Caption = 'Configurator No.';

            // trigger OnValidate()
            // var
            //     ConfigItem: Record "NV8 Configurator Item";
            // begin

            //     //>>AG003 - Start
            //     ConfiguratorFound := false;
            //     Found := false;
            //     if "Configurator No." = '' then
            //         exit;
            //     if (ConfiguratorItem.Get("Configurator No.")) then begin
            //         if ConfiguratorItem."Item No." <> '' then begin
            //             //VALIDATE(Type,Type::Item);
            //             Validate("Item No.", ConfiguratorItem."Item No.");
            //             ConfiguratorFound := true;
            //         end;
            //     end;

            //     if not ConfiguratorFound then begin
            //         if (StrLen("Configurator No.") <= 20) then begin
            //             if (Item.Get("Configurator No.")) then begin
            //                 // VALIDATE(Type,Type::Item);
            //                 Validate("Item No.", Item."No.");
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
            // end;
        }
        field(50008; "NV8 Pieces"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces';

            // trigger OnValidate()
            // begin
            //     UpdatePieces;
            // end;
        }
        field(68111; "NV8 PIN"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'PIN';
        }
        field(85019; "NV8 Jumbo Pull"; Boolean)
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'Jumbo Pull';
        }
        field(85021; "NV8 FIFO Code"; Code[7])
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'FIFO Code';
        }
        field(85022; "NV8 FIFO Date"; Date)
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'FIFO Date';

            // trigger OnValidate()
            // begin
            //     "FIFO Code" := AGGetFIFOCode("FIFO Date");
            // end;
        }
        field(85040; "NV8 Material Type"; Option)
        {
            Description = 'EC1.LOT1.01';
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
            Caption = 'Material Type';
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'EC1.LOT1.01';
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Unit Width Inches';

            // trigger OnValidate()
            // begin
            //     UpdatePieces;
            // end;
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'EC1.LOT1.01';
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
            Description = 'EC1.LOT1.01';
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
            DecimalPlaces = 2 : 5;
            Description = 'EC1.LOT1.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Unit Area m2';
        }
        field(85055; "NV8 Unit Width Code"; Code[10])
        {
            CharAllowed = '09';
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'Unit Width Code';

            // trigger OnValidate()
            // begin
            //     ConfiguratorSetup.Get;
            //     ConfiguratorSetup.SetDimLen("Unit Width Code", 5, "Unit Width Code", 0);
            //     "Unit Width Inches" := ConfiguratorSetup.GetDecimal("Unit Width Code");
            //     "Unit Width Text" := ConfiguratorSetup.GetDecimalText("Unit Width Code");
            //     UpdatePieces;
            // end;
        }
        field(85056; "NV8 Unit Width Text"; Text[30])
        {
            Description = 'EC1.LOT1.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Unit Width Text';
        }
        field(85058; "NV8 Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'Total Length meters';

            // trigger OnValidate()
            // begin
            //     TestField(Pieces);
            //     Validate("Unit Length meters", ROUND("Total Length meters" / Pieces, 0.00001));
            // end;
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'EC1.LOT1.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Total Area m2';
        }
        field(85101; "NV8 Shape"; Code[10])
        {
            CalcFormula = lookup(Item."NV8 Shape" where("No." = field("Item No.")));
            Description = 'EC1.LOT1.01,UE-648';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Shape";
            Caption = 'Shape';
        }
        field(85102; "NV8 Material"; Code[10])
        {
            CalcFormula = lookup(Item."NV8 Material" where("No." = field("Item No.")));
            Description = 'EC1.LOT1.01,UE-648';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Material";
            Caption = 'Material';
        }
        field(85107; "NV8 Specification"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Specification where("Configurator No." = field("NV8 Configurator No.")));
            Description = 'EC1.LOT1.01';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Specification';
        }
        field(85108; "NV8 Grit"; Code[10])
        {
            CalcFormula = lookup(Item."NV8 Grit" where("No." = field("Item No.")));
            Description = 'EC1.LOT1.01,UE-648';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Grit";
            Caption = 'Grit';
        }
        field(85109; "NV8 Joint"; Code[10])
        {
            CalcFormula = lookup(Item."NV8 Joint" where("No." = field("Item No.")));
            Description = 'EC1.LOT1.01,UE-648';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Joint";
            Caption = 'Joint';
        }
        field(90000; "NV8 Label Printed"; Boolean)
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'Label Printed';
        }
        field(90001; "NV8 Lot Group Code"; Code[20])
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'Lot Group Code';
        }
        field(90002; "NV8 PO No."; Code[20])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "Purchase Header"."No.";
            DataClassification = CustomerContent;
            Caption = 'PO No.';
        }
        field(91000; "NV8 Lot Quantity"; Decimal)
        {
            CalcFormula = sum("Warehouse Entry".Quantity where("Item No." = field("Item No."),
                                                                "Variant Code" = field("Variant Code"),
                                                                "Lot No." = field("Lot No."),
                                                                "Registering Date" = field("Date Filter"),
                                                                "Location Code" = field("Location Filter"),
                                                                "Bin Code" = field("Bin Filter"),
                                                                "Zone Code" = field("NV8 Zone Filter")));
            DecimalPlaces = 0 : 5;
            Description = 'EC1.LOT1.01';
            FieldClass = FlowField;
            Caption = 'Lot Quantity';
        }
        field(91001; "NV8 Zone Filter"; Code[20])
        {
            Description = 'EC1.LOT1.01';
            FieldClass = FlowFilter;
            TableRelation = Zone.Code where("Location Code" = field("Location Filter"));
            Caption = 'Zone Filter';
        }
        field(91002; "NV8 Locked"; Option)
        {
            Description = 'EC1.LOT1.01';
            OptionMembers = "None",Open,Complete;
            DataClassification = CustomerContent;
            Caption = 'Locked';
        }
        field(91003; "NV8 Locked By"; Code[200])
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'Locked By';
        }
        field(91004; "NV8 Pick No."; Code[20])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "Warehouse Activity Header"."No." where(Type = const(Pick));
            DataClassification = CustomerContent;
            Caption = 'Pick No.';
        }
        field(91005; "NV8 Allocator Comment"; Text[30])
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'Allocator Comment';
        }
        field(91006; "NV8 Allocation Entry No."; Integer)
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'Allocation Entry No.';
        }
        field(91007; "NV8 Lot Quantity (Base)"; Decimal)
        {
            CalcFormula = sum("Warehouse Entry"."Qty. (Base)" where("Item No." = field("Item No."),
                                                                     "Variant Code" = field("Variant Code"),
                                                                     "Lot No." = field("Lot No."),
                                                                     "Registering Date" = field("Date Filter"),
                                                                     "Location Code" = field("Location Filter"),
                                                                     "Bin Code" = field("Bin Filter"),
                                                                     "Zone Code" = field("NV8 Zone Filter")));
            DecimalPlaces = 0 : 5;
            Description = 'UE-548';
            FieldClass = FlowField;
            Caption = 'Lot Quantity (Base)';
        }
        field(91010; "NV8 Pick Deleted By"; Code[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Pick Deleted By';
        }
        field(91011; "NV8 Deleted Pick No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Deleted Pick No.';
        }
        field(91012; "NV8 Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Date';
        }
        field(91013; "NV8 Order No."; Code[20])
        {
            Caption = 'Order No.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(91014; "NV8 Lot Open Processed"; Boolean)
        {
            Description = 'UE-559';
            DataClassification = CustomerContent;
            Caption = 'Lot Open Processed';
        }
        field(91015; "NV8 Original Lot No."; Code[20])
        {
            Description = 'UE-606';
            DataClassification = CustomerContent;
            Caption = 'Original Lot No.';
        }
    }
}
