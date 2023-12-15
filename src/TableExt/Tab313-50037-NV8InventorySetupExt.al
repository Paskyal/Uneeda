tableextension 50037 "NV8 Inventory Setup" extends "Inventory Setup" //313
{
    fields
    {
        field(50000; "NV8 Ship/Receipt Date Earliest"; Boolean)
        {
            Description = 'UE-556';
            DataClassification = CustomerContent;
        }
        field(50001; "NV8 Safety Stock Percent"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'CAS-29511-Q5Q3Y0';
        }
        field(68001; "NV8 Safety  Stock Formula"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(68002; "NV8 Current usage Formula"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(68003; "NV8 Historical Usage Formula"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(68050; "NV8 Sales Forecast Name"; Code[10])
        {
            Caption = 'Production Forecast Name';
            TableRelation = "Production Forecast Name";
            DataClassification = CustomerContent;
        }
        field(68100; "NV8 Consignment Wksht. Nos."; Code[10])
        {
            Caption = 'Item Nos.';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(68101; "NV8 Roll ID Nos."; Code[10])
        {
            Description = 'EC1.MFG04.01';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(71000; "NV8 Lot Group No. Series"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(71001; "NV8 Auto Lot No. Series"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(71002; "NV8 Allocation Entry No."; Integer)
        {
            Description = 'EC1.LOT1.01';
            DataClassification = CustomerContent;
        }
        field(85000; "NV8 Date 1 Formula"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(85001; "NV8 Date 2 Formula"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(85002; "NV8 Date 3 Formula"; DateFormula)
        {
            DataClassification = CustomerContent;
        }
        field(85010; "NV8 Date 1 Text"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(85011; "NV8 Date 2 Text"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(85012; "NV8 Date 3 Text"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(85021; "NV8 Bin Location Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85025; "NV8 Ext. Doc. No. Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(85030; "NV8 Warehouse Location"; Code[10])
        {
            Description = 'EC1.MFG04.01';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(85031; "NV8 Factory Location"; Code[10])
        {
            Description = 'EC1.MFG04.01';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(85032; "NV8 Jumbo Transit Location"; Code[10])
        {
            Description = 'EC1.MFG04.01';
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(85041; "NV8 Location Filter 1"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(85042; "NV8 Location Filter 2"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(85043; "NV8 Location Filter 3"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(85044; "NV8 Location Filter 4"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(85045; "NV8 Location Filter 5"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(85046; "NV8 Location Filter 6"; Code[10])
        {
            TableRelation = Location;
            DataClassification = CustomerContent;
        }
        field(85100; "NV8 Cost Reporting Method"; Option)
        {
            OptionCaption = 'Unit Price,Profit %,Indirect Cost %,Last Direct Cost,Standard Cost,Estimated Cost,Last Purchase Cost,Raw Material Estimate,Unit Cost,FG Unit Cost';
            OptionMembers = "Unit Price","Profit %","Indirect Cost %","Last Direct Cost","Standard Cost","Estimated Cost","Last Purchase Cost","Raw Material Estimate","Unit Cost","FG Unit Cost";
            DataClassification = CustomerContent;
        }
        field(86000; "NV8 Slitting Approval Threshold %"; Decimal)
        {
            Description = 'UE-546';
            MaxValue = 100;
            MinValue = 0;
            DataClassification = CustomerContent;
        }
    }
}
