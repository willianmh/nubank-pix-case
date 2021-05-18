Use nubank;

CREATE Table country (
  country_id BIGINT PRIMARY KEY,
  country varchar(128) 
);

CREATE Table state (
  state_id BIGINT,
  `state` varchar(128),
  country_id BIGINT,
  PRIMARY KEY (state_id),
  FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE Table city (
  city_id BIGINT,
  city varchar(256),
  state_id BIGINT,
  PRIMARY KEY (city_id),
  FOREIGN KEY (state_id) REFERENCES state(state_id)
);

CREATE Table customers (
  customer_id BIGINT PRIMARY KEY,
  first_name varchar(128),
  last_name varchar(128),
  customer_city BIGINT,
  country_name varchar(128),
  cpf BIGINT,
  FOREIGN KEY (customer_city) REFERENCES city(city_id)
);

CREATE Table accounts (
  account_id BIGINT PRIMARY KEY,
  customer_id BIGINT,
  created_at timestamp,
  status varchar(128),
  account_branch varchar(128),
  account_check_digit varchar(128),
  account_number varchar(128),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE Table transfer_ins (
  id BIGINT PRIMARY KEY,
  account_id BIGINT,
  amount float,
  transaction_requested_at BIGINT,
  transaction_completed_at BIGINT,
  status varchar(128),
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE Table transfer_outs (
  id BIGINT PRIMARY KEY,
  account_id BIGINT,
  amount float,
  transaction_requested_at BIGINT,
  transaction_completed_at BIGINT,
  status varchar(128),
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE Table pix_movements (
  id BIGINT PRIMARY KEY,
  account_id BIGINT,
  in_or_out varchar(128),
  pix_amount float,
  pix_requested_at BIGINT,
  pix_completed_at BIGINT,
  status varchar(128),
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE Table d_month (
  month_id int PRIMARY KEY,
  action_month int
);

CREATE Table d_year (
  year_id int PRIMARY KEY,
  action_year int
);

CREATE Table d_week (
  week_id int PRIMARY KEY,
  action_week int
);

CREATE Table d_weekday (
  weekday_id int PRIMARY KEY, 
  action_weekday varchar(128)
);

CREATE Table d_time (
  time_id BIGINT PRIMARY KEY,
  action_timestamp timestamp,
  week_id int,
  month_id int,
  year_id int,
  weekday_id int,
  FOREIGN KEY (month_id) REFERENCES d_month(month_id),
  FOREIGN KEY (year_id) REFERENCES d_year(year_id),
  FOREIGN KEY (week_id) REFERENCES d_week(week_id),
  FOREIGN KEY (weekday_id) REFERENCES d_weekday(weekday_id)
);



