# 1. The First Query

*Twelve rows, one night, and the first question you ever ask a table.*

**Difficulty:** ●○○○○ · **SQL you'll use:** `SELECT`, `WHERE`, a time condition

It is the night of March 11th, 2019, the night before everything. Nobody has stolen anything yet. But the door reader at Headquarters already writes a row every time someone opens a door: who, which room, what time.

There is **one table**, `visits`, with twelve rows. They fit on one screen. Start by seeing them all: `SELECT * FROM visits`.

Then strip away what doesn't matter. That —look at everything, keep what matters, prove it— is the whole craft.

## Your task

**Who entered the Central Archive after 22:00 that night, and at exactly what time?**

## The tables

### `visits` (12 rows)

The door reader at Headquarters, the afternoon and night of March 11th, 2019. Twelve rows.

| Column | Type | What it is |
|---|---|---|
| `id` | INTEGER | Visit number |
| `name` | VARCHAR | Who swiped the card |
| `room` | VARCHAR | Which door they opened |
| `time` | TIMESTAMP | When they opened it |

## Start

From this folder, open DuckDB with the tables already loaded:

```bash
duckdb -init setup.sql
```

Using another database? The tables are plain CSV files in `data/`.

## Check your answer

When you think you have it, run this from the root of the repo, one answer per field, in this order:

```bash
python check.py 1 "<Who entered>" "<At what time>"
```

## Hints

Open them one at a time, only if you're stuck.

<details>
<summary>Hint 1: Keep one room</summary>

`SELECT * FROM visits` shows the twelve rows. To see only the ones for the Central Archive, add a condition:

```sql
SELECT * FROM visits
WHERE room = 'Central Archive';
```

Text goes in single quotes and has to be written exactly as it appears in the table.

</details>

<details>
<summary>Hint 2: Keep one time</summary>

Conditions are chained with `AND`. The time is a `TIMESTAMP`, so it's compared with another `TIMESTAMP`:

```sql
SELECT * FROM visits
WHERE room = 'Central Archive'
  AND time >= TIMESTAMP '2019-03-11 22:00';
```

If you want the time alone, without the date: `strftime(time, '%H:%M')`.

</details>

## Play it in the browser

Same case, with the story narrated, a SQL console in the page and the checker built in: https://casoabiertogame.com/?via=github-cases#/caso/t1_noir__00_la_primera_consulta

[← All cases](../../README.md)
