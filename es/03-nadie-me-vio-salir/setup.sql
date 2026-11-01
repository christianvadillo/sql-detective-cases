-- duckdb -init setup.sql

CREATE OR REPLACE TABLE alarmas AS SELECT * FROM read_csv('data/alarmas.csv', header = true, columns = {'id': 'INTEGER', 'lugar': 'VARCHAR', 'hora': 'TIMESTAMP', 'evento': 'VARCHAR'});
CREATE OR REPLACE TABLE caja AS SELECT * FROM read_csv('data/caja.csv', header = true, columns = {'ticket': 'INTEGER', 'hora': 'TIMESTAMP', 'camarero': 'VARCHAR', 'cliente': 'VARCHAR', 'importe': 'DOUBLE'});
CREATE OR REPLACE TABLE metro AS SELECT * FROM read_csv('data/metro.csv', header = true, columns = {'id': 'INTEGER', 'nombre': 'VARCHAR', 'estacion': 'VARCHAR', 'hora': 'TIMESTAMP'});
CREATE OR REPLACE TABLE sospechosos AS SELECT * FROM read_csv('data/sospechosos.csv', header = true, columns = {'nombre': 'VARCHAR', 'oficio': 'VARCHAR', 'coartada': 'VARCHAR'});
