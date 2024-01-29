tableextension 50085 "NV8 Sales Planning Line" extends "Sales Planning Line"// 99000800
{
    fields
    {
        field(50100; "NV8 Qty. to Make (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Make (Base)';
            trigger OnValidate()
            var
                SalesLine: Record "Sales Line";
            begin
                Clear(SalesLine);
                SalesLine.Get(SalesLine."document type"::Order, "Sales Order No.", "Sales Order Line No.");
                //>> UE-647
                //IF "Qty. to Make" > SalesLine.Quantity THEN
                //ERROR('Qty. to Make cannot be greater then the Order Quantity of %1',SalesLine.Quantity);
                if "NV8 Qty. to Make (Base)" > SalesLine."Quantity (Base)" then
                    Error('Qty. to Make Base cannot be greater then the Order Quantity Base of %1', SalesLine."Quantity (Base)");
            end;
        }
        field(50110; "NV8 Description 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description 2';
        }
        field(50120; "NV8 Prod. Order Created"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prod. Order Created';
        }
        field(50130; "NV8 Order Qty."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Order Qty.';
        }
        field(50140; "NV8 Outstanding Order Qty."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Outstanding Order Qty.';
        }
    }
}
