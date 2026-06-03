import 'package:flutter/material.dart';

// --- GUION PARA TU EXPOSICIÓN (30 MIN) ---
// 1. ¿Qué es Flutter? SDK de Google para crear apps multiplataforma (Android, iOS, Web).
// 2. ¿Para qué sirve? Permite crear interfaces modernas con un solo código.
// 3. Widgets: Son los bloques de construcción. Hay dos tipos principales:
//    - Stateless: Estático, no cambia (ej. un icono, un texto fijo).
//    - Stateful: Dinámico, cambia con el tiempo (ej. un formulario, un contador).

void main() => runApp(const MyApp());

// EJEMPLO DE STATELESS WIDGET
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exposición Flutter',
      home: MiFormulario(),
    );
  }
}

// EJEMPLO DE STATEFUL WIDGET (Para el Formulario)
class MiFormulario extends StatefulWidget {
  const MiFormulario({super.key});

  @override
  State<MiFormulario> createState() => _MiFormularioState();
}

class _MiFormularioState extends State<MiFormulario> {
  // Llave global para identificar y validar el formulario
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expo: Mi Primer Formulario'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Widget de espacio (Padding)
        child: Form(
          key: _formKey,
          child: Column(
            // Column: Widget para organizar elementos verticalmente
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // WIDGET TEXT: Para mostrar texto en pantalla
              const Text(
                'FORMULARIO DE REGISTRO',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30), // Espacio vacío

              // WIDGET INPUT (TextFormField): Para entrada de datos
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre Completo',
                  hintText: 'Ingresa tu nombre aquí',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                // Validación: Lógica para verificar que el campo no esté vacío
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un nombre';
                  }
                  return null;
                },
                onSaved: (value) => _nombre = value!,
              ),

              const SizedBox(height: 20),

              // WIDGET BOTÓN (ElevatedButton): Para ejecutar acciones
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Acción al presionar: Validar y mostrar mensaje
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      
                      // Feedback visual al usuario
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('¡Bienvenido $_nombre! Datos recibidos.')),
                      );
                    }
                  },
                  child: const Text('ENVIAR DATOS', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
