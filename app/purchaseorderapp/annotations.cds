using CatalogService as service from '../../srv/CatalogService';

annotate service.POs with @(
    UI.SelectionFields:[
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT
    ],
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.boost',
            Label: 'Boost',
            Inline: true
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.CITY,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.EMAIL_ADDRESS,
        },
        {
            $Type : 'UI.DataField',
            Value : OverallStatus,
            Criticality: ColorCoding,
        }
    ],
    UI.HeaderInfo:{
        TypeName: 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title:{
            $Type: 'UI.DataField',
            Value: 'Purchase Order: {PO_ID}',
        },
        Description:{
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME,
        },
        ImageUrl: 'https://cdn-icons-png.flaticon.com/512/1578/1578656.png'
    },
    UI.Facets:[{
        $Type: 'UI.CollectionFacet',
        Label: 'More Info',
        Facets:[
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'Additional Data',
                Target: '@UI.Identification',
        },
        {
                $Type: 'UI.ReferenceFacet',
                Label: 'Pricing Data',
                Target: '@UI.FieldGroup#fg1',
        },
        {
                $Type: 'UI.ReferenceFacet',
                Label: 'Status Data',
                Target: '@UI.FieldGroup#fg2',
        },
        ],
    },
    {
        $Type: 'UI.ReferenceFacet',
        Target: 'Items/@UI.LineItem#lineItems',
    }],
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: PO_ID,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Vendor Id',
            Value: PARTNER_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Severity',
            Value: ColorCoding,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.EMAIL_ADDRESS,
        }
    ],
    UI.FieldGroup #fg1:{
        Label: 'Price Data',
        Data:[
            {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT,
            },
        ],
    },
    UI.FieldGroup #fg2:{
        Label: 'Status',
        Data:[
            {
                $Type: 'UI.DataField',
                Value: CURRENCY_code,
            },
            {
                $Type: 'UI.DataField',
                Value: OVERALL_STATUS,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Life Cycle Status',
                Value: LIFECYCLE_STATUS,
            },
        ],
    }

) ;

annotate service.POItems with @(
    UI.LineItem #lineItems:[
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
        },
    ],
    UI.HeaderInfo:{
        TypeName: 'Item',
        TypeNamePlural: 'Items',
        Title:{
            $Type: 'UI.DataField',
            Value: 'Item No: {PO_ITEM_POS}',
        },
        Description:{
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID.DESCRIPTION,
        },
        ImageUrl: 'https://cdn-icons-png.flaticon.com/512/1578/1578656.png'
    },
        UI.Facets:[{
        $Type: 'UI.CollectionFacet',
        Label: 'More Info',
        Facets:[
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'Additional Data',
                Target: '@UI.Identification',
        },
        {
                $Type: 'UI.ReferenceFacet',
                Label: 'Pricing Data',
                Target: '@UI.FieldGroup#fg3',
        },
        {
                $Type: 'UI.ReferenceFacet',
                Label: 'Status Data',
                Target: '@UI.FieldGroup#fg4',
        },
        ],
    }],
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Node Key',
            Value: NODE_KEY,
        },
    ],
    UI.FieldGroup #fg3:{
        Label: 'Price Data',
        Data:[
            {
                $Type: 'UI.DataField',
                Value: GROSS_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: NET_AMOUNT,
            },
            {
                $Type: 'UI.DataField',
                Value: TAX_AMOUNT,
            },
        ],
    },
    UI.FieldGroup #fg4:{
        Label: 'Status',
        Data:[
            {
                $Type: 'UI.DataField',
                Value: CURRENCY_code,
            },
            {
            $Type: 'UI.DataField',
            Label: 'Product Name',
            Value: PRODUCT_GUID_NODE_KEY,
        }]
    }
);

// Linking Value Help with POs
annotate service.POs with {
    PARTNER_GUID @(
        Common.Text: PARTNER_GUID.COMPANY_NAME,
        Common.ValueList.entity: service.BusinessPartnerSet
        // Common.ValueList: {
        //     Label: 'Vendor',
        //     CollectionPath: 'BusinessPartnerSet'
        // }
)};


// Create Value Help
@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: COMPANY_NAME
        },
    ]
);

// Linking Value Help with POs
annotate service.POItems with {
    PRODUCT_GUID @(
        Common.Text: PRODUCT_GUID.DESCRIPTION,
        Common.ValueList.entity: service.ProductSet
)};

// Create Value Help
@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: DESCRIPTION
        },
    ]
);



