tableextension 50024 "NV8 Sales Cr.Memo Header" extends "Sales Cr.Memo Header" //114
{
    fields
    {
        field(50000; "NV8 No Charge (Sample)"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'No Charge (Sample)';
        }
        field(50001; "NV8 No Freight Charge"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'No Freight Charge';
        }
        field(50002; "NV8 No Minimum Charge"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'No Minimum Charge';
        }
        field(50003; "NV8 RSQ"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = ' ,Variable,Exact';
            OptionMembers = " ",Variable,Exact;
            DataClassification = CustomerContent;
            Caption = 'RSQ';
        }
        field(50004; "NV8 Over/Under %"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Over/Under %';
        }
        field(50005; "NV8 Packaging Requirement"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = ' ,Standard,Full Box,Private Label';
            OptionMembers = " ",Standard,"Full Box","Private Label";
            DataClassification = CustomerContent;
            Caption = 'Packaging Requirement';
        }
        field(50006; "NV8 Customer Packaging Type"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = ' ,End User,Distributor';
            OptionMembers = " ","End User",Distributor;
            DataClassification = CustomerContent;
            Caption = 'Customer Packaging Type';
        }
        field(50007; "NV8 Shipment Method Threshold"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Shipment Method Threshold';
        }
        field(50008; "NV8 Shipment Nos. (Text)"; Code[100])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Shipment Nos. (Text)';
        }
        field(50009; "NV8 No. of Freight Charges"; Integer)
        {
            CalcFormula = count("Sales Invoice Line");
            Description = 'EC1.SAL1.01';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'No. of Freight Charges';
        }
        field(50010; "NV8 Total Freight"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line".Amount where(Type = const("G/L Account")));
            Description = 'EC1.SAL1.01';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Freight';
        }
        field(50012; "NV8 Created On"; Date)
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Created On';
        }
        field(50013; "NV8 Edited By"; Code[50])
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Edited By';
        }
        field(50014; "NV8 Edited On"; Date)
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Edited On';
        }
        field(50015; "NV8 Duplicate PO Allowed by"; Code[50])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Duplicate PO Allowed by';
        }
        field(50016; "NV8 Consignment Order Incomplete"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Consignment Order Incomplete';
        }
        field(50035; "NV8 Created By"; Code[50])
        {
            Description = 'UE-302';
            Editable = false;
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
