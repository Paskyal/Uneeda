tableextension 50038 "NV8 Detailed Cust. Ledg. Entry" extends "Detailed Cust. Ledg. Entry" //379
{
    fields
    {
        field(50000; "NV8 InitEntryCH Grace Due Date"; Date)
        {
            Caption = 'Initial EntryCH Grace Due Date';
            Description = 'UNE-148';
            DataClassification = CustomerContent;
        }
    }
}
