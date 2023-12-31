tableextension 50012 "NV8 Purchase Line" extends "Purchase Line" //39
{
    fields
    {
        field(50000; "NV8 Configurator No."; Code[100])
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            // TODO PAP
            // trigger OnValidate()
            // var
            //     Item: Record Item;
            // begin

            //     //>>AG003 - Start
            //     ConfiguratorFound := false;
            //     Found := false;
            //     if "Configurator No." = '' then
            //         exit;
            //     if (ConfiguratorItem.Get("Configurator No.")) then begin
            //         if ConfiguratorItem."Item No." <> '' then begin
            //             Validate(Type, Type::Item);
            //             Validate("No.", ConfiguratorItem."Item No.");
            //             UpdateDirectUnitCost(FieldNo("Configurator No."));
            //             ConfiguratorFound := true;
            //         end;
            //     end;

            // if not ConfiguratorFound then begin
            //     if (StrLen("Configurator No.") <= 20) then begin
            //         if (Item.Get("Configurator No.")) then begin
            //             Validate(Type, Type::Item);
            //             Validate("No.", Item."No.");
            //             UpdateDirectUnitCost(FieldNo("Configurator No."));
            //             ConfiguratorFound := true;
            //         end;
            //     end;
            // end;

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
        field(50001; "NV8 Original Ordered Quantity"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
        }
        field(50002; "NV8 Original Ordered Pieces"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
        }
        field(50003; "NV8 Original Unit Length (Meters)"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
        }
        field(50004; "NV8 Pieces"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     //VALIDATE(Quantity,"Total Area m2");  //EC1.PO4.01
            //     UpdatePieces;
            // end;
        }
        field(50005; "NV8 Unit Length (Meters)"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     "NV8 Unit Length Inches" := ROUND("NV8 Unit Length meters" * 39, 0.00001);

            //     UpdatePieces;
            // end;
        }
        field(50006; "NV8 Pieces to Receive"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     if Pieces = 0 then exit;
            //     TestField(Pieces);
            //     Validate("Qty. to Receive", ROUND("Pieces to Receive" * Quantity / Pieces, 0.00001));
            // end;
        }
        field(50007; "NV8 Pieces to Invoice"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
        }
        field(50008; "NV8 Pieces Received"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
        }
        field(50009; "NV8 Pieces Invoiced"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
        }
        field(50010; "NV8 Meters Received"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
        }
        field(50011; "NV8 Meters Invoiced"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
        }
        field(50012; "NV8 Fully Received"; Boolean)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //AG046 BLD2 vmj 07.09.02
                if "Document Type" = "document type"::Order then begin
                    if Type = Type::Item then begin
                        if "NV8 Fully Received" then begin
                            GetPurchHeader();
                            Validate("Qty. to Receive");
                            Validate(Quantity, "Qty. to Receive" + "Quantity Received");
                            if "NV8 Unit Area m2" <> 0 then Validate("NV8 Pieces", (Quantity / "NV8 Unit Area m2"));  //Lhr *************
                        end;
                        if not "NV8 Fully Received" then
                            GetPurchHeader();
                        // VALIDATE(Quantity,"Original Ordered Quantity");
                    end else
                        "NV8 Fully Received" := false;
                end else
                    "NV8 Fully Received" := false;
            end;
        }
        field(50020; "NV8 Buy-From Vendor Name"; Text[50])
        {
            CalcFormula = lookup("Purchase Header"."Buy-from Vendor Name" where("Buy-from Vendor No." = field("Buy-from Vendor No.")));
            Description = 'UE-686';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85010; "NV8 Overage Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;
            // TODO PAP
            //     trigger OnValidate()
            //     begin
            //         UpdatePieces;
            //     end;
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     "NV8 Unit Length Inches" := ROUND("NV8 Unit Length meters" * 39, 0.00001);

            //     UpdatePieces;
            // end;
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            BlankZero = true;
            DataClassification = CustomerContent;
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     "NV8 Unit Length meters" := ROUND("NV8 Unit Length Inches" / 39, 0.00001);
            //     UpdatePieces;
            // end;
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
            // TODO PAP
            // trigger OnValidate()
            // begin
            //     ConfiguratorSetup.Get;
            //     ConfiguratorSetup.SetDimLen("Unit Width Code", 5, "Unit Width Code", 0);
            //     "Unit Width Inches" := ConfiguratorSetup.GetDecimal("Unit Width Code");
            //     "Unit Width Text" := ConfiguratorSetup.GetDecimalText("Unit Width Code");
            //     if "Unit Width Inches" <> 0 then
            //         Validate("Direct Unit Cost", "Cost Per meter" / "Unit Width Inches" * 39);
            //     UpdatePieces;
            // end;
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
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "NV8 Pieces" = 0 then exit;
                TestField("NV8 Pieces");
                Validate("NV8 Unit Length meters", ROUND("NV8 Total Length meters" / "NV8 Pieces", 0.00001));

                // RSQ begin
                if "NV8 Original Total Length Meters" = 0 then "NV8 Original Total Length Meters" := "NV8 Total Length meters";
                // RSQ end
            end;
        }
        field(85059; "NV8 Cost Per meter"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            BlankZero = true;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //IF "Unit Width Inches" <> 0 THEN                                                  //EC1.01 Not using Cost per meter any more
                //  VALIDATE("Direct Unit Cost","Cost Per meter" / "Unit Width Inches" * 39);       //commenting out code
                // UpdatePieces;
            end;
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
            DecimalPlaces = 0 : 4;
            DataClassification = CustomerContent;
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85101; "NV8 Shape"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Shape where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Shape";
        }
        field(85102; "NV8 Material"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Material where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Material";
        }
        field(85107; "NV8 Specification"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Specification where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Specification";
        }
        field(85108; "NV8 Grit"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Grit where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Grit";
        }
        field(85109; "NV8 Joint"; Code[10])
        {
            CalcFormula = lookup("NV8 Configurator Item".Joint where("Configurator No." = field("NV8 Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "NV8 Configurator Joint";
        }
        field(85130; "NV8 Dimension 1"; Code[10])
        {
            Description = 'UE-420';
            DataClassification = CustomerContent;
        }
        field(85140; "NV8 Dimension 2"; Code[10])
        {
            Description = 'UE-420';
            DataClassification = CustomerContent;
        }
        field(85150; "NV8 Dimension 3"; Code[10])
        {
            Description = 'UE-420';
            DataClassification = CustomerContent;
        }
        field(85160; "NV8 Dimension 4"; Code[10])
        {
            Description = 'UE-420';
            DataClassification = CustomerContent;
        }
        field(85204; "NV8 Original Total Length Meters"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(86000; "NV8 User Defined Direct Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            CaptionClass = GetCaptionClass(FIELDNO("Direct Unit Cost"));
            DataClassification = CustomerContent;
        }
        field(86001; "NV8 Sample Order"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
}
