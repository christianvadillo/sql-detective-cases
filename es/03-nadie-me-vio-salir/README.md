# 3. Nadie me vio salir

*El que mintió no es el que robó.*

**Dificultad:** ●●●○○ · **SQL que vas a usar:** `WHERE`, GROUP BY, `arg_max`, `LEAD`

A las **23:47** salta la alarma de la **Joyería Coral**, en Puerto Sal: alguien ha roto una vitrina y se ha llevado lo que había dentro.

La policía tiene cuatro sospechosos y cuatro coartadas. Bruno dice que estaba en su taller de San Ciro. Nora, buceando en Bahía Lumen. Elena, en su casa de San Ciro. Hugo, detrás de la barra de **El Ancla**, el bar que queda a dos calles de la joyería.

El metro de la costa registra cada torniquete y el bar guarda cada cobro. Tienes cuatro tablas: `sospechosos`, `metro`, `alarmas` y `caja`.

Ya sabes que alguien mintió. Lo que importa es si mentir lo convierte en el ladrón.

## Tu tarea

**¿Quién robó la Joyería Coral y a qué hora fue lo último que hizo antes de desaparecer de su sitio?**

## Las tablas

### `alarmas` (4 filas)

Central de alarmas de Puerto Sal. La Joyería Coral está a dos calles del bar El Ancla.

| Columna | Tipo | Qué es |
|---|---|---|
| `id` | INTEGER | Número de aviso |
| `lugar` | VARCHAR | Comercio que dio el aviso |
| `hora` | TIMESTAMP | Momento del aviso |
| `evento` | VARCHAR | Qué detectó el sistema |

### `caja` (54 filas)

Caja registradora del bar El Ancla, en Puerto Sal, la noche del robo.

| Columna | Tipo | Qué es |
|---|---|---|
| `ticket` | INTEGER | Número de ticket |
| `hora` | TIMESTAMP | Momento del cobro |
| `camarero` | VARCHAR | Quién cobró |
| `cliente` | VARCHAR | Titular de la tarjeta. NULL si se pagó en efectivo |
| `importe` | DOUBLE | Importe cobrado |

### `metro` (8 filas)

Torniquetes del metro de la costa la noche del robo. Cada fila es una persona cruzando un torniquete: la última fila de cada uno dice en qué ciudad se quedó.

| Columna | Tipo | Qué es |
|---|---|---|
| `id` | INTEGER | Número de registro |
| `nombre` | VARCHAR | Titular de la tarjeta de transporte |
| `estacion` | VARCHAR | Estación cuyo torniquete cruzó |
| `hora` | TIMESTAMP | Momento en que cruzó el torniquete |

### `sospechosos` (4 filas)

Los cuatro que la policía de Puerto Sal interrogó tras el robo.

| Columna | Tipo | Qué es |
|---|---|---|
| `nombre` | VARCHAR | Nombre completo |
| `oficio` | VARCHAR | A qué se dedica |
| `coartada` | VARCHAR | Dónde dice que estaba a la hora del robo |

## Empezar

Desde esta carpeta, abre DuckDB con las tablas ya cargadas:

```bash
duckdb -init setup.sql
```

¿Usas otra base de datos? Las tablas son CSV normales en `data/`.

## Comprueba tu respuesta

Cuando creas tenerla, corre esto desde la raíz del repo, una respuesta por campo y en este orden:

```bash
python check.py 3 "<Quién robó la joyería>" "<A qué hora cobró por última vez antes del robo>"
```

## Pistas

Ábrelas de una en una y sólo si te atascas.

<details>
<summary>Pista 1: Quién se quedó en Puerto Sal</summary>

Filtrar el metro por `estacion = 'Puerto Sal'` después de las once sólo te enseña a quien **se movió** a esa hora. Quien llegó antes y no volvió a cruzar un torniquete no aparece.

Pregunta otra cosa: ¿cuál es la **última** estación de cada persona? En DuckDB, `arg_max(estacion, hora)` con `GROUP BY nombre` te da la estación de la fila más tardía de cada uno.

</details>

<details>
<summary>Pista 2: Dos en la ciudad del robo</summary>

Te quedan Bruno y Hugo en Puerto Sal. Bruno mintió sobre dónde estaba, pero mentir no es robar.

Mira la `caja` de El Ancla alrededor de las 23:47. Los clientes que pagan con tarjeta dejan su nombre: ¿quién estaba en el bar a esa hora? ¿Y quién estaba cobrando?

</details>

<details>
<summary>Pista 3: El hueco en la barra</summary>

Un camarero que no se mueve de la barra cobra cada pocos minutos. Compara cada cobro con el siguiente del mismo camarero:

```sql
SELECT camarero, hora,
       LEAD(hora) OVER (PARTITION BY camarero ORDER BY hora) AS siguiente
FROM caja
ORDER BY camarero, hora;
```

Busca el hueco que contiene las 23:47.

</details>

## Juégalo en el navegador

El mismo caso, con la historia narrada, una consola SQL en la página y el comprobador dentro: https://christianvadillo.itch.io/nobody-saw-me-leave

[← Todos los casos](../../README.md)
