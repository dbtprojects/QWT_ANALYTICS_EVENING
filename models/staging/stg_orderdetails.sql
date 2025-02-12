{{config(materialized = 'incremental', unique_key = ['orderid', 'lineno']) }}

select 
od.*,
o.orderdate
from
{{source("raw_qwt", 'raw_orderdetails')}}  as od 
inner join {{source('raw_qwt', 'raw_orders')}} as o on o.orderid = od.orderid

{% if is_incremental() %}

where o.orderdate > (select max(orderdate) from {{this}} )

{% endif %}