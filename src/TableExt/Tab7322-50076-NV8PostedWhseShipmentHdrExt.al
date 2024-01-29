tableextension 50076 "NV8 Posted Whse. Shipment Hdr" extends "Posted Whse. Shipment Header" //7322
{
    fields
    {
        field(50000; "NV8 Created On Date"; Date)
        {
            Description = 'UE-537';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Created On Date';
        }
        field(51002; "NV8 Web"; Boolean)
        {
            Description = 'UE-657';
            DataClassification = CustomerContent;
            Caption = 'Web';
        }
    }
}
