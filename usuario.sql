CREATE TABLE usuarios(
	nombre VARCHAR(50) NOT NULL,
	edad INT,
	descripcion TEXT,
	id_usuario SERIAL,
	PRIMARY KEY(id_usuario)
);

SELECT * FROM usuarios;

CREATE TABLE tareas(
	id_tareas SERIAL PRIMARY KEY,
	titulo VARCHAR(50) NOT NULL,
	fecha DATE DEFAULT CURRENT_DATE,
	estado BOOLEAN DEFAULT FALSE,
	id_usuario INT,
	FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

ALTER TABLE tareas
ADD descripcion TEXT;

ALTER TABLE tareas
ALTER COLUMN descripcion SET DATA TYPE VARCHAR (300);

ALTER TABLE tareas
RENAME COLUMN titulo to cabecera;

SELECT * FROM tareas;

INSERT INTO usuarios(nombre, edad, descripcion) VALUES('Pepe', 50, 'le gusta la musica');
INSERT INTO usuarios(nombre, edad, descripcion) VALUES('Luis', 50, 'le gusta programar');

INSERT INTO tareas(cabecera, id_usuario)VALUES('comprar una guitarra', 1);




