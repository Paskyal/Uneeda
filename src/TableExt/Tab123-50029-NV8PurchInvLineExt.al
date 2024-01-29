tableextension 50029 "NV8 Purch. Inv. Line" extends "Purch. Inv. Line" //123
{
    fields
    {
        field(50000; "NV8 Configurator No."; Code[100])
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Configurator No.';
        }
        field(50001; "NV8 Original Ordered Quantity"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Original Ordered Quantity';
        }
        field(50002; "NV8 Original Ordered Pieces"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Original Ordered Pieces';
        }
        field(50003; "NV8 OriginalUnitLength(Meters)"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'OriginalUnitLength(Meters)';
        }
        field(50004; "NV8 Pieces"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces';
        }
        field(50005; "NV8 Unit Length (Meters)"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Unit Length (Meters)';
        }
        field(50006; "NV8 Pieces to Receive"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces to Receive';
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
        }
        field(50020; "NV8 Buy-From Vendor Name"; Text[50])
        {
            CalcFormula = lookup("Purchase Header"."Buy-from Vendor Name" where("Buy-from Vendor No." = field("Buy-from Vendor No.")));
            Description = 'UE-686';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Buy-From Vendor Name';
        }
        field(85010; "NV8 Overage Quantity"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
            Caption = 'Overage Quantity';
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Unit Width Inches';
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            DataClassification = CustomerContent;
            Caption = 'Unit Length meters';
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            BlankZero = true;
            DataClassification = CustomerContent;
            Caption = 'Unit Length Inches';
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
        field(85130; "NV8 Dimension 1"; Code[10])
        {
            Description = 'UE-420';
            DataClassification = CustomerContent;
            Caption = 'Dimension 1';
        }
        field(85140; "NV8 Dimension 2"; Code[10])
        {
            Description = 'UE-420';
            DataClassification = CustomerContent;
            Caption = 'Dimension 2';
        }
        field(85150; "NV8 Dimension 3"; Code[10])
        {
            Description = 'UE-420';
            DataClassification = CustomerContent;
            Caption = 'Dimension 3';
        }
        field(85160; "NV8 Dimension 4"; Code[10])
        {
            Description = 'UE-420';
            DataClassification = CustomerContent;
            Caption = 'Dimension 4';
        }
        field(85204; "NV8 OriginalTotalLengthMeters"; Decimal)
        {
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
            Caption = 'OriginalTotalLengthMeters';
        }
        field(86000; "NV8 User Defined Direct Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            DataClassification = CustomerContent;
            Caption = 'User Defined Direct Unit Cost';
        }
        field(86001; "NV8 Sample Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sample Order';
        }
    }
}
