-- create_tables.sql

CREATE TABLE professors (
  professor_id INTEGER PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  title VARCHAR(255),
  department_id INTEGER
);

CREATE TABLE departments (
  department_id INTEGER PRIMARY KEY,
  name VARCHAR(255)
);
