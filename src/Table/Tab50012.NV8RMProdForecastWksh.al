Table 50012 "NV8 RM Prod. Forecast Wksh"
{
    DataClassification = CustomerContent;
    // EC VAR003  08.26.15 BJM Renamed object


    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(2; Materal; Code[10])
        {
            TableRelation = "Configurator Material";
        }
        field(3; Grit; Code[10])
        {
            TableRelation = "Configurator Grit";
        }
        field(4; "Configurator No."; Code[100])
        {
            TableRelation = "Configurator Item";
        }
        field(5; "Vendor Classification"; Option)
        {
            OptionCaption = ' ,A,B,C';
            OptionMembers = " ",A,B,C;
        }
        field(6; "Historical Usage"; Decimal)
        {
        }
        field(7; "Current Usage"; Decimal)
        {
        }
        field(8; "Safety Stock Usage"; Decimal)
        {
        }
        field(9; "Quantity on PO"; Decimal)
        {
            FieldClass = Normal;
        }
        field(10; "Available Qty."; Decimal)
        {
        }
        field(11; "New Forecast Qty."; Decimal)
        {
        }
        field(12; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure".Code;
        }
        field(13; "Location Code"; Code[10])
        {
        }
        field(14; "Forecast Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        Text001: label 'You must specify the %1';
        Item: Record Item;
        "Purchase Line": Record "Purchase Line";
        "Comment Line": Record "Comment Line";
        InvtSetup: Record "Inventory Setup";
        ConfSetup: Record "Configurator Setup";
        JumboPull: Record "Item Ledger Entry";
        JumboSales: Record "Item Ledger Entry";
        GA: Record "Item Ledger Entry";
        ConfMat: Record "Configurator Material";
        ConfMatGrit: Record "Configurator Material-Grits";
        PurchHeader: Record "Purchase Header";
        ReqLine: Record "Requisition Line";
        ReqWkshTmpl: Record "Req. Wksh. Template";
        ReqWkshName: Record "Requisition Wksh. Name";
        EndDate: Date;
        AvailableQty: Decimal;
        QtyToOrder: Decimal;
        HistoricalUsage: Decimal;
        CurrentUsage: Decimal;
        SafetyStock: Decimal;
        GAHistorical: Decimal;
        GACurrent: Decimal;
        GASafety: Decimal;
        ConsumptionMeters: Decimal;
        Lateorders: Text[30];
        HistoricalUsageDate: Date;
        CurrentUsageDate: Date;
        SafetyStockDate: Date;
        HistoricalUsageCalc: DateFormula;
        CurrentUsageCalc: DateFormula;
        SafetyStockCalc: DateFormula;
        StdArea: Decimal;
        xSalesLM: Decimal;
        xSalesM2: Decimal;
        PullLM: Decimal;
        xPullM2: Decimal;
        xPull12LM: Decimal;
        xPull12M2: Decimal;
        OtherTotal: Decimal;
        OrdersToShow: Option "None",Late,All;
        CurrPerc: Integer;
        CreateTemplate: Boolean;
        CurrTemplateName: Code[10];
        CurrWorksheetName: Code[10];
        CreateJournal: Boolean;
        WorksheetREC: Record "KBM Payroll ImportBuff2";


    procedure SuggestForecast()
    begin

        Clear(Item);
        Clear("Purchase Line");
        Clear("Comment Line");



        if EndDate = 0D then
            Error(Text001, 'End Date');

        InvtSetup.Get;
        ConfSetup.Get;

        if CreateTemplate then begin
            ReqWkshName.Get(CurrTemplateName, CurrWorksheetName);
            ReqLine.Reset;
            ReqLine.SetRange("Worksheet Template Name", ReqWkshName."Worksheet Template Name");
            ReqLine.SetRange("Journal Batch Name", ReqWkshName.Name);
            if ReqLine.FindFirst then
                Error('There are lines on the journal.');

            ReqLine.Init;
            ReqLine."Worksheet Template Name" := ReqWkshName."Worksheet Template Name";
            ReqLine."Journal Batch Name" := ReqWkshName.Name;
            ReqLine."Line No." := 10000;
        end;


        Item.SetCurrentkey(Shape, Material);
        Item.SetFilter(Item.Shape, 'RO');
        Item.SetRange(Item.Blocked, false);
        if Item.FindSet then
            repeat
                with Item do begin


                    if not ConfMat.Get(Material) then
                        ConfMat.Init;
                    if ConfMatGrit.Get(Material, Grit) then begin
                        ConfMat.TestField("Jumbo Std. Width");
                        ConfMat.TestField("Jumbo Std. Length");
                        StdArea := ConfMat."Jumbo Std. Width" * ConfMat."Jumbo Std. Length" / 39;

                        SetFilter("Location Filter", '%1|%2', InvtSetup."Warehouse Location", InvtSetup."Jumbo Transit Location");
                        CalcFields(
                          "Jumbo Meters on Hand (UNY)", "Jumbo Meters on Hand (OCEAN)",
                          "Meters on Purch. Order", "Meters on Sales Order", "Meters on Hand");
                        AvailableQty := "Jumbo Meters on Hand (UNY)" + "Jumbo Meters on Hand (OCEAN)";


                        // FInd Sales
                        with JumboSales do begin
                            Reset;
                            SetCurrentkey("Entry Type", Material, Grit, "Source No.", "Location Code", "Posting Date");
                            SetRange(Material, Item.Material);
                            SetRange(Grit, Item.Grit);
                            SetRange("Location Code", 'AA-FLOOR');
                            SetRange(Positive, true);
                            SetRange("Jumbo Pull", true);

                            SetRange("Posting Date", CurrentUsageDate, EndDate);
                            CalcSums("Total Length meters");
                            CurrentUsage := "Total Length meters";

                            SetRange("Posting Date", HistoricalUsageDate, EndDate);
                            CalcSums("Total Length meters");
                            HistoricalUsage := "Total Length meters";

                            SetRange("Posting Date", SafetyStockDate, EndDate);
                            CalcSums("Total Length meters");
                            SafetyStock := "Total Length meters";
                        end;
                        // Find GA
                        with GA do begin
                            Reset;
                            SetCurrentkey("Entry Type", Material, Grit, "Source No.", "Location Code", "Posting Date");
                            SetRange(Material, Item.Material);
                            SetRange(Grit, Item.Grit);
                            SetRange("Entry Type", GA."entry type"::Purchase);
                            SetRange(Positive, false);
                            SetRange("Location Code", 'AA-UNY');
                            SetRange("Material Type", "material type"::Jumbo);


                            SetRange("Posting Date", CurrentUsageDate, EndDate);
                            CalcSums("Total Length meters");
                            GACurrent := -"Total Length meters";

                            SetRange("Posting Date", HistoricalUsageDate, EndDate);
                            CalcSums("Total Length meters");
                            GAHistorical := -"Total Length meters";

                            SetRange("Posting Date", SafetyStockDate, EndDate);
                            CalcSums("Total Length meters");
                            GASafety := -"Total Length meters";
                        end;
                        // Find Consumption actual
                        with GA do begin
                            Reset;
                            SetCurrentkey("Entry Type", Material, Grit, "Source No.", "Location Code", "Posting Date");
                            SetRange(Material, Item.Material);
                            SetRange(Grit, Item.Grit);
                            SetRange("Location Code", 'AA-FLOOR');
                            SetRange("Entry Type", GA."entry type"::Consumption);
                            SetRange(Positive, false);
                            SetRange("Jumbo Pull");

                            SetRange("Posting Date", HistoricalUsageDate, EndDate);
                            CalcSums(Quantity);
                            ConsumptionMeters := -ROUND(Quantity / (ConfMat."Jumbo Std. Width" / 39));

                        end;

                        if AvailableQty < (SafetyStock + GASafety) then
                            QtyToOrder := (CurrentUsage + GACurrent)
                        else
                            QtyToOrder := 0;


                        if CreateTemplate then begin
                            ReqLine.Type := ReqLine.Type::Item;
                            ReqLine.Validate("No.", Item."No.");

                            ReqLine.Validate("Action Message", ReqLine."action message"::New);
                            ReqLine.Validate(Quantity, QtyToOrder);
                            ReqLine."Location Code" := InvtSetup."Warehouse Location";
                            //  ReqLine."Qty. on Hand" := "Quantity on Hand";
                            ReqLine.Insert;
                            ReqLine."Line No." += 10000;
                        end;

                        //Insert line
                        Clear(WorksheetREC);
                        WorksheetREC."Item No." := Item."No.";
                        WorksheetREC.Materal := Item.Specification;
                        WorksheetREC.Grit := Item.Grit;
                        WorksheetREC."Configurator No." := Item."Configurator No.";
                        WorksheetREC."Vendor Classification" := ConfMatGrit."Vendor Classification";
                        WorksheetREC."Historical Usage" := HistoricalUsage + GAHistorical;
                        WorksheetREC."Current Usage" := CurrentUsage + GACurrent;
                        WorksheetREC."Safety Stock Usage" := SafetyStock + GASafety;
                        WorksheetREC."Quantity on PO" := Item."Meters on Purch. Order";
                        WorksheetREC."Available Qty." := AvailableQty;
                        WorksheetREC."New Forecast Qty." := QtyToOrder;
                        WorksheetREC."Unit of Measure Code" := Item."Base Unit of Measure";
                        //WorksheetREC."Location Code"


                    end; //Get Confmat

                end; //With ITEM





            until Item.Next = 0;
    end;


    procedure PostForecast()
    begin
    end;


    procedure UpdateDates()
    begin
        SafetyStockDate := CalcDate(SafetyStockCalc, EndDate);
        CurrentUsageDate := CalcDate(CurrentUsageCalc, EndDate);
        HistoricalUsageDate := CalcDate(HistoricalUsageCalc, EndDate);
    end;


    procedure SetTemplAndWorksheet(TemplateName: Code[10]; WorksheetName: Code[10])
    begin
        CreateTemplate := true;
        CurrTemplateName := TemplateName;
        CurrWorksheetName := WorksheetName;
    end;
}

