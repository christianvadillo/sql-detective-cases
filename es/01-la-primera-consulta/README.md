# 1. La primera consulta

*Doce filas, una noche y la primera pregunta que le haces a una tabla.*

**Dificultad:** ●○○○○ · **SQL que vas a usar:** `SELECT`, `WHERE`, una condición de hora

Es la noche del 11 de marzo de 2019, la anterior a todo. Nadie ha robado nada todavía. Pero el lector de puertas de la Jefatura ya escribe una fila cada vez que alguien abre una puerta: quién, qué sala, a qué hora.

Hay **una tabla**, `visitas`, con doce filas. Caben en una pantalla. Empieza por verlas todas: `SELECT * FROM visitas`.

Después, ve quitando lo que no importa. Eso —mirar todo, quedarte con lo que importa, demostrarlo— es todo el oficio.

## Tu tarea

**¿Quién entró al Archivo Central después de las 22:00 esa noche, y a qué hora exacta?**

## Las tablas

### `visitas` (12 filas)

El lector de puertas de la Jefatura, la tarde y la noche del 11 de marzo de 2019. Doce filas.

| Columna | Tipo | Qué es |
|---|---|---|
| `id` | INTEGER | Número de la visita |
| `nombre` | VARCHAR | Quién pasó la tarjeta |
| `sala` | VARCHAR | Qué puerta abrió |
| `hora` | TIMESTAMP | Cuándo la abrió |

## Empezar

Desde esta carpeta, abre DuckDB con las tablas ya cargadas:

```bash
duckdb -init setup.sql
```

¿Usas otra base de datos? Las tablas son CSV normales en `data/`.

## Comprueba tu respuesta

Cuando creas tenerla, corre esto desde la raíz del repo, una respuesta por campo y en este orden:

```bash
python check.py 1 "<Quién entró>" "<A qué hora>"
```

## Pistas

Ábrelas de una en una y sólo si te atascas.

<details>
<summary>Pista 1: Quedarse con una sala</summary>

`SELECT * FROM visitas` enseña las doce filas. Para ver sólo las del Archivo Central se añade una condición:

```sql
SELECT * FROM visitas
WHERE sala = 'Archivo Central';
```

El texto va entre comillas simples y tiene que escribirse exactamente igual que en la tabla.

</details>

<details>
<summary>Pista 2: Quedarse con una hora</summary>

Las condiciones se encadenan con `AND`. La hora es un `TIMESTAMP`, así que se compara con otro `TIMESTAMP`:

```sql
SELECT * FROM visitas
WHERE sala = 'Archivo Central'
  AND hora >= TIMESTAMP '2019-03-11 22:00';
```

Si quieres la hora sola, sin la fecha: `strftime(hora, '%H:%M')`.

</details>

## Juégalo en el navegador

El mismo caso, con la historia narrada, una consola SQL en la página y el comprobador dentro: https://casoabiertogame.com/?via=github-cases#/caso/t1_noir__00_la_primera_consulta

[← Todos los casos](../../README.md)
