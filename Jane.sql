use nubank;

select *
from
(

	(
		transfer_ins 
		inner join 
		d_time on transfer_ins.transaction_completed_at = d_time.time_id
	) inner join
	d_year on d_time.year_id = d_year.year_id
) inner join
accounts on transfer_ins.account_id = accounts.account_id
where
d_year.action_year = 2020 and
transfer_ins.transaction_completed_at is not Null;
