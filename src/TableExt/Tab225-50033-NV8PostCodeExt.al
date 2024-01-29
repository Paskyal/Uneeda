tableextension 50033 "NV8 Post Code" extends "Post Code" //225
{
    fields
    {
        field(50000; "NV8 US County"; Text[30])
        {
            Description = 'VAR003';
            DataClassification = CustomerContent;
            Caption = 'US County';
        }
    }
}
