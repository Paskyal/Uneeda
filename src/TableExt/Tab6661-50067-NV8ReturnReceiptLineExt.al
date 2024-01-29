tableextension 50067 "NV8 Return Receipt Line" extends "Return Receipt Line" //6661
{
    // TODO PAP Uncomment trigers
    fields
    {
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

            //     UpdatePieces;
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
            trigger OnValidate()
            var
                Temp: Decimal;
            begin
                Temp := ROUND("NV8 Unit Width Inches", 1, '<') * 100;
                Temp := Temp + ROUND((("NV8 Unit Width Inches" MOD 1) * 64), 1, '<');

                //VALIDATE("Unit Width Code",FORMAT(Temp,5,'<integer>'));
            end;
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
        field(85058; "NV8 Total Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'ECMISC';
            DataClassification = CustomerContent;
            Caption = 'Total Length meters';

            // trigger OnValidate()
            // begin
            //     TestField(Pieces);
            //     Validate("Unit Length meters", ROUND("Total Length meters" / Pieces, 0.00001));
            // end;
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
            DecimalPlaces = 0 : 5;
            Description = 'Error on decimals';
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
            //             Validate("No.", ConfiguratorItem."Item No.");
            //             ConfiguratorFound := true;
            //         end;
            //     end;

            //     if not ConfiguratorFound then begin
            //         if (StrLen("Configurator No.") <= 20) then begin
            //             if (Item.Get("Configurator No.")) then begin
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
    }
}
