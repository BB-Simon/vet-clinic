/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered IS TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name LIKE 'Agumon' OR name LIKE 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IS TRUE;
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- **************** All transactions ******************
-- Begin the transaction 1
BEGIN;

-- Update the animals table by setting the species column to unspecified
UPDATE animals
SET species = 'unspecified'

-- Verify that change was made
SELECT * FROM animals;

-- Roll back the transaction
ROLLBACK;

-- Verify that the species columns went back to the state before the transaction
SELECT * FROM animals;

-- Begin the transaction 2
BEGIN;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

-- Commit the transaction
COMMIT;

-- Verify that the species columns went back to the state before the transaction
SELECT * FROM animals;

-- Begin the transaction 3
BEGIN;

-- Delete all records in the animals table
DELETE FROM animals;

-- Verify that change was made
SELECT * FROM animals;

-- Roll back the transaction
ROLLBACK;

-- After the rollback verify if all records in the animals table still exists.
SELECT * FROM animals;

-- Begin the transaction 4
BEGIN;

-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals
WHERE date_of_birth > '2022-01-01'::date;

-- Create a savepoint for the transaction.
SAVEPOINT SP1;

-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint.
ROLLBACK TO SP1;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit transaction
COMMIT;


-- ******* Queries with aggregates **********
-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS all_escape_attempts
FROM animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, Max(weight_kg) AS max_weight 
FROM animals
GROUP By species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS all_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990,01,01' AND '2000,12,31'
GROUP By species;