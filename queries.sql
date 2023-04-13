SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '01 01 2022';
SAVEPOINT birth;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO birth;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1 1 1990' AND '1 1 2000' GROUP BY species;

SELECT name FROM animals JOIN owners ON animals.owner_id = (SELECT owners.id WHERE full_name = 'Melody Pond');

SELECT animals.name FROM animals JOIN species ON animals.species_id = (SELECT species.id WHERE species.name = 'Pokemon');

SELECT animals.name, owners.full_name FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;

SELECT species.name, COUNT(animals.name) FROM animals
JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = (SELECT owners.id WHERE owners.full_name = 'Jennifer Orwell')
JOIN species ON animals.species_id = (SELECT species.id WHERE species.name = 'Digimon');

SELECT animals.name, animals.escape_attempts FROM animals
JOIN owners ON animals.owner_id = (SELECT owners.id WHERE owners.full_name = 'Dean Winchester')
AND animals.escape_attempts = 0;

SELECT owners.full_name FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY COUNT(*) DESC LIMIT 1;