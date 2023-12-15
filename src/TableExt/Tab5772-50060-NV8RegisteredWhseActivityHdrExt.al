tableextension 50060 "NV8 Registered WhseActivityHdr" extends "Registered Whse. Activity Hdr." //5772
{
    fields
    {
        field(50050; "NV8 External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            Description = 'UE-524';
            DataClassification = CustomerContent;
        }
        field(51002; "NV8 Web"; Boolean)
        {
            Description = 'UE-657';
            DataClassification = CustomerContent;
        }
    }
}
