Table 50003 "NV8 Global Additional Charge"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Resource No."; Code[20])
        {
            TableRelation = Resource;

            trigger OnValidate()
            var
                Resource: Record Resource;
            begin
                if Resource.Get("Resource No.") then
                    Description := Resource.Name;
            end;
        }
        field(2; "Starting Date"; Date)
        {
        }
        field(3; "Ending Date"; Date)
        {
        }
        field(10; Description; Text[50])
        {
        }
        field(20; "Price Method"; Option)
        {
            OptionCaption = 'Fixed,Calculated,UPS,Min Charge';
            OptionMembers = "Fixed",Calculated,UPS,"Min Charge";
        }
        field(30; Quantity; Decimal)
        {
        }
        field(40; "Unit Price"; Decimal)
        {
        }
        field(50; "Percentage of Invoice"; Decimal)
        {
        }
        field(60; "Freight Handling Charge"; Decimal)
        {
        }
        field(70; "Based on Shipped not Invoiced"; Boolean)
        {
        }
        field(80; "Include G/L Accounts"; Boolean)
        {
        }
        field(90; "Include Resources"; Boolean)
        {
        }
        field(100; "Based on Original Order Only"; Boolean)
        {
        }
        field(110; "Min Invoice Amount Under"; Decimal)
        {
        }
        field(120; "Max Invoice Amount Over"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Resource No.", "Starting Date", "Ending Date")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

