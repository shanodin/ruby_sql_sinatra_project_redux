DROP TABLE IF EXISTS pets;
DROP TABLE IF EXISTS owners;

CREATE TABLE owners(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  phone_number VARCHAR(255)
);

CREATE TABLE pets(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  type VARCHAR(255),
  breed VARCHAR(255),
  can_adopt VARCHAR(255),
  status VARCHAR(255),
  owner_id INT REFERENCES owners(id),
  admission_date VARCHAR(255),
  photo VARCHAR(255)
);
