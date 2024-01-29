tableextension 50004 "NV8 Cust. Ledger Entry" extends "Cust. Ledger Entry" //21
{
    fields
    {
        field(50000; "NV8 Days Overdue"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Days Overdue';
        }
        field(50001; "NV8 Days to Pay"; Decimal)
        {
            DecimalPlaces = 0 : 0;
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Days to Pay';
        }
        field(50002; "NV8 Open Balance Date"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Open Balance Date';
        }
        field(50003; "NV8 Sell-to Customer Name"; Text[50])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Description = 'EC1.01';
            FieldClass = FlowField;
            Caption = 'Sell-to Customer Name';
        }
        field(51004; "NV8 Credit Hold Grace Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-148';
            Caption = 'Credit Hold Grace Due Date';
        }
        field(52000; "NV8 Sales Item ($)"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line"."Line Amount" where("NV8 Sales Type" = const(Revenue),
                                                                        "Document No." = field("Document No.")));
            Description = 'UNE-168';
            FieldClass = FlowField;
            Caption = 'Sales Item ($)';
        }
        field(52001; "NV8 Credits Item ($)"; Decimal)
        {
            CalcFormula = sum("Sales Cr.Memo Line"."Line Amount" where("NV8 Sales Type" = const(Revenue),
                                                                        "Document No." = field("Document No.")));
            Description = 'UNE-168';
            FieldClass = FlowField;
            Caption = 'Credits Item ($)';
        }
    }
}
