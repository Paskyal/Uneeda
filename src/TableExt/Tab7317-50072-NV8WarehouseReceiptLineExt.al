tableextension 50072 "NV8 Warehouse Receipt Line" extends "Warehouse Receipt Line" //7317
{
    // TODO PAP uncomment triggers
    fields
    {
        field(50000; "NV8 Configurator No."; Code[100])
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Configurator No.';

            // trigger OnValidate()
            // begin

            //     //>>AG003 - Start
            //     ConfiguratorFound := false;
            //     Found := false;
            //     if "Configurator No." = '' then
            //         exit;
            //     if (ConfiguratorItem.Get("Configurator No.")) then begin
            //         if ConfiguratorItem."Item No." <> '' then begin
            //             //  VALIDATE(Type,Type::Item);
            //             Validate("No.", ConfiguratorItem."Item No.");
            //             ConfiguratorFound := true;
            //         end;
            //     end;

            //     if not ConfiguratorFound then begin
            //         if (StrLen("Configurator No.") <= 20) then begin
            //             if (Item.Get("Configurator No.")) then begin
            //                 //      VALIDATE(Type,Type::Item);
            //                 Validate("No.", Item."No.");
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
        field(50001; "NV8 Print Receipt Labels"; Boolean)
        {
            CalcFormula = lookup(Item."NV8 Print Receipt Labels" where("No." = field("Item No.")));
            Description = 'EC1.01';
            FieldClass = FlowField;
            Caption = 'Print Receipt Labels';
        }
        field(50004; "NV8 Pieces"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces';

            // trigger OnValidate()
            // begin
            //     UpdatePieces;
            //     //VALIDATE(Quantity,Pieces);  //EC1.SAL1.01
            // end;
        }
        field(50006; "NV8 Pieces to Receive"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces to Receive';

            // trigger OnValidate()
            // var
            //     l_ResEntry: Record "Reservation Entry";
            //     scanFoundation: Codeunit UnknownCodeunit16016231;
            // begin
            //     // >>EC1.02
            //     if scanFoundation.GetItemConfiguration("Item No.") = 0 then
            //         exit;
            //     // <<EC1.02

            //     TestField(Pieces);


            //     Validate("Qty. to Receive", ROUND("Pieces to Receive" * Quantity / Pieces, 0.00001));

            //     //UE-365
            //     l_ResEntry.SetRange(l_ResEntry."Source Type", "Source Type");
            //     l_ResEntry.SetRange(l_ResEntry."Source Subtype", "Source Subtype");
            //     l_ResEntry.SetRange(l_ResEntry."Source ID", "Source No.");
            //     l_ResEntry.SetRange(l_ResEntry."Source Ref. No.", "Source Line No.");

            //     if l_ResEntry.FindFirst() then
            //         //VALIDATE("Qty. to Receive (Base)",ROUND(l_ResEntry."Quantity (Base)" * Rec."Pieces to Receive",0.00001))
            //         "Qty. to Receive (Base)" := ROUND(l_ResEntry."Quantity (Base)" * Rec."Pieces to Receive", 0.00001)
            // end;
        }
        field(50007; "NV8 Pieces to Invoice"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces to Invoice';
        }
        field(50008; "NV8 Pieces Received"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces Received';
        }
        field(50009; "NV8 Pieces Invoiced"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces Invoiced';
        }
        field(50010; "NV8 Meters Received"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Meters Received';
        }
        field(50011; "NV8 Meters Invoiced"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Meters Invoiced';
        }
        field(50012; "NV8 Fully Received"; Boolean)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Fully Received';

            // trigger OnValidate()
            // begin
            //     //
            //     // IF Type = Type::Item THEN BEGIN
            //     if "Fully Received" then begin
            //         //   GetPurchHeader;
            //         Validate("Qty. to Receive");

            //         if "Unit Area m2" <> 0 then Validate(Pieces, (Quantity / "Unit Area m2"));  //Lhr *************
            //     end;
            //     // IF NOT "Fully Received" THEN BEGIN
            //     //  GetPurchHeader;
            //     //  VALIDATE(Quantity,"Original Ordered Quantity");
            //     // END;
            //     // END ELSE
            //     //    "Fully Received" := FALSE;
            // end;
        }
        field(85010; "NV8 Overage Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
            Caption = 'Overage Quantity';

            // trigger OnValidate()
            // begin
            //     //AG046 BLD2 vmj 07.09.02
            //     //IF "Document Type" = "Document Type"::Order THEN BEGIN
            //     // IF Type = Type::Item THEN BEGIN
            //     //    IF "Fully Received" THEN
            //     //      ERROR(text85001);
            //     if ("Overage Quantity" <> 0) and (xRec."Overage Quantity" = 0) then begin
            //         //GetPurchHeader;
            //         /*{PurchHeader.Status := PurchHeader.Status::Open;
            //         PurchHeader.MODIFY;}*/
            //         Validate(Quantity, Quantity + "Overage Quantity");
            //         /*{PurchHeader.Status := PurchHeader.Status::Released;
            //         PurchHeader.MODIFY;}*/
            //     end;
            //     if ("Overage Quantity" = 0) and (xRec."Overage Quantity" <> 0) then begin
            //         //  GetPurchHeader;
            //         /*{PurchHeader.Status := PurchHeader.Status::Open;
            //         PurchHeader.MODIFY;}*/
            //         Validate(Quantity, Quantity - xRec."Overage Quantity");
            //         /*{PurchHeader.Status := PurchHeader.Status::Released;
            //         PurchHeader.MODIFY;}*/
            //     end;
            //     //E/ND ELSE  //end doc type
            //     // "Overage Quantity" := 0;

            // end;
        }
        field(85040; "NV8 Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
            Caption = 'Material Type';
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
            //     /*TEMP := ROUND("Unit Width Inches",1,'<') * 100;
            //     TEMP := TEMP + ROUND((("Unit Width Inches" MOD 1) * 64),1,'<');

            //     VALIDATE("Unit Width Code",FORMAT(TEMP,5,'<integer>'));
            //     */
            //     UpdatePieces;

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
            //     //IF "Unit Width Inches" <> 0 THEN
            //     //  VALIDATE("Direct Unit Cost","Cost Per meter" / "Unit Width Inches" * 39);
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

            // trigger OnValidate()
            // begin
            //     TestField(Pieces);
            //     Validate("Unit Length meters", ROUND("Total Length meters" / Pieces, 0.00001));

            //     // RSQ begin
            //     if "Original Total Length Meters" = 0 then "Original Total Length Meters" := "Total Length meters";
            //     // RSQ end
            // end;
        }
        field(85059; "NV8 Cost Per meter"; Decimal)
        {
            AutoFormatType = 2;
            BlankZero = true;
            DataClassification = CustomerContent;
            Caption = 'Cost Per meter';
        }
        field(85060; "NV8 Remaining Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Remaining Pieces';
        }
        field(85062; "NV8 Remaining Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 4;
            DataClassification = CustomerContent;
            Caption = 'Remaining Length meters';
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Total Area m2';
        }
        field(85065; "NV8 Remaining Area m2"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'Error on decimals';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Remaining Area m2';
        }
        field(85101; "NV8 Shape"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Shape where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Shape";
            Caption = 'Shape';
        }
        field(85102; "NV8 Material"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Material where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Material";
            Caption = 'Material';
        }
        field(85107; "NV8 Specification"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Specification where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Specification";
            Caption = 'Specification';
        }
        field(85108; "NV8 Grit"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Grit where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Grit";
            Caption = 'Grit';
        }
        field(85109; "NV8 Joint"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Joint where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Joint";
            Caption = 'Joint';
        }
        field(85204; "NV8 OriginalTotalLengthMeters"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'OriginalTotalLengthMeters';
        }
        field(86000; "NV8 User DefinedDirectUnitCost"; Decimal)
        {
            AutoFormatType = 2;
            DataClassification = CustomerContent;
            Caption = 'User DefinedDirectUnitCost';
        }
        field(86001; "NV8 Sample Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sample Order';
        }
        field(90001; "NV8 Lot Group Code"; Code[20])
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
            Caption = 'Lot Group Code';
        }
    }
}
