-- ------------------------------------------------------------------------------------------
-- create database---------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------


DROP DATABASE IF EXISTS flashCards;

CREATE DATABASE flashCards;

USE flashCards;


-- ------------------------------------------------------------------------------------------
-- landscape tables--------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------

-- users
CREATE TABLE IF NOT EXISTS users (
    userID int NOT NULL AUTO_INCREMENT,
    personName varchar(30) NOT NULL,
    PRIMARY KEY (personID)
);

-- languages
CREATE TABLE IF NOT EXISTS languages (
    languageID int NOT NULL AUTO_INCREMENT,
    languageName varchar(30) NOT NULL,
    PRIMARY KEY (languageID)
);

-- words
CREATE TABLE IF NOT EXISTS words (
    wordID int NOT NULL AUTO_INCREMENT,
    wordName varchar(50) NOT NULL,
    languageID int NOT NULL,
    wordDefinition varchar(500) NOT NULL,
    wordType varchar(50) NOT NULL,
    declension varchar(50) NOT NULL,
    PRIMARY KEY (wordID)
);

-- words for specific languages that a user is practicing
CREATE TABLE IF NOT EXISTS practiceLists(
    itemID int NOT NULL AUTO_INCREMENT,
    wordID int NOT NULL,
    userID int NOT NULL,
);

-- tracks number of correct answers for user per language
CREATE TABLE IF NOT EXISTS answers (
    answerID int NOT NULL AUTO_INCREMENT,
    wordID int NOT NULL,
    userID int NOT NULL,
    answeredRight int,
    answeredWrong int,
);

-- ------------------------------------------------------------------------------------------
-- Foreign Keys------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------


ALTER TABLE words
ADD FOREIGN KEY (languageID) REFERENCES languages(languageID);

ALTER TABLE practiceLists
ADD FOREIGN KEY (wordID) REFERENCES words(wordID);

ALTER TABLE practiceLists
ADD FOREIGN KEY (userID) REFERENCES users(userID);