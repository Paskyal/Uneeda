tableextension 50076 "NV8 Posted Whse. Shipment Hdr" extends "Posted Whse. Shipment Header" //7322
{
    fields
    {
        ield(50000;"Created On Date";Date)
        {
            Description = 'UE-537';
            Editable = false;
        }
        field(51002; "NV8 Web"; Boolean)
        {
            Description = 'UE-657';
        }
    }
}
