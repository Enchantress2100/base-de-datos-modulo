DROP DATABASE autos IF EXISTS;
CREATE DATABASE autos;

--creacion tablas autos y ventas
CREATE TABLE autos(
    id INT,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    año VARCHAR(10),
    color VARCHAR(50),
    stock INT CHECK (stock >= 0.00),
    precio INT,
    PRIMARY KEY (id)
);
--drop table autos;
--drop table ventas;


CREATE TABLE ventas(
    fecha VARCHAR(10),
    id_auto INT,
    cliente VARCHAR(100),
    referencia VARCHAR(100),
    cantidad INT,
    metodo_pago VARCHAR(100),
    FOREIGN KEY (id_auto) REFERENCES autos(id)
);


\COPY autos FROM '/Users/enchantress/Desktop/base de datos modulo/autos.csv' csv header;
\COPY ventas FROM '/Users/enchantress/Desktop/base de datos modulo/ventas.csv' csv header;



--insertar transaccion en tabla ventas con auto de id 5
BEGIN;
INSERT INTO ventas(fecha, id_auto, cliente, referencia, cantidad, metodo_pago) VALUES('2021-12-12', '5', 'Pepe Luis', '2543', 1, 'credito');
UPDATE autos SET stock= stock -1 WHERE id=5;
COMMIT;

--DELETE FROM ventas
--WHERE cliente= 'Guga Luca';

--insertar registro de ventas pero con los autos de id 2,3,4,1.
BEGIN;
INSERT INTO ventas(fecha, id_auto, cliente, referencia, cantidad, metodo_pago) VALUES('2021-12-13', '2', 'Juanita Perez', '6785', 2, 'credito');
UPDATE autos SET stock= stock -2 WHERE id=2;
COMMIT;

BEGIN;
INSERT INTO ventas(fecha, id_auto, cliente, referencia, cantidad, metodo_pago) VALUES('2021-12-10', '4', 'Carmen Tuitera', '0909', 1, 'credito');
UPDATE autos SET stock= stock -1 WHERE id=4;
COMMIT;

BEGIN;
INSERT INTO ventas(fecha, id_auto, cliente, referencia, cantidad, metodo_pago) VALUES('2021-12-13', '1', 'Guga Luca', '6675', 5, 'credito');
UPDATE autos SET stock= stock -5 WHERE id=1;
SAVEPOINT punto;

--vender auto sin stock 
BEGIN;
INSERT INTO ventas(fecha, id_auto, cliente, referencia, cantidad, metodo_pago) VALUES('2021-12-12', '3', 'JP Pinto', '2356', 1, 'debito');
UPDATE autos SET stock= stock -1 WHERE id=3;
ROLLBACK TO punto;
COMMIT;


--vender un auto con stock, crear punto de guardado, vender sin stock y rollback
BEGIN;
INSERT INTO ventas(fecha, id_auto, cliente, referencia, cantidad, metodo_pago)VALUES('2021-12-04', '2', 'Artemis', '5566', 1, 'debito');
UPDATE autos SET stock= stock -1 WHERE id=2;
COMMIT;

BEGIN;
INSERT INTO ventas(fecha, id_auto, cliente, referencia, cantidad, metodo_pago)VALUES('2021-12-04', '2', 'Luna', '5546', 2, 'debito');
UPDATE autos SET stock= stock -2 WHERE id=2;
SAVEPOINT hola; 

BEGIN;
INSERT INTO ventas(fecha, id_auto, cliente, referencia, cantidad, metodo_pago) VALUES('2021-12-12', '3', 'JP Pinto', '2356', 1, 'debito');
UPDATE autos SET stock= stock -1 WHERE id=3;
ROLLBACK TO hola;
COMMIT;

--realizar consulta que nos de la informacion de los clientes de la tabla venta, con marca y modelo del auto que compraron, se le da el alias x a los objetos de la tabla ventas, y se da y a los de tabla autos.

SELECT x.cliente, y.modelo, y.marca
FROM ventas AS x
INNER JOIN autos as y
on x.id_auto = y.id


--obtener todas las filas de la tabla ventas con o sin autos asociados

SELECT * FROM ventas;

--Obtener todas las filas de la tabla ventas y autos
SELECT * FROM ventas
FULL OUTER JOIN autos
ON ventas.id_auto=autos.id
ORDER BY cliente;

--realizar consulta para obtener todos los autos cuyos id no se han vendido.

SELECT * FROM autos
LEFT JOIN ventas
ON autos.id=ventas.id_auto
WHERE ventas IS NULL
ORDER by cliente;

--registro que no tiene relacion entre ambas tablas.
SELECT * FROM autos
FULL OUTER JOIN ventas on autos.id=ventas.id_auto
WHERE autos.id IS NULL OR ventas.id_auto IS NULL
ORDER BY marca;

--mostrar los autos que fueron comprados con debito

SELECT x.metodo_pago, y.modelo, y.marca
FROM ventas AS x
INNER JOIN autos as y
ON x.id_auto = y.id
WHERE metodo_pago='debito';

--mostrar los autos que se han vendido sobre 1.500.000
SELECT x.cantidad, y.modelo, y.marca
FROM ventas AS x
INNER JOIN autos as y
ON x.id_auto = y.id
WHERE y.precio>=1500000;









