Table 85005 "NV8 Configurator Grit"
{
    // UE-651  DB  4/13/20 Added Default Dimension fields
    // UE-651  DB  66/13/20  Expand Item Description and Item Description 2 to 50

    // TODO PAP
    // DrillDownPageID = UnknownPage85010;
    // LookupPageID = UnknownPage85010;
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
        field(20; "Material Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "NV8 Configurator Material";
        }
        field(21; "Valid Grit"; Boolean)
        {
            CalcFormula = exist("NV8 Config Material-Grits" where("Material Code" = field("Material Filter"),
                                                                     "Grit Code" = field(Code)));
            Editable = false;
            FieldClass = FlowField;
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
        field(90; "Material Item No."; Code[20])
        {
            CalcFormula = lookup("NV8 Config Material-Grits"."Material Item No." where("Material Code" = field("Material Filter"),
                                                                                          "Grit Code" = field(Code)));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = Item;
        }
        field(85066; Blocked; Boolean)
        {
        }
        field(85201; "Def. Grit Dimension Code"; Code[20])
        {
            Description = 'UE-651';
            TableRelation = Dimension;
        }
        field(85202; "Def. Grit Dim. Value Code"; Code[20])
        {
            Description = 'UE-651';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Def. Grit Dimension Code"));
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
            SetCurrentkey(Material, Grit);
            SetRange(Grit, Rec.Code);
            if Find('=><') then
                Error(UEI002, Rec.TableName, Rec.Code, TableName, "Configurator No.");
        end;
        with MaterialGrit do begin
            Reset();
            SetCurrentkey("Grit Code");
            SetRange("Grit Code", Rec.Code);
            if Find('=><') then
                Error(UEI002, Rec.TableName, Rec.Code, TableName, Code);
        end;
    end;

    trigger OnRename()
    begin
        Error(UEI001);
    end;

    var
        ConfiguratorItem: Record "NV8 Configurator Item";
        MaterialGrit: Record "NV8 Config Material-Grits";
        UEI001: label 'You can not rename the components of a Configurator Item';
        UEI002: label 'You can not delete %1, %2 because it is used in %3, %4';
}

