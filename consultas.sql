-- Blas Barbagelata     B-6146|8
-- Tomás Castro Rojas   C-6879/9

-- a
SELECT nombre FROM Persona
    WHERE codigo IN (SELECT Propietario.codigo FROM Propietario);

-- b
SELECT codigo FROM Inmueble
    WHERE precio >= 600000 AND precio <= 700000;

-- c
SELECT nombre FROM Persona
    WHERE codigo IN (SELECT Cliente.codigo FROM Cliente
        WHERE Cliente.codigo IN (SELECT codigo_cliente FROM PrefiereZona) AND Cliente.codigo NOT IN
            (SELECT codigo_cliente FROM PrefiereZona
                WHERE NOT (nombre_poblacion = "Santa Fe" AND nombre_zona = "Norte")));

-- d
SELECT nombre FROM Persona
    WHERE codigo IN (SELECT vendedor FROM Cliente
        WHERE Cliente.codigo IN (SELECT PrefiereZona.codigo FROM PrefiereZona
            WHERE nombre_poblacion = 'Rosario' AND nombre_zona = 'Centro'));

-- e
SELECT nombre_zona, COUNT(codigo), AVG(precio) FROM Inmueble
    WHERE nombre_poblacion = 'Rosario'
GROUP BY nombre_zona;

-- f
SELECT nombre FROM Persona, PrefiereZona
    WHERE codigo = codigo_cliente AND nombre_poblacion = 'Santa Fe'
GROUP BY codigo
HAVING COUNT(nombre_zona) = (SELECT COUNT(nombre_zona) FROM Zona WHERE nombre_poblacion = 'Santa Fe');