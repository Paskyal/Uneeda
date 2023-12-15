tableextension 50053 "NV8 Transfer Shipment Line" extends "Transfer Shipment Line" //5745
{
    fields
    {
        field(68081; "NV8 CNL"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(68120; "NV8 Pack Size"; Option)
        {
            OptionMembers = " ",,,"3",,"5",,,,,"10";
            DataClassification = CustomerContent;
        }
        field(85003; "NV8 Skid No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(85010; "NV8 Overage Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(85011; "NV8 Fully Shipped"; Boolean)
        {
            Description = 'UE-631';
            DataClassification = CustomerContent;
        }
        field(85012; "NV8 Original Ordered Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
        }
        field(85016; "NV8 Outstanding Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85020; "NV8 From Bin Location"; Code[20])
        {
            TableRelation = "Bin Location".Code where("Location Code" = field("Transfer-from Code"));
            DataClassification = CustomerContent;
        }
        field(85021; "NV8 To Bin Location"; Code[20])
        {
            TableRelation = "Bin Location".Code where("Location Code" = field("Transfer-to Code"));
            DataClassification = CustomerContent;
        }
        field(85040; "NV8 Material Type"; Option)
        {
            OptionCaption = ' ,Jumbo,Short Remnant,Narrow Remnant,Scrap';
            OptionMembers = " ",Jumbo,"Short Remnant","Narrow Remnant",Scrap;
            DataClassification = CustomerContent;
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
        field(85046; "NV8 Created On"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85049; "NV8 Exported On"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85050; "NV8 Pieces"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(85054; "NV8 Unit Area m2"; Decimal)
        {
            Description = 'Width / 36 x Length';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85055; "NV8 Unit Width Code"; Code[10])
        {
            CharAllowed = '09';
            DataClassification = CustomerContent;
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
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(85090; "NV8 Consignment Location"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85091; "NV8 Consignment Customer"; Code[20])
        {
            TableRelation = Customer;
            DataClassification = CustomerContent;
        }
        field(85092; "NV8 Cross-Reference No."; Code[20])
        {
            TableRelation = "Item Cross Reference"."Cross-Reference No." where("Cross-Reference Type" = const(Customer),
                                                                                "Cross-Reference Type No." = field("Consignment Customer"));
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ReturnedCrossRef: Record "Item Cross Reference";
            begin
            end;
        }
        field(85094; "NV8 Sales Price UEI"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
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
        }
        field(89100; "NV8 Pick List"; Code[10])
        {
            DataClassification = CustomerContent;

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
        }
        field(89102; "NV8 Production Order No."; Code[20])
        {
            TableRelation = "Production Order"."No." where(Status = field("Production Order Status"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(89108; "NV8 Production Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(99008; "NV8 Original Ordered Pieces"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'RSQ';
            DataClassification = CustomerContent;
        }
        field(99009; "NV8 Original Total Length Meters"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            Description = 'RSQ';
            DataClassification = CustomerContent;
        }
        field(99010; "NV8 Original Unit Length Meters"; Decimal)
        {
            DecimalPlaces = 2 : 5;
            Description = 'RSQ';
            DataClassification = CustomerContent;
        }
    }
}
