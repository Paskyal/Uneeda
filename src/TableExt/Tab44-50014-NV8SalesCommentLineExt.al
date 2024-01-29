tableextension 50014 "NV8 Sales Comment Line" extends "Sales Comment Line" //44
{
    fields
    {
        field(50100; "NV8 Created By"; Text[100])
        {
            DataClassification = CustomerContent;
            Description = 'UNE-107';
            Caption = 'Created By';
        }
    }
}
