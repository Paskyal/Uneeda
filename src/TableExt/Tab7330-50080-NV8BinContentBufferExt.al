tableextension 50080 "NV8 Bin Content Buffer" extends "Bin Content Buffer" //7330
{
    fields
    {
        field(50000; "NV8 Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            Description = 'UE-270';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
    }
}
