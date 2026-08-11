import 'package:flutter/material.dart';

import '../models/producto.dart';
import '../theme/app_theme.dart';

class CatalogoProductosScreen extends StatelessWidget {
  const CatalogoProductosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemedScreen(
      seedColor: AppPalette.catalogoProductos,
      builder: (context) => _buildContenido(context),
    );
  }

  Widget _buildContenido(BuildContext context) {
    final colorPrimario = Theme.of(context).colorScheme.primary;
    final colorSuave = Theme.of(context).colorScheme.primaryContainer;
    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de productos')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.78,
        ),
        itemCount: productosDemo.length,
        itemBuilder: (context, index) {
          final producto = productosDemo[index];
          return Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DetalleProductoScreen(producto: producto),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      color: colorSuave,
                      child: _ImagenProducto(
                        url: producto.imagenUrl,
                        icono: producto.icono,
                        colorIcono: colorPrimario,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          producto.nombre,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'RD\$${producto.precio.toStringAsFixed(2)}',
                          style: TextStyle(color: colorPrimario),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetalleProductoScreen extends StatelessWidget {
  final Producto producto;

  const DetalleProductoScreen({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(producto.nombre)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child: _ImagenProducto(
                  url: producto.imagenUrl,
                  icono: producto.icono,
                  colorIcono: colorScheme.primary,
                  tamanoIcono: 72,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              producto.nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Chip(label: Text(producto.categoria)),
            const SizedBox(height: 16),
            Text(
              'RD\$${producto.precio.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 22,
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              producto.descripcion,
              style: const TextStyle(fontSize: 15, height: 1.4),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Regresar al catálogo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Muestra la foto del producto desde internet. Mientras carga, muestra un
/// indicador de progreso; si falla (por ejemplo, sin conexión), cae de
/// vuelta al icono del producto para que la pantalla nunca quede rota.
class _ImagenProducto extends StatelessWidget {
  final String url;
  final IconData icono;
  final Color colorIcono;
  final double tamanoIcono;

  const _ImagenProducto({
    required this.url,
    required this.icono,
    required this.colorIcono,
    this.tamanoIcono = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: colorIcono,
              value: progress.expectedTotalBytes != null
                  ? progress.cumulativeBytesLoaded /
                      progress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(icono, size: tamanoIcono, color: colorIcono),
        );
      },
    );
  }
}
