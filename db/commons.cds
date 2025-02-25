namespace anubhavdb.commons;
using { Currency } from '@sap/cds/common';

type Gender : String(1) enum{
    male = 'M';
    female = 'F';
    undisclosed = 'U';
}

type AmountT : Decimal(10, 2)@(
    Semantic.amount.currencyCode: 'CURRENCY_code',
    sap.unit: 'CURRENCY_code'
);

aspect Amount: {
    CURRENCY: Currency;
    GROSS_AMOUNT: AmountT @(title: '{i18n>GROSS_AMOUNT}');
    NET_AMOUNT: AmountT @(title: '{i18n>NET_AMOUNT}');
    TAX_AMOUNT: AmountT @(title: '{i18n>TAX_AMOUNT}');
}

//reusable data types
type Guid : String(32);

type PhoneNumber: String(30)@assert.format:'^(?:\+\d{1,3})?[-.\s]?\(?\d{1,4}\)?[-.\s]?\d{1,12}$';

type EmailAddress: String(80)@assert.format : '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

//aspect to hold address data
aspect address{
    HOUSENO: Int16;
    STREET: String(32);
    CITY: String(80);
    COUNTRY: String(3);
}
