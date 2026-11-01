-- duckdb -init setup.sql

CREATE OR REPLACE TABLE access_log AS SELECT * FROM read_csv('data/access_log.csv', header = true, columns = {'id': 'INTEGER', 'staff_id': 'INTEGER', 'room': 'VARCHAR', 'entry_time': 'TIMESTAMP', 'exit_time': 'TIMESTAMP', 'card': 'VARCHAR'});
CREATE OR REPLACE TABLE staff AS SELECT * FROM read_csv('data/staff.csv', header = true, columns = {'id': 'INTEGER', 'name': 'VARCHAR', 'post': 'VARCHAR', 'division': 'VARCHAR', 'shift': 'VARCHAR'});
