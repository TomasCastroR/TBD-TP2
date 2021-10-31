CREATE DATABASE IF NOT EXISTS Biblioteca;

USE Biblioteca;

DROP TABLE IF EXISTS Escribe;
DROP TABLE IF EXISTS Autor;
DROP TABLE IF EXISTS Libro;

CREATE TABLE Autor (
    id            INT             NOT NULL    AUTO_INCREMENT,
    nombre        VARCHAR(30)     NOT NULL,
    apellido      VARCHAR(30)     NOT NULL,
    nacionailad   VARCHAR(30)     NOT NULL,
    residencia    VARCHAR(30)     NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Libro (
    ISBN           VARCHAR(13)     NOT NULL,
    titulo         VARCHAR(30)     NOT NULL,
    editorial      VARCHAR(30)     NOT NULL,
    precio         FLOAT(10,2)     NOT NULL,
    PRIMARY KEY (ISBN)
);

CREATE TABLE Escribe (
    id          INT             NOT NULL
    ISBN        VARCHAR(13)     NOT NULL,
    año         YEAR            NOT NULL,         
    PRIMARY KEY (id,ISBN),
    FOREIGN KEY (id) REFERENCES Autor(id)       ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES Libro(ISBN)   ON UPDATE CASCADE ON DELETE CASCADE
);