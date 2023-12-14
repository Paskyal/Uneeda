tableextension 50002 "NV8 G/L Entry" extends "G/L Entry" //17
{
    fields
    {
        field(50000; "NV8 Source Name"; Text[50])
        {
            Caption = 'Source Name';
            DataClassification = CustomerContent;
            Description = 'UE-377';
        }
    }
}
