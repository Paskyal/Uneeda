tableextension 50016 "NV8 Gen. Journal Line" extends "Gen. Journal Line" //81
{
    fields
    {
        field(50000; "NV8 Commissionable Amount"; Decimal)
        {
            Description = 'UE-279';
            DataClassification = CustomerContent;
            Caption = 'Commissionable Amount';
        }
        field(50001; "NV8 Commission Rate"; Decimal)
        {
            Description = 'UE-279';
            DataClassification = CustomerContent;
            Caption = 'Commission Rate';
        }
        field(50010; "NV8 Credit Hold Grace Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-148';
            Caption = 'Credit Hold Grace Due Date';
        }
    }
}
