tableextension 50036 "NV8 Sales & Receivables Setup" extends "Sales & Receivables Setup" //311
{
    fields
    {
        field(50000; "NV8 Sales Price Inactivity Period"; DateFormula)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Sales Price Inactivity Period';
        }
        field(50001; "NV8 Sales Price Quote Exp. Period"; DateFormula)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Sales Price Quote Exp. Period';
        }
        field(50002; "NV8 Sales Activity Period"; DateFormula)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Sales Activity Period';
        }
        field(50003; "NV8 Inactive Terms Code"; Code[10])
        {
            Description = 'EC1.SAL1.01';
            TableRelation = "Payment Terms".Code;
            DataClassification = CustomerContent;
            Caption = 'Inactive Terms Code';
        }
        field(50004; "NV8 Automatic Price Ending Date"; Date)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Automatic Price Ending Date';
        }
        field(50005; "NV8 Inactive Credit Limit"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Inactive Credit Limit';
        }
        field(50006; "NV8 Admin. Hold Credit Warnings"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = 'Both Warnings,Credit Limit,Overdue Balance,No Warning';
            OptionMembers = "Both Warnings","Credit Limit","Overdue Balance","No Warning";
            DataClassification = CustomerContent;
            Caption = 'Admin. Hold Credit Warnings';
        }
        field(50007; "NV8 Quantity Warning Period"; DateFormula)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Quantity Warning Period';
        }
        field(50008; "NV8 Quantity Warning Range"; DateFormula)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Quantity Warning Range';
        }
        field(50009; "NV8 Ship-to Nos."; Code[10])
        {
            Description = 'EC VAR003';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'Ship-to Nos.';
        }
        field(50010; "NV8 Quantity Warning Tolerance %"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Quantity Warning Tolerance %';
        }
        field(50011; "NV8 Web Tax Credit Resource"; Code[20])
        {
            Description = 'UE-654';
            TableRelation = Resource."No.";
            DataClassification = CustomerContent;
            Caption = 'Web Tax Credit Resource';
        }
        field(50012; "NV8 Credit Hold Grace Period"; DateFormula)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-148';
            Caption = 'Credit Hold Grace Period';
        }
    }
}
