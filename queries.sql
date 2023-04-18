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

-- What animals belong to Melody Pond?
SELECT name FROM animals JOIN owners ON animals.owner_id = (SELECT owners.id WHERE full_name = 'Melody Pond');

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species ON animals.species_id = (SELECT species.id WHERE species.name = 'Pokemon');

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT animals.name, owners.full_name FROM animals
RIGHT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(animals.name) FROM animals
JOIN species ON animals.species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = (SELECT owners.id WHERE owners.full_name = 'Jennifer Orwell')
JOIN species ON animals.species_id = (SELECT species.id WHERE species.name = 'Digimon');

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, animals.escape_attempts FROM animals
JOIN owners ON animals.owner_id = (SELECT owners.id WHERE owners.full_name = 'Dean Winchester')
AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY COUNT(*) DESC LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(animals.name) FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations ON vets.id = vet_id
LEFT JOIN species ON species.id = species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name
FROM animals
JOIN visits ON animals.id = animals_id AND date_of_visit >= '2020-04-01' AND date_of_visit <= '2020-08-30'
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

-- What animal has the most visits to vets?
SELECT animals.name
FROM animals
JOIN visits ON animals.id = animals_id
GROUP BY animals.name
ORDER BY COUNT(*) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name
FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name, species.name, vets.name, visits.date_of_visit FROM visits
JOIN animals ON animals.id = visits.animals_id
JOIN vets ON vets.id = visits.vet_id
JOIN species ON species.id = animals.species_id
WHERE visits.date_of_visit = (SELECT MAX(date_of_visit) FROM visits);

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(date_of_visit) FROM visits
JOIN animals ON animals.id = visits.animals_id
WHERE vet_id NOT IN (SELECT vet_id FROM specializations WHERE species_id = animals.species_id);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name FROM visits
JOIN vets ON visits.vet_id = (SELECT vet_id FROM vets WHERE vets.name = 'Maisy Smith')
JOIN animals ON animals.id = visits.animals_id
JOIN species ON species.id = animals.species_id
GROUP BY species.name
ORDER BY COUNT(*) DESC LIMIT 1;

SELECT COUNT(*) FROM visits where animal_id = 4;
SELECT * FROM visits where vet_id = 2;
SELECT * FROM owners where email = 'owner_18327@mail.com';