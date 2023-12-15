tableextension 50003 "NV8 Customer" extends Customer //18
{
    fields
    {
        field(50000; "NV8 Consignment Customer"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //>>EC1.SAL1.01
                if "NV8 Consignment Customer" = false then
                    "NV8 Consignment Location Code" := '';
                //<<EC1.SAL1.01
            end;
        }
        field(50001; "NV8 Consignment Location Code"; Code[10])
        {
            Description = 'EC1.SAL1.01';
            TableRelation = Location;
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                Location: Record Location;
            begin
                "NV8 Consignment Customer" := "NV8 Consignment Location Code" <> '';  //EC1.SAL1.01
                if Location.Get("NV8 Consignment Location Code") then begin
                    if (Location."NV8 Consignment Customer Code" <> '') and (Location."NV8 Consignment Customer Code" <> "No.") then
                        Error('Location %1 is already assigned to %2', Location.Code, Location."NV8 Consignment Customer Code");
                    Location."NV8 Consignment Location" := true;
                    Location."NV8 Consignment Customer Code" := "No.";
                    Location.Modify();
                end;
            end;
        }
        field(50002; "NV8 Customer Class"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = ' ,A,B,C,D';
            OptionMembers = " ",A,B,C,D;
            DataClassification = CustomerContent;
        }
        field(50003; "NV8 Hide Blank Lines"; Boolean)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50004; "NV8 Last Invoice Date"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Document Type" = const(Invoice),
                                                                         "Customer No." = field("No.")));
            Description = 'EC1.SAL1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; "NV8 AP Contact No."; Code[20])
        {
            Description = 'EC1.SAL1.01';
            TableRelation = Contact;
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                ContBusRel.SetCurrentkey("Link to Table", "No.");
                ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
                ContBusRel.SetRange("No.", "No.");
                if ContBusRel.FindFirst() then
                    Cont.SetRange("Company No.", ContBusRel."Contact No.")
                else
                    Cont.SetRange("No.", '');

                if "NV8 AP Contact No." <> '' then
                    if Cont.Get("Primary Contact No.") then;
                if Page.RunModal(0, Cont) = Action::LookupOK then
                    Validate("NV8 AP Contact No.", Cont."No.");
            end;

            trigger OnValidate()
            var
                Cont: Record Contact;
                ContBusRel: Record "Contact Business Relation";
            begin
                "NV8 AP Contact Name" := '';
                "NV8 AP Contact E-Mail" := '';
                if "NV8 AP Contact No." <> '' then begin
                    Cont.Get("NV8 AP Contact No.");

                    ContBusRel.SetCurrentkey("Link to Table", "No.");
                    ContBusRel.SetRange("Link to Table", ContBusRel."link to table"::Customer);
                    ContBusRel.SetRange("No.", "No.");
                    ContBusRel.FindFirst();

                    if Cont."Company No." <> ContBusRel."Contact No." then
                        Error(Text003, Cont."No.", Cont.Name, "No.", Name);

                    if Cont.Type = Cont.Type::Person then begin
                        "NV8 AP Contact Name" := Cont.Name;
                        "NV8 AP Contact E-Mail" := Cont."E-Mail";
                    end;
                end;
            end;
        }
        field(50006; "NV8 AP Contact Name"; Text[50])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                RMSetup: Record "Marketing Setup";
            begin
                if RMSetup.Get() then
                    if RMSetup."Bus. Rel. Code for Customers" <> '' then
                        if (xRec."NV8 AP Contact Name" = '') and (xRec."NV8 AP Contact No." = '') then begin
                            Modify();
                            UpdateContFromCust.OnModify(Rec);
                            // UpdateContFromCust.InsertNewAPContactPerson(Rec, false); //TODo PAP uncomment
                            Modify(true);
                        end
            end;
        }
        field(50007; "NV8 AP Contact E-Mail"; Text[80])
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50008; "NV8 A/R Insurance Coverage ()"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50009; "NV8 RSQ"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = ' ,Variable,Exact';
            OptionMembers = " ",Variable,Exact;
            DataClassification = CustomerContent;
        }
        field(50010; "NV8 Over/Under %"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            InitValue = 10;
            DataClassification = CustomerContent;
        }
        field(50011; "NV8 Packaging Requirement"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = ' ,Standard,Full Box,Private Label';
            OptionMembers = " ",Standard,"Full Box","Private Label";
            DataClassification = CustomerContent;
        }
        field(50012; "NV8 Customer Packaging Type"; Option)
        {
            Description = 'EC1.SAL1.01';
            OptionCaption = ' ,End User,Distributor';
            OptionMembers = " ","End User",Distributor;
            DataClassification = CustomerContent;
        }
        field(50013; "NV8 Shipment Method Threshold"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ShipTo: Record "Ship-to Address";
            begin
                //>> UE105
                if Confirm('Update All Ship-To?', false) then begin
                    ShipTo.SetRange("Customer No.", "No.");
                    if ShipTo.FindFirst() then
                        repeat
                            ShipTo.Validate("NV8 Shipment Method Threshold", "NV8 Shipment Method Threshold");
                            ShipTo.Modify();
                        until ShipTo.Next() = 0;
                end;
                //<< UE-105
            end;
        }
        field(50015; "NV8 Req. Shipping Time"; Option)
        {
            Description = 'EC1.SAL1.01';
            InitValue = "5-Day";
            OptionCaption = ' ,1-Day,2-Day,3-Day,4-Day,5-Day,6-Day,7-Day';
            OptionMembers = " ","1-Day","2-Day","3-Day","4-Day","5-Day","6-Day","7-Day";
            DataClassification = CustomerContent;
        }
        field(50016; "NV8 Created By"; Code[50])
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50017; "NV8 Created On"; Date)
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50018; "NV8 Edited By"; Code[50])
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50019; "NV8 Edited On"; Date)
        {
            Description = 'EC1.SAL1.01';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50020; "NV8 Auto. Price End Date Override"; Date)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
        }
        field(50021; "NV8 Longest Days to Pay"; Decimal)
        {
            BlankZero = true;
            CalcFormula = max("Cust. Ledger Entry"."NV8 Days to Pay" where("Customer No." = field("No."),
                                                                        "Document Type" = const(Invoice),
                                                                        "Document Date" = field("Date Filter")));
            DecimalPlaces = 0 : 0;
            Description = 'EC1.SAL1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50022; "NV8 Average Days to Pay"; Decimal)
        {
            BlankZero = true;
            CalcFormula = average("Cust. Ledger Entry"."NV8 Days to Pay" where("Customer No." = field("No."),
                                                                            "Document Type" = const(Invoice),
                                                                            "Document Date" = field("Date Filter")));
            DecimalPlaces = 0 : 0;
            Description = 'EC1.SAL1.01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50023; "NV8 Credit Hold Grace Period"; DateFormula)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-148';
        }
        field(50024; "NV8 CH Grace Balance Due (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = field("No."),
                                                                                 "NV8 InitEntryCH Grace Due Date" = field(upperlimit("Date Filter")),
                                                                                 "Initial Entry Global Dim. 1" = field("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = field("Currency Filter")));
            Caption = 'CH Grace Balance Due ($)';
            Description = 'UNE-148';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50029; "NV8 Customer Source"; Code[20])
        {
            Description = 'Customer Source, DC082718';
            TableRelation = "NV8 Customer Source Code"."Source Code";
            DataClassification = CustomerContent;
        }
        field(50040; "NV8 Bill-To No.Pstd.Samp.Ord"; Integer)
        {
            CalcFormula = count("Sales Shipment Header" where("Bill-to Customer No." = field("No."),
                                                               "Sell-to Customer No." = filter('206162')));
            Description = 'UE-667';
            FieldClass = FlowField;
        }
        field(50041; "NV8 Bill-To No. Sample Orders"; Integer)
        {
            CalcFormula = count("Sales Header" where("Bill-to Customer No." = field("No."),
                                                      "Sell-to Customer No." = filter('206162')));
            Description = 'UE-667';
            FieldClass = FlowField;
        }
        field(50060; "NV8 Freight Chg. Never"; Boolean)
        {
            Description = 'UE-105';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ShipTo: Record "Ship-to Address";
            begin
                //>> UE-105
                if "NV8 Freight Chg. Never" then begin
                    //"Free Freight" := true; //PAP 14000000
                    "NV8 Freight Chg.  Always" := false;
                    "NV8 Freight Chg. Threshhold" := false;
                end;
                //PAP 14000000
                // else
                // "Free Freight" := false; 

                if Confirm('Update All Ship-To?', false) then begin
                    ShipTo.SetRange("Customer No.", "No.");
                    if ShipTo.FindFirst() then
                        repeat
                            ShipTo.Validate("NV8 Freight Chg. Never", "NV8 Freight Chg. Never");
                            ShipTo.Modify();
                        until ShipTo.Next() = 0;
                end;
                //<< UE-105
            end;
        }
        field(50061; "NV8 Freight Chg.  Always"; Boolean)
        {
            Description = 'UE-105';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ShipTo: Record "Ship-to Address";
            begin
                //>> UE-105
                if "NV8 Freight Chg.  Always" then begin
                    //>> UE-635
                    // "Free Freight" := FALSE;
                    // "Free Freight" := true;  //for first invoice //PAP references 14000000 field
                    //<< UE-635
                    "NV8 Freight Chg. Never" := false;
                    "NV8 Freight Chg. Threshhold" := false;
                end;

                if Confirm('Update All Ship-To?', false) then begin
                    ShipTo.SetRange("Customer No.", "No.");
                    if ShipTo.FindFirst() then
                        repeat
                            ShipTo.Validate("NV8 Freight Chg.  Always", "NV8 Freight Chg.  Always");
                            ShipTo.Modify();
                        until ShipTo.Next() = 0;
                end;

                //<< UE-105
            end;
        }
        field(50062; "NV8 Freight Chg. Threshhold"; Boolean)
        {
            Description = 'UE-105';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ShipTo: Record "Ship-to Address";
            begin
                //>> UE-105
                if "NV8 Freight Chg. Threshhold" then begin
                    //>> UE-635     2/27/19
                    // "Free Freight" := FALSE;
                    // "Free Freight" := true;  //for first invoice  //PAP 14000000range
                    //<< UE-635  2/27/19
                    "NV8 Freight Chg. Never" := false;
                    "NV8 Freight Chg.  Always" := false;
                end;

                if Confirm('Update All Ship-To?', false) then begin
                    ShipTo.SetRange("Customer No.", "No.");
                    if ShipTo.FindFirst() then
                        repeat
                            ShipTo.Validate("NV8 Freight Chg. Threshhold", "NV8 Freight Chg. Threshhold");
                            ShipTo.Modify();
                        until ShipTo.Next() = 0;
                end;

                //<< UE-105
            end;
        }
        field(50063; "NV8 No Free Freight"; Boolean)
        {
            Description = 'UE-635';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ShipTo: Record "Ship-to Address";
            begin
                //>> UE-635
                if "NV8 No Free Freight" then begin
                    //Validate("Free Freight", false);  //PAP 14000000
                    "NV8 Freight Chg.  Always" := false;
                    "NV8 Freight Chg. Threshhold" := false;
                end;
                // PAP 14000000
                //  else
                //     Validate("Free Freight", true);

                if Confirm('Update All Ship-To?', false) then begin
                    ShipTo.SetRange("Customer No.", "No.");
                    if ShipTo.FindFirst() then
                        repeat
                            ShipTo.Validate("NV8 No Free Freight", "NV8 No Free Freight");
                            ShipTo.Modify();
                        until ShipTo.Next() = 0;
                end;
                //<< UE-635
            end;
        }
        field(50064; "NV8 ECOMM Setup"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'BF032023';
        }
        field(51002; "NV8 Web"; Boolean)
        {
            Description = 'UE-657';
            DataClassification = CustomerContent;
        }
        field(51051; "NV8 Additional Shipping Advice"; Option)
        {
            Description = 'EC1.WMS11.01';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
            DataClassification = CustomerContent;
        }
        field(52000; "NV8 Sales Item ($)"; Decimal)
        {
            CalcFormula = sum("Sales Invoice Line"."Line Amount" where("Sell-to Customer No." = field("No."),
                                                                        "NV8 Sales Type" = const(Revenue),
                                                                        Quantity = filter(> 0),
                                                                        "Posting Date" = field("Date Filter")));
            Description = 'UNE-129';
            FieldClass = FlowField;
        }
        field(52001; "NV8 Credits Item ($)"; Decimal)
        {
            CalcFormula = sum("Sales Cr.Memo Line"."Line Amount" where("NV8 Sales Type" = const(Revenue),
                                                                        "Sell-to Customer No." = field("No."),
                                                                        Quantity = filter(> 0),
                                                                        "Posting Date" = field("Date Filter")));
            Description = 'UNE-185';
            FieldClass = FlowField;
        }
    }
    var
        UpdateContFromCust: Codeunit "CustCont-Update";
        Text003: label 'Contact %1 %2 is not related to customer %3 %4.';
}
