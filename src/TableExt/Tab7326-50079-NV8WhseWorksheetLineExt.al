tableextension 50079 "NV8 Whse. Worksheet Line" extends "Whse. Worksheet Line" //7326
{
    // TODO PAP uncomment triggers
    fields
    {
        field(50000; "NV8 Customer Name"; Text[50])
        {
            CalcFormula = lookup("Sales Header"."Sell-to Customer Name" where("No." = field("Source No."),
                                                                               "Sell-to Customer No." = field("Destination No.")));
            Description = 'UE-464';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Customer Name';
        }
        field(50001; "NV8 Prod. Order No."; Code[20])
        {
            CalcFormula = lookup("Production Order"."No." where(Status = filter(Released | Finished | "Firm Planned"),
                                                                 "NV8 Source Doc No." = field("Source No."),
                                                                 "Source No." = field("Item No."),
                                                                 "Location Code" = field("Location Code")));
            Description = 'UE-464,EN-092822';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Prod. Order No.';
        }
        field(50002; "NV8 Prod. Order Quantity"; Decimal)
        {
            CalcFormula = lookup("Production Order".Quantity where(Status = filter(Released | Finished | "Firm Planned"),
                                                                    "NV8 Source Doc No." = field("Source No."),
                                                                    "Source No." = field("Item No."),
                                                                    "Location Code" = field("Location Code")));
            DecimalPlaces = 0 : 5;
            Description = 'UE-464,EN-092822';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Prod. Order Quantity';
        }
        field(50003; "NV8 No Charge (Sample)"; Boolean)
        {
            CalcFormula = lookup("Sales Line"."NV8 No Charge (Sample)" where("Document No." = field("Source No."),
                                                                          "Sell-to Customer No." = field("Destination No."),
                                                                          Type = const(Item),
                                                                          "No." = field("Item No.")));
            Description = 'UE-464';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'No Charge (Sample)';
        }
        field(50004; "NV8 SO Orig. Order Quantity"; Decimal)
        {
            CalcFormula = lookup("Sales Line"."NV8 Original Ordered Quantity" where("Document No." = field("Source No."),
                                                                                 Type = const(Item),
                                                                                 "No." = field("Item No.")));
            Description = 'UE-464';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'SO Orig. Order Quantity';
        }
        field(50005; "NV8 TO Orig. Order Quantity"; Decimal)
        {
            CalcFormula = lookup("Transfer Line"."NV8 Original Ordered Quantity" where("Document No." = field("Source No."),
                                                                                    "Item No." = field("Item No.")));
            Description = 'UE-464';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'TO Orig. Order Quantity';
        }
        field(50006; "NV8 External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            Description = 'UE-524';
            DataClassification = CustomerContent;
        }
        field(50007; "NV8 Prod. Order Status"; Option)
        {
            CalcFormula = lookup("Production Order".Status where(Status = filter(Released | Finished | "Firm Planned"),
                                                                  "NV8 Source Doc No." = field("Source No."),
                                                                  "Source No." = field("Item No."),
                                                                  "Location Code" = field("Location Code")));
            Description = 'EN-092822';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished;
            Caption = 'Prod. Order Status';
        }
        field(68110; "NV8 Roll ID"; Code[20])
        {
            Description = 'EC1.MFG04.01';
            DataClassification = CustomerContent;
            Caption = 'Roll ID';
        }
        field(85019; "NV8 Jumbo Pull"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Jumbo Pull';
        }
        field(85026; "NV8 FIFO Code"; Code[7])
        {
            DataClassification = CustomerContent;
            Caption = 'FIFO Code';
        }
        field(85027; "NV8 FIFO Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'FIFO Date';

            // trigger OnValidate()
            // begin
            //     "FIFO Code" := AGGetFIFOCode("FIFO Date");
            // end;
        }
        field(85040; "NV8 Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
            Caption = 'Material Type';
        }
        field(85050; "NV8 Pieces"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'ECMISC';
            DataClassification = CustomerContent;
            Caption = 'Pieces';

            // trigger OnValidate()
            // begin
            //     //>> UE-365
            //     if "NV8 Pieces" < "NV8 Pieces Handled" then
            //         FieldError("NV8 Pieces", StrSubstNo(Text010, "NV8 Pieces Handled"));

            //     Validate("NV8 Remaining Pieces", ("NV8 Pieces" - "NV8 Pieces Handled"));
            //     //<< UE-365
            //     //UpdatePieces;
            // end;
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'ECMISC';
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Unit Width Inches';

            // trigger OnValidate()
            // var
            //     Temp: Decimal;
            // begin
            //     Temp := ROUND("NV8 Unit Width Inches", 1, '<') * 100;
            //     Temp := Temp + ROUND((("NV8 Unit Width Inches" MOD 1) * 64), 1, '<');

            //     //VALIDATE("Unit Width Code",FORMAT(Temp,5,'<integer>'));

            //     UpdatePieces;
            // end;
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Description = 'ECMISC';
            DataClassification = CustomerContent;
            Caption = 'Unit Length meters';

            // trigger OnValidate()
            // begin
            //     //"Unit Length Inches" := ROUND("Unit Length meters" * 39,0.00001);
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
            Caption = 'Unit Area m2';
        }
        field(85058; "NV8 Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'ECMISC';
            DataClassification = CustomerContent;
            Caption = 'Total Length meters';
            trigger OnValidate()
            begin
                TestField("NV8 Pieces");
                Validate("NV8 Unit Length meters", ROUND("NV8 Total Length meters" / "NV8 Pieces", 0.00001));
            end;
        }
        field(85060; "NV8 Remaining Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Remaining Pieces';
            trigger OnValidate()
            begin
                Validate("NV8 Pieces to Handle", "NV8 Remaining Pieces");  // UE-365
            end;
        }
        field(85061; "NV8 Pieces to Handle"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'UE-365';
            DataClassification = CustomerContent;
            Caption = 'Pieces to Handle';

            // trigger OnValidate()
            // var
            //     Qty: Decimal;
            //     QtyBase: Decimal;
            // begin
            //     /*
            //     //UE-365
            //     IF xRec."Pieces to Handle" = 0 THEN
            //       OrigPiecesToHandle := Rec."Pieces to Handle"
            //     ELSE
            //       OrigPiecesToHandle := xRec."Pieces to Handle";
            //     QtyToHandleBase := "Qty. to Handle (Base)";
            //     QtyToHandle := "Qty. to Handle";
            //     UpdatePieces;
            //     */

            //     //>>UE-365 12/08/15 TB Getting base quantities
            //     if GetQtyFromWhseEntry(Rec, QtyBase, Qty) then begin
            //         //>> UE-503      Put back
            //         "Qty. to Handle" := "Pieces to Handle" * Qty;
            //         //  VALIDATE("Qty. to Handle","Pieces to Handle" * Qty);
            //         //<< UE-503
            //         "Qty. to Handle (Base)" := "Pieces to Handle" * QtyBase;
            //     end;
            //     //<<UE-365

            // end;
        }
        field(85062; "NV8 Remaining Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Error on decimals';
            DataClassification = CustomerContent;
            Caption = 'Remaining Length meters';
        }
        field(85063; "NV8 Pieces Handled"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'UE-365';
            DataClassification = CustomerContent;
            Caption = 'Pieces Handled';
            trigger OnValidate()
            begin
                //UE-365
                //VALIDATE("Remaining Pieces",Pieces - "Pieces Handled");
            end;
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
        field(85100; "NV8 Configurator No."; Code[100])
        {
            TableRelation = "NV8 Configurator Item" where(Status = filter(Item .. "Valid Item"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
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
            //             Validate("Item No.", ConfiguratorItem."Item No.");
            //             ConfiguratorFound := true;
            //         end;
            //     end;

            //     if not ConfiguratorFound then begin
            //         if (StrLen("Configurator No.") <= 20) then begin
            //             if (Item.Get("Configurator No.")) then begin
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

            //     /* remove as copied from T37)
            //     IF NOT ConfiguratorFound THEN BEGIN
            //       COMMIT;
            //       IF CONFIRM(AG012,FALSE) THEN BEGIN
            //         ConfiguratorItem.INSERT(TRUE);
            //         COMMIT;

            //         IF FORM.RUNMODAL(FORM::"Configurator Item Card",ConfiguratorItem) = ACTION::LookupOK THEN BEGIN
            //           VALIDATE("Item No.",ConfiguratorItem."Item No.");
            //           ConfiguratorFound := TRUE;
            //         END;
            //       END;
            //     END;
            //     */

            //     // UpdateConfiguration;
            //     //IF NOT ConfiguratorFound THEN
            //     //  ERROR(AG013);

            // end;
        }
        field(85110; "NV8 Shape"; Code[10])
        {
            TableRelation = "NV8 Configurator Shape";
            DataClassification = CustomerContent;
            Caption = 'Shape';
        }
        field(85120; "NV8 Material"; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
            DataClassification = CustomerContent;
            Caption = 'Material';
        }
        field(85180; "NV8 Grit"; Code[10])
        {
            TableRelation = "NV8 Configurator Grit";
            DataClassification = CustomerContent;
            Caption = 'Grit';
        }
        field(85185; "NV8 No. of Lots"; Integer)
        {
            CalcFormula = count("Whse. Item Tracking Line" where("Source ID" = field("Whse. Document No."),
                                                                  "Item No." = field("Item No.")));
            Description = 'UE-227';
            FieldClass = FlowField;
            Caption = 'No. of Lots';
        }
        field(85186; "NV8 From Allocation"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-35';
            Caption = 'From Allocation';
        }
    }
}
