tableextension 50034 "NV8 Reason Code" extends "Reason Code" //231
{
    fields
    {
        field(50000; "NV8 Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            Description = 'UE-270';
            TableRelation = "Gen. Business Posting Group";
            DataClassification = CustomerContent;
        }
    }
}
