{{config(materialized = 'table', schema = env_var('DBT_TRANSFORMSCHEMA', 'TRANSFORMING_DEV'))}}

with recursive managers 
        (indent, officeid, empid, empname, emptitle, managerid, managername, managertitle) 
    as
      (

    select '*' as indent, 
                    office as officeid,
                    empid, 
                    firstname as empname, 
                    title as emptitle, 
                    empid as managerid, 
                    firstname as managername,
                    title as managertitle 
                    from {{ref('stg_employees')}} where title = 'President'

        union all

          select indent || '*',
            emp.office as officeid,
            emp.empid, 
            emp.firstname as empname, 
            emp.title as emptitle, 
            mgr.empid as managerid,
            mgr.empname as managername,
            mgr.emptitle as managertitle
          from {{ref('stg_employees')}} as emp inner join managers as mgr
            on emp.reportsto = mgr.empid
      ),

      office (officeid, city, country)
      as
      (
      select officeid, city, country from {{ref('stg_offices')}}
      )

  select indent,  empid, empname, emptitle, managerid, managername, managertitle,
  ofc.city, ofc.country
    from managers as mgr inner join office as ofc on mgr.officeid = ofc.officeid