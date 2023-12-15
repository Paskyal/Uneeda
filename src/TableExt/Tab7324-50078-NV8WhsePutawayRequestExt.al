tableextension 50078 "NV8 Whse. Put-away Request" extends "Whse. Put-away Request" //7324
{
    fields
    {
        field(50000; "NV8 Posting Date"; Date)
        {
            CalcFormula = lookup("Posted Whse. Receipt Header"."Posting Date" where("No." = field("Document No.")));
            Description = 'Postind Date from the Whse Receipt UE-480';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "NV8 Vendor Shipment No."; Code[35])
        {
            CalcFormula = lookup("Posted Whse. Receipt Header"."Vendor Shipment No." where("No." = field("Document No.")));
            Description = 'UE-480';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
