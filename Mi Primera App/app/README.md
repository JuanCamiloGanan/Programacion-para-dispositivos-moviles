## Programacion para dispositivos moviles

## Taller Android Studio

En esta carpeta podrá encontrar los ejercicios propuestos en en el taller, además de las preguntas a responder:

- [Ejercicio 1 - 4](https://github.com/JuanCamiloGanan/Programacion-para-dispositivos-moviles/blob/main/Mi%20Primera%20App/app/src/main/java/Ejercicios_1_4.kt)

# Preguntas

1- ¿Cuál es la diferencia entre `val` y `var`?
R= `val` define una variable inmutable (no se puede reasignar), mientras que `var` permite cambiar su valor después de declararla.

2- ¿Para qué sirve el operador `?:` (Elvis)?
R= Permite asignar un valor por defecto cuando una expresión es nula.
Ejemplo: `val nombre = texto ?: "Desconocido"`

3- ¿Qué genera automáticamente una `data class` que una clase normal no?
R= Genera automáticamente métodos como `toString()`, `equals()`, `hashCode()` y `copy()`, además de manejar mejor la comparación de objetos.

4- ¿Qué hace el Adapter en un RecyclerView?
R= Conecta los datos con las vistas, creando y vinculando cada elemento de la lista con su representación en pantalla.

5- ¿Por qué usar View Binding en lugar de findViewById?
R= Porque es más seguro, además de evitar errores, es más rápido de escribir y elimina la necesidad de buscar vistas manualmente.