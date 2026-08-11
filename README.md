# 📱 Ejercicios de Tecnologías Móviles

Aplicación móvil desarrollada con **Flutter y Dart** como parte de la asignatura **Tecnologías Móviles**.

El proyecto reúne los **10 ejercicios prácticos** establecidos en la asignación, con el propósito de practicar los fundamentos del desarrollo de aplicaciones móviles utilizando Flutter y Dart.

---

## 🎯 Objetivo del proyecto

El objetivo principal de este proyecto es **practicar Flutter y Dart** mediante la implementación de diferentes aplicaciones y funcionalidades.

A través de los ejercicios se trabajan conceptos como:

* Creación y organización de interfaces.
* Uso de widgets de Flutter.
* Manejo de estado.
* Entrada y validación de datos.
* Formularios.
* Listas.
* Clases y objetos.
* Navegación entre pantallas.
* Manejo de eventos.
* Uso de componentes interactivos.

---

## 📚 Ejercicios implementados

### 1. 👤 Tarjeta de presentación personal

Aplicación que muestra una tarjeta de presentación con los datos personales de una persona.

**Incluye:**

* Fotografía o avatar.
* Nombre completo.
* Profesión u ocupación.
* Número de teléfono.
* Correo electrónico.
* Ciudad o país.
* Breve descripción personal.
* Información de contacto agrupada mediante una tarjeta.

**Widgets y conceptos utilizados:**

`Scaffold` · `AppBar` · `Column` · `Row` · `CircleAvatar` · `Text` · `Icon` · `Card` · `Container`

La fotografía se presenta de forma circular y la información se organiza de manera centrada y adaptable a la pantalla.

---

### 2. 👥 Contador de personas

Aplicación destinada a llevar el conteo de personas que entran y salen de un lugar.

**Funciones:**

* ➕ Agregar una persona.
* ➖ Restar una persona.
* 🔄 Reiniciar el contador.
* Evitar valores menores que cero.
* Mostrar **"Capacidad alcanzada"** al llegar a 20 personas.
* Solicitar confirmación antes de reiniciar.

**Conceptos utilizados:**

* `StatefulWidget`
* `setState`
* Eventos de botones.
* Condicionales.
* `AlertDialog`

El contador comienza en cero y la interfaz se actualiza inmediatamente después de cada interacción.

---

### 3. 🎂 Calculadora de edad

Aplicación que permite calcular aproximadamente la edad de una persona a partir de su año de nacimiento.

**Datos de entrada:**

* Nombre.
* Año de nacimiento.

**Funciones:**

* Calcular la edad.
* Validar que el nombre no esté vacío.
* Validar el año introducido.
* Verificar que el año no sea mayor que el año actual.
* Verificar que el año sea mayor que 1900.
* Mostrar mensajes de error.
* Limpiar los campos.

Para obtener el año actual se puede utilizar `DateTime.now().year`.

**Conceptos utilizados:**

* `TextField`
* `TextFormField`
* `TextEditingController`
* Conversión de texto a números.
* Validaciones.
* Operaciones aritméticas.

---

### 4. 💰 Calculadora de propinas

Aplicación para calcular el valor de la propina y el total que debe pagar un cliente.

**Datos de entrada:**

* Monto de la cuenta.
* Porcentaje de propina.

**Porcentajes disponibles:**

* 5 %
* 10 %
* 15 %
* 20 %

**Resultados:**

* Valor de la propina.
* Total de la cuenta más la propina.

Los resultados se muestran utilizando dos posiciones decimales.

**Conceptos utilizados:**

* Formularios.
* Operaciones con números decimales.
* Controles de selección.
* Formateo de resultados.
* Actualización de la interfaz.

También incluye validación del monto y un botón para reiniciar la calculadora.

---

### 5. 🌡️ Conversor de temperatura

Aplicación para realizar conversiones entre grados Celsius y Fahrenheit.

**Conversiones disponibles:**

```text
Celsius → Fahrenheit
Fahrenheit → Celsius
```

**Fórmulas utilizadas:**

```text
Fahrenheit = (Celsius × 9 / 5) + 32

Celsius = (Fahrenheit - 32) × 5 / 9
```

**Funciones:**

* Introducir una temperatura.
* Seleccionar el tipo de conversión.
* Validar que el valor sea numérico.
* Mostrar el resultado con dos posiciones decimales.
* Indicar la unidad del resultado.
* Limpiar el resultado al cambiar el tipo de conversión.
* Ejecutar la conversión mediante el botón **Convertir**.

**Conceptos utilizados:**

* Fórmulas matemáticas.
* Controles de selección.
* Validación de entradas.
* Variables de estado.
* Interpolación de cadenas.

---

### 6. 🚦 Semáforo interactivo

Aplicación que simula el funcionamiento básico de un semáforo.

El semáforo cuenta con tres luces:

* 🔴 Rojo.
* 🟡 Amarillo.
* 🟢 Verde.

El cambio de estado sigue el siguiente orden:

```text
Rojo → Verde → Amarillo → Rojo
```

Cada estado muestra un mensaje:

| Estado      | Mensaje       |
| ----------- | ------------- |
| 🔴 Rojo     | Deténgase     |
| 🟡 Amarillo | Prepárese     |
| 🟢 Verde    | Puede avanzar |

**Conceptos utilizados:**

* Condicionales.
* Manejo de estados.
* Cambio dinámico de colores.
* `Container`
* `BoxDecoration`
* `Column`

El semáforo inicia en rojo y solamente una luz permanece activa a la vez.

---

### 7. 🧑‍🎓 Formulario de registro de estudiante

Aplicación que permite registrar los datos básicos de un estudiante.

**Campos:**

* Matrícula.
* Nombre completo.
* Correo electrónico.
* Carrera.
* Edad.
* Sexo.
* Aceptación de términos y condiciones.

El formulario valida los datos antes de permitir el registro y muestra un resumen de la información registrada.

**Validaciones:**

* Todos los campos son obligatorios.
* La edad debe ser mayor que cero.
* El correo debe contener `@` y un punto.
* La carrera debe seleccionarse de una lista.
* El sexo se selecciona mediante opciones.
* Los términos deben ser aceptados.

**Conceptos utilizados:**

* `Form`
* `GlobalKey<FormState>`
* `validator`
* `DropdownButtonFormField`
* `RadioListTile`
* `CheckboxListTile`

---

### 8. 🛒 Lista de compras

Aplicación para registrar y administrar productos que una persona necesita comprar.

Cada producto puede:

* Ser agregado a la lista.
* Marcarse como comprado.
* Mostrar su nombre tachado cuando ha sido comprado.
* Ser eliminado.
* Ser eliminado mediante confirmación.

También se muestra la cantidad de productos pendientes y existe una opción para eliminar todos los productos comprados.

**Conceptos utilizados:**

* Listas.
* `ListView`
* `ListView.builder`
* `Checkbox`
* Modelos de datos.
* `setState`
* Agregar, modificar y eliminar elementos.

---

### 9. 🛍️ Catálogo básico de productos

Aplicación que muestra un catálogo sencillo de productos mediante tarjetas.

Cada producto contiene:

* Nombre.
* Precio.
* Descripción corta.
* Imagen.
* Categoría.

Al seleccionar un producto se abre una segunda pantalla con sus detalles completos.

**Productos contemplados:**

* Computadora portátil.
* Teléfono móvil.
* Audífonos.
* Teclado.
* Reloj inteligente.

**Conceptos utilizados:**

* Clases y objetos en Dart.
* Listas de objetos.
* `ListView.builder`
* `GridView.builder`
* `Navigator`
* Navegación entre pantallas.
* Envío de datos entre pantallas.
* Tarjetas reutilizables.

---

### 10. ✅ Aplicación de tareas pendientes

Aplicación para administrar tareas personales.

Cada tarea contiene:

* Título.
* Descripción.
* Fecha límite.
* Nivel de prioridad:

  * Baja.
  * Media.
  * Alta.

**Funciones:**

* Visualizar tareas.
* Agregar nuevas tareas.
* Seleccionar fecha límite.
* Seleccionar prioridad.
* Marcar tareas como completadas.
* Editar tareas.
* Eliminar tareas.
* Confirmar antes de eliminar.
* Mostrar estadísticas.

En la parte superior se muestran:

* **Total de tareas.**
* **Tareas pendientes.**
* **Tareas completadas.**

Las tareas completadas se muestran con el texto tachado.

---

## 🛠️ Tecnologías utilizadas

* **Flutter**
* **Dart**
* **Material Design**
* Widgets de Flutter
* `StatefulWidget`
* `setState`
* Formularios y validaciones
* Listas y modelos de datos
* Navegación con `Navigator`

---

## 📖 Conceptos practicados

Durante el desarrollo de los ejercicios se practicaron diferentes fundamentos del desarrollo móvil con Flutter:

* Estructura de una aplicación Flutter.
* Creación y composición de widgets.
* Diseño de interfaces.
* `Scaffold` y `AppBar`.
* Organización mediante `Column` y `Row`.
* Manejo de imágenes.
* Uso de `Card` y `Container`.
* Manejo de estado.
* `StatefulWidget`.
* `setState`.
* Eventos de botones.
* Condicionales.
* Formularios.
* Validación de datos.
* `TextEditingController`.
* `TextField` y `TextFormField`.
* `Checkbox`.
* `RadioListTile`.
* `DropdownButtonFormField`.
* `AlertDialog`.
* `showDatePicker`.
* Listas.
* `ListView.builder`.
* `GridView.builder`.
* Clases y objetos en Dart.
* Navegación con `Navigator`.
* Envío de datos entre pantallas.

---

## 📂 Estructura del proyecto

La estructura general corresponde a una aplicación Flutter:

```text
proyecto/
│
├── android/
├── ios/
├── lib/
│   └── main.dart
│
├── test/
│
├── web/
├── windows/
├── macos/
├── linux/
│
├── pubspec.yaml
└── README.md
```

La carpeta `lib` contiene el código principal de la aplicación y `main.dart` corresponde al punto de entrada del proyecto.

---

## 🚀 Instalación y ejecución

### Requisitos

Para ejecutar el proyecto se necesita tener instalado:

* Flutter SDK
* Dart SDK
* Android Studio o Visual Studio Code
* Un dispositivo físico o emulador compatible

### Clonar el repositorio

```bash
git clone URL_DEL_REPOSITORIO
```

### Entrar al proyecto

```bash
cd NOMBRE_DEL_PROYECTO
```

### Instalar dependencias

```bash
flutter pub get
```

### Ejecutar la aplicación

```bash
flutter run
```

---

## 🔍 Verificación del proyecto

Para comprobar que el proyecto no presenta problemas de análisis:

```bash
flutter analyze
```

Para ejecutar las pruebas:

```bash
flutter test
```

---

## 🎓 Información académica

**Asignatura:** Tecnologías Móviles

**Tecnología principal:** Flutter

**Lenguaje:** Dart

**Tipo de proyecto:** Proyecto académico individual

**Objetivo:** Practicar Flutter y Dart mediante la implementación de los ejercicios establecidos en la asignación.

---

## 👤 Autor

**Giovanny Bautista Castillo**

---

## 📌 Nota

Este proyecto fue desarrollado con **fines académicos** para la asignatura **Tecnologías Móviles**, implementando los ejercicios planteados en la actividad y aplicando los conceptos fundamentales del desarrollo de aplicaciones móviles con Flutter y Dart.
