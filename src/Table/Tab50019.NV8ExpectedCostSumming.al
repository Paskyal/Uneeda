Table 50019 "NV8 Expected Cost Summing"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Cost Amount Expected"; Decimal)
        {
        }
        field(3; "Item Ledger Entry Type"; Option)
        {
            Caption = 'Item Ledger Entry Type';
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(4; "Document No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
            SumIndexFields = "Cost Amount Expected";
        }
    }

    fieldgroups
    {
    }
}

