tableextension 50031 "NV8 Purch. Cr. Memo Line" extends "Purch. Cr. Memo Line" //125
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
        field(50003; "NV8 Original Unit Length (Meters)"; Decimal)
        {
            Description = 'EC1.PO4.01';
            DataClassification = CustomerContent;
            Caption = 'Original Unit Length (Meters)';
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
        field(50020; "NV8 Buy-From Vendor Name"; Text[50])
        {
            CalcFormula = lookup("Purchase Header"."Buy-from Vendor Name" where("Buy-from Vendor No." = field("Buy-from Vendor No.")));
            Description = 'UE-686';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Buy-From Vendor Name';
        }
    }
}
