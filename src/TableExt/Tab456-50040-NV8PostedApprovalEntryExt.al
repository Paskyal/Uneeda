tableextension 50040 "NV8 Posted Approval Entry" extends "Posted Approval Entry" //456
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
