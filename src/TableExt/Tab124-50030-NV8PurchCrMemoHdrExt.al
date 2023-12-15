tableextension 50030 "NV8 Purch. Cr. Memo Hdr." extends "Purch. Cr. Memo Hdr." //124
{
    fields
    {
        field(50000; "NV8 Created By"; Code[50])
        {
            Description = 'EC1.PO4.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50001; "NV8 Created On"; Date)
        {
            Description = 'EC1.PO4.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50002; "NV8 Edited By"; Code[50])
        {
            Description = 'EC1.PO4.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50003; "NV8 Edited On"; Date)
        {
            Description = 'EC1.PO4.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
}
