tableextension 50047 "NV8 Prod. Order Routing Line" extends "Prod. Order Routing Line" //5409
{
    fields
    {
        field(50000; "NV8 Subcontractor PO"; Code[20])
        {
            CalcFormula = lookup("Purchase Line"."Document No." where("Prod. Order No." = field("Prod. Order No."),
                                                                       "Work Center No." = field("Work Center No.")));
            Description = 'UE-376';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
