-- duckdb -init setup.sql

CREATE OR REPLACE TABLE visits AS SELECT * FROM read_csv('data/visits.csv', header = true, columns = {'id': 'INTEGER', 'name': 'VARCHAR', 'room': 'VARCHAR', 'time': 'TIMESTAMP'});
