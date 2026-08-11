import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class _Producto {
  String nombre;
  bool comprado;

  _Producto({required this.nombre}) : comprado = false;
}

class ListaComprasScreen extends StatefulWidget {
  const ListaComprasScreen({super.key});

  @override
  State<ListaComprasScreen> createState() => _ListaComprasScreenState();
}

class _ListaComprasScreenState extends State<ListaComprasScreen> {
  final _nombreController = TextEditingController();
  final List<_Producto> _productos = [];

  int get _pendientes => _productos.where((p) => !p.comprado).length;

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  void _agregarProducto() {
    final nombre = _nombreController.text.trim();
    if (nombre.isEmpty) return;
    setState(() {
      _productos.add(_Producto(nombre: nombre));
      _nombreController.clear();
    });
  }

  Future<void> _eliminarProducto(int index) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar producto'),
        content: Text('¿Eliminar "${_productos[index].nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmar == true) {
      setState(() => _productos.removeAt(index));
    }
  }

  void _eliminarComprados() {
    setState(() => _productos.removeWhere((p) => p.comprado));
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScreen(
      seedColor: AppPalette.listaCompras,
      builder: (context) => _buildContenido(context),
    );
  }

  Widget _buildContenido(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de compras')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      labelText: 'Nuevo producto',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _agregarProducto(),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _agregarProducto,
                  child: const Text('Agregar'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pendientes: $_pendientes',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: _productos.any((p) => p.comprado)
                      ? _eliminarComprados
                      : null,
                  icon: const Icon(Icons.delete_sweep_outlined),
                  label: const Text('Quitar comprados'),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _productos.isEmpty
                ? const Center(child: Text('No hay productos en la lista'))
                : ListView.builder(
                    itemCount: _productos.length,
                    itemBuilder: (context, index) {
                      final producto = _productos[index];
                      return CheckboxListTile(
                        value: producto.comprado,
                        onChanged: (v) => setState(
                          () => producto.comprado = v ?? false,
                        ),
                        title: Text(
                          producto.nombre,
                          style: TextStyle(
                            decoration: producto.comprado
                                ? TextDecoration.lineThrough
                                : null,
                            color: producto.comprado ? Colors.grey : null,
                          ),
                        ),
                        secondary: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => _eliminarProducto(index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
