tableextension 50063 "NV8 Item Tracking Code" extends "Item Tracking Code" //6502
{
    fields
    {
        field(54000; "NV8 Auto Track"; Boolean)
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
        }
    }
}
