Table 50024 "NV8 Transfer Planning Line"
{
    // UE-647  DB  10/3/19 Change Qty to Make field to be Qty. to Make Base

    Caption = 'Sales Planning Line';
    DataCaptionFields = "Transfer Order No.";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Transfer Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            TableRelation = "Transfer Header";
        }
        field(2; "Transfer Order Line No."; Integer)
        {
            Caption = 'Sales Order Line No.';
            TableRelation = "Transfer Line"."Line No." where("Document No." = field("Transfer Order No."));
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;

            trigger OnValidate()
            var
                Item: Record Item;
            begin
                Item.Get("Item No.");
                "Low-Level Code" := Item."Low-Level Code";
            end;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
        }
        field(6; Available; Decimal)
        {
            Caption = 'Available';
            DecimalPlaces = 0 : 5;
        }
        field(7; "Next Planning Date"; Date)
        {
            Caption = 'Next Planning Date';
        }
        field(8; "Expected Delivery Date"; Date)
        {
            Caption = 'Expected Delivery Date';
        }
        field(9; "Planning Status"; Option)
        {
            Caption = 'Planning Status';
            OptionCaption = 'None,Simulated,Planned,Firm Planned,Released,Inventory';
            OptionMembers = "None",Simulated,Planned,"Firm Planned",Released,Inventory;
        }
        field(10; "Needs Replanning"; Boolean)
        {
            Caption = 'Needs Replanning';
        }
        field(11; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."),
                                                       Code = field("Variant Code"));
        }
        field(12; "Planned Quantity"; Decimal)
        {
            Caption = 'Planned Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(15; "Low-Level Code"; Integer)
        {
            Caption = 'Low-Level Code';
            Editable = false;
        }
        field(50100; "Qty. to Make (Base)"; Decimal)
        {

            trigger OnValidate()
            var
                TransferLine: Record "Transfer Line";
            begin
                Clear(TransferLine);
                TransferLine.Get("Transfer Order No.", "Transfer Order Line No.");
                //>> UE-647
                //IF "Qty. to Make" > TransferLine.Quantity THEN
                //ERROR('Qty. to Make cannot be greater then the Order Quantity of %1',TransferLine.Quantity);
                if "Qty. to Make (Base)" > TransferLine."Quantity (Base)" then
                    Error('Qty. to Make cannot be greater then the Order Quantity Base of %1', TransferLine."Quantity (Base)");
                //<< 647
            end;
        }
        field(50110; "Description 2"; Text[50])
        {
        }
        field(50120; "Prod. Order Created"; Boolean)
        {
        }
        field(50130; "Order Qty."; Decimal)
        {
        }
        field(50140; "Outstanding Order Qty."; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Transfer Order No.", "Transfer Order Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Low-Level Code")
        {
        }
    }

    fieldgroups
    {
    }
}

