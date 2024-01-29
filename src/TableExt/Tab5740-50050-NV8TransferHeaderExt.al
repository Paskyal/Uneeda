tableextension 50050 "NV8 Transfer Header" extends "Transfer Header" //5740
{
    fields
    {
        field(50000; "NV8 Picking Instructions"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Picking Instructions';
        }
        field(50010; "NV8 Print From Location"; Option)
        {
            OptionMembers = UNY,EkaSou,NW,SW,WWC;
            DataClassification = CustomerContent;
            Caption = 'Print From Location';
        }
        field(51051; "NV8 Additional Shipping Advice"; Option)
        {
            Description = 'EC1.WMS11.01';
            OptionCaption = 'Partial,Complete';
            OptionMembers = Partial,Complete;
            DataClassification = CustomerContent;
            Caption = 'Additional Shipping Advice';
        }
        field(51052; "NV8 Ignore Initial Shipping Advice"; Boolean)
        {
            Description = 'EC1.WMS11.01';
            DataClassification = CustomerContent;
            Caption = 'Ignore Initial Shipping Advice';
        }
        field(52000; "NV8 Original Shipment Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'UNE-175';
            Caption = 'Original Shipment Date';
        }
        field(68046; "NV8 Req. Shipping Time"; Option)
        {
            OptionMembers = Standard,"1-Day","2-Day","3-Day","4-Day","5-Day";
            DataClassification = CustomerContent;
            Caption = 'Req. Shipping Time';
        }
        field(68084; "NV8 PSL Lines"; Boolean)
        {
            CalcFormula = exist("Transfer Line" where("Document No." = field("No."),
                                                       "NV8 PSL Locked" = const(true),
                                                       "Outstanding Quantity" = filter(> 0.00001),
                                                       "Derived From Line No." = const(0)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'PSL Lines';
        }
        field(68085; "NV8 CNL Lines"; Boolean)
        {
            CalcFormula = exist("Transfer Line" where("Document No." = field("No."),
                                                       "NV8 CNL" = const(true),
                                                       "Outstanding Quantity" = filter(> 0)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'CNL Lines';
        }
        field(68086; "NV8 Requested Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Requested Receipt Date';
        }
        field(68100; "NV8 Order Queue Status"; Option)
        {
            Description = ',Entering,,,,Ready To Plan,Planning,Planned,,,,Ready To Pick,Picking,Picked,,,,Ready To Ship,Shipping,Shipped,,,,Billing,,,Complete';
            OptionMembers = ,Entering,,,,"Ready To Plan","To Be Picked",Production,,"Back Order","Needs Attention",,Picking,Picked,,,,"Ready To Ship",,Shipped;
            DataClassification = CustomerContent;
            Caption = 'Order Queue Status';
            trigger OnValidate()
            begin
                /*IF "Order Queue Status" <> xRec."Order Queue Status" THEN BEGIN
                  SalesSetup.GET;
                  IF SalesSetup."Sync Order Queue" THEN
                    SyncOrder;
                END;
                */

            end;
        }
        field(68101; "NV8 Allocation Status"; Option)
        {
            OptionMembers = "Nothing Available","Partially Available","Fully Available","In Stock Unavailable","Partially Allocated","Fully Allocated";
            DataClassification = CustomerContent;
            Caption = 'Allocation Status';
        }
        field(68102; "NV8 Bulk Ship"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Bulk Ship';
        }
        field(68110; "NV8 Sec. Territory Code"; Code[10])
        {
            TableRelation = Territory;
            DataClassification = CustomerContent;
            Caption = 'Sec. Territory Code';
        }
        field(68500; "NV8 Freight Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
            Caption = 'Freight Amount';
        }
        field(68501; "NV8 Freight Charged"; Decimal)
        {
            DecimalPlaces = 2 : 2;
            DataClassification = CustomerContent;
            Caption = 'Freight Charged';
        }
        field(85016; "NV8 Manual Hold"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Manual Hold';
            trigger OnValidate()
            begin
                "NV8 Hold Reason Code" := '';
                "NV8 Put on Hold By" := UserId;
            end;
        }
        field(85017; "NV8 Hold Reason Code"; Code[10])
        {
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
            Caption = 'Hold Reason Code';
            trigger OnValidate()
            begin
                if "NV8 Hold Reason Code" <> '' then begin
                    "NV8 Manual Hold" := true;
                    "NV8 Put on Hold By" := UserId;
                end;
            end;
        }
        field(85018; "NV8 Put on Hold By"; Code[20])
        {
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'Put on Hold By';
        }
        field(85038; "NV8 RSQ"; Option)
        {
            Description = 'AG046  vmj 07.09.02';
            InitValue = Variable;
            OptionCaption = ' ,Variable,Exact';
            OptionMembers = " ",Variable,Exact;
            DataClassification = CustomerContent;
            Caption = 'RSQ';
            trigger OnValidate()
            var
                ProdOrder: Record "Production Order";
            begin
                ProdOrder.SetFilter(Status, '%1|%2', ProdOrder.Status::"Firm Planned", ProdOrder.Status::Released);
                ProdOrder.SetRange("NV8 Source Doc Type", ProdOrder."NV8 source doc type"::"Transfer Order");
                ProdOrder.SetRange("NV8 Source Doc No.", "No.");
                if ProdOrder.FindFirst() then
                    repeat
                        ProdOrder."NV8 RSQ" := "NV8 RSQ";
                        ProdOrder.Modify();
                    until ProdOrder.Next() = 0;
            end;
        }
        field(85041; "NV8 Red Dot"; Boolean)
        {
            CalcFormula = exist("Transfer Line" where("Document No." = field("No."),
                                                       "NV8 Red Dot" = const(true)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Red Dot';
        }
        field(85042; "NV8 Red Dot Level"; Option)
        {
            Description = 'Not used';
            OptionMembers = "1","2","3";
            DataClassification = CustomerContent;
            Caption = 'Red Dot Level';
        }
        field(85043; "NV8 Must Ship"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Must Ship';
        }
        field(85044; "NV8 Original Ship Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Original Ship Date';
        }
        field(85045; "NV8 Created By"; Code[200])
        {
            Editable = false;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }
        field(85046; "NV8 Created On"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Created On';
        }
        field(85047; "NV8 Edited By"; Code[200])
        {
            Editable = false;
            TableRelation = User;
            DataClassification = CustomerContent;
            Caption = 'Edited By';
        }
        field(85048; "NV8 Edited On"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Edited On';
        }
        field(85049; "NV8 Exported On"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Exported On';
        }
        field(85050; "NV8 Next Ship Date"; Date)
        {
            CalcFormula = min("Transfer Line"."Shipment Date" where("Document No." = field("No."),
                                                                     "Outstanding Quantity" = filter(<> 0),
                                                                     "Derived From Line No." = const(0)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Next Ship Date';
        }
        field(85058; "NV8 Sales Reps (All)"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Reps (All)';
            trigger OnLookup()
            var
                SalesReps: Record "Salesperson/Purchaser";
            begin
                SalesReps.Reset();
                //SalesReps.SETFILTER(Code,STRSUBSTNO('%1',"Sales Reps (All)"));
                Page.RunModal(0, SalesReps);
            end;
        }
        field(85090; "NV8 Consignment Location"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Consignment Location';
        }
        field(85091; "NV8 Consignment Customer"; Code[20])
        {
            TableRelation = Customer;
            DataClassification = CustomerContent;
            Caption = 'Consignment Customer';
            // TODO PAP Uncomment
            // trigger OnValidate()
            // begin
            //     if Cust.Get("NV8 Consignment Customer") then begin
            //         "NV8 RSQ" := Cust.RSQ; //rsq
            //         "NV8 Req. Shipping Time" := Cust."Req. Shipping Time";
            //     end;
            // end;
        }
        field(85093; "NV8 Customer Name"; Text[30])
        {
            CalcFormula = lookup(Customer.Name where("No." = field("NV8 Consignment Customer")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Customer Name';
        }
        field(85140; "NV8 Hide Blank Lines"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Hide Blank Lines';
        }
        field(85150; "NV8 No. of Cartons"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Cartons';
        }
        field(85151; "NV8 No. of Pallets"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Pallets';
        }
        field(85152; "NV8 Total Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Weight';
        }
        field(85153; "NV8 Class"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Class';
        }
        field(89100; "NV8 Pick List"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Pick List';
            trigger OnValidate()
            begin
                /*IF ("Pick List" = '') AND (xRec."Pick List"= '') THEN
                  EXIT;
                
                IF ("Pick List" = '') THEN BEGIN // AND (xRec."Pick List" <> '') THEN BEGIN
                  IF NOT CONFIRM('Do you want to remove ALL the Transfer lines from Picking on this order?',FALSE) THEN BEGIN
                    ERROR('The Transfer Lines have not been released.');
                  END;
                END ELSE BEGIN
                  PickListHeader.GET("Pick List");
                  TESTFIELD("Transfer-from Code",PickListHeader."Location Code");
                END;
                
                {
                WITH TransferLine DO BEGIN
                  LOCKTABLE;
                  RESET;
                  SETRANGE("Document No.",Rec."No.");
                  IF Rec."Pick List" <> '' THEN BEGIN
                    SETFILTER("Pick List",'%1','');
                    SETFILTER("Qty. to Ship",'>%1',0);
                  END;
                  IF NOT FIND('-') THEN
                    ERROR('There are no lines on this order to Pick.');
                  REPEAT
                    "Pick List" := Rec."Pick List";
                    MODIFY;
                  UNTIL NEXT = 0;
                END;
                }
                
                //>> UEI-403
                IF "Order Queue Status" = "Order Queue Status"::Entering THEN
                  FIELDERROR("Order Queue Status",'must not be Entering');
                IF "Order Queue Status" = "Order Queue Status"::"Ready To Plan" THEN
                  FIELDERROR("Order Queue Status",'must not Ready to Plan');
                //<< UEI-403
                //>> UEI-482
                IF "Pick List" <> '' THEN BEGIN
                  TransferLine.RESET;
                  TransferLine.SETRANGE("Document No.","No.");
                  TransferLine.SETFILTER("Pick List",'<>''''');
                  IF TransferLine.FINDFIRST THEN
                    ERROR('MUST REMOVE CURRENT PICK BEFORE ASSIGNING A NEW PICK');
                END;
                //<< UEI-482
                
                IF Rec."Pick List" <> '' THEN BEGIN
                  WITH TransferLine DO BEGIN
                    LOCKTABLE;
                    RESET;
                    SETRANGE("Document No.",Rec."No.");
                    //?? do we want only the blank ones
                    SETFILTER("Pick List",'%1','');
                    SETFILTER("Qty. to Ship",'>=%1',0);
                    IF FINDSET THEN BEGIN
                      REPEAT
                        CALCFIELDS("Reserved Inventory");
                        IF "Reserved Inventory" > 0 THEN BEGIN
                          "Pick List" := Rec."Pick List";
                        END;
                        IF "Qty. to Ship" <> "Reserved Inventory" THEN
                          VALIDATE("Qty. to Ship","Reserved Inventory");
                        MODIFY;
                      UNTIL NEXT = 0;
                    END;
                    //>> UEI-403
                    //IF NOT PickFound THEN
                    //  ERROR('There are no lines on this order to Pick.');
                    //<< UEI-403
                  END;
                END ELSE BEGIN
                  WITH TransferLine DO BEGIN
                    LOCKTABLE;
                    RESET;
                    SETRANGE("Document No.",Rec."No.");
                    // SETRANGE("Pick List",Rec."Pick List");
                    IF FINDSET THEN BEGIN
                      REPEAT
                        "Pick List" := '';
                        MODIFY;
                      UNTIL NEXT = 0;
                    END;
                  END;
                END;
                
                
                // Picking
                //>> UEI-403
                IF ("Pick List" <> '') AND ("Pick List" <> xRec."Pick List") THEN
                  VALIDATE("Order Queue Status","Order Queue Status"::Picking)
                ELSE IF "Pick List" = '' THEN BEGIN
                  "Order Queue Status" := "Order Queue Status"::"Ready To Plan";
                  ChangeOrderStatus(TRUE);
                END;
                //<< UEI-403
                    */

            end;
        }
        field(89101; "NV8 Pick Quantity"; Decimal)
        {
            BlankZero = true;
            CalcFormula = sum("Transfer Line"."Outstanding Qty. (Base)" where("Document No." = field("No.")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Pick Quantity';
        }
    }
}
