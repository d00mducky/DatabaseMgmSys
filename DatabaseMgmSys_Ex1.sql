/* Kyle Perra */

/* 1 */

SHOW TABLES;

/* 2 */

CREATE TABLE Wombats
(
name VARCHAR(255),
birthdate DATE,
owner VARCHAR(255),
city VARCHAR(255),
state VARCHAR(2),
zip INT,
rabid ENUM('YES','NO')
);

/* 3 */

SHOW TABLES;

/* 4 */

DESCRIBE Wombats;

/* 5 */

INSERT INTO Wombats (name, birthdate, owner, city, state, zip, rabid)
VALUES ('Chucky','2013/06/12','Fred Jones','Skamokawa','WA','98647','YES');

INSERT INTO Wombats (name, birthdate, owner, city, state, zip, rabid)
VALUES ('Matilda','2009/07/03','Jon Smith','Puyallup','WA','98371','NO');

INSERT INTO Wombats (name, birthdate, owner, city, state, zip, rabid)
VALUES ('Fido','2002/06/08','Fred Jones','Skamokawa','WA','98647','NO');

INSERT INTO Wombats (name, birthdate, owner, city, state, zip, rabid)
VALUES ('Blinky','2008/02/12','Fred Jones','Skamokawa','WA','98647','NO');

INSERT INTO Wombats (name, birthdate, owner, city, state, zip, rabid)
VALUES ('Gherkin','2015/12/08','Ethel Smith','Walla Walla','WA','99362','NO');

INSERT INTO Wombats (name, birthdate, owner, city, state, zip, rabid)
VALUES ('Kermit','2004/11/08','Allen Kirby','Sequim','WA','98382','NO');

INSERT INTO Wombats (name, birthdate, owner, city, state, zip, rabid)
VALUES ('Frank','2010/09/25','Judy Greer','Tulalip','WA','98271','NO');

/* 6 */

SELECT name FROM Wombats 
WHERE ownder LIKE 'Fred Jones'
ORDER BY birthday;

/* 7 */

SELECT owner FROM Wombats 
WHERE birthday <DATE_SUB(NOW(), INTERVAL 10 YEAR);

/* 8 */

SELECT name FROM Wombats 
WHERE name LIKE '%k%';

/* 9 */

DELETE FROM Wombats 
WHERE name LIKE 'Chucky';

UPDATE Wombats 
SET owner = 'Ethel Smith', city = 'Walla Walla', zip = 99362
WHERE owner = 'Fred Jones';

/* 10 */

CREATE TABLE Owners
(
id INT NOT NULL AUTO_INCREMENT, 
name VARCHAR(255), 
city VARCHAR(255), 
state VARCHAR(2), 
zip INT, 
PRIMARY KEY(id)
);

/* 11 */

INSET INTO Owners(name, city, state, zip) VALUES ('Chucky', 'Skamokawa','WA', 98647),
('Matilda','Puyallup','WA',98371),
('Fido','Skamokawa','WA',98647),
('Blinky','Skamokawa','WA',98647),
('Gherkin','Walla Walla','WA',99362),
('Kermit','Sequim','WA',98382),
('Frank','Tulalip','WA',98271);

/* 12 */

ALTER TABLE Wombats 
ADD owners_id INT NOT NULL DEFAULT 0;

/* 13 */

ALTER TABLE Wombats
ADD CONSTRAINT fk_owner_id
FOREIGN KEY(owner_id)
REFERENCES Owners(id);

/* 14 */

UPDATE Wombats
SET owner_id=(SELECT id FROM Owners WHERE name=Wombats.owner);

/* 15 */

ALTER TABLE Wombats 
DROP COLUMN owner, 
DROP COLUMN city, 
DROP COLUMN state, 
DROP COLUMN zip;

/* 16 */

SELECT DISTINCT Owners.zip FROM Owners, Wombats 
WHERE Wombats.name LIKE '%k%' OR Wombats.name LIKE '%K%' 
ORDER BY Wombats.name ASC;