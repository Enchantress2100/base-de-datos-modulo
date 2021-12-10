CREATE DATABASE pizzeria;

CREATE TABLE pizzas(
id INT,
stock INT CHECK(stock >=0.00),
costo DECIMAL,
nombre VARCHAR(25),
PRIMARY KEY(id)
);

CREATE TABLE ventas(
cliente VARCHAR(30),
fecha DATE,
monto INT,
pizza INT,
FOREIGN KEY (pizza) REFERENCES pizzas(id)
);

--agregar un registro a la tabla pizzas para establecer el stock inicial en 0
INSERT INTO pizzas (id, stock, costo, nombre)VALUES(1,0,12000,'Napolitana');

--ingresar una nueva pizza, para aumentar el stock a 1.
INSERT INTO pizzas (id, stock, costo, nombre)VALUES(2,2,15000,'Hawaiana');

--probar base de datos, ya que intentaremos vender la pizza de la que no tenemos stock
BEGIN;
INSERT INTO ventas(cliente, fecha, monto, pizza) VALUES('Consuelo Gomez', '2021-12-12', 12000,1);
UPDATE pizzas SET stock= stock -1 WHERE id=1;
COMMIT;
--da error

--queremos vender las dos pizzas registradas, pero solo la segunda tiene stock, por lo tanto, marcaremos un punto de guardado despues de actualizar el stock disponibley haciendo rollbacl hacia el punto donde se recibio el error.

BEGIN;
INSERT INTO ventas(cliente, fecha, monto, pizza) VALUES('Juan Perez', '2021-12-12', 15000, 2);
UPDATE pizzas SET stock=stock-1 WHERE id=2;
SAVEPOINT checkpoint;
INSERT INTO ventas (cliente, fecha, monto, pizza) VALUES('Cuca Sofia', '2021-12-12', 12000, 1);
UPDATE pizzas SET stock =stock -1 WHERE id=1;
ROLLBACK TO checkpoint;