tableextension 50056 "NV8 Warehouse Request" extends "Warehouse Request" //5765
{
    fields
    {
        field(50003; "NV8 RSQ"; Option)
        {
            Description = 'EC1.WMS11.01';
            OptionCaption = ' ,Variable,Exact';
            OptionMembers = " ",Variable,Exact;
            DataClassification = CustomerContent;
            Caption = 'RSQ';
        }
        field(50004; "NV8 Over/Under %"; Decimal)
        {
            Description = 'EC1.WMS11.01';
            DataClassification = CustomerContent;
            Caption = 'Over/Under %';
        }
        field(50005; "NV8 Packaging Requirement"; Option)
        {
            Description = 'EC1.WMS11.01';
            OptionCaption = ' ,Standard,Full Box,Private Label';
            OptionMembers = " ",Standard,"Full Box","Private Label";
            DataClassification = CustomerContent;
            Caption = 'Packaging Requirement';
        }
        field(50006; "NV8 Customer Packaging Type"; Option)
        {
            Description = 'EC1.WMS11.01';
            OptionCaption = ' ,End User,Distributor';
            OptionMembers = " ","End User",Distributor;
            DataClassification = CustomerContent;
            Caption = 'Customer Packaging Type';
        }
        field(51002; "NV8 Web"; Boolean)
        {
            Description = 'UE-657';
            DataClassification = CustomerContent;
            Caption = 'Web';
        }
        field(51051; "NV8 Additional Shipping Advice"; Option)
        {
            Description = 'EC1.WMS11.01';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
            DataClassification = CustomerContent;
            Caption = 'Additional Shipping Advice';
        }
        field(51052; "NV8 Ignore Initial Shipping Advice"; Boolean)
        {
            Description = 'EC1.WMS11.01';
            DataClassification = CustomerContent;
            Caption = 'Ignore Initial Shipping Advice';
        }
    }
}
