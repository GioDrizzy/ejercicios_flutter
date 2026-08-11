import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FormularioEstudianteScreen extends StatefulWidget {
  const FormularioEstudianteScreen({super.key});

  @override
  State<FormularioEstudianteScreen> createState() =>
      _FormularioEstudianteScreenState();
}

class _FormularioEstudianteScreenState
    extends State<FormularioEstudianteScreen> {
  final _formKey = GlobalKey<FormState>();

  final _matriculaController = TextEditingController();
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _edadController = TextEditingController();

  final List<String> _carreras = const [
    'Ingeniería en Sistemas',
    'Ingeniería Civil',
    'Administración de Empresas',
    'Medicina',
    'Derecho',
  ];
  String? _carreraSeleccionada;

  String? _sexoSeleccionado;
  bool _aceptaTerminos = false;

  @override
  void dispose() {
    _matriculaController.dispose();
    _nombreController.dispose();
    _correoController.dispose();
    _edadController.dispose();
    super.dispose();
  }

  void _registrar() {
    final formValido = _formKey.currentState?.validate() ?? false;

    if (!formValido ||
        _carreraSeleccionada == null ||
        _sexoSeleccionado == null ||
        !_aceptaTerminos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa todos los campos y acepta los términos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registro exitoso'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _resumenLinea('Matrícula', _matriculaController.text),
            _resumenLinea('Nombre', _nombreController.text),
            _resumenLinea('Correo', _correoController.text),
            _resumenLinea('Carrera', _carreraSeleccionada!),
            _resumenLinea('Edad', _edadController.text),
            _resumenLinea('Sexo', _sexoSeleccionado!),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _limpiarFormulario();
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  Widget _resumenLinea(String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text('$etiqueta: $valor'),
    );
  }

  void _limpiarFormulario() {
    _formKey.currentState?.reset();
    _matriculaController.clear();
    _nombreController.clear();
    _correoController.clear();
    _edadController.clear();
    setState(() {
      _carreraSeleccionada = null;
      _sexoSeleccionado = null;
      _aceptaTerminos = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScreen(
      seedColor: AppPalette.formularioEstudiante,
      builder: (context) => _buildContenido(context),
    );
  }

  Widget _buildContenido(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de estudiante')),
      body: ResponsiveFormBody(
        child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _matriculaController,
              decoration: const InputDecoration(
                labelText: 'Matrícula',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _correoController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Campo obligatorio';
                if (!v.contains('@') || !v.contains('.')) {
                  return 'Correo inválido';
                }
                return null;
              },
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _carreraSeleccionada,
              decoration: const InputDecoration(
                labelText: 'Carrera',
                border: OutlineInputBorder(),
              ),
              items: _carreras
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) => setState(() => _carreraSeleccionada = v),
              validator: (v) => v == null ? 'Selecciona una carrera' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _edadController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Edad',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                final edad = int.tryParse(v ?? '');
                if (edad == null || edad <= 0) {
                  return 'Introduce una edad válida';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            const Text('Sexo', style: TextStyle(fontWeight: FontWeight.bold)),
            RadioListTile<String>(
              title: const Text('Femenino'),
              value: 'Femenino',
              groupValue: _sexoSeleccionado,
              onChanged: (v) => setState(() => _sexoSeleccionado = v),
            ),
            RadioListTile<String>(
              title: const Text('Masculino'),
              value: 'Masculino',
              groupValue: _sexoSeleccionado,
              onChanged: (v) => setState(() => _sexoSeleccionado = v),
            ),
            CheckboxListTile(
              title: const Text('Acepto los términos y condiciones'),
              value: _aceptaTerminos,
              onChanged: (v) =>
                  setState(() => _aceptaTerminos = v ?? false),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registrar,
              child: const Text('Registrar'),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
