tableextension 50068 "NV8 Price List Line" extends "Price List Line" //7001
//PAP 
// Table 7002 Sales Price is marked for removal, added custom fields from Table 7002 to Table 7001 Price List Line
{
    fields
    {
        field(50000; "NV8 Special Price Code"; Code[10])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50001; "NV8 Item Blocked"; Boolean)
        {
            // CalcFormula = lookup(Item.Blocked where("No." = field("Item No."))); //TODO PAP Check the field
            Description = 'EC1.SAL1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "NV8 Customer Name"; Text[50])
        {
            // CalcFormula = lookup(Customer.Name where("No." = field("Sales Code"))); //TODO PAP
            Description = 'EC1.SAL1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "NV8 Item Description"; Text[100])
        {
            Description = 'EC1.SAL1.01,CAS-40665-Y3X3S1';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50004; "NV8 Item Description 2"; Text[50])
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            FieldClass = Normal;
            DataClassification = CustomerContent;
        }
        field(50005; "NV8 Customer Blocked"; Option)
        {
            // CalcFormula = lookup(Customer.Blocked where("No." = field("Sales Code")));// TODO PAP
            Description = 'EC1.SAL1.01';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = ' ,Ship,Invoice,All';
            OptionMembers = " ",Ship,Invoice,All;
        }
        field(50006; "NV8 Configurator No."; Code[100])
        {
            Description = 'EC1.SAL1.01';
            TableRelation = "NV8 Configurator Item"."Configurator No.";
            DataClassification = CustomerContent;
            // TODO PAP uncomment
            // trigger OnValidate()
            // var
            //     ConfigItem: Record "NV8 Configurator Item";
            // begin
            //     //EC1.SAL1.01
            //     if ConfigItem.Get("NV8 Configurator No.") then begin
            //         if "Item No." <> ConfigItem."Item No." then
            //             Validate("Item No.", ConfigItem."Item No.");
            //         Shape := ConfigItem.Shape;
            //     end;
            // end;
        }
        field(50007; "NV8 Shape"; Code[10])
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50008; "NV8 Created Date"; Date)
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50009; "NV8 Status"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = 'Quote,Active,On Hold,Closed,Inactive,New Quote,Expired Quote';
            OptionMembers = "New Quote",Active,"On Hold",Closed,Inactive,Quote,"Expired Quote";
            DataClassification = CustomerContent;
        }
        field(50010; "NV8 Item Search Description"; Code[200])
        {
            // CalcFormula = lookup(Item."Search Description" where("No." = field("Item No.")));//TODO PAP
            Description = 'EC1.SAL1.01';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
