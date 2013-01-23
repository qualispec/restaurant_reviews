-- create_tables.sql

CREATE TABLE chefs (
  id INTEGER PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  mentor VARCHAR(30)
);

CREATE TABLE restaurants (
  id INTEGER PRIMARY KEY,
  name VARCHAR(30),
  neighborhood VARCHAR(30),
  cuisine VARCHAR(30)
);


CREATE TABLE head_chef_tenures (
  id INTEGER PRIMARY KEY,
  chef_id INTEGER,
  restaurant_id INTEGER,
  start_date DATE,
  end_date DATE
);


CREATE TABLE critic (
  id INTEGER PRIMARY KEY,
  screen_name VARCHAR(30)
);


CREATE TABLE restaurant_reviews (
  review_id INTEGER PRIMARY KEY,
  critic_id INTEGER,
  restaurant_id VARCHAR(30),
  name VARCHAR(30),
  text_review TEXT(1000),
  score INTEGER,
  date_of_review DATE
);