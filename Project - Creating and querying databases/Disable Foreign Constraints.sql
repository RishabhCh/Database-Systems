-- Set foreign keys for airport table
ALTER TABLE airport DISABLE CONSTRAINT fk_airport_country; 
ALTER TABLE airport DISABLE CONSTRAINT fk_airport_city;

-- Set foreign keys for borders table
ALTER TABLE borders DISABLE CONSTRAINT fk_borders_country_1;
ALTER TABLE borders DISABLE CONSTRAINT fk_borders_country_2;

-- Set foreign keys for city table
ALTER TABLE city DISABLE CONSTRAINT fk_city_province;

-- Set foreign keys for city_local_name table
ALTER TABLE city_local_name DISABLE CONSTRAINT fk_city_local_name_city;

-- Set foreign keys for city_local_name table
ALTER TABLE city_other_name DISABLE CONSTRAINT fk_city_other_name_city;

-- Set foreign key for city_populations table
ALTER TABLE city_populations DISABLE CONSTRAINT fk_city_populations_city;

-- Set foreign key for country table
ALTER TABLE country DISABLE CONSTRAINT fk_country_capital_city;

-- Set foreign key for country_other_local_name table
ALTER TABLE country_other_local_name DISABLE CONSTRAINT fk_country_other_local_name_country;

-- Set foreign key for country_continent table
ALTER TABLE country_continent DISABLE CONSTRAINT fk_country_continent_country;
ALTER TABLE country_continent DISABLE CONSTRAINT fk_country_continent_continent;

-- Set foreign key for country_populations table
ALTER TABLE country_populations DISABLE CONSTRAINT fk_country_populations_country;

-- Set foreign key for economy table
ALTER TABLE economy DISABLE CONSTRAINT fk_economy_country;

-- Set foreign key for ethnic_group table
ALTER TABLE ethnic_group DISABLE CONSTRAINT fk_ethnic_group_country;

-- Set foreign key for is_member table
ALTER TABLE is_member DISABLE CONSTRAINT fk_is_member_country;
ALTER TABLE is_member DISABLE CONSTRAINT fk_is_member_organization;

-- Set foreign key for language table
ALTER TABLE language DISABLE CONSTRAINT fk_language_country;

-- Set foreign key for located_on table
ALTER TABLE located_on DISABLE CONSTRAINT fk_located_on_city;

-- Set foreign key for organization table
ALTER TABLE organization DISABLE CONSTRAINT fk_organization_city;

-- Set foreign key for politics table
ALTER TABLE politics DISABLE CONSTRAINT fk_politics_country;
ALTER TABLE politics DISABLE CONSTRAINT fn_politics_dependent_country;

-- Set foreign key for country_population table
ALTER TABLE country_population DISABLE CONSTRAINT fn_country_population_country;

-- Set foreign key for province table
ALTER TABLE province DISABLE CONSTRAINT fk_province_country;

-- Set foreign key for province_capital table
ALTER TABLE province_capital DISABLE CONSTRAINT fk_province_capital_province;
ALTER TABLE province_capital DISABLE CONSTRAINT fk_province_capital_capprov_province;
ALTER TABLE province_capital DISABLE CONSTRAINT fk_province_capital_city;

-- Set foreign key for province_local_name table
ALTER TABLE province_local_name DISABLE CONSTRAINT fk_province_local_name_province;

-- Set foreign key for province_other_name table
ALTER TABLE province_other_name DISABLE CONSTRAINT fk_province_other_name_province;

-- Set primary key for province_population table
ALTER TABLE province_population DISABLE CONSTRAINT fk_province_population_province;

-- Set primary key for province_population table
ALTER TABLE religion DISABLE CONSTRAINT fk_religion_country;