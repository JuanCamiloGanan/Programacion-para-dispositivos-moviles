## Tienda App - Flutter

Aplicación móvil desarrollada en Flutter que consume una API REST para mostrar, crear y gestionar productos.

## Funcionalidades

- Listado de productos desde API
- Vista de detalle de producto con:
  - Imagen
  - Título
  - Precio
  - Categoría
  - Descripción
  - Rating
- Creación de producto (POST)
  - Muestra confirmación con ID generado

### Bonificación implementada
- Actualización de producto (PUT)
- Eliminación de producto (DELETE)

---

## Tecnologías utilizadas

- Flutter
- Dart
- HTTP (consumo de API REST)
- FakeStoreAPI

## Cómo ejecutar el proyecto

### 1. Clonar el repositorio

```bash
git clone https://github.com/JuanCamiloGanan/Programacion-para-dispositivos-moviles/tree/main

cd tienda_app
```

### 2. Instalar dependencias

Ubicarse en la carpeta raíz (donde está pubspec.yaml) y ejecutar:

```bash
flutter pub get
```

### 3. Ejecutar la aplicación
```bash
flutter run
```

## Tener en cuenta

### Para actualizar cambios durante el desarrollo

Mientras la app está corriendo:

Hot Reload (rápido):
```bash
r
```
Hot Restart (recomendado):
```bash
R
```

### Solución de errores comunes

Si aparecen errores inesperados:
```bash
flutter clean
flutter pub get
flutter run
```

## Estructura del proyecto
```bash
lib/
│
├── models/
│   └── product.dart
│
├── services/
│   └── api_service.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── detail_screen.dart
│   ├── create_product_screen.dart
│   └── edit_product_screen.dart
│
└── main.dart
```

## Flujo de uso
- Ver productos en pantalla principal
- Seleccionar producto → ver detalle
- Crear nuevo producto (botón +)
- Editar o eliminar producto desde detalle

## Autor

- Juan Camilo Gañan Blandón
- Ingeniería en Informática
- Universidad de Caldas