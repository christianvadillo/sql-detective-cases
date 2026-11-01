# 2. The File Nobody Asked For

*One folder short and fifteen alibis too many.*

**Difficulty:** ●○○○○ · **SQL you'll use:** `SELECT`, `WHERE`, date ranges, ORDER BY

It has been raining on Lumen Bay for nine days and **file 88-C** has vanished from the Central Archive.

Commissioner Solano doesn't want a scandal: 88-C is the shoebox where half the harbour's accounts sleep. What she does want is a name, and she wants it before the morning shift.

Forensics puts the disappearance **on the night of March 12th, 2019, between 21:00 and 23:00**. The Central Archive opens only with a card, and the door reader logs everything.

You have two tables: `staff` and `access_log`. Start by looking at what's inside.

## Your task

**Who entered the Central Archive between 21:00 and 23:00 on March 12th, 2019, which division are they from, and at exactly what time did they cross the door?**

## The tables

### `access_log` (114 rows)

Card reader on the interior doors of Headquarters.

| Column | Type | What it is |
|---|---|---|
| `id` | INTEGER | Record identifier |
| `staff_id` | INTEGER | Reference to staff.id |
| `room` | VARCHAR | Room that was accessed |
| `entry_time` | TIMESTAMP | Moment the card opened the door |
| `exit_time` | TIMESTAMP | Moment of exit. NULL if the door closed on its own and nobody clocked out |
| `card` | VARCHAR | Card used |

### `staff` (15 rows)

The staff of Lumen Bay Headquarters.

| Column | Type | What it is |
|---|---|---|
| `id` | INTEGER | Internal staff identifier |
| `name` | VARCHAR | Full name as it appears on the badge |
| `post` | VARCHAR | Position |
| `division` | VARCHAR | Unit they belong to |
| `shift` | VARCHAR | Usual shift: morning, afternoon or night |

## Start

From this folder, open DuckDB with the tables already loaded:

```bash
duckdb -init setup.sql
```

Using another database? The tables are plain CSV files in `data/`.

## Check your answer

When you think you have it, run this from the root of the repo, one answer per field, in this order:

```bash
python check.py 2 "<Suspect's name>" "<Division they belong to>" "<Exact time they entered>"
```

## Hints

Open them one at a time, only if you're stuck.

<details>
<summary>Hint 1: Where to start</summary>

Before accusing anyone, look at the data. `SELECT * FROM access_log LIMIT 20;` and `SELECT * FROM staff;` tell you which columns you have.

The question asks for three filters at once: one specific room, one specific day and one specific time window. All three go in the same `WHERE`, joined with `AND`.

</details>

<details>
<summary>Hint 2: Filtering by time</summary>

The `entry_time` column is a `TIMESTAMP`, not a bare date. Two ways to fence the night:

- `entry_time >= '2019-03-12 21:00' AND entry_time < '2019-03-12 23:00'`
- `entry_time BETWEEN TIMESTAMP '2019-03-12 21:00' AND TIMESTAMP '2019-03-12 23:00'`

Mind the classic trap: there is an access to the Central Archive at that same hour **the day before**. Filter by time only, not by date, and you take home two names.

</details>

<details>
<summary>Hint 3: The skeleton, almost whole</summary>

You still need to join the record to the person:

```sql
SELECT s.name, a.entry_time, a.exit_time
FROM access_log a
JOIN staff s ON s.id = a.staff_id
WHERE a.room = 'Central Archive'
  AND a.entry_time >= '2019-03-12 21:00'
  AND a.entry_time <  '2019-03-12 23:00';
```

If `JOIN` still sounds like Greek, do it in two steps: first pull the `staff_id` from `access_log`, then look it up by hand in `staff`.

</details>

## Play it in the browser

Same case, with the story narrated, a SQL console in the page and the checker built in: https://casoabiertogame.com/?via=github-cases#/caso/t1_noir__01_el_expediente

[← All cases](../../README.md)
