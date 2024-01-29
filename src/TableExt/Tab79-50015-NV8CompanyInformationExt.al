tableextension 50015 "NV8 Company Information" extends "Company Information"  //79
{
    fields
    {
        field(50000; "NV8 Color Logo"; Blob)
        {
            SubType = Bitmap;
            DataClassification = CustomerContent;
            Caption = 'Color Logo';
        }
    }
}
