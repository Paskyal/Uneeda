tableextension 50019 "NV8 Comment Line" extends "Comment Line"//97
{
    fields
    {
        field(50000; "NV8 Comment Type"; Option)
        {
            Description = 'EC1.SAL1.01,UE-638';
            OptionCaption = ' ,Accounting,Customer Support,Other,Customer';
            OptionMembers = " ",Accounting,"Customer Support",Other,Customer;
            DataClassification = CustomerContent;
            Caption = 'Comment Type';
        }
        field(50001; "NV8 SO/TO Pop-up"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'SO/TO Pop-up';
        }
        field(50002; "NV8 PO Pop-up"; Boolean)
        {
            Description = 'EC1.INV4.01';
            DataClassification = CustomerContent;
            Caption = 'PO Pop-up';
        }
        field(50003; "NV8 Customer No."; Code[20])
        {
            Description = 'UE-638';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
        }
        field(50100; "NV8 Created By"; Text[100])
        {
            DataClassification = CustomerContent;
            Description = 'UNE-107';
            Caption = 'Created By';
        }
        field(85030; "NV8 Print On Production Order"; Boolean)
        {
            Description = 'EC1.INV4.01';
            DataClassification = CustomerContent;
            Caption = 'Print On Production Order';
        }
    }
}
