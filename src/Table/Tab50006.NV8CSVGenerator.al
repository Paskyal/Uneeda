Table 50006 "NV8 CSV Generator"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionCaption = 'Invoice,Credit Memo';
            OptionMembers = Invoice,"Credit Memo";
        }
        field(2; "Document Type Identifier"; Code[20])
        {
        }
        field(3; "Document No."; Code[20])
        {
        }
        field(4; "Document Line No."; Integer)
        {
        }
        field(5; "Line Type"; Option)
        {
            OptionCaption = ' ,A,B,C';
            OptionMembers = " ",A,B,C;
        }
        field(6; "First Line"; Boolean)
        {
        }
        field(7; "Ready To Export"; Boolean)
        {

            // trigger OnValidate() //TODO PAP Uncomment
            // begin
            //     CSVGenerator.Reset;
            //     CSVGenerator.SetRange("Document Type", "Document Type");
            //     CSVGenerator.SetRange("Document No.", "Document No.");
            //     CSVGenerator.SetFilter("Document Line No.", '<>%1', "Document Line No.");
            //     CSVGenerator.ModifyAll("Ready To Export", "Ready To Export");
            // end;
        }
        field(8; Exported; Boolean)
        {
        }
        field(9; "Exported On"; Date)
        {
        }
        field(10; "Exported By"; Code[50])
        {
        }
        field(11; "Export Type"; Option)
        {
            OptionCaption = 'OB10';
            OptionMembers = OB10;
        }
        field(12; "Document Date"; Date)
        {
        }
        field(13; "Ship Date"; Date)
        {
        }
        field(14; "Due Date"; Date)
        {
        }
        field(15; "Purchase Order No."; Code[20])
        {
        }
        field(16; "Supplier Order No."; Code[20])
        {
        }
        field(17; "Customer OB10 No."; Code[20])
        {
        }
        field(18; "Bill-to Customer No."; Code[20])
        {
        }
        field(19; "Bill of Lading no."; Code[20])
        {
        }
        field(20; "Bill-to Customer Name"; Text[50])
        {
        }
        field(21; "Bill-to Address"; Text[50])
        {
        }
        field(22; "Bill-to Address 2"; Text[50])
        {
        }
        field(23; "Bill-to City"; Text[50])
        {
        }
        field(24; "Bill-to County"; Text[30])
        {
            Caption = 'Bill-to State';
        }
        field(25; "Bill-to Post Code"; Code[20])
        {
            Caption = 'Bill-to Zip Code';
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(26; "Ship-to Account No."; Code[30])
        {
        }
        field(27; "Ship-to Name"; Text[50])
        {
        }
        field(28; "Ship-to Address"; Text[50])
        {
        }
        field(29; "Ship-to Address 2"; Text[50])
        {
        }
        field(30; "Ship-to County"; Text[30])
        {
        }
        field(31; "Ship-to Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(32; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(33; "Remit-to Name"; Text[50])
        {
        }
        field(34; "Remit-to Address"; Text[50])
        {
        }
        field(35; "Remit-to Address 2"; Text[50])
        {
        }
        field(36; "Remit-to City"; Text[30])
        {
        }
        field(37; "Remit-to County"; Text[30])
        {
        }
        field(38; "Remit-to Post Code"; Code[20])
        {
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(39; "Bank Name"; Text[30])
        {
        }
        field(40; "Bank Account No."; Code[30])
        {
        }
        field(41; "Bank Routing No."; Code[30])
        {
        }
        field(42; "Invoice Detail"; Text[100])
        {
        }
        field(43; "Other Reference No."; Code[30])
        {
        }
        field(44; "PO Number"; Code[35])
        {
            Description = 'UE-642';
        }
        field(45; "PO Line Number"; Code[30])
        {
        }
        field(46; "Bill of Lading"; Code[30])
        {
        }
        field(47; "Invoice Line Number"; Integer)
        {
        }
        field(48; "Shipment Number"; Code[30])
        {
        }
        field(49; "Product Code"; Code[30])
        {
        }
        field(50; "Part Number"; Code[30])
        {
        }
        field(51; "Product Description"; Text[100])
        {
        }
        field(52; "Unit of Measure"; Code[30])
        {
        }
        field(53; Quantity; Decimal)
        {
        }
        field(54; "Unit Price"; Decimal)
        {
        }
        field(55; "Line Item Tax"; Decimal)
        {
        }
        field(56; "Total Line Amount"; Decimal)
        {
        }
        field(57; "Rail / Truck #"; Code[30])
        {
        }
        field(58; "Invoice Line Detail Comments"; Text[100])
        {
        }
        field(59; "Fuel Amount"; Decimal)
        {
        }
        field(60; Freight; Decimal)
        {
        }
        field(61; "Misc. Amount"; Decimal)
        {
        }
        field(62; "Discount %"; Decimal)
        {
        }
        field(63; "Discount Amount"; Decimal)
        {
        }
        field(64; "Discount Date"; Date)
        {
        }
        field(65; "Total Amount"; Decimal)
        {
        }
        field(66; "Total Tax Amount"; Decimal)
        {
        }
        field(67; "Ship-to City"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Document Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Export Type", "Ready To Export")
        {
        }
    }

    fieldgroups
    {
    }

    // trigger OnDelete() //TODO PAP Uncomment
    // begin
    //     if "Line Type" = "line type"::A then begin
    //         CSVGenerator.Reset;
    //         CSVGenerator.SetRange("Document Type", "Document Type");
    //         CSVGenerator.SetRange("Document No.", "Document No.");
    //         CSVGenerator.DeleteAll;
    //     end;
    // end;

    var
    // CSVGenerator: Record "KBM KABOOM Funding Control"; //TODO PAP
}

