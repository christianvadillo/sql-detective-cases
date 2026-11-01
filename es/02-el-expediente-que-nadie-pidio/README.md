# 2. El expediente que nadie pidió

*Una carpeta menos y quince coartadas de más.*

**Dificultad:** ●○○○○ · **SQL que vas a usar:** `SELECT`, `WHERE`, rangos de fechas, ORDER BY

Llueve sobre Bahía Lumen desde hace nueve días y el **expediente 88-C** ha desaparecido del Archivo Central.

La comisaria Solano no quiere escándalo: el 88-C es la caja de zapatos donde duerme media contabilidad del puerto. Lo que sí quiere es un nombre, y lo quiere antes del turno de mañana.

El forense fija la desaparición **la noche del 12 de marzo de 2019, entre las 21:00 y las 23:00**. Sólo se entra al Archivo Central con tarjeta, y el lector de puertas lo registra todo.

Tienes dos tablas: `empleados` y `accesos`. Empieza mirando qué hay dentro.

## Tu tarea

**¿Quién entró al Archivo Central entre las 21:00 y las 23:00 del 12 de marzo de 2019, de qué división es, y a qué hora exacta cruzó la puerta?**

## Las tablas

### `accesos` (114 filas)

Lector de tarjetas de las puertas interiores de la Jefatura.

| Columna | Tipo | Qué es |
|---|---|---|
| `id` | INTEGER | Identificador del registro |
| `empleado_id` | INTEGER | Referencia a empleados.id |
| `sala` | VARCHAR | Sala a la que se accedió |
| `entrada` | TIMESTAMP | Momento en que la tarjeta abrió la puerta |
| `salida` | TIMESTAMP | Momento de salida. NULL si la puerta se cerró sola y nadie fichó |
| `tarjeta` | VARCHAR | Tarjeta usada |

### `empleados` (15 filas)

Plantilla de la Jefatura de Bahía Lumen.

| Columna | Tipo | Qué es |
|---|---|---|
| `id` | INTEGER | Identificador interno de plantilla |
| `nombre` | VARCHAR | Nombre completo tal como figura en la placa |
| `puesto` | VARCHAR | Cargo |
| `division` | VARCHAR | Unidad a la que pertenece |
| `turno` | VARCHAR | Turno habitual: mañana, tarde o noche |

## Empezar

Desde esta carpeta, abre DuckDB con las tablas ya cargadas:

```bash
duckdb -init setup.sql
```

¿Usas otra base de datos? Las tablas son CSV normales en `data/`.

## Comprueba tu respuesta

Cuando creas tenerla, corre esto desde la raíz del repo, una respuesta por campo y en este orden:

```bash
python check.py 2 "<Nombre del sospechoso>" "<División a la que pertenece>" "<Hora exacta a la que entró>"
```

## Pistas

Ábrelas de una en una y sólo si te atascas.

<details>
<summary>Pista 1: Por dónde se empieza</summary>

Antes de acusar a nadie, mira los datos. `SELECT * FROM accesos LIMIT 20;` y `SELECT * FROM empleados;` te dicen qué columnas tienes.

La pregunta pide tres filtros a la vez: una sala concreta, un día concreto y una franja horaria concreta. Los tres van en el mismo `WHERE`, unidos con `AND`.

</details>

<details>
<summary>Pista 2: Filtrar por tiempo</summary>

La columna `entrada` es un `TIMESTAMP`, no una fecha suelta. Dos formas de acotar la noche:

- `entrada >= '2019-03-12 21:00' AND entrada < '2019-03-12 23:00'`
- `entrada BETWEEN TIMESTAMP '2019-03-12 21:00' AND TIMESTAMP '2019-03-12 23:00'`

Ojo con la trampa clásica: hay un acceso al Archivo Central a esa misma hora **del día anterior**. Si sólo filtras por hora y no por fecha, te llevas dos nombres.

</details>

<details>
<summary>Pista 3: El esqueleto casi entero</summary>

Te falta unir el registro con la persona:

```sql
SELECT e.nombre, a.entrada, a.salida
FROM accesos a
JOIN empleados e ON e.id = a.empleado_id
WHERE a.sala = 'Archivo Central'
  AND a.entrada >= '2019-03-12 21:00'
  AND a.entrada <  '2019-03-12 23:00';
```

Si el `JOIN` todavía te suena a chino, hazlo en dos pasos: primero saca el `empleado_id` de `accesos`, y después búscalo a mano en `empleados`.

</details>

## Juégalo en el navegador

El mismo caso, con la historia narrada, una consola SQL en la página y el comprobador dentro: https://casoabiertogame.com/?via=github-cases#/caso/t1_noir__01_el_expediente

[← Todos los casos](../../README.md)
