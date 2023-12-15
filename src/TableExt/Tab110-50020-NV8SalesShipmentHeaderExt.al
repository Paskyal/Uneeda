tableextension 50020 "NV8 Sales Shipment Header" extends "Sales Shipment Header"//110
{
    fields
    {
        field(50000; "NV8 No Charge (Sample)"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50001; "NV8 No Freight Charge"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50002; "NV8 No Minimum Charge"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50003; "NV8 RSQ"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = ' ,Variable,Exact';
            OptionMembers = " ",Variable,Exact;
            DataClassification = CustomerContent;
        }
        field(50004; "NV8 Over/Under %"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50005; "NV8 Packaging Requirement"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = ' ,Standard,Full Box,Private Label';
            OptionMembers = " ",Standard,"Full Box","Private Label";
            DataClassification = CustomerContent;
        }
        field(50006; "NV8 Customer Packaging Type"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = ' ,End User,Distributor';
            OptionMembers = " ","End User",Distributor;
            DataClassification = CustomerContent;
        }
        field(50007; "NV8 Shipment Method Threshold"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50008; "NV8 Shipment Nos. (Text)"; Code[100])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50009; "NV8 No. of Freight Charges"; Integer)
        {
            CalcFormula = count("Sales Invoice Line");
            Description = 'EC1.SAL1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "NV8 Total Freight"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line".Amount where(Type = const("G/L Account")));
            Description = 'EC1.SAL1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "NV8 Created On"; Date)
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50013; "NV8 Edited By"; Code[50])
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50014; "NV8 Edited On"; Date)
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50015; "NV8 Duplicate PO Allowed by"; Code[50])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50016; "NV8 Consignment Order Incomplete"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50022; "NV8 Credit Hold Released By"; Code[50])
        {
            Description = 'UE-397';
            Editable = false;
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(50023; "NV8 Price Hold Released By"; Code[50])
        {
            Description = 'UE-397';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50024; "NV8 Manual Hold Released By"; Code[50])
        {
            Description = 'UE-397';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50025; "NV8 Credit Hold Released On"; Date)
        {
            Description = 'UE-397';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50026; "NV8 Price Hold Released On"; Date)
        {
            Description = 'UE-397';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50027; "NV8 Manual Hold Released On"; Date)
        {
            Description = 'UE-397';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50030; "NV8 Item Hold Released By"; Code[50])
        {
            Description = 'UE-397';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50031; "NV8 Item Hold Released On"; Date)
        {
            Description = 'UE-397';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50035; "NV8 Created By"; Code[50])
        {
            Description = 'UE-302';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50040; "NV8 Original Ordered Amount"; Decimal)
        {
            CalcFormula = sum("Sales Shipment Line"."Original Ordered Amount" where("Document No." = field("No."),
                                                                                     Type = const(Item)));
            DecimalPlaces = 2 : 2;
            Description = 'UE-635';
            FieldClass = FlowField;
        }
        field(50060; "NV8 Freight Chg. Never"; Boolean)
        {
            Description = 'UE-105';
            DataClassification = CustomerContent;
        }
        field(50061; "NV8 Freight Chg.  Always"; Boolean)
        {
            Description = 'UE-105';
            DataClassification = CustomerContent;
        }
        field(50062; "NV8 Freight Chg. Threshhold"; Boolean)
        {
            Description = 'UE-105';
            DataClassification = CustomerContent;
        }
        field(50064; "NV8 No Free Freight"; Boolean)
        {
            Description = 'UE-635';
            DataClassification = CustomerContent;
        }
        field(51002; "NV8 Web"; Boolean)
        {
            Description = 'UE-657';
            DataClassification = CustomerContent;
        }
    }
}
