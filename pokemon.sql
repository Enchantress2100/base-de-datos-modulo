CREATE DATABASE pokemon;

CREATE TABLE Pokemones (
    pokedex INT,
    nombre varchar(10),
    tipo1 varchar(10),
    tipo2 varchar(10),
    PRIMARY KEY (pokedex)
);

CREATE TABLE mis_pokemones (
    pokedex INT,
    fecha_captura date,
    lugar varchar(20),
    huevo boolean,
    peso float,
    estatura float,
    FOREIGN KEY (pokedex) REFERENCES pokemones (pokedex)
    );

\COPY Pokemones FROM '/Users/enchantress/Desktop/base de datos modulo/pokemonesKanto.csv' csv header;

\COPY mis_pokemones FROM '/Users/enchantress/Desktop/base de datos modulo/mis_pokemones.csv' csv header;

SELECT * FROM pokemones
INNER JOIN mis_pokemones
ON Pokemones.pokedex=mis_pokemones.pokedex
ORDER BY nombre;

SELECT * FROM pokemones
LEFT JOIN mis_pokemones
ON Pokemones.pokedex=mis_pokemones.pokedex
ORDER BY nombre;

SELECT * FROM pokemones
LEFT JOIN mis_pokemones
ON Pokemones.pokedex=mis_pokemones.pokedex
WHERE mis_pokemones IS NULL
ORDER BY nombre;

SELECT * FROM pokemones
FULL OUTER JOIN mis_pokemones
ON Pokemones.pokedex=mis_pokemones.pokedex
ORDER BY nombre;

SELECT * FROM pokemones
FULL OUTER JOIN mis_pokemones ON pokemones.pokedex=mis_pokemones.pokedex
WHERE Pokemones.pokedex IS NULL OR mis_pokemones.pokedex IS NULL
ORDER BY nombre;

SELECT pokedex FROM mis_pokemones
WHERE huevo=true;

SELECT pokedex, nombre
FROM pokemones
WHERE pokedex IN
(SELECT pokedex
FROM mis_pokemones
WHERE huevo=true
);


SELECT y.nombre, x.pokedex, x.peso
FROM(
    SELECT peso, pokedex
    FROM mis_pokemones
    WHERE peso > 200
) AS x
INNER JOIN pokemones AS y ON x.pokedex= y.pokedex;


