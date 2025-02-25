namespace anubhav.cds;

using { anubhav.db.master, anubhav.db.transaction } from './data-model';

context cdsviews {
    define view![POWorkList] as
        select from transaction.purchaseorder{
            key PO_ID as ![purchaseorderNo],
            key Items.PO_ITEM_POS as ![Position],
            PARTNER_GUID.BP_ID as ![VendorId],
            PARTNER_GUID.COMPANY_NAME as ![CompanyName],
            Items.GROSS_AMOUNT as ![GrossAmount],
            Items.NET_AMOUNT as ![NetAmount],
            Items.TAX_AMOUNT as ![TaxAmount],
            case OVERALL_STATUS
                when 'N' then 'New'
                when 'D' then 'Delivered'
                when 'P' then 'Pending'
                when 'A' then 'Approved'
                when 'X' then 'Rejected' end as ![Status],
            Items.PRODUCT_GUID.DESCRIPTION as ![Product],
            PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country]
        };

    define view![ProductVH] as
        select from master.product{
            PRODUCT_ID as ![ProductId],
            DESCRIPTION as ![ProductName]
        };

    define view![ItemsView] as
        select from transaction.poitems{
            PARENT_KEY.PARTNER_GUID.NODE_KEY as ![VendorId],
            PRODUCT_GUID.NODE_KEY as ![ProductId],
            CURRENCY as ![Currency],
            GROSS_AMOUNT as ![GrossAmount],
            NET_AMOUNT as ![NetAmount],
            TAX_AMOUNT as ![TaxAmount],
            PARENT_KEY.OVERALL_STATUS as ![Status]
        };
    define view![ProductOrders] as select from master.product
    mixin {
        PO_ORDERS: Association[0..*] to ItemsView on PO_ORDERS.ProductId = $projection.ProductKey
    } into
    {
        NODE_KEY as ![ProductKey],
        DESCRIPTION as ![ProductName],
        PRICE as ![Price],
        SUPPLIER_GUID.BP_ID as ![SupplierId],
        SUPPLIER_GUID.COMPANY_NAME as ![SupplierName],
        PO_ORDERS
    }
}
