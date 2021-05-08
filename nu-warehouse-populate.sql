Use nubank;

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/country/part-00000-tid-1677742373246381339-be5b42bd-656f-4d6f-96a0-094baf7e7086-5637068-1-c000.csv'
INTO TABLE country 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(country, country_id);

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/state/part-00000-tid-8168439510122586522-952b0534-66d4-41ce-8744-f66c06aac746-5637015-1-c000.csv'
INTO TABLE state 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(state,country_id,state_id);

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/city/part-00000-tid-3016927596101492886-d03e2169-f4e8-4c57-a2b3-a56d5168275d-5636806-1-c000.csv'
INTO TABLE city 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(city,state_id,city_id);

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/customers/part-00000-tid-6380665879930604667-ad6ca85c-04bb-469e-b0cf-395e634c8753-5636804-1-c000.csv'
INTO TABLE customers 
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id,first_name,last_name,customer_city,cpf,country_name);

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/accounts/part-00000-tid-4727103262398151985-402ef528-4c81-4834-b4ad-541c0da72cd8-5636803-1-c000.csv'
INTO TABLE accounts
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(account_id,customer_id,@created_at,status,account_branch,account_check_digit,account_number)
SET created_at = DATE_FORMAT(STR_TO_DATE(@created_at,'%Y-%m-%dT%H:%i:%s.%fZ'),'%Y-%m-%d %H:%i:%s');

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/transfer_ins/part-00000-tid-3029698034815685249-7fc41d58-c231-4e33-ac38-4f87141a5780-5573069-1-c000.csv'
INTO TABLE transfer_ins
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id,account_id,amount,transaction_requested_at,@transaction_completed_at,status)
SET transaction_completed_at = IF(@transaction_completed_at="NaN", Null, @transaction_completed_at);

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/transfer_outs/part-00000-tid-8080996519800486434-f8e56525-3cc5-44c9-9fad-7ebeefc4bbb9-5573447-1-c000.csv'
INTO TABLE transfer_outs
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id,account_id,amount,transaction_requested_at,@transaction_completed_at,status)
SET transaction_completed_at = IF(@transaction_completed_at="NaN", Null, @transaction_completed_at);

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/pix_movements/part-00000-tid-8452669778079327534-8b8fcb3c-39d4-459f-81e8-c72e386ef3bd-5574198-1-c000.csv'
INTO TABLE pix_movements
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id,account_id,in_or_out,pix_amount,pix_requested_at,@pix_completed_at,status)
SET pix_completed_at = IF(@pix_completed_at="NaN", Null, @pix_completed_at);

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/d_month/part-00000-tid-2126202298789004890-eb1868ce-508e-4d67-b1bc-baccf22fb7c9-5632439-1-c000.csv'
INTO TABLE d_month
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(month_id,action_month);

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/d_year/part-00000-tid-7069962764778277724-d711ec89-a3ba-4871-815d-048009699f39-5635522-1-c000.csv'
INTO TABLE d_year
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(year_id,action_year);

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/d_week/part-00000-tid-6322408872210481555-1e79c24f-e238-4e3e-96c4-6744fb180c54-5627044-1-c000.csv'
INTO TABLE d_week
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(week_id,action_week);

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/d_weekday/part-00000-tid-5226327334446934286-d8574e0b-b7e8-4e52-a959-7507aae4768b-5632440-1-c000.csv'
INTO TABLE d_weekday
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(weekday_id,action_weekday);

LOAD DATA INFILE 'C:/Users/willh/codes/nubank-pix-case/Nubank Analytics Engineer Case PIX/tables/d_time/part-00000-tid-4544860247627019718-dd4a1ae5-7a30-4e83-9d30-84e076e5de86-5619754-1-c000.csv'
INTO TABLE d_time
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(time_id,@action_timestamp,week_id,month_id,year_id,weekday_id)
SET action_timestamp = DATE_FORMAT(STR_TO_DATE(@action_timestamp,'%Y-%m-%dT%H:%i:%s.%fZ'),'%Y-%m-%d %H:%i:%s');