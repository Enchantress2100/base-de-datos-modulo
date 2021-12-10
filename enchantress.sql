CREATE TABLE cuentas(
    numero_cuenta INT NOT NULL UNIQUE PRIMARY KEY,
    balance DECIMAL CHECK (balance >=0.00)
);
--check valida que el monto sea mayor a cero

--registraremos dos cuentas con saldo de 1000 cada una.
INSERT INTO cuentas(numero_cuenta, balance) VALUES(1, 1000);
INSERT INTO cuentas(numero_cuenta, balance) VALUES(2, 1000);

--transferencia de 1000 desde la cuenta 1 a la cuenta 2

BEGIN TRANSACTION;
UPDATE cuentas SET balance= balance -1000 WHERE numero_cuenta=1;
UPDATE cuentas SET balance= balance +1000 WHERE numero_cuenta=2;

--rollback: 
UPDATE cuentas SET balance= balance +1000 WHERE numero_cuenta=2;
UPDATE cuentas SET balance= balance -1000 WHERE numero_cuenta=1;
ROLLBACK;
--no paso nada, rollback deshizo lo que habria querido hacer.

--probar savepoint, registrando una tercera cuenta con saldo de 5000 y guardar ese punto con savepoint
BEGIN TRANSACTION;
INSERT INTO cuentas(numero_cuenta, balance) VALUES(3, 5000);
SAVEPOINT nueva_cuenta;


--intentaremos transferir 3000 desde la cuenta 2 (pero no hay 3000)
UPDATE cuentas SET balance= balance -3000 WHERE numero_cuenta=2;
UPDATE cuentas SET balance= balance +3000 WHERE numero_cuenta=3;
ROLLBACK TO nueva_cuenta;
COMMIT;




