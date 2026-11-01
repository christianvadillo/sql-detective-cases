-- duckdb -init setup.sql

CREATE OR REPLACE TABLE accesos AS SELECT * FROM read_csv('data/accesos.csv', header = true, columns = {'id': 'INTEGER', 'empleado_id': 'INTEGER', 'sala': 'VARCHAR', 'entrada': 'TIMESTAMP', 'salida': 'TIMESTAMP', 'tarjeta': 'VARCHAR'});
CREATE OR REPLACE TABLE empleados AS SELECT * FROM read_csv('data/empleados.csv', header = true, columns = {'id': 'INTEGER', 'nombre': 'VARCHAR', 'puesto': 'VARCHAR', 'division': 'VARCHAR', 'turno': 'VARCHAR'});
