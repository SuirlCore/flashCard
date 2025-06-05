-- ------------------------------------------------------------------------------------------
-- create database---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------


DROP DATABASE IF EXISTS plants;

CREATE DATABASE plants;

USE plants;


-- ------------------------------------------------------------------------------------------
-- landscape tables--------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------

-- people
CREATE TABLE IF NOT EXISTS people (
    personID int NOT NULL AUTO_INCREMENT,
    personName varchar(30) NOT NULL,
    personPicture mediumblob,
    PRIMARY KEY (personID)
);

-- plants
CREATE TABLE IF NOT EXISTS plants (
    plantID int NOT NULL AUTO_INCREMENT,
    plantName varchar(30) NOT NULL,
    speciesID int,
    plantPic mediumblob,
    dateAcquired date,
    status ENUM('active', 'given_away', 'dead') NOT NULL DEFAULT 'active',
    ownedBy int,
    PRIMARY KEY (plantID)
);

-- plant notes
CREATE TABLE IF NOT EXISTS plantNotes (
    noteID int NOT NULL AUTO_INCREMENT,
    plantID int NOT NULL,
    noteDate date,
    note varchar(1000),
    PRIMARY KEY (noteID)
);

-- species
CREATE TABLE IF NOT EXISTS species (
    speciesID int NOT NULL AUTO_INCREMENT,
    speciesName varchar(30) NOT NULL,
    speciesScientificName varchar(30) NOT NULL,
    speciesCare varchar(1000) NOT NULL,
    speciesCareLink varchar(1000),
    PRIMARY KEY (speciesID)
);

-- times watered
CREATE TABLE IF NOT EXISTS waterDate (
    waterID int NOT NULL AUTO_INCREMENT,
    plantID int NOT NULL,
    waterDate date NOT NULL,
    PRIMARY KEY (waterID)
);

-- times fertalized
CREATE TABLE IF NOT EXISTS fertalizedDate (
    fertalizedID int NOT NULL AUTO_INCREMENT,
    plantID int NOT NULL,
    fertalizeDate date NOT NULL,
    PRIMARY KEY (fertalizedID)
);

-- track status changes
CREATE TABLE IF NOT EXISTS statusChange (
    changeID int NOT NULL AUTO_INCREMENT,
    plantID int NOT NULL,
    status varchar(15),
    disposition varchar (500),
    dateChanged date NOT NULL,
    PRIMARY KEY (changeID)
);

-- create wishlists
CREATE TABLE IF NOT EXISTS wishlists (
    wishlistID int NOT NULL AUTO_INCREMENT,
    wishlistName varchar(50) NOT NULL,
    personID int NOT NULL,
);

--wishlist items
CREATE TABLE IF NOT EXISTS wishlistItems (
    itemID int NOT NULL AUTO_INCREMENT,
    wishlistID int NOT NULL,
    speciesID int NOT NULL,

);

-- ------------------------------------------------------------------------------------------
-- Foreign Keys------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------


ALTER TABLE plants
ADD FOREIGN KEY (ownedBy) REFERENCES people(personID);

ALTER TABLE plants
ADD FOREIGN KEY (speciesID) REFERENCES species(speciesID);

ALTER TABLE waterDate
ADD FOREIGN KEY (plantID) REFERENCES plants(plantID);

ALTER TABLE fertalizedDate
ADD FOREIGN KEY (plantID) REFERENCES plants(plantID);

ALTER TABLE plantNotes
ADD FOREIGN KEY (plantID) REFERENCES plants(plantID);

ALTER TABLE statusChange
ADD FOREIGN KEY (plantID) REFERENCES plants(plantID);

ALTER TABLE wishlists
ADD FOREIGN KEY (personID) REFERENCES people(personID);

ALTER TABLE wishlistItems
ADD FOREIGN KEY (speciesID) REFERENCES species(speciesID);

ALTER TABLE wishlistItems
ADD FOREIGN KEY (wishlistID) REFERENCES wishilsts(wishlistID);