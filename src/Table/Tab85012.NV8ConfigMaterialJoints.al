Table 85012 "NV8 Config Material-Joints"
{
    // TODO PAP
    // DrillDownPageID = UnknownPage85022;
    // LookupPageID = UnknownPage85022;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Material Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = "NV8 Configurator Material";
        }
        field(3; "Joint Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = "NV8 Configurator Joint";
        }
        field(10; Description; Text[30])
        {
            NotBlank = true;
        }
        field(11; "Description 2"; Text[30])
        {
        }
        field(90; "Usage Comment 1"; Text[80])
        {
        }
        field(91; "Usage Comment 2"; Text[80])
        {
        }
        field(101; "Specification 1"; Text[50])
        {
        }
        field(102; "Specification 2"; Text[50])
        {
        }
        field(103; "Specification 3"; Text[50])
        {
        }
        field(104; "Specification 4"; Text[50])
        {
        }
        field(105; "Specification 5"; Text[50])
        {
        }
        field(106; "Specification 6"; Text[50])
        {
        }
        field(107; "Specification 7"; Text[50])
        {
        }
        field(108; "Specification 8"; Text[50])
        {
        }
        field(110; "Material Cost/inch"; Decimal)
        {
        }
        field(111; "Labour Cost/inch"; Decimal)
        {
        }
        field(85055; "Unit Width Code"; Code[10])
        {
            CharAllowed = '09';
        }
        field(85066; Blocked; Boolean)
        {
            Enabled = false;
        }
        field(85090; "Consignment Location"; Code[10])
        {
            Editable = false;
        }
        field(85091; "Consignment Customer"; Code[20])
        {
            CalcFormula = lookup(Location."NV8 Consignment Customer Code" where(Code = field("Consignment Location")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Customer;
        }
    }

    keys
    {
        key(Key1; "Material Code", "Joint Code")
        {
            Clustered = true;
        }
        key(Key2; "Joint Code", "Material Code")
        {
        }
    }

    fieldgroups
    {
    }
}

