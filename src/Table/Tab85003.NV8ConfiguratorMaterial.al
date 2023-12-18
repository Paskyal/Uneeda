Table 85003 "NV8 Configurator Material"
{
    // UE-651  DB  2/28/20 Added Default Dimension fields
    // UE-651  DB  66/13/20  Expand Item Description and Item Description 2 to 50

    // TODO PAP
    // DrillDownPageID = UnknownPage85006;
    // LookupPageID = UnknownPage85006;
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
        }
        field(10; Description; Text[30])
        {

            trigger OnValidate()
            begin
                if "Description 2" = '' then
                    "Description 2" := Description;
                if "Item Description" = '' then
                    "Item Description" := Description;
                if "Item Description 2" = '' then
                    "Item Description 2" := Description;
            end;
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
        field(80; "Jumbo Std. Width"; Decimal)
        {
        }
        field(81; "Jumbo Std. Length"; Decimal)
        {
        }
        field(90; "Material Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(95; "Replacement Material"; Code[10])
        {
            TableRelation = "NV8 Configurator Material";
        }
        field(100; "Jumbo Min. Width"; Decimal)
        {
        }
        field(101; "Jumbo Min. Length"; Decimal)
        {
        }
        field(102; "Narrow Remnant Min. Width"; Decimal)
        {
        }
        field(103; "Narrow Remnant Min. Length"; Decimal)
        {
        }
        field(104; "Short Remnant Min. Width"; Decimal)
        {
        }
        field(105; "Short Remnant Min. Length"; Decimal)
        {
        }
        field(106; "Scrap Min. Width"; Decimal)
        {
            Description = 'Not Used';
        }
        field(107; "Scrap Min. Length"; Decimal)
        {
        }
        field(150; "Jumbo Pull Formula"; DateFormula)
        {
        }
        field(68000; "Previous Code"; Code[10])
        {
        }
        field(68020; "Default Vendor Classification"; Option)
        {
            OptionMembers = " ",A,B,C;

            trigger OnValidate()
            begin
                if not Confirm('Do you want to set all Grits to this Clasification') then begin
                    Message('The Grits have not been changed');
                    exit;
                end;
                with MaterialGrit do begin
                    Reset();
                    SetCurrentkey("Material Code");
                    SetRange("Material Code", Rec.Code);
                    if Find('-') then
                        repeat
                            Validate("Vendor Classification", Rec."Default Vendor Classification");
                            Modify();
                        until Next() = 0;
                end;
            end;
        }
        field(85000; "Country of Origin"; Code[10])
        {
            TableRelation = "Country/Region".Code;
        }
        field(85066; Blocked; Boolean)
        {
        }
        field(85097; "Material Type"; Option)
        {
            OptionMembers = " ",Paper,Cloth,Combo,Film;
        }
        field(85105; "Estimated Cost"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(85200; "Freight Cost (/m2)"; Decimal)
        {
            DecimalPlaces = 5 : 5;
        }
        field(85201; "Def. Mat. Dimension Code"; Code[20])
        {
            Description = 'UE-651';
            TableRelation = Dimension;
        }
        field(85202; "Def. Mat. Dim. Value Code"; Code[20])
        {
            Description = 'UE-651';
            TableRelation = "Dimension Value".Code where("Dimension Code" = field("Def. Mat. Dimension Code"));
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
        MaterialGrit: Record "NV8 Config Material-Grits";
        SalesLine: Record "Sales Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        CU22: Codeunit "Item Jnl.-Post Line";
        UEI001: label 'You can not rename the components of a Configurator Item';
        UEI002: label 'You can not delete %1, %2 because it is used in %3, %4';


    procedure Jumbostuff()
    begin
        /*
        WITH JumboSales DO BEGIN
          RESET;
          SETCURRENTKEY("Entry Type",Material,Grit,"Source No.","Location Code","Posting Date");
          SETRANGE("Entry Type","Entry Type"::Sale);
          SETRANGE(Material,Item.Material);
          SETRANGE(Grit,Item.Grit);
          SETRANGE("Posting Date",StartDate,EndDate);
          CALCSUMS("Total Area m2","Total Length meters");
          SalesLM := -"Total Length meters";
          SalesM2 := -"Total Area m2";
        
          SETRANGE("Entry Type");
          SETRANGE("Location Code",'AA-FLOOR');
          SETRANGE(Positive,TRUE);
          SETRANGE("Jumbo Pull",TRUE);
          CALCSUMS("Total Area m2","Total Length meters");
          PullLM := "Total Length meters";
          PullM2 := "Total Area m2";
        
          SETRANGE("Posting Date",CALCDATE('-12M',EndDate),EndDate);
          CALCSUMS("Total Area m2","Total Length meters");
          Pull12LM := "Total Length meters";
          Pull12M2 := "Total Area m2";
        END;
        */

    end;
}

