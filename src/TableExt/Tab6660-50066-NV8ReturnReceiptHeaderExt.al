tableextension 50066 "NV8 Return Receipt Header" extends "Return Receipt Header" //6660
{
    fields
    {
        field(50012; "NV8 Created On"; Date)
        {
            Description = 'UE-302';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Created On';
        }
        field(50013; "NV8 Edited By"; Code[50])
        {
            Description = 'UE-302';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Edited By';
        }
        field(50014; "NV8 Edited On"; Date)
        {
            Description = 'UE-302';
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Edited On';
        }
        field(50035; "NV8 Created By"; Code[50])
        {
            Description = 'UE-302';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }
    }
}
