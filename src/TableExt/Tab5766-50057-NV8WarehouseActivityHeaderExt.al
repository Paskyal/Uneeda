tableextension 50057 "NV8 Warehouse Activity Header" extends "Warehouse Activity Header" //5766
{
    fields
    {
        field(50000; "NV8 Slitting Put/Pick"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Slitting Put/Pick';
        }
        field(50001; "NV8 Creation Date"; Date)
        {
            Description = 'UE-340';
            DataClassification = CustomerContent;
            Caption = 'Creation Date';
        }
        field(50002; "NV8 Created By"; Code[50])
        {
            Description = 'UE-340';
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }
        field(51002; "NV8 Web"; Boolean)
        {
            Description = 'UE-657';
            DataClassification = CustomerContent;
            Caption = 'Web';
        }
    }
}
