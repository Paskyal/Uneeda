tableextension 50006 "NV8 Vendor Ledger Entry" extends "Vendor Ledger Entry" //25
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
    }
}
