Table 85000 "NV8 Configurator Setup"
{
    DataClassification = CustomerContent;
    // UNE-165 11/9/21 DB  Add "Configurator Item Status" Field


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(10; "Prototype No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(11; "Item Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(15; "Raw Material Converter Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(31; "Production BOM Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(32; "Routing Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(34; "Configurator Item Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(35; "Item Prefix"; Code[10])
        {
        }
        field(36; "BOM Prefix"; Code[10])
        {
        }
        field(37; "Routing Prefix"; Code[10])
        {
        }
        field(50; "Minimum Length Shape"; Integer)
        {
        }
        field(51; "Maximum Length Shape"; Integer)
        {
        }
        field(52; "Valid Characters Shape"; Code[250])
        {
        }
        field(60; "Decimals Represent"; Option)
        {
            OptionMembers = Decimals,"64ths";

            trigger OnValidate()
            begin
                if not Confirm(AG001, false) then
                    Error(AG002);
            end;
        }
        field(70; "Default Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(111; "Configurator Code 1"; Code[10])
        {
        }
        field(112; "Configurator Code 2"; Code[10])
        {
        }
        field(113; "Configurator Code 3"; Code[10])
        {
        }
        field(114; "Configurator Code 4"; Code[10])
        {
        }
        field(115; "Configurator Code 5"; Code[10])
        {
        }
        field(116; "Configurator Code 6"; Code[10])
        {
        }
        field(117; "Configurator Code 7"; Code[10])
        {
        }
        field(118; "Configurator Code 8"; Code[10])
        {
        }
        field(119; "Configurator Code 9"; Code[10])
        {
        }
        field(121; "Configurator Text 1"; Text[30])
        {
        }
        field(122; "Configurator Text 2"; Text[30])
        {
        }
        field(123; "Configurator Text 3"; Text[30])
        {
        }
        field(124; "Configurator Text 4"; Text[30])
        {
        }
        field(125; "Configurator Text 5"; Text[30])
        {
        }
        field(126; "Configurator Text 6"; Text[30])
        {
        }
        field(127; "Configurator Text 7"; Text[30])
        {
        }
        field(128; "Configurator Text 8"; Text[30])
        {
        }
        field(129; "Configurator Text 9"; Text[30])
        {
        }
        field(1000; "Allocation Template"; Code[10])
        {
            TableRelation = "Item Journal Template";
        }
        field(1001; "Remnant Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Allocation Template"));
        }
        field(1002; "Remnant Pull Request"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Allocation Template"));
        }
        field(1003; "Jumbo Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Allocation Template"));
        }
        field(1004; "Jumbo Pull Request"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Allocation Template"));
        }
        field(1005; "Return Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Allocation Template"));
        }
        field(1006; "Return List"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Allocation Template"));
        }
        field(1010; "Raw Material Shape"; Code[10])
        {
            TableRelation = "NV8 Configurator Shape" where("Dimensioned Roll" = const(true));
        }
        field(1011; "Re-Cut Shape"; Code[10])
        {
            TableRelation = "NV8 Configurator Shape";
        }
        field(68100; "Purchase Shape Setup"; Code[10])
        {
            Caption = 'Purchase Shape Setup';
            TableRelation = "NV8 Configurator Shape";
        }
        field(68101; "Configurator Item Status"; Option)
        {
            Description = 'UNE-165';
            OptionCaption = 'Prototype,Item,Valid Item,Blocked';
            OptionMembers = Prototype,Item,"Valid Item",Blocked;
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

    var
        Decimal: Decimal;
        "Integer": Integer;
        Numerator: Integer;
        Denominator: Integer;
        AG001: label 'If you change the representation of dimensions, this will not flow through to existing data, and the settings will be Inconsistent.\Do you want to continue.';
        AG002: label 'The changes have not been saved.';
        AG005: label 'The dimension %1 (%2) can not contain more than %3 Characters.';


    procedure GetDecimal(Dimension: Code[10]): Decimal
    begin
        if not Evaluate(Decimal, Dimension) then
            exit(0);
        case "Decimals Represent" of
            "decimals represent"::Decimals:
                exit(Decimal / 100);
            "decimals represent"::"64ths":
                begin
                    Integer := ROUND(Decimal / 100, 1, '<');
                    Decimal := Decimal MOD 100;
                    exit(Integer + ROUND(Decimal / 64, 0.00001));
                end;
        end;
    end;


    procedure GetDecimalText(Dimension: Code[10]): Text[20]
    begin
        if Dimension = '' then
            exit('');
        if not Evaluate(Decimal, Dimension) then
            Decimal := 0;
        Decimal := ROUND(Decimal / 100, 0.01);
        case "Decimals Represent" of
            "decimals represent"::Decimals:
                exit(Format(Decimal));
            "decimals represent"::"64ths":
                begin
                    Integer := Decimal DIV 1;
                    Numerator := Decimal * 100 MOD 100;
                    case Numerator of
                        21: //assume this to be 1/3
                            begin
                                Numerator := 1;
                                Denominator := 3;
                            end;
                        43: // assume this to be 2/3
                            begin
                                Numerator := 2;
                                Denominator := 3;
                            end;
                        else begin
                            Denominator := 64;
                            if Numerator > 63 then
                                Error('The decimal can not be greater than 63/64 ths.');
                            if Numerator = 0 then
                                exit(StrSubstNo('%1', Integer));
                            while (Numerator MOD 2 = 0) do begin
                                Numerator /= 2;
                                Denominator /= 2;
                            end;
                        end;
                    end;
                    if Integer <> 0 then
                        exit(StrSubstNo('%1-%2/%3', Integer, Numerator, Denominator))
                    else
                        exit(StrSubstNo('%1/%2', Numerator, Denominator));
                end;
        end;
    end;


    procedure GetAreaM2(Pieces: Decimal; Dim1: Code[10]; Dim2: Code[10]): Decimal
    var
        Length: Decimal;
        Width: Decimal;
    begin
        if not Evaluate(Width, Dim1) then
            exit(0);
        Width /= 100;
        if not Evaluate(Length, Dim2) then
            Length := 0
        else
            Length /= 100;
        if Length = 0 then
            Length := Width;
        exit(ROUND(Pieces * Width * Length / 39 / 39, 0.00001));
    end;


    procedure SetDimLen(var Dimension: Code[10]; Length: Integer; FieldName: Text[50]; Rule: Option Optional,Blank,Mandatory,Same,"Less Than","Greater Than")
    begin
        if Length = 0 then
            exit;
        if (Rule = Rule::Optional) and (Dimension = '') then
            exit;
        if Length > 10 then
            Length := 10;
        if StrLen(Dimension) > Length then
            Error(AG005, FieldName, Dimension, Length);
        while StrLen(Dimension) < Length do
            Dimension := '0' + Dimension;
    end;


    procedure GetM2(Pieces: Decimal; Width: Decimal; LengthM: Decimal): Decimal
    begin
        exit(ROUND(Pieces * Width * LengthM / 39, 0.00001));
    end;


    procedure GetUnitLength(Quantity: Decimal; Pieces: Decimal; Width: Decimal): Decimal
    begin
        exit(ROUND(Quantity * 39 / Width / Pieces, 0.00001));
    end;
}

