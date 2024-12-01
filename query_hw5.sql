use l3;

-- p1
select od.*, (select o.customer_id from orders as o where od.order_id=o.id) as customer_id from order_details as od;

-- p2
select od.* from order_details as od
where od.order_id in (select o.id from orders as o where o.shipper_id=3);

-- p3
select od.order_id, avg(od.quantity) 
from (select order_id, quantity from order_details where quantity>10) as od
group by od.order_id
;

-- p4
with temp_od as (select order_id, quantity from order_details where quantity>10)
select temp_od.order_id, avg(temp_od.quantity) from temp_od
group by temp_od.order_id
;

-- p5
drop function if exists divider;
delimiter //
create function divider(a float, b float)
returns float
deterministic
no sql
begin
	declare res float default null;
    if b != 0 then
        set res = a / b;
	end if;
    return res;
end //
delimiter ;

select od.quantity, divider(od.quantity, 10)
from order_details as od
;






