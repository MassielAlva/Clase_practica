# Introducción a Flutter
Proyecto de ejemplo para aprender los fundamentos de Flutter: widgets, botones y formularios.
## ¿Qué es Flutter?
Flutter es un **SDK de código abierto** creado por Google para desarrollar aplicaciones **multiplataforma** (Android, iOS, Web, Windows, macOS, Linux) desde un **único código base** escrito en **Dart**.

### Ventajas
- Una sola base de código para 6 plataformas
- Alto rendimiento (compila a código nativo)
- Hot Reload (ves los cambios al instante)
- Gran cantidad de widgets prediseñados
## Conceptos clave
| Concepto | Descripción |
|----------|-------------|
| **Widget** | Todo en Flutter es un widget: botones, textos, márgenes, etc. |
| **StatelessWidget** | Widget estático que no cambia (ej: un título, un icono) |
| **StatefulWidget** | Widget dinámico que puede cambiar su estado (ej: un formulario, un contador) |
| **BuildContext** | Contexto del widget en el árbol de la interfaz |
## Código esencial: Botón y Formulario
### 1. Botón simple (`ElevatedButton`)
```dart
ElevatedButton(
  onPressed: () {
    print('Botón presionado');
  },
  child: const Text('Presióname'),
)
```

Con estilo personalizado:

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  ),
  onPressed: () => print('¡Click!'),
  child: const Text('Enviar'),
)
```
### 2. Campo de texto (`TextFormField`)
```dart
TextFormField(
  decoration: InputDecoration(
    labelText: 'Nombre',
    hintText: 'Escribe tu nombre',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.person),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  },
  onSaved: (value) => _nombre = value!,
)
```


## Formulario explicado por partes

### Parte 1: Importar Material Design

```dart
import 'package:flutter/material.dart';
```
Esta línea importa todos los widgets de Material Design (botones, textos, formularios, colores, etc.).

---

### Parte 2: Punto de entrada de la app

```dart
void main() => runApp(const MyApp());
```
`main()` es la función principal que ejecuta la app. `runApp()` monta el widget raíz.

---

### Parte 3: Widget raíz (StatelessWidget)

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MiFormulario(),
    );
  }
}
```
- `StatelessWidget`: widget que **no cambia** una vez renderizado
- `MaterialApp`: envoltorio principal que da el tema Material Design
- `home`: la pantalla principal que se muestra al iniciar

---

### Parte 4: Widget del formulario (StatefulWidget)

```dart
class MiFormulario extends StatefulWidget {
  const MiFormulario({super.key});

  @override
  State<MiFormulario> createState() => _MiFormularioState();
}
```
- `StatefulWidget`: widget que **puede cambiar** su contenido (porque el formulario necesita actualizarse)
- `createState()`: crea el estado asociado al widget

---

### Parte 5: Estado del formulario

```dart
class _MiFormularioState extends State<MiFormulario> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
```
- `_formKey`: identificador único del formulario para controlarlo (validar, guardar, resetear)
- `_nombre`: variable que almacenará el texto ingresado por el usuario

---

### Parte 6: Scaffold (el esqueleto de la pantalla)

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Mi Formulario'),
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
    ),
```
- `Scaffold`: estructura básica de una pantalla (AppBar, body, bottomNavigationBar, etc.)
- `AppBar`: barra superior con título y color

---

### Parte 7: El Formulario

```dart
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
```
- `Padding`: agrega espacio alrededor (20 píxeles de margen)
- `Form`: widget que agrupa campos y permite validarlos como conjunto
- `Column`: organiza los hijos **verticalmente**
- `MainAxisAlignment.center`: centra los elementos en el eje vertical

---

### Parte 8: Título del formulario

```dart
            const Text(
              'FORMULARIO DE REGISTRO',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
```
- `Text`: muestra texto en pantalla
- `TextStyle`: define tamaño (`fontSize`), grosor (`fontWeight`), color, etc.
- `SizedBox`: espacio vacío de separación (30 píxeles de alto)

---

### Parte 9: Campo de texto (TextFormField)

```dart
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre Completo',
                hintText: 'Ingresa tu nombre aquí',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa un nombre';
                }
                return null;
              },
              onSaved: (value) => _nombre = value!,
            ),
```
- `TextFormField`: campo de entrada de texto con validación incluida
- `InputDecoration`: personaliza el campo (etiqueta, borde, icono)
  - `labelText`: texto flotante arriba del campo
  - `hintText`: texto de ayuda dentro del campo
  - `border`: borde redondeado
  - `prefixIcon`: icono a la izquierda
- `validator`: función que valida el contenido. Si devuelve un `String`, se muestra como error. Si devuelve `null`, todo está bien
- `onSaved`: función que se ejecuta al guardar; aquí asignamos el valor a `_nombre`

---

### Parte 10: Botón de enviar

```dart
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('¡Bienvenido $_nombre!')),
                    );
                  }
                },
                child: const Text('ENVIAR DATOS', style: TextStyle(fontSize: 16)),
              ),
            ),
```
- `SizedBox` con `width: double.infinity`: hace que el botón ocupe todo el ancho disponible
- `ElevatedButton`: botón con elevación (sombra)
- `style`: personaliza colores de fondo y texto
- `onPressed`: función que se ejecuta al presionar
  - `_formKey.currentState!.validate()`: valida **todos** los campos del formulario. Si algún `validator` devuelve error, retorna `false`
  - `_formKey.currentState!.save()`: ejecuta `onSaved` de cada campo
  - `SnackBar`: mensaje flotante temporal en la parte inferior
