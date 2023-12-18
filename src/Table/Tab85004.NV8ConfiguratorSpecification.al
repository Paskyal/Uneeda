Table 85004 "NV8 Configurator Specification"
{
    // UE-651  DB  4/13/20 Added Default Dimension fields
    // UE-651  DB  66/13/20  Expand Item Description and Item Description 2 to 50

    // TODO PAP
    // DrillDownPageID = UnknownPage85008;
    // LookupPageID = UnknownPage85008;
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(10; Description; Text[30])
        {
            NotBlank = true;
        }
        field(11; "Description 2"; Text[30])
        {
        }
        field(30; "Item Description"; Text[50])
        {
            Description = 'UE-651';
        }
        field(31; "Item Description 2"; Text[50])
        {
            Description = 'UE-651';
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
        field(101; "Instruction 1"; Text[50])
        {
        }
        field(102; "Instruction 2"; Text[50])
        {
        }
        field(103; "Instruction 3"; Text[50])
        {
        }
        field(104; "Instruction 4"; Text[50])
        {
        }
        field(85066; Blocked; Boolean)
        {
        }
        field(85201; "Def. Spec. Dimension Code"; Code[20])
        {
            Description = 'UE-651';
            TableRelation = Dimension;
        }
        field(85202; "Def. Spec. Dim. Value Code"; Code[20])
        {
            Description = 'UE-651';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Def. Spec. Dimension Code"));
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ConfiguratorItem: Record "NV8 Configurator Item";
        UEI001: label 'You can not rename the components of a Configurator Item';
        UEI002: label 'You can not delete %1, %2 because it is used in %3, %4';
}

