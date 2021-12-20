-- Create airport table
CREATE TABLE airport(
    iata_code     VARCHAR2(3),
    name          VARCHAR2(255),
    country_code  VARCHAR2(5),
    city_name     VARCHAR2(255),
    province_name VARCHAR2(255),
    island        VARCHAR2(255),
    latitude      NUMBER,
    longitude     NUMBER,
    elevation     NUMBER,
    gmt_offset    NUMBER(2)
);
-- Set primary key for airport table
ALTER TABLE airport ADD CONSTRAINT pk_airport PRIMARY KEY (iata_code);
delete from airport where iata_code = 'PYH'
ALTER TABLE airport ADD CONSTRAINT check_iata_code CHECK (UPPER(iata_code)=iata_code);
ALTER TABLE airport ADD CONSTRAINT check_latitude CHECK (latitude >= -90 AND latitude <= 90);
ALTER TABLE airport ADD CONSTRAINT check_longitude CHECK (longitude >= -180 AND longitude <= 180);
ALTER TABLE airport ADD CONSTRAINT check_gmt_offset CHECK (gmt_offset >= -12 AND gmt_offset <=14);


-- Create borders table
CREATE TABLE borders(
    country_code_1 VARCHAR2(5),
    country_code_2 VARCHAR2(5),
    length         NUMBER
);
-- Set primary key for borders table
ALTER TABLE borders ADD CONSTRAINT pk_borders PRIMARY KEY (country_code_1, country_code_2);

ALTER TABLE borders ADD CONSTRAINT check_borders_length CHECK (length >= 0);

-- Create city table
CREATE TABLE city(
    name          VARCHAR2(255),
    country_code  VARCHAR2(5),
    province_name VARCHAR2(255),
    elevation     NUMBER,
    latitude      NUMBER,
    longitude     NUMBER
);
-- Set primary key for city table
ALTER TABLE city ADD CONSTRAINT pk_city PRIMARY KEY (name, province_name, country_code);

ALTER TABLE city ADD CONSTRAINT check_city_latitude CHECK (latitude >= -90 AND latitude <= 90);
ALTER TABLE city ADD CONSTRAINT check_city_longitude CHECK (longitude >= -180 AND longitude <= 180);

-- Create city_local_name table
CREATE TABLE city_local_name(
    city_name       VARCHAR2(255),
    province_name   VARCHAR2(255),
    country_code    VARCHAR2(5),
    city_local_name VARCHAR2(255)
);

-- Set primary key for city local name table
ALTER TABLE city_local_name ADD CONSTRAINT pk_city_local_name PRIMARY KEY (city_name, province_name, country_code);


-- Create city_other_name table
CREATE TABLE city_other_name(
    city_name       VARCHAR2(255),
    province_name   VARCHAR2(255),
    country_code    VARCHAR2(5),
    city_other_name VARCHAR2(255)
);

-- Set primary key for city other name table
ALTER TABLE city_other_name ADD CONSTRAINT pk_city_other_name PRIMARY KEY (city_name, province_name, country_code,city_other_name);


-- Create table City Population
CREATE TABLE city_populations(
    city_name     VARCHAR2(255),
    province_name VARCHAR2(255),
    country_code  VARCHAR2(5),
    population    NUMBER(11),
    year          NUMBER(4)
);
-- Set primary key for city populations table
ALTER TABLE city_populations ADD CONSTRAINT pk_city_populations PRIMARY KEY (city_name, province_name, country_code, year);

ALTER TABLE city_populations ADD CONSTRAINT check_city_populations_population CHECK (population>0);
ALTER TABLE city_populations ADD CONSTRAINT check_city_populations_year CHECK (year >= 0);

-- Create country table
CREATE TABLE country(
    name          VARCHAR2(255),
    code          VARCHAR2(5),
    capital       VARCHAR2(255),
    province_name VARCHAR2(255),
    area          NUMBER,
    population    NUMBER(11)
);
-- Set primary key for country table
ALTER TABLE country ADD CONSTRAINT pk_country PRIMARY KEY (code);

ALTER TABLE country ADD CONSTRAINT check_country_code CHECK (UPPER(code)=code);
ALTER TABLE country ADD CONSTRAINT check_country_area CHECK (area>0);
ALTER TABLE country ADD CONSTRAINT check_country_code CHECK (population>=0);

-- Create Table country_continent to determine which continent the country lies in 
CREATE TABLE country_continent(
    country_code         VARCHAR2(5),
    continent_name       VARCHAR2(20),
    encompass_percentage NUMBER(5,2)
);
-- Set primary key for country_continent table
ALTER TABLE country_continent ADD CONSTRAINT pk_country_continent PRIMARY KEY (country_code, continent_name);

ALTER TABLE country_continent ADD CONSTRAINT check_country_continent_percentage CHECK (encompass_percentage >= 0 AND encompass_percentage <= 100);

-- Create continent table
CREATE TABLE continent(
    name VARCHAR2(20),
    area NUMBER
);
-- Set primary key for continent table
ALTER TABLE continent ADD CONSTRAINT pk_continent PRIMARY KEY (name);

ALTER TABLE continent ADD CONSTRAINT check_continent_area CHECK (area >= 0);

-- Create country_other_local_name table
CREATE TABLE country_other_local_name(
    country_code VARCHAR2(5),
    country_local_name VARCHAR2(255),
    country_other_name VARCHAR2(255)
);
-- Set primary key for country_other_local_name table
ALTER TABLE country_other_local_name ADD CONSTRAINT pk_country_other_local_name PRIMARY KEY (country_code);


-- Create country_populations table
CREATE TABLE country_populations(
    country_code VARCHAR2(5),
    population   NUMBER(11),
    year         NUMBER(5)
);
-- Set primary key for country_other_local_name table
ALTER TABLE country_populations ADD CONSTRAINT pk_country_populations PRIMARY KEY (country_code, year);

ALTER TABLE country_populations ADD CONSTRAINT check_country_populations CHECK (population > 0);
ALTER TABLE country_populations ADD CONSTRAINT check_country_populations_year CHECK (year > 0);

-- Create economy table
CREATE TABLE economy(
    country_code           VARCHAR2(5),
    gdp                    NUMBER,
    agriculture_percentage NUMBER(5,2),
    service_percentage     NUMBER(5,2),
    industry_percentage    NUMBER(5,2),
    inflation              NUMBER,
    unemployment           NUMBER
);

-- Set primary key for country_other_local_name table
ALTER TABLE economy ADD CONSTRAINT pk_economy PRIMARY KEY (country_code);

ALTER TABLE economy ADD CONSTRAINT check_economy_agriculture_percentage CHECK (agriculture_percentage >= 0 AND agriculture_percentage <= 100);
ALTER TABLE economy ADD CONSTRAINT check_economy_service_percentage CHECK (service_percentage >= 0 AND service_percentage <= 100);
ALTER TABLE economy ADD CONSTRAINT check_economy_industry_percentage CHECK (industry_percentage >= 0 AND industry_percentage <= 100);
ALTER TABLE economy ADD CONSTRAINT check_economy_gdp CHECK (gdp >= 0);
ALTER TABLE economy ADD CONSTRAINT check_economy_unemployment CHECK (unemployment >= 0);

-- Create ethnic_group table
CREATE TABLE ethnic_group(
    country_code            VARCHAR2(5),
    ethnic_group_name       VARCHAR2(255),
    ethnic_group_percentage NUMBER(5,2)
);
-- Set primary key for country_other_local_name table
ALTER TABLE ethnic_group ADD CONSTRAINT pk_ethnic_group PRIMARY KEY (country_code, ethnic_group_name);

ALTER TABLE ethnic_group ADD CONSTRAINT check_ethnic_group_percentage CHECK (ethnic_group_percentage >= 0 AND ethnic_group_percentage <=100);

CREATE TABLE is_member(
    organization_abbreviation VARCHAR2(20),
    country_code              VARCHAR2(5),
    type_of_membership        VARCHAR2(255)
);
-- Set primary key for country_other_local_name table
ALTER TABLE is_member ADD CONSTRAINT pk_is_member PRIMARY KEY (organization_abbreviation,country_code);


-- Create Language table
CREATE TABLE language(
    country_code  VARCHAR2(5),
    language      VARCHAR2(255),
    percentage    NUMBER(5,2)
);
-- Set primary key for country_other_local_name table
ALTER TABLE language ADD CONSTRAINT pk_language PRIMARY KEY (language,country_code);

ALTER TABLE language ADD CONSTRAINT check_language_percentage CHECK (percentage >= 0 AND percentage <=100);

-- Create table located_on
CREATE TABLE located_on(
    city_name     VARCHAR2(255),
    province_name VARCHAR2(255),
    country_code  VARCHAR2(5),
    island        VARCHAR2(255)
);
-- Set primary key for country_other_local_name table
ALTER TABLE located_on ADD CONSTRAINT pk_located_on PRIMARY KEY (city_name,province_name,country_code,island);


-- Create organization table
CREATE TABLE organization(
    name VARCHAR2(255),
    abbreviation  VARCHAR2(20),
    city_name     VARCHAR2(255),
    province_name VARCHAR2(255),
    country_code  VARCHAR2(5),
    established   DATE
);
-- Set primary key for country_other_local_name table
ALTER TABLE organization ADD CONSTRAINT pk_organization PRIMARY KEY (abbreviation);

-- Create politics table
CREATE TABLE politics(
    country_code      VARCHAR2(5),
    independence_date DATE,
    was_dependent     VARCHAR2(255),
    dependent         VARCHAR2(5),
    government        VARCHAR2(255)
);
-- Set primary key for country_other_local_name table
ALTER TABLE politics ADD CONSTRAINT pk_politics PRIMARY KEY (country_code);


-- Create country_population table
CREATE TABLE country_population(
    country_code      VARCHAR2(5),
    population_growth NUMBER,
    infant_mortality  NUMBER(4)
);
-- Set primary key for country_popoulation table
ALTER TABLE country_population ADD CONSTRAINT pk_country_population PRIMARY KEY (country_code);

ALTER TABLE country_population ADD CONSTRAINT check_country_pop_infant_mortality CHECK (infant_mortality >= 0 AND infant_mortality<=1000);

-- Create province table
CREATE TABLE province(
    name         VARCHAR2(255),
    country_code VARCHAR2(5),
    area         NUMBER
);
-- Set primary key for country_popoulation table
ALTER TABLE province ADD CONSTRAINT pk_province PRIMARY KEY (name,country_code);

ALTER TABLE province ADD CONSTRAINT check_province CHECK (area>0);

-- Create province_capital table for determining the capital of a province
CREATE TABLE province_capital(
    province_name VARCHAR2(255),
    country_code  VARCHAR2(5),
    capital       VARCHAR2(255),
    capprov       VARCHAR2(255)
);
-- Set primary key for country_popoulation table
ALTER TABLE province_capital ADD CONSTRAINT pk_province_capital PRIMARY KEY (province_name,country_code);


-- Create province_local_name table
CREATE TABLE province_local_name(
    province_name       VARCHAR2(255),
    country_code        VARCHAR2(5),
    province_local_name VARCHAR2(255)
);
-- Set primary key for province_local_name
ALTER TABLE province_local_name ADD CONSTRAINT pk_province_local_name PRIMARY KEY (province_name,country_code);


-- Create province_other_name table
CREATE TABLE province_other_name(
    province_name       VARCHAR2(255),
    country_code        VARCHAR2(5),
    province_other_name VARCHAR2(255)
);
-- Set primary key for province_other_name
ALTER TABLE province_other_name ADD CONSTRAINT pk_province_other_name PRIMARY KEY (province_name,country_code,province_other_name);


-- Create province_population table
CREATE TABLE province_population(
    province_name VARCHAR2(255),
    country_code  VARCHAR2(5),
    population    NUMBER(11),
    year          NUMBER(4)
);
-- Set primary key for province_population table
ALTER TABLE province_population ADD CONSTRAINT pk_province_population PRIMARY KEY (province_name,country_code,population,year);

ALTER TABLE province_population ADD CONSTRAINT check_province_population_population CHECK (population > 0);
ALTER TABLE province_population ADD CONSTRAINT check_province_population_year CHECK (year > 0);

-- Create religion table
CREATE TABLE religion(
    country_code VARCHAR2(5),
    name         VARCHAR2(255),
    percentage   NUMBER(5,2)
);
-- Set primary key for religion table
ALTER TABLE religion ADD CONSTRAINT pk_religion PRIMARY KEY (country_code,name);

ALTER TABLE religion ADD CONSTRAINT check_religion_percentage CHECK (percentage >= 0 AND percentage <= 100);

-- CREATE FOREIGN KEYS FOR TABLES

-- Set foreign keys for airport table
ALTER TABLE airport ADD CONSTRAINT fk_airport_country FOREIGN KEY (country_code) REFERENCES country (code);
ALTER TABLE airport ADD CONSTRAINT fk_airport_city FOREIGN KEY (city_name,province_name,country_code) REFERENCES city (name,province_name,country_code);

-- Set foreign keys for borders table
ALTER TABLE borders ADD CONSTRAINT fk_borders_country_1 FOREIGN KEY (country_code_1) REFERENCES country (code);
ALTER TABLE borders ADD CONSTRAINT fk_borders_country_2 FOREIGN KEY (country_code_2) REFERENCES country (code);

-- Set foreign keys for city table
ALTER TABLE city ADD CONSTRAINT fk_city_province FOREIGN KEY (province_name,country_code) REFERENCES province (name, country_code);

-- Set foreign keys for city_local_name table
ALTER TABLE city_local_name ADD CONSTRAINT fk_city_local_name_city FOREIGN KEY (city_name,province_name,country_code) REFERENCES city (name,province_name,country_code);

-- Set foreign keys for city_local_name table
ALTER TABLE city_other_name ADD CONSTRAINT fk_city_other_name_city FOREIGN KEY (city_name,province_name,country_code) REFERENCES city (name,province_name,country_code);

-- Set foreign key for city_populations table
ALTER TABLE city_populations ADD CONSTRAINT fk_city_populations_city FOREIGN KEY (city_name,province_name,country_code) REFERENCES city (name,province_name,country_code);

-- Set foreign key for country table
ALTER TABLE country ADD CONSTRAINT fk_country_capital_city FOREIGN KEY (capital,province_name,code) REFERENCES city (name,province_name,country_code);

-- Set foreign key for country_other_local_name table
ALTER TABLE country_other_local_name ADD CONSTRAINT fk_country_other_local_name_country FOREIGN KEY (country_code) REFERENCES country (code);

-- Set foreign key for country_continent table
ALTER TABLE country_continent ADD CONSTRAINT fk_country_continent_country FOREIGN KEY (country_code) REFERENCES country (code);
ALTER TABLE country_continent ADD CONSTRAINT fk_country_continent_continent FOREIGN KEY (continent_name) REFERENCES continent (name);

-- Set foreign key for country_populations table
ALTER TABLE country_populations ADD CONSTRAINT fk_country_populations_country FOREIGN KEY (country_code) REFERENCES country (code);

-- Set foreign key for economy table
ALTER TABLE economy ADD CONSTRAINT fk_economy_country FOREIGN KEY (country_code) REFERENCES country (code);

-- Set foreign key for ethnic_group table
ALTER TABLE ethnic_group ADD CONSTRAINT fk_ethnic_group_country FOREIGN KEY (country_code) REFERENCES country (code);

-- Set foreign key for is_member table
ALTER TABLE is_member ADD CONSTRAINT fk_is_member_country FOREIGN KEY (country_code) REFERENCES country (code);
ALTER TABLE is_member ADD CONSTRAINT fk_is_member_organization FOREIGN KEY (organization_abbreviation) REFERENCES organization (abbreviation);

-- Set foreign key for language table
ALTER TABLE language ADD CONSTRAINT fk_language_country FOREIGN KEY (country_code) REFERENCES country (code);

-- Set foreign key for located_on table
ALTER TABLE located_on ADD CONSTRAINT fk_located_on_city FOREIGN KEY (city_name, province_name, country_code) REFERENCES city (name,province_name,country_code);

-- Set foreign key for organization table
ALTER TABLE organization ADD CONSTRAINT fk_organization_city FOREIGN KEY (city_name, province_name, country_code) REFERENCES city (name,province_name,country_code);

-- Set foreign key for politics table
ALTER TABLE politics ADD CONSTRAINT fk_politics_country FOREIGN KEY (country_code) REFERENCES country (code);
ALTER TABLE politics ADD CONSTRAINT fn_politics_dependent_country FOREIGN KEY (dependent) REFERENCES country (code);

-- Set foreign key for country_population table
ALTER TABLE country_population ADD CONSTRAINT fn_country_population_country FOREIGN KEY (country_code) REFERENCES country (code);

-- Set foreign key for province table
ALTER TABLE province ADD CONSTRAINT fk_province_country FOREIGN KEY (country_code) REFERENCES country (code);

-- Set foreign key for province_capital table
ALTER TABLE province_capital ADD CONSTRAINT fk_province_capital_province FOREIGN KEY (province_name,country_code) REFERENCES province(name,country_code);
ALTER TABLE province_capital ADD CONSTRAINT fk_province_capital_capprov_province FOREIGN KEY (capprov,country_code) REFERENCES province(name,country_code);
ALTER TABLE province_capital ADD CONSTRAINT fk_province_capital_city FOREIGN KEY (capital,province_name,country_code) REFERENCES city(name,province_name,country_code);

-- Set foreign key for province_local_name table
ALTER TABLE province_local_name ADD CONSTRAINT fk_province_local_name_province FOREIGN KEY (province_name,country_code) REFERENCES province(name,country_code);

-- Set foreign key for province_other_name table
ALTER TABLE province_other_name ADD CONSTRAINT fk_province_other_name_province FOREIGN KEY (province_name,country_code) REFERENCES province(name,country_code);

-- Set primary key for province_population table
ALTER TABLE province_population ADD CONSTRAINT fk_province_population_province FOREIGN KEY (province_name,country_code) REFERENCES province(name,country_code);

-- Set primary key for province_population table
ALTER TABLE religion ADD CONSTRAINT fk_religion_country FOREIGN KEY (country_code) REFERENCES country(code);