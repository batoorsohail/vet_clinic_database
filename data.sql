INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Agumon', '02 03 2020', 10.23, true, 2),
      ('Gabumon', '11 15 2018', 8, true, 2),
      ('Pikachu', '06 07 2021', 15.04, false, 1),
      ('Devimon', '05 12 2017', 11, true, 5);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES('Charmander', '02 08 2020', -11, false, 0),
      ('Plantmon', '11 15 2021', -5.7, true, 2),
      ('Squirtle', '04 02 1993', -12.13, false, 3),
      ('Angemon', '06 12 2005', -45, true, 1),
      ('Boarmon', '06 07 2005', 20.4, true, 7),
      ('Blossom', '10 13 1998', 17, true, 3),
      ('Ditto', '05 14 2022', 22, true, 4);

INSERT INTO owners (full_name, age)
VALUES('Sam Smith', 34),
      ('Jennifer Orwell', 19),
      ('Bob', 45),
      ('Melody Pond', 77),
      ('Dean Winchester', 14),
      ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES('Pokemon'),
      ('Digimon');

-- Inserted animals so it includes the species_id value
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE name NOT LIKE '%mon';

-- Inserted animals to include owner information (owner_id)
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE animals.name LIKE 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE animals.name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE animals.name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE animals.name IN ('Angemon', 'Boarmon');
UPDATE animals SET owner_id = (SELECT id from owners WHERE full_name = 'Bob') WHERE animals.name = 'Devimon' OR name = 'Plantmon';

INSERT INTO vets (name, age, date_of_graduation)
VALUES('William Tatcher', 45, '04 23 2000'),
      ('Maisy Smith', 26, '01 17 2019'),
      ('Stephanie Mendez', 64, '05 04 1981'),
      ('Jack Harkness', 38, '06 08 2008');

INSERT INTO specializations (species_id, vet_id)
VALUES((SELECT id FROM species WHERE name = 'Pokemon'),(SELECT id FROM vets WHERE name = 'William Tatcher')),
      ((SELECT id FROM species WHERE name = 'Digimon'),(SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
      ((SELECT id FROM species WHERE name = 'Pokemon'),(SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
      ((SELECT id FROM species WHERE name = 'Digimon'),(SELECT id FROM vets WHERE name = 'Jack Harkness'));

INSERT INTO visits (animals_id, vet_id, date_of_visit)
VALUES((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher') ,'05 24 2020'),
      ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '07 22 2020'),
      ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '02 02 2021'),
      ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '01 05 2021'),
      ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '03 08 2020'),
      ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '05 14 2020'),
      ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '05 04 2021'),
      ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '02 24 2021'),
      ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '12 21 2019'),
      ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '08 10 2020'),
      ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '04 07 2021'),
      ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '09 29 2019'),
      ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '10 03 2020'),
      ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '11 04 2020'),
      ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '01 24 2019'),
      ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '05 15 2019'),
      ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '02 27 2020'),
      ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '08 03 2020'),
      ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '05 24 2020'),
      ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '01 11 2021');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animals_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';