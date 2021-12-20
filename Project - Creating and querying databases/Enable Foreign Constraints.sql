-- Set foreign keys for airport table
ALTER TABLE airport ENABLE CONSTRAINT fk_airport_country; 
ALTER TABLE airport ENABLE CONSTRAINT fk_airport_city;

-- Set foreign keys for borders table
ALTER TABLE borders ENABLE CONSTRAINT fk_borders_country_1;
ALTER TABLE borders ENABLE CONSTRAINT fk_borders_country_2;

-- Set foreign keys for city table
ALTER TABLE city ENABLE CONSTRAINT fk_city_province;

-- Set foreign keys for city_local_name table
ALTER TABLE city_local_name ENABLE CONSTRAINT fk_city_local_name_city;

-- Set foreign keys for city_local_name table
ALTER TABLE city_other_name ENABLE CONSTRAINT fk_city_other_name_city;

-- Set foreign key for city_populations table
ALTER TABLE city_populations ENABLE CONSTRAINT fk_city_populations_city;

-- Set foreign key for country table
ALTER TABLE country ENABLE CONSTRAINT fk_country_capital_city;

-- Set foreign key for country_other_local_name table
ALTER TABLE country_other_local_name ENABLE CONSTRAINT fk_country_other_local_name_country;

-- Set foreign key for country_continent table
ALTER TABLE country_continent ENABLE CONSTRAINT fk_country_continent_country;
ALTER TABLE country_continent ENABLE CONSTRAINT fk_country_continent_continent;

-- Set foreign key for country_populations table
ALTER TABLE country_populations ENABLE CONSTRAINT fk_country_populations_country;

-- Set foreign key for economy table
ALTER TABLE economy ENABLE CONSTRAINT fk_economy_country;

-- Set foreign key for ethnic_group table
ALTER TABLE ethnic_group ENABLE CONSTRAINT fk_ethnic_group_country;

-- Set foreign key for is_member table
ALTER TABLE is_member ENABLE CONSTRAINT fk_is_member_country;
ALTER TABLE is_member ENABLE CONSTRAINT fk_is_member_organization;

-- Set foreign key for language table
ALTER TABLE language ENABLE CONSTRAINT fk_language_country;

-- Set foreign key for located_on table
ALTER TABLE located_on ENABLE CONSTRAINT fk_located_on_city;

-- Set foreign key for organization table
ALTER TABLE organization ENABLE CONSTRAINT fk_organization_city;

-- Set foreign key for politics table
ALTER TABLE politics ENABLE CONSTRAINT fk_politics_country;
ALTER TABLE politics ENABLE CONSTRAINT fn_politics_dependent_country;

-- Set foreign key for country_population table
ALTER TABLE country_population ENABLE CONSTRAINT fn_country_population_country;

-- Set foreign key for province table
ALTER TABLE province ENABLE CONSTRAINT fk_province_country;

-- Set foreign key for province_capital table
ALTER TABLE province_capital ENABLE CONSTRAINT fk_province_capital_province;
ALTER TABLE province_capital ENABLE CONSTRAINT fk_province_capital_capprov_province;
ALTER TABLE province_capital ENABLE CONSTRAINT fk_province_capital_city;

-- Set foreign key for province_local_name table
ALTER TABLE province_local_name ENABLE CONSTRAINT fk_province_local_name_province;

-- Set foreign key for province_other_name table
ALTER TABLE province_other_name ENABLE CONSTRAINT fk_province_other_name_province;

-- Set primary key for province_population table
ALTER TABLE province_population ENABLE CONSTRAINT fk_province_population_province;

-- Set primary key for province_population table
ALTER TABLE religion ENABLE CONSTRAINT fk_religion_country;