# SQL detective cases

Three crimes you solve by querying the evidence. Each case has a short story, a few tables of records (door logs, a subway turnstile log, a bar's till), one question, and a checker that tells you if your answer is right without showing the solution.

They start easy and get harder: the first one needs `WHERE` and `ORDER BY`; the last one needs a window function to find a 23-minute gap in someone's alibi. In English and in Spanish.

| # | Case | Difficulty |
|---|---|---|
| 1 | [The First Query](en/01-the-first-query/README.md) · *Twelve rows, one night, and the first question you ever ask a table.* | ●○○○○ |
| 2 | [The File Nobody Asked For](en/02-the-file-nobody-asked-for/README.md) · *One folder short and fifteen alibis too many.* | ●○○○○ |
| 3 | [Nobody Saw Me Leave](en/03-nobody-saw-me-leave/README.md) · *The one who lied is not the one who stole.* | ●●●○○ |

## How to play

You need [DuckDB](https://duckdb.org/docs/installation/) (or any SQL database that can load CSV) and Python 3 for the checker.

```bash
git clone https://github.com/christianvadillo/sql-detective-cases
cd sql-detective-cases/en/01-the-first-query
duckdb -init setup.sql
```

Read the case's README, query the tables, and when you have the answer:

```bash
cd ../..
python check.py 1 "<who>" "<when>"
```

Each case has hints you can open one at a time. The solutions are not in the repo; `cases.json` only has hashes of the answers.

## Where these come from

They are the free cases of [Caso Abierto](https://casoabiertogame.com/?via=github-cases), a detective game you play by writing SQL in the browser, where you also have to hand in the query that proves your accusation. Cases 1 and 2 are its first two case files; case 3 is a standalone case [on itch.io](https://christianvadillo.itch.io/nobody-saw-me-leave). The full game has 28 cases across four seasons (paid).

If you like traps more than stories, [sql-traps](https://github.com/christianvadillo/sql-traps) has fifteen SQL mistakes that return wrong results without an error.

---

# Casos de detective en SQL

Tres crímenes que se resuelven consultando las pruebas. Cada caso trae una historia corta, unas tablas de registros (el lector de una puerta, los torniquetes del metro, la caja de un bar), una pregunta y un comprobador que te dice si acertaste sin enseñarte la solución.

Van de fácil a difícil: el primero se resuelve con `WHERE` y `ORDER BY`; el último pide una función de ventana para encontrar un hueco de 23 minutos en una coartada. En español y en inglés.

| # | Caso | Dificultad |
|---|---|---|
| 1 | [La primera consulta](es/01-la-primera-consulta/README.md) · *Doce filas, una noche y la primera pregunta que le haces a una tabla.* | ●○○○○ |
| 2 | [El expediente que nadie pidió](es/02-el-expediente-que-nadie-pidio/README.md) · *Una carpeta menos y quince coartadas de más.* | ●○○○○ |
| 3 | [Nadie me vio salir](es/03-nadie-me-vio-salir/README.md) · *El que mintió no es el que robó.* | ●●●○○ |

## Cómo se juega

Necesitas [DuckDB](https://duckdb.org/docs/installation/) (o cualquier base de datos que cargue CSV) y Python 3 para el comprobador.

```bash
git clone https://github.com/christianvadillo/sql-detective-cases
cd sql-detective-cases/es/01-la-primera-consulta
duckdb -init setup.sql
```

Lee el README del caso, consulta las tablas y, cuando tengas la respuesta:

```bash
cd ../..
python check.py 1 "<quién>" "<cuándo>"
```

Cada caso tiene pistas que se abren de una en una. Las soluciones no están en el repo; `cases.json` sólo guarda el hash de cada respuesta.

## De dónde salen

Son los casos gratis de [Caso Abierto](https://casoabiertogame.com/?via=github-cases), un juego de detectives que se juega escribiendo SQL en el navegador y en el que además hay que entregar la consulta que prueba la acusación. Los casos 1 y 2 son sus dos primeros expedientes; el 3 es un caso suelto [en itch.io](https://christianvadillo.itch.io/nobody-saw-me-leave). El juego completo tiene 28 casos en cuatro temporadas (de pago).

Si te gustan más las trampas que las historias, [sql-traps](https://github.com/christianvadillo/sql-traps) tiene quince errores de SQL que devuelven resultados equivocados sin dar error.

## License / Licencia

Case texts and data: CC BY 4.0. `check.py`: MIT. See [LICENSE](LICENSE).
