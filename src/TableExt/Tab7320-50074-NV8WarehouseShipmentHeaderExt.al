tableextension 50074 "NV8 Warehouse Shipment Header" extends "Warehouse Shipment Header" //7320
{
    fields
    {
        field(50000; "NV8 Created On Date"; Date)
        {
            Description = 'UE-537';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(51002; "NV8 Web"; Boolean)
        {
            Description = 'UE-657';
            DataClassification = CustomerContent;
        }
    }
}
