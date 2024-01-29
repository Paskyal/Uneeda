tableextension 50055 "NV8 Transfer Receipt Line" extends "Transfer Receipt Line" //5747
{
    fields
    {
        field(68081; "NV8 CNL"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CNL';
        }
        field(68110; "NV8 Sec. Territory Code"; Code[10])
        {
            // CalcFormula = lookup("Transfer Receipt Header".Field9586660 where("No." = field("Document No.")));//TODO PAP Check the field
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Territory;
            Caption = 'Sec. Territory Code';
        }
        field(68400; "NV8 Catalog No."; Code[20])
        {
            CalcFormula = lookup(Item."NV8 Catalog No." where("No." = field("Item No.")));
            Caption = 'Catalog No.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(85003; "NV8 Skid No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Skid No.';
        }
        field(85010; "NV8 Overage Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
            Caption = 'Overage Quantity';
        }
        field(85012; "NV8 Original Ordered Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
            Caption = 'Original Ordered Quantity';
        }
        field(85016; "NV8 Outstanding Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Outstanding Quantity';
        }
        field(85020; "NV8 From Bin Location"; Code[20])
        {
            TableRelation = "NV8 Bin Location".Code where("Location Code" = field("Transfer-from Code"));
            DataClassification = CustomerContent;
            Caption = 'From Bin Location';
        }
        field(85021; "NV8 To Bin Location"; Code[20])
        {
            TableRelation = "NV8 Bin Location".Code where("Location Code" = field("Transfer-to Code"));
            DataClassification = CustomerContent;
            Caption = 'To Bin Location';
        }
        field(85040; "NV8 Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
            Caption = 'Material Type';
        }
        field(85044; "NV8 Original Ship Date"; Date)
        {
            Caption = 'Original Ship Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(85050; "NV8 Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'Pieces';
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Unit Width Inches';
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
            Caption = 'Unit Length meters';
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Length Inches';
        }
        field(85054; "NV8 Unit Area m2"; Decimal)
        {
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
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Total Area m2';
        }
        field(85090; "NV8 Consignment Location"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Consignment Location';
        }
        field(85091; "NV8 Consignment Customer"; Code[20])
        {
            TableRelation = Customer;
            DataClassification = CustomerContent;
            Caption = 'Consignment Customer';
        }
        field(85092; "NV8 Cross-Reference No."; Code[20])
        {
            TableRelation = "Item Reference"."Reference No." where("Reference Type" = const(Customer),
                                                                                "Reference Type No." = field("NV8 Consignment Customer"));
            DataClassification = CustomerContent;
            Caption = 'Cross-Reference No.';
            trigger OnValidate()
            var
                ReturnedCrossRef: Record "Item Reference";
            begin
            end;
        }
        field(85093; "NV8 Customer Name"; Text[30])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("NV8 Consignment Customer")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Customer Name';
        }
        field(85100; "NV8 Configurator No."; Code[100])
        {
            TableRelation = "NV8 Configurator Item" where(Status = filter(Item .. "Valid Item"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Configurator No.';
        }
        field(85311; "NV8 Split Pieces"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details".Pieces where("Prod. Order No." = field("NV8 Production Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Split Pieces';
        }
        field(85312; "NV8 Split Total Length meters"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details"."Total Length meters" where("Prod. Order No." = field("NV8 Production Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Split Total Length meters';
        }
        field(85313; "NV8 Split Total Area m2"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("NV8 Split Roll Details"."Total Area m2" where("Prod. Order No." = field("NV8 Production Order No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Split Total Area m2';
        }
        field(89100; "NV8 Pick List"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Pick List';
            trigger OnValidate()
            begin
                TestField(Quantity);
            end;
        }
        field(89101; "NV8 Production Order Status"; Option)
        {
            OptionCaption = 'Simulated,Planned,Firm Planned,Released,Finished';
            OptionMembers = Simulated,Planned,"Firm Planned",Released,Finished;
            DataClassification = CustomerContent;
            Caption = 'Production Order Status';
        }
        field(89102; "NV8 Production Order No."; Code[20])
        {
            TableRelation = "Production Order"."No." where(Status = field("NV8 Production Order Status"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Production Order No.';
        }
        field(89108; "NV8 Production Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Production Due Date';
        }
        field(99008; "NV8 Original Ordered Pieces"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'RSQ';
            DataClassification = CustomerContent;
            Caption = 'Original Ordered Pieces';
        }
        field(99009; "NV8 Original Total Length Meters"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'RSQ';
            DataClassification = CustomerContent;
            Caption = 'Original Total Length Meters';
        }
        field(99010; "NV8 Original Unit Length Meters"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'RSQ';
            DataClassification = CustomerContent;
            Caption = 'Original Unit Length Meters';
        }
    }
}
