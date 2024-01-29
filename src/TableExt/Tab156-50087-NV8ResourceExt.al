tableextension 50087 "NV8 Resource" extends Resource //156
{
    fields
    {
        field(50000; "NV8 Sales Type"; Option)
        {
            Description = 'EC1.SAL1.01,UE-462';
            InitValue = Other;
            OptionCaption = 'Revenue,Freight,Surcharge,Minimum Charge,Other';
            OptionMembers = Revenue,Freight,Surcharge,"Minimum Charge",Other;
            DataClassification = CustomerContent;
            Caption = 'Sales Type';
        }
        field(50001; "NV8 Exclude from Sales Stats"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Exclude from Sales Stats';
        }
    }
}
