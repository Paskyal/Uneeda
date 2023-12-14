Table 50002 "NV8 Customer Item Sales"
{
    DataClassification = CustomerContent;
    // UE-61 DB  02/03/16  Changed Sales FlowField calculations
    // UE-396  DB  02/03/16  Add Description 2
    // UE-665  DB  7/9/20  Set filter for no blank items


    fields
    {
        field(1; "Item No."; Code[20])
        {
            Description = 'PK';
        }
        field(2; "Variant Code"; Code[10])
        {
            Description = 'PK';
        }
        field(3; "Unit of Measure Code"; Code[10])
        {
            Description = 'PK';
        }
        field(10; Description; Text[50])
        {
        }
        field(20; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(30; "Customer Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(40; "Configurator No."; Code[100])
        {
        }
        field(50; Shape; Code[10])
        {
        }
        field(60; Material; Code[10])
        {
        }
        field(70; Specification; Code[10])
        {
        }
        field(80; Grit; Code[10])
        {
        }
        field(90; Joint; Code[10])
        {
        }
        field(100; "Source No."; Code[20])
        {
        }
        field(110; "Customer Name"; Text[50])
        {
        }
        field(120; "Entry Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            InitValue = Sale;
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.,Transfer,Consumption,Output, ,Assembly Consumption,Assembly Output';
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output," ","Assembly Consumption","Assembly Output";
        }
        field(130; "Source Type Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ' ,Customer,Vendor,Item';
            OptionMembers = " ",Customer,Vendor,Item;
        }
        field(140; Pieces; Decimal)
        {
        }
        field(150; "Unit Width Inches"; Decimal)
        {
        }
        field(160; "Unit Width Code"; Code[10])
        {
        }
        field(170; "Total Length Meters"; Decimal)
        {
        }
        field(180; "Sales (Qty)"; Decimal)
        {
            CalcFormula = sum("Item Ledger Entry".Quantity where("Item No." = field("Item No."),
                                                                  "Variant Code" = field("Variant Code"),
                                                                  "Unit of Measure Code" = field("Unit of Measure Code"),
                                                                  "Source Type" = const(Customer),
                                                                  "Entry Type" = const(Sale),
                                                                  "Source No." = field("Source No."),
                                                                  "Posting Date" = field("Date Filter")));
            FieldClass = FlowField;
        }
        field(190; "Sales ($)"; Decimal)
        {
            CalcFormula = - sum("Value Entry"."Sales Amount (Actual)" where("Item No." = field("Item No."),
                                                                            "Variant Code" = field("Variant Code"),
                                                                            "Source No." = field("Source No."),
                                                                            "Posting Date" = field("Date Filter"),
                                                                            "Item Ledger Entry Type" = const(Sale),
                                                                            "Source Type" = const(Customer)));
            FieldClass = FlowField;
        }
        field(200; "Usage (Qty)"; Decimal)
        {
        }
        field(50000; "Description 2"; Text[50])
        {
            Description = 'UE-396';
        }
    }

    keys
    {
        key(Key1; "Item No.", "Variant Code", "Unit of Measure Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    //TODO PAP Uncomment
    // procedure UpdateData(var CustItemSales: Record "Customer Item Sales" temporary; pCustFilter: Code[20]; pDateFilter: Text[50])
    // var
    //     Item: Record Item;
    //     Cust: Record Customer;
    //     SalesPrice: Record "Sales Price";
    //     NextEntryNo: Integer;
    //     Window: Dialog;
    //     Counter: Integer;
    //     NoOfRecords: Integer;
    //     Factor: Integer;
    //     StartTime: Time;
    //     CurrentTime: Time;
    //     EstEndTime: Time;
    //     LastTime: Time;
    //     ILE: Record "Item Ledger Entry";
    //     TimeRemaining: Time;
    // begin
    //     Window.Open(
    //       'Configuration : #2######################\' +
    //       'Time Remaining: #6####### End #5########\' +
    //       '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    //     Window.Update(2, 'Counting Records...');
    //     NoOfRecords := Count;
    //     Counter := 0;
    //     StartTime := Time;
    //     EstEndTime := 000000T;
    //     TimeRemaining := 000000T;
    //     LastTime := Time - 100000;

    //     NextEntryNo := 1;

    //     CustItemSales.DeleteAll;

    //     ILE.Reset;
    //     ILE.SetCurrentkey("Source Type", "Source No.", "Entry Type", "Item No.", "Variant Code", "Posting Date");
    //     ILE.SetRange("Source Type", ILE."source type"::Customer);
    //     ILE.SetFilter("Source No.", pCustFilter);
    //     ILE.SetRange("Entry Type", ILE."entry type"::Sale);
    //     ILE.SetFilter("Item No.", '<>%1', '');  // UE-665
    //     if pDateFilter <> '' then
    //         ILE.SetFilter("Posting Date", pDateFilter);
    //     if ILE.FindSet then
    //         repeat
    //             NoOfRecords := ILE.Count;
    //             Counter += 1;
    //             Window.Update(2, "Configurator No.");

    //             CurrentTime := Time;
    //             if (CurrentTime > (LastTime + 1000)) or (NoOfRecords < 500) then begin
    //                 Factor := ROUND(Counter / NoOfRecords * 10000, 1, '>');
    //                 LastTime := CurrentTime;
    //                 TimeRemaining := 000000T + ROUND(((CurrentTime - StartTime) * ((10000 - Factor) / Factor)), 1);
    //                 EstEndTime := CurrentTime + (TimeRemaining - 000000T);
    //                 Window.Update(1, Factor);
    //                 Window.Update(5, EstEndTime);
    //                 Window.Update(6, Format(TimeRemaining, 0, '<Hours24,2>:<Minutes,2>:<Seconds,2>'));
    //             end;

    //             with CustItemSales do begin
    //                 if not Get(ILE."Item No.", ILE."Variant Code", ILE."Unit of Measure Code") then begin
    //                     Init;
    //                     "Source No." := ILE."Source No.";
    //                     "Item No." := ILE."Item No.";
    //                     "Variant Code" := ILE."Variant Code";
    //                     "Unit of Measure Code" := ILE."Unit of Measure Code";

    //                     Item.Get("Item No.");
    //                     Description := Item.Description;
    //                     "Description 2" := Item."Description 2";  //UE-396
    //                     "Configurator No." := Item."Configurator No.";
    //                     Shape := Item.Shape;
    //                     Material := Item.Material;
    //                     Specification := Item.Specification;
    //                     Grit := Item.Grit;
    //                     Joint := Item.Joint;

    //                     Cust.Get("Source No.");
    //                     "Customer Name" := Cust.Name;
    //                     "Entry Type Filter" := ILE."Entry Type";
    //                     "Source Type Filter" := ILE."Source Type";

    //                     //Pieces := -ILE.pieces;
    //                     //"Unit Width Inches" := ILE."Unit Width Inches"
    //                     //"Unit Width Code" := ILE."Unit Width Code"
    //                     //"Total Length Meters" := -ILE."Total Length Meters"

    //                     "Sales (Qty)" := -ILE.Quantity;
    //                     if ILE."Sales Amount (Expected)" = 0 then
    //                         "Sales ($)" := -ILE."Sales Amount (Actual)"
    //                     else
    //                         "Sales ($)" := -ILE."Sales Amount (Expected)";
    //                     //"Usage (Qty)" := ILE.Usage;

    //                     Insert;
    //                 end else begin

    //                     //Pieces += -ILE.pieces;
    //                     //"Unit Width Inches" += ILE."Unit Width Inches"
    //                     //"Unit Width Code" += ILE."Unit Width Code"
    //                     //"Total Length Meters" += ILE."Total Length Meters"

    //                     "Sales (Qty)" += -ILE.Quantity;
    //                     if ILE."Sales Amount (Expected)" = 0 then
    //                         "Sales ($)" += -ILE."Sales Amount (Actual)"
    //                     else
    //                         "Sales ($)" += -ILE."Sales Amount (Expected)";
    //                     //"Usage (Qty)" += -ILE.Usage;
    //                     Modify;

    //                 end;

    //             end;

    //         until ILE.Next = 0;
    // end;
}

