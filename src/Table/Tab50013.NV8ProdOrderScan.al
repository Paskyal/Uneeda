Table 50013 "NV8 Prod. Order Scan"
{
    DataClassification = CustomerContent;
    // UNE-162 DB  11/5/21 Set Table Relationship to validate Prod Order No
    // 
    // UNE-198 DC 12/23/21 Added Firm Planned Status to Prod Order No Filter


    fields
    {
        field(1; "Prod. Order No."; Code[20])
        {
            TableRelation = "Production Order"."No." where(Status = filter("Firm Planned" | Released | Finished));
        }
        field(2; "Work/Machine Center"; Code[29])
        {

            trigger OnValidate()
            begin
                if WorkCenterREC.Get("Work/Machine Center") then begin
                    "Work Center Code" := WorkCenterREC."No.";
                    "Scan Date" := WorkDate();
                    "Scan Time" := Time;
                end;

                if MachineCREC.Get("Work/Machine Center") then begin
                    "Machine Center Code" := MachineCREC."No.";
                    "Scan Date" := WorkDate();
                    "Scan Time" := Time;
                end;
            end;
        }
        field(3; "Scan Date"; Date)
        {
        }
        field(4; "Scan Time"; Time)
        {
        }
        field(5; "Work Center Code"; Code[20])
        {
            TableRelation = "Work Center"."No.";
        }
        field(6; "Machine Center Code"; Code[20])
        {
            Description = '20';
            TableRelation = "Machine Center"."No.";
        }
        field(7; "Entry No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Prod. Order No.", "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        l_ScanREC: Record "NV8 Prod. Order Scan";
    begin
        l_ScanREC.SetCurrentkey(l_ScanREC."Entry No.");
        if l_ScanREC.FindLast() then
            "Entry No." := l_ScanREC."Entry No." + 1
        else
            "Entry No." := 1;
    end;

    var
        WorkCenterREC: Record "Work Center";
        MachineCREC: Record "Machine Center";
}

