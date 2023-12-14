Table 85011 "NV8 Configurator Shape-Joints"
{
    DrillDownPageID = UnknownPage85021;
    LookupPageID = UnknownPage85021;
    DataClassification = CustomerContent;

    fields
    {
        field(1; Shape; Code[10])
        {
            NotBlank = true;
            TableRelation = "Configurator Shape";
        }
        field(3; Joint; Code[10])
        {
            NotBlank = true;
            TableRelation = "Configurator Joint";
        }
        field(10; Description; Text[30])
        {
            NotBlank = true;
        }
        field(11; "Description 2"; Text[30])
        {
        }
        field(20; "Material Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Configurator Material";
        }
        field(21; "Valid Shape"; Boolean)
        {
            CalcFormula = exist("Configurator Material-Joints" where("Material Code" = field("Material Filter"),
                                                                      "Joint Code" = field(Joint)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Default Routing No."; Code[20])
        {
            TableRelation = "Routing Header";
        }
        field(55; "Default BOM No."; Code[20])
        {
            TableRelation = "Production BOM Header";

            trigger OnValidate()
            var
                MfgSetup: Record "Manufacturing Setup";
                ProdBOMHeader: Record "Production BOM Header";
                CalcLowLevel: Codeunit "Calculate Low-Level Code";
            begin
            end;
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
        field(85066; Blocked; Boolean)
        {
            Enabled = false;
        }
    }

    keys
    {
        key(Key1; Shape, Joint)
        {
            Clustered = true;
        }
        key(Key2; Joint, Shape)
        {
        }
    }

    fieldgroups
    {
    }
}

