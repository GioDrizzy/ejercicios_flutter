import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ContadorPersonasScreen extends StatefulWidget {
  const ContadorPersonasScreen({super.key});

  @override
  State<ContadorPersonasScreen> createState() =>
      _ContadorPersonasScreenState();
}

class _ContadorPersonasScreenState extends State<ContadorPersonasScreen> {
  int _contador = 0;
  static const int _capacidadMaxima = 20;

  void _agregar() {
    if (_contador < _capacidadMaxima) {
      setState(() => _contador++);
    }
  }

  void _restar() {
    if (_contador > 0) {
      setState(() => _contador--);
    }
  }

  Future<void> _reiniciar() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reiniciar contador'),
        content: const Text('¿Seguro que deseas colocar el contador en cero?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reiniciar'),
          ),
        ],
      ),
    );
    if (confirmar == true) {
      setState(() => _contador = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScreen(
      seedColor: AppPalette.contadorPersonas,
      builder: (context) => _buildContenido(context),
    );
  }

  Widget _buildContenido(BuildContext context) {
    final capacidadAlcanzada = _contador >= _capacidadMaxima;
    final colorPrimario = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Contador de personas')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$_contador',
              style: TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.bold,
                color: capacidadAlcanzada ? Colors.red : colorPrimario,
              ),
            ),
            const SizedBox(height: 8),
            if (capacidadAlcanzada)
              const Text(
                'Capacidad alcanzada',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _restar,
                  icon: const Icon(Icons.remove),
                  label: const Text('Restar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: capacidadAlcanzada ? null : _agregar,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _reiniciar,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reiniciar'),
            ),
          ],
        ),
      ),
    );
  }
}
