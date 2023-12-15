tableextension 50027 "NV8 Purch. Rcpt. Line" extends "Purch. Rcpt. Line" //121
{
    fields
    {
        field(50000; "NV8 Configurator No."; Code[100])
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                //>>AG003 - Start
                ConfiguratorFound := false;
                Found := false;
                if "Configurator No." = '' then
                    exit;
                if (ConfiguratorItem.Get("Configurator No.")) then begin
                    if ConfiguratorItem."Item No." <> '' then begin
                        Validate(Type, Type::Item);
                        Validate("No.", ConfiguratorItem."Item No.");
                        ConfiguratorFound := true;
                    end;
                end;

                if not ConfiguratorFound then begin
                    if (StrLen("Configurator No.") <= 20) then begin
                        if (Item.Get("Configurator No.")) then begin
                            Validate(Type, Type::Item);
                            Validate("No.", Item."No.");
                            ConfiguratorFound := true;
                        end;
                    end;
                end;

                if not ConfiguratorFound then begin
                    Component := CopyStr("Configurator No.", 1, 2);
                    Remaining := CopyStr("Configurator No.", 3);

                    ConfiguratorItem.Init;
                    ConfiguratorItem."Configurator No." := '';
                    ConfiguratorItem."Temp Configurator No." := "Configurator No.";
                    if ConfiguratorShape.Get(Component) then begin
                        ConfiguratorItem.Validate(Shape, Component);
                        Component := '';
                        if StrLen(Remaining) > 2 then
                            repeat
                                Component := Component + CopyStr(Remaining, 1, 1);
                                if StrLen(Remaining) > 1 then
                                    Remaining := CopyStr(Remaining, 2)
                                else
                                    Remaining := '';
                                if ConfiguratorMaterial.Get(Component) then begin
                                    ConfiguratorItem.Validate(Material, Component);
                                    Found := true;
                                end;
                            until Found or (StrLen(Component) >= 10) or (StrLen(Remaining) = 0);
                        if not Found then
                            Remaining := Component + Remaining;
                    end;
                end;

                if Found and (StrLen(Remaining) >= 3) then begin
                    Found := false;
                    Component := CopyStr(Remaining, StrLen(Remaining) - 2);
                    if ConfiguratorJoint.Get(Component) then begin
                        ConfiguratorItem.Validate(Joint, Component);
                        if StrLen(Remaining) > 3 then
                            Remaining := CopyStr(Remaining, 1, StrLen(Remaining) - 3)
                        else
                            Remaining := '';
                    end;
                    Component := '';
                    if StrLen(Remaining) > 1 then
                        repeat
                            Component := CopyStr(Remaining, StrLen(Remaining), 1) + Component;
                            if StrLen(Remaining) > 1 then
                                Remaining := CopyStr(Remaining, 1, StrLen(Remaining) - 1)
                            else
                                Remaining := '';
                            if ConfiguratorMaterialGrit.Get(ConfiguratorItem.Material, Component) then begin
                                ConfiguratorItem.Validate(Grit, Component);
                                Found := true;
                            end;
                        until Found or (StrLen(Component) >= 10) or (StrLen(Remaining) < 1);
                    if not Found then
                        Remaining := Component + Remaining;
                end;

                if Found and (StrLen(Remaining) >= 10) then begin
                    Found := false;
                    ConfiguratorItem.Validate("Dimension 1", CopyStr(Remaining, 1, 5));
                    ConfiguratorItem.Validate("Dimension 2", CopyStr(Remaining, 6, 5));
                    // Remaining := COPYSTR(Remaining,10);
                end;
            end;
        }
        field(50001; "NV8 Original Ordered Quantity"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Validate(Quantity, "Original Ordered Quantity");

                "Original Ordered Pieces" := Quantity;
                "Original Unit Length (Meters)" := Quantity;
            end;
        }
        field(50002; "NV8 Original Ordered Pieces"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Validate(Quantity, "Original Ordered Pieces");
                if Confirm(Text50000) then begin
                    "Original Ordered Quantity" := Quantity;
                    "Original Unit Length (Meters)" := Quantity;
                end;
            end;
        }
        field(50003; "NV8 Original Unit Length (Meters)"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Validate(Quantity, "Original Unit Length (Meters)");

                if Confirm(Text50000) then begin
                    "Original Ordered Quantity" := Quantity;
                    "Original Ordered Pieces" := Quantity;
                end;
            end;
        }
        field(50004; "NV8 Pieces"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //VALIDATE(Quantity,"Total Area m2");  //EC1.PO4.01

                // RSQ mod LHR
                UpdOQ := false;
                if ("Original Ordered Pieces" <> 0) and (xRec.Pieces <> Pieces) and (not "Fully Received") then begin //added not FR
                    if Confirm('Do you want to update the Original Ordered Pieces, Y/N?', true) then begin
                        "Original Ordered Pieces" := Pieces;
                        UpdOQ := true;
                    end;
                end;
                // RSQ mod LHR

                if ("Original Ordered Pieces" = 0) then
                    "Original Ordered Pieces" := Pieces;  // LHR RSQ mod

                UpdatePieces;
                if UpdOQ = true then begin
                    "Original Ordered Quantity" := Quantity;
                    "Original Total Length Meters" := "Total Length meters";
                end;
            end;
        }
        field(50005; "NV8 Unit Length (Meters)"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //VALIDATE(Quantity,"Total Area m2");  //EC1.PO4.01

                "Unit Length Inches" := ROUND("Unit Length (Meters)" * 39, 0.00001);
                UpdatePieces;
            end;
        }
        field(50006; "NV8 Pieces to Receive"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField(Pieces);
                //VALIDATE("Qty. to Receive",ROUND("Pieces to Receive" * Quantity / Pieces,0.00001));
            end;
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
                /*//>>EC1.PO4.01
                IF "Fully Received" = TRUE THEN
                  VALIDATE(Quantity,("Qty. to Receive" + "Quantity Received"))
                ELSE
                  VALIDATE(Quantity,"Original Ordered Quantity");
                 */
                /*
                //AG046 BLD2 vmj 07.09.02
                IF "Document Type" = "Document Type"::Order THEN BEGIN
                 IF Type = Type::Item THEN BEGIN
                  IF "Fully Received" THEN BEGIN
                   GetPurchHeader;
                   IF "Original Ordered Quantity" = 0 THEN
                           "Original Ordered Quantity" := Quantity;
                   VALIDATE("Qty. to Receive");
                   VALIDATE(Quantity,"Qty. to Receive" + "Quantity Received");
                   IF "Unit Area m2" <> 0 THEN VALIDATE(Pieces,(Quantity/"Unit Area m2"));  //Lhr *************
                  END;
                 IF NOT "Fully Received" THEN BEGIN
                   GetPurchHeader;
                   VALIDATE(Quantity,"Original Ordered Quantity");
                  END;
                 END ELSE
                    "Fully Received" := FALSE;
                END ELSE
                    "Fully Received" := FALSE;
                */

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

            trigger OnValidate()
            begin
                /*
                //AG046 BLD2 vmj 07.09.02
                IF
                "Document Type" = "Document Type"::Order THEN BEGIN
                 IF Type = Type::Item THEN BEGIN
                    IF "Fully Received" THEN
                      ERROR(text85001);
                  IF ("Overage Quantity" <> 0) AND (xRec."Overage Quantity" = 0) THEN BEGIN
                     GetPurchHeader;
                     {{PurchHeader.Status := PurchHeader.Status::Open;
                     PurchHeader.MODIFY;}}
                     IF "Original Ordered Quantity" = 0 THEN
                       "Original Ordered Quantity" := Quantity;
                     VALIDATE(Quantity,Quantity + "Overage Quantity");
                     {{PurchHeader.Status := PurchHeader.Status::Released;
                     PurchHeader.MODIFY;}}
                  END;
                  IF ("Overage Quantity" = 0) AND (xRec."Overage Quantity" <> 0) THEN BEGIN
                     GetPurchHeader;
                     {{PurchHeader.Status := PurchHeader.Status::Open;
                     PurchHeader.MODIFY;}}
                     VALIDATE(Quantity,Quantity - xRec."Overage Quantity");
                     {{PurchHeader.Status := PurchHeader.Status::Released;
                     PurchHeader.MODIFY;}}
                  END;
                  IF (xRec."Overage Quantity" <> 0) AND ("Overage Quantity" <> 0) THEN BEGIN
                     GetPurchHeader;
                     {{PurchHeader.Status := PurchHeader.Status::Open;
                     PurchHeader.MODIFY;}}
                     VALIDATE(Quantity, "Original Ordered Quantity" + "Overage Quantity");
                     {{PurchHeader.Status := PurchHeader.Status::Released;
                     PurchHeader.MODIFY;}}
                  END;
                 END ELSE //end type
                    "Overage Quantity" := 0;
                END ELSE  //end doc type
                 "Overage Quantity" := 0;
                 */

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
                /*TEMP := ROUND("Unit Width Inches",1,'<') * 100;
                TEMP := TEMP + ROUND((("Unit Width Inches" MOD 1) * 64),1,'<');
                
                VALIDATE("Unit Width Code",FORMAT(TEMP,5,'<integer>'));
                */

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
                "Unit Length (Meters)" := ROUND("Unit Length Inches" / 39, 0.00001);
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
                "Unit Width Text" := ConfiguratorSetup.GetDecimalText("Unit Width Code");
                if "Unit Width Inches" <> 0 then
                    Validate("Direct Unit Cost", "Cost Per meter" / "Unit Width Inches" * 39);
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
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField(Pieces);
                Validate("Unit Length (Meters)", ROUND("Total Length meters" / Pieces, 0.00001));

                // RSQ begin
                if "Original Total Length Meters" = 0 then "Original Total Length Meters" := "Total Length meters";
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
                if "Unit Width Inches" <> 0 then
                    Validate("Direct Unit Cost", "Cost Per meter" / "Unit Width Inches" * 39);
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
            CalcFormula = lookup("Configurator Item".Shape where("Configurator No." = field("Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Configurator Shape";
        }
        field(85102; "NV8 Material"; Code[10])
        {
            CalcFormula = lookup("Configurator Item".Material where("Configurator No." = field("Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Configurator Material";
        }
        field(85107; "NV8 Specification"; Code[10])
        {
            CalcFormula = lookup("Configurator Item".Specification where("Configurator No." = field("Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Configurator Specification";
        }
        field(85108; "NV8 Grit"; Code[10])
        {
            CalcFormula = lookup("Configurator Item".Grit where("Configurator No." = field("Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Configurator Grit";
        }
        field(85109; "NV8 Joint"; Code[10])
        {
            CalcFormula = lookup("Configurator Item".Joint where("Configurator No." = field("Configurator No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Configurator Joint";
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
            DataClassification = CustomerContent;
        }
        field(86001; "NV8 Sample Order"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
}
