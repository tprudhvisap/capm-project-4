using { anubhav.db.master, anubhav.db.transaction } from '../db/data-model';

service CatalogService @(path:'CatalogService') {

    entity BusinessPartnerSet as projection on master.businesspartner;
    entity AddressSet as projection on master.address;
    entity EmployeeSet as projection on master.employees;
    entity ProductSet as projection on master.product;
    function getOrderStatus() returns POs;
    entity POs @( 
        odata.draft.enabled: true,
        Common.DefaultValuesFunction: 'getOrderStatus'
    )as projection on transaction.purchaseorder{
        *,
        case OVERALL_STATUS 
            when 'D' then 'Delivered'
            when 'A' then 'Approved'
            when 'P' then 'Pending'
            when 'X' then 'Rejected'
            when 'O' then 'Open'
            when 'N' then 'New' end as OverallStatus: String(10),
        case OVERALL_STATUS 
            when 'D' then 0
            when 'A' then 3
            when 'P' then 2
            when 'X' then 3
            when 'O' then 3
            when 'N' then 3 end as ColorCoding: String(10),
        // Items,

    } actions{
        @cds.odata.bindingparameter.name:'_getValues'
        @Common.SideEffects:{
            TargetProperties: ['_getValues/GROSS_AMOUNT']
        }
        action boost() returns POs;
        function getLargestOrder() returns POs;
    };
    entity POItems as projection on transaction.poitems;

}