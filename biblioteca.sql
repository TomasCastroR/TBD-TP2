-- Blas Barbagelata     B-6146|8
-- Tomás Castro Rojas   C-6879/9

-- EJERCICIO 1
CREATE DATABASE IF NOT EXISTS Biblioteca;

USE Biblioteca;

DROP TABLE IF EXISTS Escribe;
DROP TABLE IF EXISTS Autor;
DROP TABLE IF EXISTS Libro;

CREATE TABLE Autor (
    id            INT             NOT NULL    AUTO_INCREMENT,
    nombre        VARCHAR(30)     NOT NULL,
    apellido      VARCHAR(30)     NOT NULL,
    nacionalidad  VARCHAR(30)     NOT NULL,
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

-- EJERCICIO 2
CREATE INDEX apellido_idx ON Autor(apellido);
CREATE INDEX titulo_idx ON Libro(titulo);

-- EJERCICIO 3
INSERT INTO Autor(id, nombre, apellido, nacionalidad, residencia) VALUES (DEFAULT, 'Abelardo', 'Castillo', 'Peru', 'Madrid');
INSERT INTO Autor(id, nombre, apellido, nacionalidad, residencia) VALUES (DEFAULT, 'George', 'Orwell', 'Inglaterra', 'Berlin');
INSERT INTO Autor(id, nombre, apellido, nacionalidad, residencia) VALUES (DEFAULT, 'Julio', 'Cortazar', 'Argentina', 'Paris');
INSERT INTO Autor(id, nombre, apellido, nacionalidad, residencia) VALUES (DEFAULT, 'Jorge Luis', 'Borges', 'Uruguay', 'Buenos Aires');
INSERT INTO Autor(id, nombre, apellido, nacionalidad, residencia) VALUES (DEFAULT, 'Karl', 'Marx', 'Chile', 'Nueva York');
INSERT INTO Autor(id, nombre, apellido, nacionalidad, residencia) VALUES (DEFAULT, 'Charly', 'Garcia', 'Brasil', 'Roma');

INSERT INTO Libro(ISBN, titulo, editorial, precio) VALUES ('3859113507841', 'Manifiesto Comunista', 'URSS', 750);
INSERT INTO Libro(ISBN, titulo, editorial, precio) VALUES ('6123804007084', '1984', 'Planeta', 84.50);
INSERT INTO Libro(ISBN, titulo, editorial, precio) VALUES ('2792081331417', 'Watchmen', 'Panini', 120.12);
INSERT INTO Libro(ISBN, titulo, editorial, precio) VALUES ('362355125324', 'Rayuela', 'UNR', 250);
INSERT INTO Libro(ISBN, titulo, editorial, precio) VALUES ('8916894484194', 'Cancion Para Mi Muerte', 'MTV', 200.1);
INSERT INTO Libro(ISBN, titulo, editorial, precio) VALUES ('4344393307054', 'Beatriz', 'Aleph', 315.75);

INSERT INTO Escribe(id, ISBN, año) VALUES 
    ((SELECT id FROM Autor WHERE nombre = 'Julio' AND apellido = 'Cortazar'),
     (SELECT ISBN FROM Libro WHERE titulo = 'Rayuela' AND editorial = 'UNR'),
     '1963');
INSERT INTO Escribe(id, ISBN, año) VALUES 
    ((SELECT id FROM Autor WHERE nombre = 'Charly' AND apellido = 'Garcia'),
     (SELECT ISBN FROM Libro WHERE titulo = 'Cancion Para Mi Muerte' AND editorial = 'MTV'),
     '2001');
INSERT INTO Escribe(id, ISBN, año) VALUES 
    ((SELECT id FROM Autor WHERE nombre = 'Karl' AND apellido = 'Marx'),
     (SELECT ISBN FROM Libro WHERE titulo = 'Manifiesto Comunista' AND editorial = 'URSS'),
     '1848');
INSERT INTO Escribe(id, ISBN, año) VALUES 
    ((SELECT id FROM Autor WHERE nombre = 'Abelardo' AND apellido = 'Castillo'),
     (SELECT ISBN FROM Libro WHERE titulo = 'Watchmen' AND editorial = 'Panini'),
     '1998');
INSERT INTO Escribe(id, ISBN, año) VALUES 
    ((SELECT id FROM Autor WHERE nombre = 'George' AND apellido = 'Orwell'),
     (SELECT ISBN FROM Libro WHERE titulo = '1984' AND editorial = 'Planeta'),
     '1941');
INSERT INTO Escribe(id, ISBN, año) VALUES 
    ((SELECT id FROM Autor WHERE nombre = 'Jorge Luis' AND apellido = 'Borges'),
     (SELECT ISBN FROM Libro WHERE titulo = 'Beatriz' AND editorial = 'Aleph'),
     '1963');

-- EJERCICIO 4
UPDATE Autor SET residencia = 'Buenos Aires' 
    WHERE nombre = 'Abelardo' AND apellido = 'Castillo';

UPDATE Libro SET precio = precio * 1.1 
    WHERE editorial = 'UNR';

UPDATE Libro Set precio = precio * 1.1 
    WHERE ISBN IN (SELECT ISBN FROM Escribe 
        WHERE id IN (SELECT id FROM Autor 
            WHERE nacionalidad <> 'Argentina')) AND precio > 200;
UPDATE Libro Set precio = precio * 1.2
    WHERE ISBN IN (SELECT ISBN FROM Escribe 
        WHERE id IN (SELECT id FROM Autor 
            WHERE nacionalidad <> 'Argentina')) AND precio <= 200;

DELETE FROM Libro
    WHERE ISBN IN (SELECT ISBN FROM Escribe
        WHERE año = '1998');