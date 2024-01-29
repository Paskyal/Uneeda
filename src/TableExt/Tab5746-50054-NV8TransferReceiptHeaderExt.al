tableextension 50054 "NV8 Transfer Receipt Header" extends "Transfer Receipt Header" //5746
{
    fields
    {
        field(85045; "NV8 Created By"; Code[200])
        {
            Description = 'UE-390';
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }
        field(85046; "NV8 Created On"; Date)
        {
            Description = 'UE-390';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Created On';
        }
        field(85047; "NV8 Edited By"; Code[200])
        {
            Description = 'UE-390';
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'Edited By';
        }
        field(85048; "NV8 Edited On"; Date)
        {
            Description = 'UE-390';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Edited On';
        }
        field(85090; "NV8 Consignment Location"; Boolean)
        {
            Description = 'UE-341';
            DataClassification = CustomerContent;
            Caption = 'Consignment Location';
        }
        field(85091; "NV8 Consignment Customer"; Code[20])
        {
            Description = 'UE-341';
            TableRelation = Customer;
            DataClassification = CustomerContent;
            Caption = 'Consignment Customer';
        }
    }
}
