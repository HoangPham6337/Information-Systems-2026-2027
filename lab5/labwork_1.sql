CREATE DATABASE IF NOT EXISTS magazine;

USE magazine;

CREATE TABLE magazine (
    magazineid VARCHAR(50) PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    issn CHAR(8),
    number INT,
    year INT
);

CREATE TABLE article (
    articleid VARCHAR(50) PRIMARY KEY,
    title VARCHAR(200) UNIQUE,
    pageofbeginning INT,
    pageofending INT,
    magazineid VARCHAR(50),
    FOREIGN KEY (magazineid) REFERENCES magazine (magazineid)
);

CREATE TABLE author (
    authorid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    ascription VARCHAR(100)
);

CREATE TABLE articleauthor (
    authorid VARCHAR(50),
    articleid VARCHAR(50),
    orderno INT,
    PRIMARY KEY (authorid, articleid),
    FOREIGN KEY (authorid) REFERENCES author (authorid),
    FOREIGN KEY (articleid) REFERENCES article (articleid)
);
