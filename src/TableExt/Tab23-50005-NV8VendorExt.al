tableextension 50005 "NV8 Vendor" extends Vendor //23
{
    fields
    {
        field(50000; "NV8 Created By"; Code[50])
        {
            Description = 'EC1.PO4.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }
        field(50001; "NV8 Created On"; Date)
        {
            Description = 'EC1.PO4.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Created On';
        }
        field(50002; "NV8 Edited By"; Code[50])
        {
            Description = 'EC1.PO4.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Edited By';
        }
        field(50003; "NV8 Edited On"; Date)
        {
            Description = 'EC1.PO4.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Edited On';
        }
        field(50004; "NV8 Commission Recipient"; Code[20])
        {
            Description = 'UE-279';
            // TableRelation = "Commission Recipient"; //PAP 5000000 range
            DataClassification = CustomerContent;
            Caption = 'Commission Recipient';
        }
    }
}
