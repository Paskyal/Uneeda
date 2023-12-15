tableextension 50004 "NV8 Cust. Ledger Entry" extends "Cust. Ledger Entry" //21
{
    fields
    {
        field(50000; "NV8 Days Overdue"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50001; "NV8 Days to Pay"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50002; "NV8 Open Balance Date"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50003; "NV8 Sell-to Customer Name"; Text[50])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Description = 'EC1.01';
            FieldClass = FlowField;
        }
        field(51004; "NV8 Credit Hold Grace Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-148';
        }
        field(52000; "Sales Item ($)"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line"."Line Amount" where("Sales Type" = const(Revenue),
                                                                        "Document No." = field("Document No.")));
            Description = 'UNE-168';
            FieldClass = FlowField;
        }
        field(52001; "Credits Item ($)"; Decimal)
        {
            CalcFormula = sum("Sales Cr.Memo Line"."Line Amount" where("Sales Type" = const(Revenue),
                                                                        "Document No." = field("Document No.")));
            Description = 'UNE-168';
            FieldClass = FlowField;
        }
    }
}
