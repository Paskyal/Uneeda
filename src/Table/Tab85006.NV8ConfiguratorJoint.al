Table 85006 "NV8 Configurator Joint"
{
    // UE-651  DB  4/13/20 Added Default Dimension fields
    // UE-651  DB  66/13/20  Expand Item Description and Item Description 2 to 50

    // TODO PAP
    // DrillDownPageID = UnknownPage85012;
    // LookupPageID = UnknownPage85012;
    DataClassification = CustomerContent;

    fields
    {
        field(3; "Code"; Code[10])
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
        field(90; "Usage Comment 1"; Text[80])
        {
        }
        field(91; "Usage Comment 2"; Text[80])
        {
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
        field(105; "Instruction 5"; Text[50])
        {
        }
        field(106; "Instruction 6"; Text[50])
        {
        }
        field(107; "Instruction 7"; Text[50])
        {
        }
        field(108; "Instruction 8"; Text[50])
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
        }
        field(85201; "Def. Joint Dimension Code"; Code[20])
        {
            Description = 'UE-651';
            TableRelation = Dimension;
        }
        field(85202; "Def. Joint Dim. Value Code"; Code[20])
        {
            Description = 'UE-651';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Def. Joint Dimension Code"));
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

    trigger OnDelete()
    begin

        with ConfiguratorItem do begin
            Reset();
            SetCurrentkey(Shape, Material, "Dimension 1", "Dimension 2", "Dimension 3", "Dimension 4", Specification, Grit, Joint);
            SetRange(Joint, Rec.Code);
            if Find('=><') then
                Error(UEI002, Rec.TableName, Rec.Code, TableName, "Configurator No.");
        end;
    end;

    var
        ConfiguratorItem: Record "NV8 Configurator Item";
        UEI001: label 'You can not rename the components of a Configurator Item';
        UEI002: label 'You can not delete %1, %2 because it is used in %3, %4';
}

