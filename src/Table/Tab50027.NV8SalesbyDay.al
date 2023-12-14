Table 50027 "NV8 Sales by Day"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Integer)
        {
        }
        field(52000; "Sales Item ($)"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line"."Line Amount" where("Sales Type" = const(Revenue),
                                                                        "Posting Date" = field("Date Filter")));
            Description = 'UNE-168';
            FieldClass = FlowField;
        }
        field(52001; "Credits Item ($)"; Decimal)
        {
            CalcFormula = sum("Sales Cr.Memo Line"."Line Amount" where("Sales Type" = const(Revenue),
                                                                        "Posting Date" = field("Date Filter")));
            Description = 'UNE-168';
            FieldClass = FlowField;
        }
        field(68000; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(68001; "Sales ($)"; Decimal)
        {
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Posting Date" = field("Date Filter"),
                                                                         "Document Type" = filter(Invoice | "Credit Memo")));
            FieldClass = FlowField;
        }
        field(68990; "No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

