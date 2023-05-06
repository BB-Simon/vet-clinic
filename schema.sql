/* Database schema to keep the structure of entire database. */

-- Animals schema
CREATE TABLE animals(
    id              INT GENERATED ALWAYS AS IDENTITY,
    name			VARCHAR(50),	
    date_of_birth	DATE,
    escape_attempts	INT,
    neutered		BOOLEAN,
    weight_kg		DECIMAL,
    species         VARCHAR
    PRIMARY KEY(id)
);

-- Owners schema
CREATE TABLE owners (
    id			INT GENERATED ALWAYS AS IDENTITY,
    full_name		VARCHAR(50),
    age			INT,
    PRIMARY KEY(id)
);

-- Species schema
CREATE TABLE species (
    id			INT GENERATED ALWAYS AS IDENTITY,
    name			VARCHAR(50),
    PRIMARY KEY(id)
);

-- Remove column species
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY(species_id) 
REFERENCES species(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals
ADD CONSTRAINT fk_owners
FOREIGN KEY(owner_id) 
REFERENCES owners(id);

-- Vets schema
CREATE TABLE vets(
    id			INT GENERATED ALWAYS AS IDENTITY,
    name		VARCHAR(100),	
    age			INT,
    date_of_graduation	DATE,
    PRIMARY KEY(id)
);

-- Specializations schema
CREATE TABLE specializations (
  id			INT GENERATED ALWAYS AS IDENTITY,
  species_id	INT REFERENCES species(id),
  vet_id		INT REFERENCES vets(id),
  PRIMARY KEY(id)
);

-- Visits schema
CREATE TABLE visits (
  id			INT GENERATED ALWAYS AS IDENTITY,
  animal_id		INT REFERENCES animals(id),
  vet_id		INT REFERENCES vets(id),
  date_of_visit		DATE,
  PRIMARY KEY(id)
);