tableextension 50059 "NV8 Warehouse Setup" extends "Warehouse Setup" //5769
{
    fields
    {
        field(50000; "NV8 Warehouse Zone"; Code[20])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = Zone.Code;
            DataClassification = CustomerContent;
        }
        field(50001; "NV8 Floor Zone"; Code[20])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = Zone.Code;
            DataClassification = CustomerContent;
        }
        field(50002; "NV8 Auto Reclass Template"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "Warehouse Journal Template".Name where(Type = const(Reclassification));
            DataClassification = CustomerContent;
        }
        field(50003; "NV8 Auto Reclass Batch"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "Warehouse Journal Batch".Name where("Journal Template Name" = field("Auto Reclass Template"),
                                                                  "Template Type" = const(Reclassification));
            DataClassification = CustomerContent;
        }
        field(50004; "NV8 Put-Away Template"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "Whse. Worksheet Template".Name where(Type = const("Put-away"));
            DataClassification = CustomerContent;
        }
        field(50005; "NV8 Put-Away Worksheet Name"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "Whse. Worksheet Name".Name where("Worksheet Template Name" = field("Put-Away Template"),
                                                               "Template Type" = const("Put-away"));
            DataClassification = CustomerContent;
        }
        field(50006; "NV8 Pick Template Name"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "Whse. Worksheet Template".Name where(Type = const(Pick));
            DataClassification = CustomerContent;
        }
        field(50007; "NV8 Pick Worksheet Name"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "Whse. Worksheet Name".Name where("Worksheet Template Name" = field("Pick Template Name"),
                                                               "Template Type" = const(Pick));
            DataClassification = CustomerContent;
        }
        field(50008; "NV8 Consumption Template Name"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "Item Journal Template".Name where(Type = const(Consumption));
            DataClassification = CustomerContent;
        }
        field(50009; "NV8 Consumption Worksheet Name"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Consumption Template Name"));
            DataClassification = CustomerContent;
        }
        field(50010; "NV8 Waste Adj. Template Name"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "Warehouse Journal Template".Name where(Type = const(Item));
            DataClassification = CustomerContent;
        }
        field(50011; "NV8 Waste Adj. Batch Name"; Code[10])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = "Warehouse Journal Batch".Name where("Journal Template Name" = field("Waste Adj. Template Name"));
            DataClassification = CustomerContent;
        }
        field(50012; "NV8 Floor Zone Filter"; Code[250])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = Zone.Code;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(50013; "NV8 Warehouse Zone Filter"; Code[250])
        {
            Description = 'EC1.LOT1.01';
            TableRelation = Zone.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(50020; "NV8 Last Lot open Entry Processed"; Integer)
        {
            Description = 'UE-559';
            DataClassification = CustomerContent;
        }
    }
}
