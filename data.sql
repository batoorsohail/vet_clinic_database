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
      ((SELECT id FROM species WHERE name = 'Digimon'),(SELECT id FROM vets WHERE name = 'Jack Harkness'))