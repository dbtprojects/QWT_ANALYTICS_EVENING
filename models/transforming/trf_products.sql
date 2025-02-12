{{config(materialized = 'table', schema = env_var('DBT_TRANSFORMSCHEMA', 'TRANSFORMING_DEV'))}}

select 
p.productid,
p.productname,
s.CompanyName,
s.ContactName,
s.Address,
s.City,
s.Country,
c.categoryname,
p.quantityperunit,
p.unitcost,
p.unitprice,
p.unitsinstock,
p.unitsonorder,
TO_DECIMAL((p.unitprice - p.unitcost ), 9, 2) as profit,
IFF(p.unitsinstock - p.unitsonorder < 0, 'not available', 'available') as productavailability
from
{{ref('stg_products')}} as p 
left join 
{{ref('trf_suppliers')}} as s
on p.SupplierID = s.SupplierID
left join 
{{ref('lkp_categories')}} as c
on p.categoryid = c.categoryid