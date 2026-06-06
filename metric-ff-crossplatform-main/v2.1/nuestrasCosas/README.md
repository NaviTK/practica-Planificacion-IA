# Proyecto de Planificación - Fases y Ejecución

## Fases del Proyecto

Fase 1: Configuración e Infraestructura
[ ] Formar el equipo: Confirmar el grupo de trabajo (preferiblemente 3 personas).

[ ] Instalar el software: Descargar y compilar el planificador metric-ff desde el enlace oficial para vuestro sistema operativo.

[ ] Revisar documentación: Leer los ejemplos de PDDL proporcionados en la web de la asignatura para entender la sintaxis de los predicados, acciones y fluentes numéricos.

Fase 2: Modelado del Nivel Básico (Nota Máx: 5)
[ ] Definir el Dominio Básic o: Crear los predicados y los operadores (acciones) para:

Alojar al cliente en un hotel de una ciudad.

Volar entre ciudades sin repetir ninguna.

[ ] Definir el Problema Básico: Crear un archivo de problema con un mapa mínimo de ciudades, vuelos y hoteles conectados, asegurando que el grafo sea conexo.

[ ] Verificar: Validar que el planificador encuentra un itinerario que visita el número mínimo de ciudades requerido.

Fase 3: Implementación Incremental de Extensiones
(Decidid juntos hasta qué nota queréis aspirar para implementar estas extensiones de forma acumulativa)

[ ] Extensión 1 (Nota Máx: 6): Añadir restricciones numéricas para controlar el mínimo/máximo de días por ciudad y la duración total del viaje.

[ ] Extensión 2 (Nota Máx: 7 si se hace sola con la Ext 1): Incorporar el "interés" de las ciudades (valores de 1 a 3) y configurar la métrica para minimizar este valor (visitar lo más interesante).

[ ] Extensión 3 (Nota Máx: 7 si se hace sola con la Ext 1 / 8.5 junto a Ext 2): Añadir precios a vuelos y hoteles. Configurar restricciones de precio total mínimo/máximo y buscar minimizar el coste total.

[ ] Extensión 4 (Nota Máx: 10): Fusionar las extensiones 2 y 3. Deberéis definir una función de métrica ponderada (multiplicar coste e interés por pesos) y probar cómo cambian los planes generados al variar dichos pesos.

Fase 4: Juegos de Prueba y Evaluación
[ ] Diseñar escenarios no triviales: Crear un mínimo de 2 casos de prueba por cada extensión implementada.

[ ] Ejecutar y guardar trazas: Correr los problemas en metric-ff y guardar las trazas de resolución en archivos de texto.

[ ] Analizar resultados: Analizar los planes obtenidos. En el caso de la Extensión 4, documentar textualmente por qué cambian los planes al modificar las ponderaciones.

Fase 5: Redacción de la Documentación y Entrega
[ ] Redactar el informe: El documento debe seguir estrictamente la rúbrica de evaluación e incluir:

Explicación detallada y justificación de cada predicado y variable del dominio.

Explicación y necesidad de cada operador (acciones).

Descripción del proceso de diseño incremental.

Justificación de los juegos de prueba y explicación de las soluciones obtenidas.

[ ] Preparar los archivos de código: Organizar los archivos .pddl de dominios y problemas de forma limpia y clara.

[ ] Subir al Racó: Realizar la entrega electrónica antes del 8 de junio.

---

## Ejecución de Extensiones

Para ejecutar los escenarios de prueba, especialmente los de la Extensión 4 (con métricas numéricas ponderadas), es **imprescindible** utilizar el algoritmo de búsqueda A* óptimo provisto por Metric-FF. Si no lo hacemos, el planificador ignorará nuestras métricas por defecto al detectar precondiciones numéricas, usando en su lugar una búsqueda rápida que ignora el coste.

Se asume que te encuentras en el directorio `v2.1` al momento de ejecutar los comandos en la terminal.

## Comandos de Ejemplo para la Extensión 4

### 1. Priorizando el coste económico (Problema 4-1)
```bash
..\ff-v2.1.exe -o nuestrasCosas\dominio4.pddl -f nuestrasCosas\problema4-1.pddl -s 3 -w 1 > nuestrasCosas\traza4-1.txt
```

### 2. Priorizando el mayor interés turístico (Problema 4-2)
```bash
..\ff-v2.1.exe -o nuestrasCosas\dominio4.pddl -f nuestrasCosas\problema4-2.pddl -s 3 -w 1 > nuestrasCosas\traza4-2.txt
```

## Explicación de los parámetros

- **`-o`**: Especifica la ruta al archivo del Dominio (Operators).
- **`-f`**: Especifica la ruta al archivo del Problema (Facts).
- **`-s 3`**: Cambia la configuración de búsqueda interna a **"Weighted A*"** (A* ponderado). Esto obliga al planificador a tener en cuenta el `(:metric ...)` declarado en el problema para calcular los costes de los planes parciales, evitando su comportamiento por defecto (*Enforced Hill-Climbing*) que ignora la optimización cuando hay variables de días.
- **`-w 1`**: Establece el peso que se le da a la función heurística del algoritmo A* en `1`. Matemáticamente, un A* con peso heurístico igual a 1 garantiza que el plan final encontrado sea el **óptimo global** (el mejor plan posible según los precios/intereses).
- **`> [archivo]`**: Redirige la salida estándar de la consola hacia un archivo `.txt`. Así se guardan las "trazas" de la ejecución para su posterior análisis en la Fase 4 y entrega en la Fase 5.

## Comandos de Prueba para Extensiones Previas

A continuación se listan todos los comandos necesarios para ejecutar los dos juegos de prueba de cada extensión (Fase 4), garantizando que se guardan las trazas en `.txt`.

### Extensión 0 (Nivel Básico)
```bash
..\ff-v2.1.exe -o nuestrasCosas\dominio0.pddl -f nuestrasCosas\problema0-1.pddl -s 3 -w 1 > nuestrasCosas\traza0-1.txt
..\ff-v2.1.exe -o nuestrasCosas\dominio0.pddl -f nuestrasCosas\problema0-2.pddl -s 3 -w 1 > nuestrasCosas\traza0-2.txt
```

### Extensión 1 (Restricciones de Días)
```bash
..\ff-v2.1.exe -o nuestrasCosas\dominio1.pddl -f nuestrasCosas\problema1-1.pddl -s 3 -w 1 > nuestrasCosas\traza1-1.txt
..\ff-v2.1.exe -o nuestrasCosas\dominio1.pddl -f nuestrasCosas\problema1-2.pddl -s 3 -w 1 > nuestrasCosas\traza1-2.txt
```

### Extensión 2 (Interés de Ciudades)
```bash
..\ff-v2.1.exe -o nuestrasCosas\dominio2.pddl -f nuestrasCosas\problema2-1.pddl -s 3 -w 1 > nuestrasCosas\traza2-1.txt
..\ff-v2.1.exe -o nuestrasCosas\dominio2.pddl -f nuestrasCosas\problema2-2.pddl -s 3 -w 1 > nuestrasCosas\traza2-2.txt
```

### Extensión 3 (Precios de Vuelos y Hoteles)
```bash
..\ff-v2.1.exe -o nuestrasCosas\dominio3.pddl -f nuestrasCosas\problema3-1.pddl -s 3 -w 1 > nuestrasCosas\traza3-1.txt
..\ff-v2.1.exe -o nuestrasCosas\dominio3.pddl -f nuestrasCosas\problema3-2.pddl -s 3 -w 1 > nuestrasCosas\traza3-2.txt
```
