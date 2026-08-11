import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TarjetaPresentacionScreen extends StatelessWidget {
  const TarjetaPresentacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedScreen(
      seedColor: AppPalette.tarjetaPresentacion,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return Scaffold(
          appBar: AppBar(title: const Text('Tarjeta de presentación')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: colorScheme.primary,
                  child: const Icon(Icons.person, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'María Fernández',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Desarrolladora de Software',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _InfoRow(
                          icon: Icons.phone_outlined,
                          texto: '+1 (809) 555-1234',
                          color: colorScheme.primary,
                        ),
                        const Divider(),
                        _InfoRow(
                          icon: Icons.email_outlined,
                          texto: 'maria.fernandez@correo.com',
                          color: colorScheme.primary,
                        ),
                        const Divider(),
                        _InfoRow(
                          icon: Icons.location_on_outlined,
                          texto: 'Santo Domingo, República Dominicana',
                          color: colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Apasionada por la tecnología y el desarrollo móvil. '
                  'Me gusta crear aplicaciones que resuelvan problemas reales '
                  'y aprender nuevas herramientas todos los días.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, height: 1.4),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String texto;
  final Color color;

  const _InfoRow({required this.icon, required this.texto, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 12),
        Expanded(child: Text(texto, style: const TextStyle(fontSize: 15))),
      ],
    );
  }
}
