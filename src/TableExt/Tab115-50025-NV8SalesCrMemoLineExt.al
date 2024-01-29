tableextension 50025 "NV8 Sales Cr.Memo Line" extends "Sales Cr.Memo Line" //115
{
    fields
    {
        field(50000; "NV8 No Charge (Sample)"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'No Charge (Sample)';
        }
        field(50001; "NV8 Sales Type"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionMembers = Revenue,Freight,Surcharge,"Minimum Charge";
            DataClassification = CustomerContent;
            Caption = 'Sales Type';
        }
        field(50002; "NV8 Sales Price Code"; Code[10])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Sales Price Code';
        }
        field(50003; "NV8 Catalog No."; Code[20])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Catalog No.';
        }
        field(50004; "NV8 Configurator No."; Code[100])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Configurator No.';
        }
        field(50005; "NV8 Original Ordered Quantity"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Original Ordered Quantity';
        }
        field(50006; "NV8 Original Ordered Pieces"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Original Ordered Pieces';
        }
        field(50007; "NV8 Original Unit Length (Meters)"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Original Unit Length (Meters)';
        }
        field(50008; "NV8 Pieces"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces';
        }
        field(50009; "NV8 Unit Length (Meters)"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Unit Length (Meters)';
        }
        field(50010; "NV8 Price Type"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = 'Manual,List,Valid';
            OptionMembers = Manual,List,Valid;
            DataClassification = CustomerContent;
            Caption = 'Price Type';
        }
        field(50011; "NV8 Manual Price Entered By"; Code[50])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Manual Price Entered By';
        }
        field(50012; "NV8 Manual Discount %"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Manual Discount %';
        }
        field(50013; "NV8 Exclude from Sales Stats"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Exclude from Sales Stats';
        }
        field(50016; "NV8 Pieces Shipped"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces Shipped';
        }
        field(50017; "NV8 Pieces Invoiced"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Pieces Invoiced';
        }
        field(50018; "NV8 Meters Shipped"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Meters Shipped';
        }
        field(50019; "NV8 Meters Invoiced"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Meters Invoiced';
        }
        field(50020; "NV8 Fully Shipped"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Fully Shipped';
        }
        field(50021; "NV8 On Hold"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'On Hold';
        }
        field(85051; "NV8 Unit Width Inches"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
            MaxValue = 999;
            MinValue = 0;
            DataClassification = CustomerContent;
            Caption = 'Unit Width Inches';
        }
        field(85052; "NV8 Unit Length meters"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Unit Length meters';
        }
        field(85053; "NV8 Unit Length Inches"; Decimal)
        {
            BlankZero = true;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Unit Length Inches';
        }
        field(85054; "NV8 Unit Area m2"; Decimal)
        {
            BlankZero = true;
            Description = 'Width / 39 x Length';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Unit Area m2';
        }
        field(85055; "NV8 Unit Width Code"; Code[10])
        {
            CharAllowed = '09';
            Editable = false;
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
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Total Length meters';
        }
        field(85059; "NV8 Price Per meter"; Decimal)
        {
            BlankZero = true;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Price Per meter';
        }
        field(85064; "NV8 Total Area m2"; Decimal)
        {
            BlankZero = true;
            DecimalPlaces = 2 : 5;
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Total Area m2';
        }
    }
}
