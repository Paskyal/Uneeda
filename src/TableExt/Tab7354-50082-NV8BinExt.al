tableextension 50082 "NV8 Bin" extends Bin //7354
{
    fields
    {
        field(50000; "NV8 Allow Consumption"; Boolean)
        {
            Description = 'UE-579';
            DataClassification = CustomerContent;
            Caption = 'Allow Consumption';
        }
        field(60000; "NV8 Excl. from RAW Mat Status"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-202';
            Caption = 'Excl. from RAW Mat Status';
        }
    }
}
