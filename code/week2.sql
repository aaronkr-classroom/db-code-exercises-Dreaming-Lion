CREATE DATABASE ut;

CREATE TABLE animals (
	id bigserial, 
	name varchar(20),
	age integer,
	kind varchar(20),
	dob date,
	location varchar(50)
);

TABLE animals -- SELECT * FROM animals;

INSERT INTO animals (name, age, kind, dob, location)
VALUES ('Cat', 45, 'tiger', '2010-10-10', 'Seoul, Korea'),
	   ('Pooh', 13, 'bear', '1931-01-03', 'England'),
	   ('Togo', 13, 'dog', '1897-12-13', 'Alaska, USA'),
	   ('Michaelangelo', 12, 'turtle', '1981-04-05', 'USA'),
	   ('Baghera', 27, 'panther', '1888-12-12', 'England');

