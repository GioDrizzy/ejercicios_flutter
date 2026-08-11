import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CalculadoraEdadScreen extends StatefulWidget {
  const CalculadoraEdadScreen({super.key});

  @override
  State<CalculadoraEdadScreen> createState() => _CalculadoraEdadScreenState();
}

class _CalculadoraEdadScreenState extends State<CalculadoraEdadScreen> {
  final _nombreController = TextEditingController();
  final _anioController = TextEditingController();

  String? _mensaje;
  bool _esError = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _anioController.dispose();
    super.dispose();
  }

  void _calcular() {
    final nombre = _nombreController.text.trim();
    final anioTexto = _anioController.text.trim();
    final anioActual = DateTime.now().year;
    final anio = int.tryParse(anioTexto);

    if (nombre.isEmpty) {
      setState(() {
        _esError = true;
        _mensaje = 'El nombre no puede quedar vacío.';
      });
      return;
    }
    if (anio == null) {
      setState(() {
        _esError = true;
        _mensaje = 'El año de nacimiento debe ser un valor numérico.';
      });
      return;
    }
    if (anio > anioActual) {
      setState(() {
        _esError = true;
        _mensaje = 'El año no puede ser mayor que el año actual ($anioActual).';
      });
      return;
    }
    if (anio <= 1900) {
      setState(() {
        _esError = true;
        _mensaje = 'El año debe ser mayor que 1900.';
      });
      return;
    }

    final edad = anioActual - anio;
    setState(() {
      _esError = false;
      _mensaje = '$nombre, tienes aproximadamente $edad años.';
    });
  }

  void _limpiar() {
    _nombreController.clear();
    _anioController.clear();
    setState(() => _mensaje = null);
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScreen(
      seedColor: AppPalette.calculadoraEdad,
      builder: (context) => _buildContenido(context),
    );
  }

  Widget _buildContenido(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de edad')),
      body: ResponsiveFormBody(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _anioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Año de nacimiento',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _calcular,
                      child: const Text('Calcular edad'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _limpiar,
                      child: const Text('Limpiar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_mensaje != null)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _esError
                        ? Colors.red.shade50
                        : Colors.green.shade50,
                    border: Border.all(
                      color: _esError ? Colors.red : Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _esError
                            ? Icons.error_outline
                            : Icons.check_circle_outline,
                        color: _esError ? Colors.red : Colors.green,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _mensaje!,
                          style: TextStyle(
                            color: _esError
                                ? Colors.red.shade900
                                : Colors.green.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
