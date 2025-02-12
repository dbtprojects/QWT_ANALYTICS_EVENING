{{config(materialized = 'view', schema = 'reporting_dev')}}

select 
c.companyname,
c.contactname,

min(o.orderdate) as first_order_date,
min(d.day_of_week_name) as first_order_day,
max(o.orderdate) as recent_order_date,
max(d.day_of_week_name) as recent_order_Day,
sum(o.quantity) as total_quantity,
sum(o.linesalesamount) as total_sales

from

{{ref('dim_customers')}} as c 
left join 
{{ref('fct_orders')}} as o 

on c.customerid = o.customerid
left join {{ref('dim_date')}} as d
on o.orderdate = d.date_day

group by c.companyname, c.contactname
order by total_sales desc