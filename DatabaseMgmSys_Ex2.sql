/******** KYLE PERRA ********/
/******** CS 420 - Montgomery ********/


/*********************************************** #1 ***********************************************/
START TRANSACTION;

/*********************************************** #2 ***********************************************/
SET FOREIGN_KEY_CHECKS  = 0;

/*********************************************** #3 ***********************************************/
DROP TABLE IF EXISTS Wombats;

/*********************************************** #4 ***********************************************/
DROP TABLE IF EXISTS Owners;

/*********************************************** #5 ***********************************************/
SET FOREIGN_KEY_CHECKS  = 1;

/*********************************************** #6 ***********************************************/
COMMIT;

/*********************************************** #7 ***********************************************/
CREATE TABLE Wombats (
    
 id INT NOT NULL AUTO_INCREMENT,
 name VARCHAR(255),
 birth DATE,
 gender ENUM('M','F'),
 rabid ENUM('YES','NO'),
 owner_id INT, 
 PRIMARY KEY(id)) 
    ENGINE=InnoDB;

/*********************************************** #8 ***********************************************/
CREATE TABLE Owners (
    
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(2),
    zip INT, 
    favorite_wombat_id INT,
    PRIMARY KEY(id))
        ENGINE=InnoDB;

/*********************************************** #9 ***********************************************/
INSERT Wombats;

/*********************************************** #10 **********************************************/
INSERT Owners;

/*********************************************** #11 **********************************************/
ALTER TABLE Wombats 
ADD CONSTRAINT fk_owner_id 
FOREIGN KEY(owner_id) REFERENCES Owners(id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

/*********************************************** #12 **********************************************/

/* Use a query to find the id of the owner whose favorite wombat id does not refer to a wombat */
SELECT id FROM Owners
    WHERE NOT EXISTS (SELECT * FROM Wombats WHERE id = Owners.favorite_wombat_id);
/* The result of this query highlights the Owner Jake - output: [id] => 5 */
/* Upon further inspection, one can notice that Jake's
initial favorite_wombat_id is well out of range (110 out of 20) */

/* Use the table above and an update statement to fix that error (you can hard code the wombat’s
id and owner’s id into this query) */
/* Here, we will set Jake's new favorite wombat to Molly - #20 */
UPDATE Owners 
    SET favorite_wombat_id = 20 WHERE id = 5;

/* Now add the constraint to the table */
ALTER TABLE Owners
ADD CONSTRAINT fk_favorite_wombat_id
FOREIGN KEY (favorite_wombat_id) REFERENCES Wombats(id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

/*********************************************** #13 **********************************************/

/* This code results in error, given the previously assigned constraint,
a 'favorite' Wombat cannot be deleted */
DELETE FROM Wombats 
    WHERE id = 10;
/* Output:= 1451: Cannot delete or update a parent row: a foreign key constraint fails (`perrak`.`owners`, CONSTRAINT `fk_favorite_wombat_id` FOREIGN KEY (`favorite_wombat_id`) REFERENCES `wombats` (`id`) ON UPDATE CASCADE) */

/*********************************************** #14 **********************************************/
UPDATE Wombats 
    SET id = 25 WHERE id = 10;

/*********************************************** #15 **********************************************/
ALTER TABLE Wombats
    AUTO_INCREMENT = 25;

/*********************************************** #16 **********************************************/
SELECT favorite_wombat_id FROM Owners
    WHERE Owners.id = 2;

/*********************************************** #17 **********************************************/

/* This code results in error, given the previously assigned constraint,
an actual owner of a Wombat cannot be deleted */
DELETE FROM Owners 
    WHERE id = 1;
/* Output:= 1451: Cannot delete or update a parent row: a foreign key constraint fails (`perrak`.`wombats`,
CONSTRAINT `fk_owner_id` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`id`) ON UPDATE CASCADE) */

/*********************************************** #18 **********************************************/

/* For some reason, I could not follow through with this query on the testing page */
UPDATE Owners
    SET id = 6 WHERE id = 4;
    
/*********************************************** #19 **********************************************/
ALTER TABLE Owners
    AUTO_INCREMENT = 6; /* This will update the value for auto incrementing on newly created Owners */
    
/*********************************************** #20 **********************************************/
SELECT favorite_wombat_id FROM Owners
    WHERE Owners.id = 4;

/*********************************************** #21 **********************************************/

/* returns the Owner id of whomever might not be paired with their favorite_wombat_id */
SELECT id FROM Owners 
    WHERE NOT EXISTS (SELECT * FROM Wombats WHERE Owners.favorite_wombat_id = owner_id); 
    
/*********************************************** #22 **********************************************/
/* Pam's favorite wombat is owned already by Jane Doe, so we can change her preference to match a Wombat
with her specific owner_id */
UPDATE Owners
    SET favorite_wombat_id = 1 WHERE id = 6;