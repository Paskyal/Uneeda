tableextension 50000 "NV8 Customer Price Group" extends "Customer Price Group" //6
{
    fields
    {
        field(50000; "NV8 Auto. PriceEndDate Overide"; Date)
        {
            Caption = 'Auto. Price End Date Overide';
            DataClassification = CustomerContent;
            Description = 'EC1.SAL1.01';
        }
    }
}
