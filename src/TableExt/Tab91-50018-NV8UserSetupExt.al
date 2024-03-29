tableextension 50018 "NV8 User Setup" extends "User Setup" //91
{
    fields
    {
        field(50000; "NV8 Release Credit Hold"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Release Credit Hold';
        }
        field(50001; "NV8 Release Price Hold"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Release Price Hold';
        }
        field(50002; "NV8 Release Manual Hold"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Release Manual Hold';
        }
        field(50003; "NV8 Allow Duplicate Cust. Order"; Boolean)
        {
            Description = 'EC1.SEC4.01';
            DataClassification = CustomerContent;
            Caption = 'Allow Duplicate Cust. Order';
        }
        field(50004; "NV8 Release Item Hold"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Release Item Hold';
        }
        field(51000; "NV8 Assigned Location Code"; Code[20])
        {
            Description = 'EC1.INV4.01';
            TableRelation = Location.Code;
            DataClassification = CustomerContent;
            Caption = 'Assigned Location Code';
        }
        field(51001; "NV8 Allow Undo Finished Prod Order"; Boolean)
        {
            Description = 'EC1.SEC4.01';
            DataClassification = CustomerContent;
            Caption = 'Allow Undo Finished Prod Order';
        }
        field(51002; "NV8 Web"; Boolean)
        {
            Description = 'UE-657';
            DataClassification = CustomerContent;
            Caption = 'Web';
        }
        field(85130; "NV8 Warehouse Location"; Code[10])
        {
            Description = 'EC1.MFG04.01';
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Warehouse Location';
        }
        field(85131; "NV8 Factory Location"; Code[10])
        {
            Description = 'EC1.MFG04.01';
            TableRelation = Location;
            DataClassification = CustomerContent;
            Caption = 'Factory Location';
        }
        field(86000; "NV8 Slitting Threshold Pwd."; Text[30])
        {
            Description = 'UE-546';
            ExtendedDatatype = Masked;
            DataClassification = CustomerContent;
            Caption = 'Slitting Threshold Pwd.';
        }
    }
}
