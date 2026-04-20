// Ejercicio 1
fun describirEstudiante(nombre: String, edad: Int, correo: String?): String {
    val correoFinal = correo ?: "No registrado"
    return "Nombre: $nombre, Edad: $edad, Correo: $correoFinal"
}

// Ejercicio 2
fun calcularDescuento(tipoCliente: String, monto: Double): Double {
    val descuento = when (tipoCliente.lowercase()) {
        "premium" -> 0.20
        "regular" -> 0.10
        "nuevo" -> 0.05
        else -> 0.0
    }
    return monto * (1 - descuento)
}

// Ejercicio 3
data class Estudiante(val nombre: String, val nota: Double)

// Ejercicio 4
data class Producto(val nombre: String, val precio: Double, val cantidad: Int)

fun resumenCarrito(productos: List<Producto>): String {
    val totalArticulos = productos.sumOf { it.cantidad }
    val totalPrecio = productos.sumOf { it.precio * it.cantidad }
    return "Artículos: $totalArticulos, Total: $${"%.2f".format(totalPrecio)}"
}

// MAIN (para ejecutar todo)
fun main() {

    println(describirEstudiante("Ana", 21, null))

    println(calcularDescuento("premium", 100000.0))

    val estudiantes = listOf(
        Estudiante("María", 4.5),
        Estudiante("Pedro", 2.8),
        Estudiante("Laura", 3.9)
    )

    val resultado = estudiantes
        .filter { it.nota >= 3.0 }
        .sortedByDescending { it.nota }
        .map { it.nombre }

    println(resultado)

    val carrito = listOf(
        Producto("Laptop", 2500000.0, 1),
        Producto("Mouse", 45000.0, 2)
    )

    println(resumenCarrito(carrito))
}