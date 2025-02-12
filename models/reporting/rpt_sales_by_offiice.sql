{{ config(materialized = 'view', schema = 'reporting_dev') }}

select 
e.country,
c.companyname,
c.contactname,
count(o.orderid) as toal_orders,
sum(o.quantity) as total_quantity,
sum(o.linesalesamount) as total_sales,
avg(o.margin) as avg_margin

from
{{ref('dim_customers')}} as c inner join 
{{ref('fct_orders')}} as o on c.customerid = o.customerid
inner join
{{ref('dim_employees')}} as e on e.empid = o. employeeid

where e.country = '{{var('v_country', 'France') }}'

group by e.country, c.companyname, c.contactname

