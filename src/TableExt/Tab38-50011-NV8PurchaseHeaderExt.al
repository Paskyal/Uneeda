tableextension 50011 "NV8 Purchase Header" extends "Purchase Header" //38
{
    fields
    {
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
