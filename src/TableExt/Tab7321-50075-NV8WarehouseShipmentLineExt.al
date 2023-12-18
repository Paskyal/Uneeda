tableextension 50075 "NV8 Warehouse Shipment Line" extends "Warehouse Shipment Line" //7321
{
    fields
    {
        field(50000; "NV8 Fully Shipped"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                SalesLine: Record "Sales Line";
                SalesHeaderTemp: Record "Sales Header" temporary;
                TransLine: Record "Transfer Line";
                TransHEaderTemp: Record "Transfer Header" temporary;
                TransHeader: Record "Transfer Header";
            begin
                //>>EC1.SAL1.01


                /*
                //When field is checked, the system process the RSQ rules and if okay
                //changes the quantity field to match the Qty shipped + Qty to Ship
                //If uncehcekd then the Quantity changed back to Orig Qty value
                */
                GetLocation("Location Code");
                if "Fully Shipped" = true then begin
                    if (("Qty. to Ship" + "Qty. Shipped") <> "Qty. Picked") and
                       (Location."Require Pick") then
                        Error('Qty. to Ship and Qty. Shipped cannot be different than the amount picked for this order');


                    if "Source Type" = Database::"Sales Line" then begin
                        CheckRSQ;
                        //>>UE-65
                        GetSalesHeader;
                        SalesHeaderTemp.Copy(SalesHeader);
                        SalesHeader.Status := SalesHeader.Status::Open;
                        SalesHeader.Modify;
                        //>> UE-65  2/10/17
                        "Qty. (Base)" := "Qty. to Ship (Base)" + "Qty. Shipped (Base)";
                        Quantity := "Qty. Shipped" + "Qty. to Ship";
                        "Qty. Outstanding" := Quantity - "Qty. Shipped";
                        "Qty. Outstanding (Base)" := "Qty. (Base)" - "Qty. Shipped (Base)";
                        Modify();
                        //  VALIDATE(Quantity,("Qty. Shipped" + "Qty. to Ship"));
                        // VALIDATE("Qty. Outstanding",Quantity - "Qty. Shipped");
                        //<< UE-65  2/10/17
                        //<<UE-65
                        if SalesLine.Get("Source Subtype", "Source No.", "Source Line No.") then begin
                            SalesLine.Quantity := ("Qty. to Ship" + SalesLine."Quantity Shipped");
                            SalesLine."Quantity (Base)" := CalcBaseQty(SalesLine.Quantity);
                            SalesLine."Outstanding Quantity" := SalesLine.Quantity - SalesLine."Quantity Shipped";
                            SalesLine."Outstanding Qty. (Base)" := SalesLine."Quantity (Base)" - SalesLine."Qty. Shipped (Base)";
                            SalesLine."Std. Pack Quantity" := SalesLine.CalcStdPackQty(SalesLine."Quantity (Base)");
                            SalesLine."Package Quantity" := SalesLine.CalcPackageQty(SalesLine."Std. Pack Quantity");
                            SalesLine.UpdateUnitPrice(SalesLine.FieldNo(Quantity));
                            //>>UE-65
                            SalesLine."Fully Shipped" := true;
                            //<<UE-65
                            SalesLine.Modify();
                        end;
                        //>>UE-65
                        SalesHeader.Status := SalesHeaderTemp.Status;
                        SalesHeader.Modify;
                        //<<UE-65

                    end;  //IF Sales Line
                          //Now check for Transfer

                    if "Source Type" = Database::"Transfer Line" then begin
                        TransHeader.SetRange(TransHeader."No.", "Source No.");
                        TransHeader.FindFirst();
                        //>>UE-65

                        TransHEaderTemp.Copy(TransHeader);
                        TransHeader.Status := TransHeader.Status::Open;
                        TransHeader.Modify();
                        //>> UE-65  2/10/17
                        "Qty. (Base)" := "Qty. to Ship (Base)" + "Qty. Shipped (Base)";
                        Quantity := "Qty. Shipped" + "Qty. to Ship";
                        "Qty. Outstanding" := Quantity - "Qty. Shipped";
                        "Qty. Outstanding (Base)" := "Qty. (Base)" - "Qty. Shipped (Base)";
                        Modify();
                        //  VALIDATE(Quantity,("Qty. Shipped" + "Qty. to Ship"));
                        // VALIDATE("Qty. Outstanding",Quantity - "Qty. Shipped");
                        //<< UE-65  2/10/17
                        //<<UE-65
                        if TransLine.Get("Source No.", "Source Line No.") then begin
                            TransLine.Quantity := ("Qty. to Ship" + TransLine."Quantity Shipped");
                            TransLine."Quantity (Base)" := "Qty. (Base)";
                            TransLine."Outstanding Quantity" := TransLine.Quantity - TransLine."Quantity Shipped";
                            TransLine."Outstanding Qty. (Base)" := TransLine."Quantity (Base)" - TransLine."Qty. Shipped (Base)";
                            //    TransLine."Std. Pack Quantity" := TransLine.CalcStdPackQty(TransLine."Quantity (Base)");
                            //    TransLine."Package Quantity" := TransLine.CalcPackageQty(TransLine."Std. Pack Quantity");
                            //    TransLine.UpdateUnitPrice(TransLine.FIELDNO(Quantity));
                            //>>UE-65
                            TransLine."Fully Shipped" := true;
                            //<<UE-65
                            TransLine.Modify();
                        end;
                        //>>UE-65
                        TransHeader.Status := TransHEaderTemp.Status;
                        TransHeader.Modify();
                        //<<UE-65
                    end;



                end else begin
                    if SalesLine.Get("Source Subtype", "Source No.", "Source Line No.") then begin
                        //>>UE-65
                        GetSalesHeader;
                        SalesHeaderTemp.Copy(SalesHeader);
                        SalesHeader.Status := SalesHeader.Status::Open;
                        SalesHeader.Modify;
                        Validate(Quantity, SalesLine."Original Ordered Quantity");
                        //<<UE-65
                        SalesLine.Quantity := SalesLine."Original Ordered Quantity";
                        SalesLine."Quantity (Base)" := CalcBaseQty(SalesLine.Quantity);
                        SalesLine."Std. Pack Quantity" := SalesLine.CalcStdPackQty(SalesLine."Quantity (Base)");
                        SalesLine."Package Quantity" := SalesLine.CalcPackageQty(SalesLine."Std. Pack Quantity");
                        SalesLine.UpdateUnitPrice(SalesLine.FieldNo(Quantity));
                        //>>UE-65
                        SalesLine."Fully Shipped" := false;
                        //<<UE-65
                        SalesLine.Modify();
                        //>>UE-65
                        SalesHeader.Status := SalesHeaderTemp.Status;
                        SalesHeader.Modify;
                        //<<UE-65
                    end;

                    if TransLine.Get("Source No.", "Source Line No.") then begin
                        //>>UE-65

                        TransHeader.SetRange(TransHeader."No.", "Source No.");
                        TransHeader.FindFirst();
                        //>>UE-65

                        TransHEaderTemp.Copy(TransHeader);
                        TransHeader.Status := TransHeader.Status::Open;
                        TransHeader.Modify();
                        Validate(Quantity, TransLine."Original Ordered Quantity");
                        //<<UE-65
                        TransLine.Quantity := TransLine."Original Ordered Quantity";
                        //   TransLine."Quantity (Base)" := ;
                        //>>UE-65
                        TransLine."Fully Shipped" := false;
                        //<<UE-65
                        TransLine.Modify();
                        //>>UE-65
                        TransHeader.Status := TransHEaderTemp.Status;
                        TransHeader.Modify();
                        //<<UE-65
                    end;



                end;

            end;
        }
        field(68110; "NV8 Roll ID"; Code[20])
        {
            Description = 'EC1.MFG04.01';
            DataClassification = CustomerContent;
        }
        field(85019; "NV8 Jumbo Pull"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85026; "NV8 FIFO Code"; Code[7])
        {
            DataClassification = CustomerContent;
        }
        field(85027; "NV8 FIFO Date"; Date)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "FIFO Code" := AGGetFIFOCode("FIFO Date");
            end;
        }
        field(85040; "NV8 Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
        }
        field(85050; "NV8 Pieces"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'ECMISC';
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
            Description = 'ECMISC';
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Temp: Decimal;
            begin
                Temp := ROUND("Unit Width Inches", 1, '<') * 100;
                Temp := Temp + ROUND((("Unit Width Inches" MOD 1) * 64), 1, '<');

                //VALIDATE("Unit Width Code",FORMAT(Temp,5,'<integer>'));
            end;
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'ECMISC';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //"Unit Length Inches" := ROUND("Unit Length meters" * 39,0.00001);
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
        field(85058; "NV8 Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'ECMISC';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField(Pieces);
                Validate("Unit Length meters", ROUND("Total Length meters" / Pieces, 0.00001));
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
            DecimalPlaces = 0 : 5;
            Description = 'Error on decimals';
            DataClassification = CustomerContent;
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
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
        field(85100; "NV8 Configurator No."; Code[100])
        {
            TableRelation = "Configurator Item" where(Status = filter(Item .. "Valid Item"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
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
                        Validate("Item No.", ConfiguratorItem."Item No.");
                        ConfiguratorFound := true;
                    end;
                end;

                if not ConfiguratorFound then begin
                    if (StrLen("Configurator No.") <= 20) then begin
                        if (Item.Get("Configurator No.")) then begin
                            Validate("Item No.", Item."No.");
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

                /* remove as copied from T37)
                IF NOT ConfiguratorFound THEN BEGIN
                  COMMIT;
                  IF CONFIRM(AG012,FALSE) THEN BEGIN
                    ConfiguratorItem.INSERT(TRUE);
                    COMMIT;
                
                    IF FORM.RUNMODAL(FORM::"Configurator Item Card",ConfiguratorItem) = ACTION::LookupOK THEN BEGIN
                      VALIDATE("Item No.",ConfiguratorItem."Item No.");
                      ConfiguratorFound := TRUE;
                    END;
                  END;
                END;
                */

                // UpdateConfiguration;
                //IF NOT ConfiguratorFound THEN
                //  ERROR(AG013);

            end;
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
        field(85180; "NV8 Grit"; Code[10])
        {
            TableRelation = "Configurator Grit";
            DataClassification = CustomerContent;
        }
    }
}
