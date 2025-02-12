{{config(materialized = 'table', schema = env_var('DBT_TRANSFORMSCHEMA', 'TRANSFORMING_DEV'))}}

select 

GET(XMLGET(SupplierInfo, 'SupplierID'), '$') as SupplierID,
GET(XMLGET(SupplierInfo, 'CompanyName'), '$')::varchar as CompanyName,
GET(XMLGET(SupplierInfo, 'ContactName'), '$')::varchar as ContactName,
GET(XMLGET(SupplierInfo, 'Address'), '$')::varchar as Address,
GET(XMLGET(SupplierInfo, 'City'), '$')::varchar as City,
GET(XMLGET(SupplierInfo, 'PostalCode'), '$')::varchar as PostalCode,
GET(XMLGET(SupplierInfo, 'Country'), '$')::varchar as Country,
GET(XMLGET(SupplierInfo, 'Phone'), '$')::varchar as Phone,
GET(XMLGET(SupplierInfo, 'Fax'), '$')::varchar as Fax

from 

{{ref('stg_suppliers')}}