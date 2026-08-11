import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum _LuzSemaforo { rojo, verde, amarillo }

class SemaforoScreen extends StatefulWidget {
  const SemaforoScreen({super.key});

  @override
  State<SemaforoScreen> createState() => _SemaforoScreenState();
}

class _SemaforoScreenState extends State<SemaforoScreen> {
  _LuzSemaforo _luzActual = _LuzSemaforo.rojo;

  void _cambiarLuz() {
    setState(() {
      switch (_luzActual) {
        case _LuzSemaforo.rojo:
          _luzActual = _LuzSemaforo.verde;
          break;
        case _LuzSemaforo.verde:
          _luzActual = _LuzSemaforo.amarillo;
          break;
        case _LuzSemaforo.amarillo:
          _luzActual = _LuzSemaforo.rojo;
          break;
      }
    });
  }

  String get _mensaje {
    switch (_luzActual) {
      case _LuzSemaforo.rojo:
        return 'Deténgase';
      case _LuzSemaforo.amarillo:
        return 'Prepárese';
      case _LuzSemaforo.verde:
        return 'Puede avanzar';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScreen(
      seedColor: AppPalette.semaforo,
      builder: (context) => _buildContenido(context),
    );
  }

  Widget _buildContenido(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Semáforo interactivo')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.directions_car_filled_outlined,
                    size: 40, color: Colors.grey),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _Luz(
                        color: Colors.red,
                        encendida: _luzActual == _LuzSemaforo.rojo,
                      ),
                      const SizedBox(height: 16),
                      _Luz(
                        color: Colors.amber,
                        encendida: _luzActual == _LuzSemaforo.amarillo,
                      ),
                      const SizedBox(height: 16),
                      _Luz(
                        color: Colors.green,
                        encendida: _luzActual == _LuzSemaforo.verde,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  _mensaje,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: _cambiarLuz,
                  icon: const Icon(Icons.sync),
                  label: const Text('Cambiar luz'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Luz extends StatelessWidget {
  final Color color;
  final bool encendida;

  const _Luz({required this.color, required this.encendida});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: encendida ? color : color.withValues(alpha: 0.2),
        boxShadow: encendida
            ? [BoxShadow(color: color.withValues(alpha: 0.7), blurRadius: 20)]
            : null,
      ),
    );
  }
}
