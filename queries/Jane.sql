use nubank;

select Month, customers.customer_id as customerId, totalAmountIn, totalAmountOut, (totalAmountIn - totalAmountOut) as balance
from
(
	select t.action_month as Month, s.account_id as account_id, sum(ifnull(totalAmountIn,0)) as totalAmountIn, sum(ifnull(totalAmountOut,0)) as totalAmountOut
	from
	(
		select	account_id, pix_completed_at as time_id, 
				(case when in_or_out = "pix_in" then pix_amount end) as totalAmountIn,
				(case when in_or_out = "pix_out" then pix_amount end) as totalAmountOut
		from pix_movements
		where pix_completed_at is not null
		
		union all

		select account_id, transaction_completed_at as time_id, amount as totalAmountIn, null as totalAmountOut
		from transfer_ins
		where transaction_completed_at is not null
		
		union all
		
		select account_id, transaction_completed_at as time_id, null as totalAmountIn, amount as totalAmountOut
		from transfer_outs
		where transaction_completed_at is not null
	) as s
	inner join 
		(
			select action_month, time_id
			from (d_time inner join d_year on d_time.year_id = d_year.year_id)
			inner join 
				d_month
			on 
				d_time.month_id = d_month.month_id
			where action_year=2020
		) as t
	on 
		s.time_id = t.time_id
	group by s.account_id, t.action_month
) as totalInAndOut
inner join
	(
		customers inner join accounts on customers.customer_id = accounts.customer_id
	)
on
	totalInAndOut.account_id = accounts.account_id
order by t.action_month ASC;
