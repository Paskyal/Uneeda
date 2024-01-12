tableextension 50081 "NV8 Whse. Int. Put-away Line" extends "Whse. Internal Put-away Line" //7332
{
    // TODO PAP Uncomment triggers
    fields
    {
        field(50000; "NV8 Slitting Put/Pick"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85040; "NV8 Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
        }
        field(85050; "NV8 Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     UpdatePieces;
            // end;
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     Temp := ROUND("Unit Width Inches", 1, '<') * 100;
            //     Temp := Temp + ROUND((("Unit Width Inches" MOD 1) * 64), 1, '<');

            //     //VALIDATE("Unit Width Code",FORMAT(Temp,5,'<integer>'));
            // end;
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     "NV8 Unit Length Inches" := ROUND("NV8 Unit Length meters" * 39, 0.00001);
            //     UpdatePieces;
            // end;
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;

            // trigger OnValidate()
            // begin
            //     "NV8 Unit Length meters" := ROUND("NV8 Unit Length Inches" / 39, 0.00001);
            //     UpdatePieces;
            // end;
        }
        field(85054; "NV8 Unit Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Description = 'Width / 36 x Length';
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
                TestField("NV8 Pieces");
                Validate("NV8 Unit Length meters", ROUND("NV8 Total Length meters" / "NV8 Pieces", 0.00001));
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
            TableRelation = "NV8 Configurator Item" where(Status = filter(Item .. "Valid Item"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                /*//>>AG003 - Start
                ConfiguratorFound := FALSE;
                Found := FALSE;
                IF "Configurator No." = '' THEN
                  EXIT;
                IF (ConfiguratorItem.GET("Configurator No.")) THEN BEGIN
                  IF ConfiguratorItem."Item No." <> '' THEN BEGIN
                    VALIDATE("Item No.",ConfiguratorItem."Item No.");
                    ConfiguratorFound := TRUE;
                  END;
                END;
                
                IF NOT ConfiguratorFound THEN BEGIN
                  IF (STRLEN("Configurator No.") <= 20) THEN BEGIN
                    IF (Item.GET("Configurator No.")) THEN BEGIN
                      VALIDATE("Item No.",Item."No.");
                      ConfiguratorFound := TRUE;
                    END;
                  END;
                END;
                
                IF NOT ConfiguratorFound THEN BEGIN
                  Component := COPYSTR("Configurator No.",1,2);
                  Remaining := COPYSTR("Configurator No.",3);
                
                  ConfiguratorItem.INIT;
                  ConfiguratorItem."Configurator No." := '';
                  ConfiguratorItem."Temp Configurator No." := "Configurator No.";
                  IF ConfiguratorShape.GET(Component) THEN BEGIN
                    ConfiguratorItem.VALIDATE(Shape,Component);
                    Component := '';
                    IF STRLEN(Remaining) > 2 THEN
                      REPEAT
                        Component := Component + COPYSTR(Remaining,1,1);
                        IF STRLEN(Remaining) > 1 THEN
                          Remaining := COPYSTR(Remaining,2)
                        ELSE
                          Remaining := '';
                        IF ConfiguratorMaterial.GET(Component) THEN BEGIN
                          ConfiguratorItem.VALIDATE(Material,Component);
                          Found := TRUE;
                        END;
                      UNTIL Found OR (STRLEN(Component) >= 10) OR (STRLEN(Remaining) = 0);
                      IF NOT Found THEN
                        Remaining := Component + Remaining;
                  END;
                END;
                
                IF Found AND (STRLEN(Remaining) >= 3) THEN BEGIN
                  Found := FALSE;
                    Component := COPYSTR(Remaining,STRLEN(Remaining) - 2);
                    IF ConfiguratorJoint.GET(Component) THEN BEGIN
                      ConfiguratorItem.VALIDATE(Joint,Component);
                      IF STRLEN(Remaining) > 3 THEN
                        Remaining := COPYSTR(Remaining,1,STRLEN(Remaining) - 3)
                      ELSE
                        Remaining := '';
                    END;
                    Component := '';
                    IF STRLEN(Remaining) > 1 THEN
                      REPEAT
                        Component := COPYSTR(Remaining,STRLEN(Remaining),1) + Component;
                        IF STRLEN(Remaining) > 1 THEN
                          Remaining := COPYSTR(Remaining,1,STRLEN(Remaining) - 1)
                        ELSE
                          Remaining := '';
                        IF ConfiguratorMaterialGrit.GET(ConfiguratorItem.Material,Component) THEN BEGIN
                          ConfiguratorItem.VALIDATE(Grit,Component);
                          Found := TRUE;
                        END;
                      UNTIL Found OR (STRLEN(Component) >= 10) OR (STRLEN(Remaining) < 1);
                      IF NOT Found THEN
                        Remaining := Component + Remaining;
                END;
                
                IF Found AND (STRLEN(Remaining) >= 10) THEN BEGIN
                  Found := FALSE;
                  ConfiguratorItem.VALIDATE("Dimension 1",COPYSTR(Remaining,1,5));
                  ConfiguratorItem.VALIDATE("Dimension 2",COPYSTR(Remaining,6,5));
                  // Remaining := COPYSTR(Remaining,10);
                END;
                
                
                IF NOT ConfiguratorFound THEN BEGIN
                ///  COMMIT;
                  IF CONFIRM(AG012,FALSE) THEN BEGIN
                    ConfiguratorItem.INSERT(TRUE);
                  //  COMMIT;
                    IF PAGE.RUNMODAL(PAGE::"Configurator Item Card",ConfiguratorItem) = ACTION::LookupOK THEN BEGIN
                      VALIDATE("Item No.",ConfiguratorItem."Item No.");
                      ConfiguratorFound := TRUE;
                    END;
                  END;
                END;
                
                // UpdateConfiguration;
                //IF NOT ConfiguratorFound THEN
                //  ERROR(AG013);
                  */

            end;
        }
        field(85110; "NV8 Shape"; Code[10])
        {
            TableRelation = "NV8 Configurator Shape";
            DataClassification = CustomerContent;
        }
        field(85120; "NV8 Material"; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
            DataClassification = CustomerContent;
        }
        field(85122; "NV8 Subst. Material"; Code[10])
        {
            Editable = false;
            TableRelation = "NV8 Configurator Material";
            DataClassification = CustomerContent;
        }
        field(85170; "NV8 Specification"; Code[10])
        {
            TableRelation = "NV8 Configurator Specification";
            DataClassification = CustomerContent;
        }
        field(85180; "NV8 Grit"; Code[10])
        {
            TableRelation = "NV8 Configurator Grit";
            DataClassification = CustomerContent;
        }
        field(85190; "NV8 Joint"; Code[10])
        {
            TableRelation = "NV8 Configurator Joint";
            DataClassification = CustomerContent;
        }
    }
}
