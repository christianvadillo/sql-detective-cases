-- duckdb -init setup.sql

CREATE OR REPLACE TABLE visitas AS SELECT * FROM read_csv('data/visitas.csv', header = true, columns = {'id': 'INTEGER', 'nombre': 'VARCHAR', 'sala': 'VARCHAR', 'hora': 'TIMESTAMP'});
