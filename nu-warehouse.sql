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
  city_id INT,
  city varchar(256)
  state_id BIGINT,
  PRIMARY KEY (city_id),
  FOREIGN KEY (state_id) REFERENCES state(state_id)
);

CREATE Table customers (
  customer_id BIGINT PRIMARY KEY,
  first_name varchar(128),
  last_name varchar(128),
  customer_city int,
  country_name varchar(128),
  cpf int,
  FOREIGN KEY (customer_city) REFERENCES city(city_id)
);



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


