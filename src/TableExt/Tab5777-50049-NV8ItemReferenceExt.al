tableextension 50049 "NV8 Item Reference" extends "Item Reference" //5777
{
    fields
    {
        field(50000; "NV8 Item Description 1"; Text[50])
        {
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Description = 'UE-285';
            FieldClass = FlowField;
        }
        field(50001; "NV8 Item Description 2"; Text[50])
        {
            CalcFormula = lookup(Item."Description 2" where("No." = field("Item No.")));
            Description = 'UE-285';
            FieldClass = FlowField;
        }
    }
}
