using { anubhav.cds } from '../db/cdsviews';
using { anubhav.db.master } from '../db/data-model';

service MyService {

    entity ProductOrdersSet as projection on cds.cdsviews.ProductOrders{
        *,
        PO_ORDERS
    };

    entity ReadEmployeeSrv as projection on master.employees;

}