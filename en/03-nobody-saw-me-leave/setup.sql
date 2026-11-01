-- duckdb -init setup.sql

CREATE OR REPLACE TABLE alarms AS SELECT * FROM read_csv('data/alarms.csv', header = true, columns = {'id': 'INTEGER', 'place': 'VARCHAR', 'time': 'TIMESTAMP', 'event': 'VARCHAR'});
CREATE OR REPLACE TABLE subway AS SELECT * FROM read_csv('data/subway.csv', header = true, columns = {'id': 'INTEGER', 'name': 'VARCHAR', 'station': 'VARCHAR', 'time': 'TIMESTAMP'});
CREATE OR REPLACE TABLE suspects AS SELECT * FROM read_csv('data/suspects.csv', header = true, columns = {'name': 'VARCHAR', 'job': 'VARCHAR', 'alibi': 'VARCHAR'});
CREATE OR REPLACE TABLE till AS SELECT * FROM read_csv('data/till.csv', header = true, columns = {'ticket': 'INTEGER', 'time': 'TIMESTAMP', 'bartender': 'VARCHAR', 'customer': 'VARCHAR', 'amount': 'DOUBLE'});
