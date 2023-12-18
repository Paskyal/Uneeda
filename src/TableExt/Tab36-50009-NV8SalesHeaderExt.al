tableextension 50009 "NV8 Sales Header" extends "Sales Header" //36
{
    fields
    {
        field(50000; "NV8 No Charge (Sample)"; Boolean)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ShipToAddress: Record "Ship-to Address";
            begin
                UpdateSalesLines(FieldCaption("No Charge (Sample)"), true);  //EC1.SAL1.01
                //>> UE-372
                if "No Charge (Sample)" = true then
                //>> UE-105
                begin
                    "Freight Chg. Never" := true;
                    //<< UE-105
                    "Free Freight" := true;
                    "Freight Chg.  Always" := false;
                    "Freight Chg. Threshhold" := false;
                    //<< UE-372
                    //>> UE-105
                end else begin
                    ShipToAddress.Get("Sell-to Customer No.", "Ship-to Code");
                    "Freight Chg. Never" := ShipToAddress."Freight Chg. Never";
                    "Freight Chg.  Always" := ShipToAddress."Freight Chg.  Always";
                    "Freight Chg. Threshhold" := ShipToAddress."Freight Chg. Threshhold";
                    Validate("No Free Freight", ShipToAddress."No Free Freight"); //UE-635
                    if "Freight Chg. Never" then
                        "Free Freight" := true
                    else
                        "Free Freight" := false;
                end;
                //<<UE-105
            end;
        }
        field(50001; "NV8 No Freight Charge"; Boolean)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;
        }
        field(50002; "NV8 No Minimum Charge"; Boolean)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;
        }
        field(50003; "NV8 RSQ"; Option)
        {
            Description = 'EC1SAL1..01';
            OptionCaption = ' ,Variable,Exact';
            OptionMembers = " ",Variable,Exact;
            DataClassification = CustomerContent;
        }
        field(50004; "NV8 Over/Under %"; Decimal)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;
        }
        field(50005; "NV8 Packaging Requirement"; Option)
        {
            Description = 'EC1SAL1..01';
            OptionCaption = ' ,Standard,Full Box,Private Label';
            OptionMembers = " ",Standard,"Full Box","Private Label";
            DataClassification = CustomerContent;
        }
        field(50006; "NV8 Customer Packaging Type"; Option)
        {
            Description = 'EC1SAL1..01';
            OptionCaption = ' ,End User,Distributor';
            OptionMembers = " ","End User",Distributor;
            DataClassification = CustomerContent;
        }
        field(50007; "NV8 Shipment Method Threshold"; Decimal)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;
        }
        field(50008; "NV8 Shipment Nos. (Text)"; Code[100])
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;
        }
        field(50009; "NV8 No. of Freight Charges"; Integer)
        {
            CalcFormula = count("Sales Invoice Line");
            Description = 'EC1SAL1..01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50010; "NV8 Total Freight"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line".Amount where(Type = const("G/L Account")));
            Description = 'EC1SAL1..01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "NV8 Created On"; Date)
        {
            Description = 'EC1SAL1..01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50013; "NV8 Edited By"; Code[50])
        {
            Description = 'EC1SAL1..01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50014; "NV8 Edited On"; Date)
        {
            Description = 'EC1SAL1..01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50015; "NV8 Duplicate PO Allowed by"; Code[50])
        {
            Description = 'EC1SAL1..01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(50016; "NV8 Consignment Order Incomplete"; Boolean)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;
        }
        field(50017; "NV8 Order On Hold"; Boolean)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;
        }
        field(50018; "NV8 Credit Hold"; Boolean)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>>EC1.SAL1.01
                if xRec."Credit Hold" then begin
                    UserSetup.Get(UserId);
                    if UserSetup."Release Credit Hold" then begin
                        "Credit Hold Released By" := UserId;
                        "Credit Hold Released On" := WorkDate();
                        Modify();
                    end else
                        Error(Text50003);

                end;
                UpdateHoldStatus;
            end;
        }
        field(50019; "NV8 Price Hold"; Boolean)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>>EC1.SAL1.01
                if xRec."Price Hold" then begin
                    UserSetup.Get(UserId);
                    if UserSetup."Release Price Hold" then begin
                        "Price Hold Released By" := UserId;
                        "Price Hold Released On" := WorkDate();
                        Modify();
                    end else
                        Error(Text50003);

                end;
                UpdateHoldStatus;
            end;
        }
        field(50020; "NV8 Manual Hold"; Boolean)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>>EC1.SAL1.01
                if "Manual Hold" then
                    Error(Text50002);

                "Hold Reason Code" := '';
                if xRec."Manual Hold" then begin
                    UserSetup.Get(UserId);
                    if UserSetup."Release Manual Hold" then begin
                        "Manual Hold Released By" := UserId;
                        "Manual Hold Released On" := WorkDate();
                        Modify();
                    end else
                        Error(Text50003);

                end;
                UpdateHoldStatus;
            end;
        }
        field(50021; "NV8 Hold Reason Code"; Code[10])
        {
            Description = 'EC1SAL1..01';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>>EC1.SAL1.01
                if "Hold Reason Code" <> '' then
                    "Manual Hold" := true;
                // need to trigger update
                UpdateHoldStatus;
            end;
        }
        field(50022; "NV8 Credit Hold Released By"; Code[50])
        {
            Description = 'EC1SAL1..01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(50023; "NV8 Price Hold Released By"; Code[50])
        {
            Description = 'EC1SAL1..01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(50024; "NV8 Manual Hold Released By"; Code[50])
        {
            Description = 'EC1SAL1..01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(50025; "NV8 Credit Hold Released On"; Date)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;
        }
        field(50026; "NV8 Price Hold Released On"; Date)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;
        }
        field(50027; "NV8 Manual Hold Released On"; Date)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;
        }
        field(50028; "NV8 Order Released"; Boolean)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;
        }
        field(50029; "NV8 Item Hold"; Boolean)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>>EC1.SAL1.01
                if xRec."Item Hold" then begin
                    UserSetup.Get(UserId);
                    if UserSetup."Release Item Hold" then begin
                        "Item Hold Released By" := UserId;
                        "Item Hold Released On" := WorkDate();
                        Modify();
                        SalesLine.Reset();
                        SalesLine.SetRange("Document Type", "Document Type");
                        SalesLine.SetRange("Document No.", "No.");
                        SalesLine.SetRange("Item Hold", true);
                        SalesLine.ModifyAll("Item Hold", false);
                    end else
                        Error(Text50003);

                end;
                UpdateHoldStatus;
            end;
        }
        field(50030; "NV8 Item Hold Released By"; Code[50])
        {
            Description = 'EC1SAL1..01';
            TableRelation = User."User Name";
            DataClassification = CustomerContent;
        }
        field(50031; "NV8 Item Hold Released On"; Date)
        {
            Description = 'EC1SAL1..01';
            DataClassification = CustomerContent;
        }
        field(50035; "NV8 Created By"; Code[50])
        {
            Description = 'UE-302';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(50040; "NV8 Original Ordered Amount"; Decimal)
        {
            CalcFormula = sum("Sales Line"."Original Ordered Amount" where("Document Type" = field("Document Type"),
                                                                            "Document No." = field("No."),
                                                                            Type = const(Item)));
            DecimalPlaces = 2 : 2;
            Description = 'UE-105';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //>>UE-105
                CalcFields("Original Ordered Amount");
                if "Original Ordered Amount" = 1044 then begin
                    Jimbo := true;
                end;

                if "Freight Chg. Threshhold" then begin   //>> UE-105  4/5/16

                    if "Original Ordered Amount" >= "Shipment Method Threshold" then
                        "Free Freight" := true
                    else begin
                        GetCust("Sell-to Customer No.");
                        ShipToAddr.Init;
                        if "Ship-to Code" <> '' then
                            ShipToAddr.Get("Sell-to Customer No.", "Ship-to Code");
                        if (Cust."Free Freight" = false) and
                           (ShipToAddr."Free Freight" = false) then
                            "Free Freight" := false;
                    end;
                    Modify();
                    //>>UE-105

                end;  //>> UE-105  4/5/16
            end;
        }
        field(50060; "NV8 Freight Chg. Never"; Boolean)
        {
            Description = 'UE-105';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>> UE-105
                if "Freight Chg. Never" then begin
                    "Free Freight" := true;
                    "Freight Chg.  Always" := false;
                    "Freight Chg. Threshhold" := false;
                end else
                    "Free Freight" := false;
                //<< UE-105
            end;
        }
        field(50061; "NV8 Freight Chg.  Always"; Boolean)
        {
            Description = 'UE-105';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>> UE-105
                if "Freight Chg.  Always" then begin
                    "Free Freight" := false;
                    "Freight Chg. Never" := false;
                    "Freight Chg. Threshhold" := false;
                end;
                //<< UE-105
            end;
        }
        field(50062; "NV8 Freight Chg. Threshhold"; Boolean)
        {
            Description = 'UE-105';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>> UE-105
                if "Freight Chg. Threshhold" then begin
                    "Free Freight" := false;
                    "Freight Chg. Never" := false;
                    "Freight Chg.  Always" := false;
                end;
                //<< UE-105
            end;
        }
        field(50063; "NV8 Freight Check Run"; Boolean)
        {
            Description = 'UE-635';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50064; "NV8 No Free Freight"; Boolean)
        {
            Description = 'UE-635';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>> UE-635
                if "No Free Freight" then begin
                    Validate("Free Freight", false);
                    "Freight Chg.  Always" := false;
                    "Freight Chg. Threshhold" := false;
                    "Free Freight" := false;
                end;
                //<< UE-635
            end;
        }
        field(50065; "NV8 Blanket"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'BF11-18-22';

            trigger OnValidate()
            begin
                UpdateSalesLines(FieldCaption(Blanket), true);  //CAS-37795-W2P2K8
            end;
        }
        field(51002; "NV8 Web"; Boolean)
        {
            Description = 'UE-657';
            DataClassification = CustomerContent;
        }
        field(51003; "NV8 Comments Displayed"; Boolean)
        {
            Description = 'UE-657';
            DataClassification = CustomerContent;
        }
        field(51004; "NV8 Credit Hold Grace Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-148';
        }
        field(51051; "NV8 Additional Shipping Advice"; Option)
        {
            Description = 'EC1.WMS11.01';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
            DataClassification = CustomerContent;
        }
        field(51052; "NV8 Ignore Initial Shipping Advice"; Boolean)
        {
            Description = 'EC1.WMS11.01';
            DataClassification = CustomerContent;
        }
        field(52000; "NV8 Original Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-175';
        }
    }
}
