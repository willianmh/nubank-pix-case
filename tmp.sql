CREATE Table country (
  country_id BIGINT PRIMARY KEY,
  country varchar(128) 
)

CREATE Table state (
  state_id BIGINT PRIMARY KEY,
  state varchar(128)
  country_id BIGINT,
  FOREIGN KEY (country_id) REFERENCES country(countr_id)
)

CREATE Table city (
  city_id int [pk]
  city varchar(256)
  state_id BIGINT,
)

CREATE Table customers (
  customer_id BIGINT PRIMARY KEY,
  first_name varchar(128)
  last_name varchar(128)
  customer_city int
  country_name varchar(128)
  cpf int
)

CREATE Table accounts (
  account_id BIGINT PRIMARY KEY,
  customer_id BIGINT,
  created_at timestamp
  status varchar(128)
  account_branch varchar(128)
  account_check_digit varchar(128)
  account_number varchar(128)
)

CREATE Table transfer_ins (
  id BIGINT PRIMARY KEY,
  account_id BIGINT,
  amount float
  transaction_requested_at int
  transaction_completed_at int
  status varchar(128)
)

CREATE Table transfer_outs (
  id BIGINT PRIMARY KEY,
  account_id BIGINT,
  amount float
  transaction_requested_at int
  transaction_completed_at int
  status varchar(128)
)

CREATE Table pix_movements (
  id BIGINT PRIMARY KEY,
  account_id BIGINT,
  in_or_out varchar(128)
  pix_amount float
  pix_requested_at int
  pix_completed_at int
  status varchar(128)
)

CREATE Table d_month (
  month_id int [pk]
  action_month int
)

CREATE Table d_year (
  year_id int [pk]
  action_year int
)

CREATE Table d_time (
  time_id int [pk]
  action_timestamp timestamp
  week_id int
  month_id int
  year_id int
  weekday_id int
)

CREATE Table d_week (
  week_id int [pk]
  action_week int
)

CREATE Table d_weekday (
  weekday_id int [pk] 
  action_weekday varchar(128)
)

Ref: state.country_id > country.country_id
Ref: city.state_id > state.state_id

Ref: customers.customer_city > city.city_id
Ref: accounts.customer_id - customers.customer_id

Ref: transfer_ins.account_id > accounts.account_id
Ref: transfer_outs.account_id > accounts.account_id
Ref: pix_movements.account_id > accounts.account_id

Ref: transfer_outs.transaction_requested_at > d_time.time_id
Ref: transfer_outs.transaction_completed_at > d_time.time_id

Ref: transfer_ins.transaction_requested_at > d_time.time_id
Ref: transfer_ins.transaction_completed_at > d_time.time_id

Ref: pix_movements.pix_requested_at > d_time.time_id
Ref: pix_movements.pix_completed_at > d_time.time_id

Ref: d_time.week_id > d_week.week_id
Ref: d_time.month_id > d_month.month_id
Ref: d_time.year_id > d_year.year_id
Ref: d_time.weekday_id > d_weekday.weekday_id