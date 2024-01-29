tableextension 50032 "NV8 Ship-to Address" extends "Ship-to Address" //222
{
    // TODO PAP Uncomment OnValidate triggers
    fields
    {
        field(50000; "NV8 Shipment Method Threshold"; Decimal)
        {
            Description = 'EC1.SAL1.01';
            DataClassification = CustomerContent;
            Caption = 'Shipment Method Threshold';
        }
        field(50001; "NV8 Headquarters"; Boolean)
        {
            Description = 'EC VAR003';
            DataClassification = CustomerContent;
            Caption = 'Headquarters';

            // trigger OnValidate()
            // begin
            //     ShipTo1.SetFilter("Customer No.", "Customer No.");
            //     ShipTo1.SetFilter(Headquarters, '%1', true);
            //     if ShipTo1.FindFirst then begin
            //         Message(EC001);
            //     end;
            // end;
        }
        field(50060; "NV8 Freight Chg. Never"; Boolean)
        {
            Description = 'UE-105';
            DataClassification = CustomerContent;
            Caption = 'Freight Chg. Never';

            // trigger OnValidate()
            // begin
            //     //>> UE-105
            //     if "Freight Chg. Never" then begin
            //         "Free Freight" := true;
            //         "Freight Chg.  Always" := false;
            //         "Freight Chg. Threshhold" := false;
            //     end else
            //         "Free Freight" := false;
            //     //<< UE-105
            // end;
        }
        field(50061; "NV8 Freight Chg.  Always"; Boolean)
        {
            Description = 'UE-105';
            DataClassification = CustomerContent;
            Caption = 'Freight Chg.  Always';

            // trigger OnValidate()
            // begin
            //     //>> UE-105
            //     if "Freight Chg.  Always" then begin
            //         //>> UE-635
            //         // "Free Freight" := FALSE;
            //         "Free Freight" := true;  // Charge for first invoice
            //                                  //<< UE-635
            //         "Freight Chg. Never" := false;
            //         "Freight Chg. Threshhold" := false;
            //     end;
            //     //<< UE-105
            // end;
        }
        field(50062; "NV8 Freight Chg. Threshhold"; Boolean)
        {
            Description = 'UE-105';
            DataClassification = CustomerContent;
            Caption = 'Freight Chg. Threshhold';

            // trigger OnValidate()
            // begin
            //     //>> UE-105
            //     if "Freight Chg. Threshhold" then begin
            //         //>> UE-635
            //         // "Free Freight" := FALSE;
            //         "Free Freight" := true;  // Charge for first invoice
            //                                  //<< UE-635
            //         "Freight Chg. Never" := false;
            //         "Freight Chg.  Always" := false;
            //     end;
            //     //<< UE-105
            // end;
        }
        field(50063; "NV8 No Free Freight"; Boolean)
        {
            Description = 'UE-635';
            DataClassification = CustomerContent;
            Caption = 'No Free Freight';

            // trigger OnValidate()
            // begin
            //     //>> UE-635
            //     if "No Free Freight" then begin
            //         Validate("Free Freight", false);
            //         "Freight Chg.  Always" := false;
            //         "Freight Chg. Threshhold" := false;
            //     end;
            //     //<< UE-635
            // end;
        }
        field(85000; "NV8 No. Series"; Code[10])
        {
            Description = 'EC VAR003';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
    }
}
