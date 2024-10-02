drop table if exists crime;

create table crime(
	ID int primary key not null,
	County varchar(100) not null,
	State varchar(50) not null,
	year integer not null,
	county_population integer not null,
	murder integer not null,
	rape integer not null,
	robbery integer not null,
	aggravated_assaults integer not null,
	burglary integer not null,
	larceny integer not null,
	auto_theft integer not null,
	arson integer not null
);


DROP TABLE IF EXISTS "library";

CREATE TABLE "library"(
	ID INT PRIMARY KEY NOT NULL,
	STATE VARCHAR(50) NOT NULL,
	YEAR INT NOT NULL,
	COUNTY VARCHAR(100) NOT NULL,
	LIBRARY_ID VARCHAR(50),
	LIBRARY_NAME VARCHAR(100) NOT NULL,
	CITY VARCHAR(100) NOT NULL,
	ZIP INT NOT NULL,
	ADDRESS VARCHAR(200),
	FIPSST DOUBLE PRECISION,
	LONGITUDE DOUBLE PRECISION,
	LATITUDE DOUBLE PRECISION,
	COUNTY_POP DOUBLE PRECISION,
	VISITS INT,
	HRS_OPEN INT,
	MOBILE_BOOKS INT,
	KIDCIRCL INT,
	KIDATTEN DOUBLE PRECISION,
	AUDIO DOUBLE PRECISION,
	VIDEO DOUBLE PRECISION,
	SUBSCRIP INT,
	LOCGVT INT,
	STGVT INT,
	FEDGVT INT,
	OTHER_INCOME INT,
	TOTAL_INCOME INT
);

DROP TABLE IF EXISTS "school";

Create table "school"(
	"School Name" varchar(150),
	"State Name [Public School] Latest available year" varchar(50),
	Year int,
	"American Indian/Alaska Native Students [Public School" int,
	"Asian or Asian/Pacific Islander Students [Public School" int,
	"Black or African American Students [Public School" int,   
	"Charter School [Public School" varchar(10),
	"County Name [Public School" varchar(150),
	"Female Students [Public School" int,
	"Free Lunch Eligible [Public School" int,
	"Full-Time Equivalent (FTE) Teachers [Public School" double precision,
	"Hispanic Students [Public School" int,
	"Location City [Public School" varchar(150),
	"Location ZIP [Public School" int,
	"Magnet School [Public School" varchar(10),
	"Male Students [Public School" int,
	"Pupil/Teacher Ratio [Public School" double precision,
	"Reduced-price Lunch Eligible Students [Public School" int,
	"School ID - NCES Assigned [Public School" int,
	"School Type [Public School" varchar(50), 
	"Total Students All Grades (Excludes AE) [Public School" int,
	"White Students [Public School"  int
);


alter table "library"
    add constraint library_crime_fk foreign key (COUNTY, YEAR) references crime (County, year);

alter table "school"
    add constraint school_crime_fk foreign key ("Charter School [Public School", Year) references crime (County, year);






	