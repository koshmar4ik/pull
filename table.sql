create schema booking_fact;

CREATE TABLE booking_fact.Dim_Airports (
	id serial not null primary key,
  	airport_name text NOT NULL
);


CREATE TABLE booking_fact.Dim_Tariff (
	id serial not null primary key,
    flight_no bpchar(6) NOT NULL,
	fare_conditions varchar(10) NOT NULL,
    amount numeric(10, 2) NOT NULL
);

CREATE TABLE booking_fact.Dim_Aircrafts (
	id serial not null primary key,
   	model text NOT NULL
);

CREATE TABLE booking_fact.Dim_Passengers (
	id serial not null primary key,
    passenger_id varchar(20) NOT NULL,
	passenger_name text NOT NULL
);

CREATE TABLE booking_fact.Fact_Flights (
	id serial not null primary key,
    passenger_id bigint not null,
	actual_departure timestamptz NULL,
	actual_arrival timestamptz NULL,
	diff_departure int NULL,
	diff_arrival int NULL,
	aircraft_code int  not null,
	departure_airport int  not null,
	arrival_airport int not null,
	tariff int not null
);

CREATE TABLE booking_fact.Dim_Calendar
AS
WITH dates AS (
    SELECT dd::date AS dt
    FROM generate_series
            ('2010-01-01'::timestamp
            , '2030-01-01'::timestamp
            , '1 day'::interval) dd
)
SELECT
    to_char(dt, 'YYYYMMDD')::int AS id,
    dt AS date
    FROM dates
ORDER BY dt


CREATE TABLE booking_fact.err_flight (
	id serial not null primary key,
    passenger_id text,
	flight_id int,
	flight_no text
);

CREATE TABLE booking_fact.err_aircraft (
	id serial not null primary key,
    air_code bpchar(6),
	model text
);

CREATE TABLE booking_fact.err_passinger (
	id serial not null primary key,
    ticket_no text,
	passenger_id text,
	fare_conditions text
);
