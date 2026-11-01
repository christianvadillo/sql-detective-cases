# 3. Nobody Saw Me Leave

*The one who lied is not the one who stole.*

**Difficulty:** ●●●○○ · **SQL you'll use:** `WHERE`, GROUP BY, `arg_max`, `LEAD`

At **23:47** the alarm goes off at **Coral Jewelers**, in Salt Harbor: someone has smashed a display case and taken what was inside.

The police have four suspects and four alibis. Bruno says he was in his workshop in San Ciro. Nora, diving in Lumen Bay. Elena, at home in San Ciro. Hugo, behind the bar at **El Ancla**, the bar two streets from the jewelry shop.

The coastal subway logs every turnstile and the bar keeps every charge. You have four tables: `suspects`, `subway`, `alarms` and `till`.

You already know someone lied. What matters is whether lying makes them the thief.

## Your task

**Who robbed Coral Jewelers, and at what time did they do the last thing before vanishing from their post?**

## The tables

### `alarms` (4 rows)

Salt Harbor alarm center. Coral Jewelers is two streets from the El Ancla bar.

| Column | Type | What it is |
|---|---|---|
| `id` | INTEGER | Alert number |
| `place` | VARCHAR | Shop that raised the alert |
| `time` | TIMESTAMP | Moment of the alert |
| `event` | VARCHAR | What the system detected |

### `subway` (8 rows)

Coastal subway turnstiles on the night of the robbery. Each row is a person passing a turnstile: each person's last row says which city they stayed in.

| Column | Type | What it is |
|---|---|---|
| `id` | INTEGER | Record number |
| `name` | VARCHAR | Transit card holder |
| `station` | VARCHAR | Station whose turnstile they passed |
| `time` | TIMESTAMP | Moment they passed the turnstile |

### `suspects` (4 rows)

The four people Salt Harbor police questioned after the robbery.

| Column | Type | What it is |
|---|---|---|
| `name` | VARCHAR | Full name |
| `job` | VARCHAR | What they do for a living |
| `alibi` | VARCHAR | Where they say they were at the time of the robbery |

### `till` (54 rows)

Cash register of the El Ancla bar, in Salt Harbor, on the night of the robbery.

| Column | Type | What it is |
|---|---|---|
| `ticket` | INTEGER | Ticket number |
| `time` | TIMESTAMP | Moment of the charge |
| `bartender` | VARCHAR | Who rang it up |
| `customer` | VARCHAR | Card holder. NULL if paid in cash |
| `amount` | DOUBLE | Amount charged |

## Start

From this folder, open DuckDB with the tables already loaded:

```bash
duckdb -init setup.sql
```

Using another database? The tables are plain CSV files in `data/`.

## Check your answer

When you think you have it, run this from the root of the repo, one answer per field, in this order:

```bash
python check.py 3 "<Who robbed the jewelry shop>" "<Time of their last charge before the robbery>"
```

## Hints

Open them one at a time, only if you're stuck.

<details>
<summary>Hint 1: Who stayed in Salt Harbor</summary>

Filtering the `subway` table for `station = 'Salt Harbor'` after eleven only shows you who **moved** at that time. Whoever arrived earlier and never passed another turnstile doesn't show up.

Ask something else: what is each person's **last** station? In DuckDB, `arg_max(station, time)` with `GROUP BY name` gives you the station of each person's latest row.

</details>

<details>
<summary>Hint 2: Two in the city of the robbery</summary>

That leaves Bruno and Hugo in Salt Harbor. Bruno lied about where he was, but lying isn't stealing.

Look at the El Ancla `till` around 23:47. Customers who pay by card leave their name: who was in the bar at that time? And who was ringing up?

</details>

<details>
<summary>Hint 3: The gap behind the bar</summary>

A bartender who never leaves the bar rings something up every few minutes. Compare each charge with the next one by the same bartender:

```sql
SELECT bartender, time,
       LEAD(time) OVER (PARTITION BY bartender ORDER BY time) AS next_time
FROM till
ORDER BY bartender, time;
```

Look for the gap that contains 23:47.

</details>

## Play it in the browser

Same case, with the story narrated, a SQL console in the page and the checker built in: https://christianvadillo.itch.io/nobody-saw-me-leave

[← All cases](../../README.md)
