tableextension 50041 "NV8 Prepayment Inv.Line Buffer" extends "Prepayment Inv. Line Buffer" //461
{
    fields
    {
        field(50000; "NV8 Description 2"; Text[50])
        {
            Description = 'UE-398';
            DataClassification = CustomerContent;
            Caption = 'Description 2';
        }
    }
}
