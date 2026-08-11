# Ejercicios Flutter

Proyecto único de Flutter con los 10 ejercicios individuales, accesibles desde
un menú principal (`lib/main.dart`).

## Contenido

| # | Ejercicio | Archivo |
|---|-----------|---------|
| 1 | Tarjeta de presentación personal | `lib/screens/ex1_tarjeta_presentacion.dart` |
| 2 | Contador de personas | `lib/screens/ex2_contador_personas.dart` |
| 3 | Calculadora de edad | `lib/screens/ex3_calculadora_edad.dart` |
| 4 | Calculadora de propinas | `lib/screens/ex4_calculadora_propinas.dart` |
| 5 | Conversor de temperatura | `lib/screens/ex5_conversor_temperatura.dart` |
| 6 | Semáforo interactivo | `lib/screens/ex6_semaforo.dart` |
| 7 | Formulario de registro de estudiante | `lib/screens/ex7_formulario_estudiante.dart` |
| 8 | Lista de compras | `lib/screens/ex8_lista_compras.dart` |
| 9 | Catálogo básico de productos | `lib/screens/ex9_catalogo_productos.dart` |
| 10 | Aplicación de tareas pendientes | `lib/screens/ex10_tareas_pendientes.dart` |

Modelos de datos en `lib/models/` (`producto.dart`, `tarea.dart`).

## Cómo correrlo en Android (Windows/Mac/Linux)

Este entorno de chat no tiene el SDK de Flutter instalado, así que el proyecto
se entregó como código fuente. Para ejecutarlo en tu máquina:

1. **Instala Flutter** siguiendo la guía oficial: https://docs.flutter.dev/get-started/install
   (incluye Android Studio o al menos el Android SDK + un emulador o
   dispositivo físico con depuración USB activada).

2. **Descomprime este proyecto** en una carpeta, por ejemplo `ejercicios_flutter/`.

3. Abre una terminal dentro de esa carpeta y genera los archivos de
   plataforma (Android/iOS/etc.) que faltan, ya que aquí solo se incluye el
   código Dart (`lib/`) y `pubspec.yaml`:

   ```bash
   flutter create .
   ```

   Esto no sobrescribe tu carpeta `lib/` ni tu `pubspec.yaml` existentes;
   solo agrega `android/`, `ios/`, etc.

4. Instala las dependencias:

   ```bash
   flutter pub get
   ```

5. Conecta un dispositivo Android (o abre un emulador) y verifica que Flutter
   lo detecta:

   ```bash
   flutter devices
   ```

6. Corre la app:

   ```bash
   flutter run
   ```

7. Para generar el APK instalable:

   ```bash
   flutter build apk --release
   ```

   El archivo quedará en `build/app/outputs/flutter-apk/app-release.apk`.

## Notas

- Todos los ejercicios usan **estado local** (`setState`, `List` en memoria).
  No requieren backend ni Firebase — al cerrar la app se pierde el estado,
  tal como piden los requisitos originales.
- Si más adelante quieres persistencia real (por ejemplo en los ejercicios 9
  y 10), se puede añadir Firestore como mejora sin tocar la estructura de
  pantallas.

## Modo oscuro y paleta de colores

- El switch de modo claro/oscuro está en el `AppBar` del menú principal
  (`lib/main.dart`). Cambia `ThemeMode` a nivel de `MaterialApp`, por lo que
  el modo oscuro se aplica **nativamente en toda la app** (todas las
  pantallas, formularios, diálogos, etc. — no hay nada que configurar por
  pantalla).
- La paleta base es "Índigo nocturno" (`#3F4B8C`), definida en
  `lib/theme/app_theme.dart` junto con 10 variantes sutiles (una por
  ejercicio) generadas con `ColorScheme.fromSeed`. Cada pantalla se envuelve
  en un widget `ThemedScreen` que aplica su variante respetando el modo
  claro/oscuro activo.
- Para cambiar la paleta base más adelante, solo hay que editar
  `AppPalette.base` y las 10 constantes de variantes en
  `lib/theme/app_theme.dart` — el resto de la app se actualiza solo.

## Diseño responsive (teléfono / tablet / escritorio)

- **Menú principal** (`lib/main.dart`): la grilla usa `LayoutBuilder` para
  medir el ancho disponible y ajustar automáticamente la cantidad de
  columnas — 2 en teléfono, 3 en tablet vertical, 4 en tablet horizontal /
  escritorio pequeño, 5 en escritorio grande. Además, el contenido se
  centra y limita a un ancho máximo (`kMaxContentWidth`, 1100px) para que
  las tarjetas no queden estiradas de borde a borde en monitores anchos.
- **Ejercicio 6 (semáforo)**: el contenido está envuelto en
  `Center` + `ConstrainedBox` con un ancho máximo de 420px, así que en
  pantallas grandes el semáforo queda centrado en vez de pegado a una
  esquina.
- **Ejercicio 9 (catálogo)**: la grilla usa
  `SliverGridDelegateWithMaxCrossAxisExtent` en lugar de un número fijo de
  columnas — cada tarjeta de producto tiene un ancho máximo (220px) y
  Flutter calcula solo cuántas caben por fila según el tamaño de la
  pantalla, así que se ve bien tanto en un teléfono angosto como en un
  monitor de escritorio.
- **Formularios (ejercicios 3, 4, 5 y 7)**: se envolvieron en el widget
  `ResponsiveFormBody` (`lib/theme/app_theme.dart`), que centra el
  contenido y lo limita a 520px de ancho. Así, en tablet/escritorio el
  formulario no se estira de borde a borde — se ve como una tarjeta
  centrada, más cómoda de leer y llenar.

## Imágenes de producto (ejercicio 9)

- Cada producto del catálogo (`lib/models/producto.dart`) tiene un campo
  `imagenUrl` con una foto de stock real (con licencia gratuita de
  Unsplash — no requieren atribución, pero sí conexión a internet en
  tiempo de ejecución para cargarse).
- El widget `_ImagenProducto` (dentro de `ex9_catalogo_productos.dart`) usa
  `Image.network` con `loadingBuilder` (muestra un spinner mientras carga)
  y `errorBuilder` (si no hay conexión o la imagen falla, cae de vuelta al
  icono del producto) — así la pantalla nunca se rompe si el dispositivo
  está offline.
- Si prefieres imágenes propias en vez de las de stock, basta con
  reemplazar el valor de `imagenUrl` por otra URL, o migrar a
  `Image.asset` empaquetando los archivos en `assets/` y declarándolos en
  `pubspec.yaml`.
