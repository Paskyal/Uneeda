tableextension 50039 "NV8 Approval Entry" extends "Approval Entry" //454
{
    fields
    {
        field(50000; "NV8 Buy-From/Sell-To Name"; Text[50])
        {
            Description = 'UE-666';
            DataClassification = CustomerContent;
            Caption = 'Buy-From/Sell-To Name';
        }
    }
}
