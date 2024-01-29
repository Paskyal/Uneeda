tableextension 50042 "NV8 Contact" extends Contact //5050
{
    fields
    {
        field(50030; "NV8 Employee"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'env_sr_CAS-29504-V1J3J7';
            Caption = 'Employee';
        }
        field(50031; "NV8 Cust No"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'env_sr_CAS-29504-V1J3J7';
            TableRelation = Customer."No.";
            Caption = 'Cust No';
        }
    }
}
