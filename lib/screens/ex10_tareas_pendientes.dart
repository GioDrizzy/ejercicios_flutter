import 'package:flutter/material.dart';

import '../models/tarea.dart';
import '../theme/app_theme.dart';

class TareasPendientesScreen extends StatefulWidget {
  const TareasPendientesScreen({super.key});

  @override
  State<TareasPendientesScreen> createState() =>
      _TareasPendientesScreenState();
}

class _TareasPendientesScreenState extends State<TareasPendientesScreen> {
  final List<Tarea> _tareas = [];

  int get _completadas => _tareas.where((t) => t.completada).length;
  int get _pendientes => _tareas.length - _completadas;

  Future<void> _abrirFormulario({Tarea? tareaExistente, int? index}) async {
    final resultado = await Navigator.of(context).push<Tarea>(
      MaterialPageRoute(
        builder: (_) => _FormularioTareaScreen(tarea: tareaExistente),
      ),
    );

    if (resultado == null) return;

    setState(() {
      if (index != null) {
        _tareas[index] = resultado;
      } else {
        _tareas.add(resultado);
      }
    });
  }

  Future<void> _eliminarTarea(int index) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar tarea'),
        content: Text('¿Eliminar "${_tareas[index].titulo}"?'),
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
      setState(() => _tareas.removeAt(index));
    }
  }

  Color _colorPrioridad(Prioridad p) {
    switch (p) {
      case Prioridad.alta:
        return Colors.red;
      case Prioridad.media:
        return Colors.orange;
      case Prioridad.baja:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScreen(
      seedColor: AppPalette.tareasPendientes,
      builder: (context) => _buildContenido(context),
    );
  }

  Widget _buildContenido(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Tareas pendientes')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Resumen(titulo: 'Total', valor: _tareas.length),
                _Resumen(titulo: 'Pendientes', valor: _pendientes),
                _Resumen(titulo: 'Completadas', valor: _completadas),
              ],
            ),
          ),
          Expanded(
            child: _tareas.isEmpty
                ? const Center(child: Text('No tienes tareas registradas'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _tareas.length,
                    itemBuilder: (context, index) {
                      final tarea = _tareas[index];
                      return Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: tarea.completada,
                            onChanged: (v) => setState(
                              () => tarea.completada = v ?? false,
                            ),
                          ),
                          title: Text(
                            tarea.titulo,
                            style: TextStyle(
                              decoration: tarea.completada
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: tarea.completada ? Colors.grey : null,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'Vence: ${tarea.fechaLimite.day}/${tarea.fechaLimite.month}/${tarea.fechaLimite.year}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Chip(
                                label: Text(
                                  tarea.prioridad.etiqueta,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                backgroundColor:
                                    _colorPrioridad(tarea.prioridad),
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                onPressed: () => _abrirFormulario(
                                  tareaExistente: tarea,
                                  index: index,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => _eliminarTarea(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _Resumen extends StatelessWidget {
  final String titulo;
  final int valor;

  const _Resumen({required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$valor',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(titulo, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _FormularioTareaScreen extends StatefulWidget {
  final Tarea? tarea;

  const _FormularioTareaScreen({this.tarea});

  @override
  State<_FormularioTareaScreen> createState() =>
      _FormularioTareaScreenState();
}

class _FormularioTareaScreenState extends State<_FormularioTareaScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _descripcionController;
  DateTime? _fechaLimite;
  Prioridad _prioridad = Prioridad.media;

  @override
  void initState() {
    super.initState();
    final tarea = widget.tarea;
    _tituloController = TextEditingController(text: tarea?.titulo ?? '');
    _descripcionController =
        TextEditingController(text: tarea?.descripcion ?? '');
    _fechaLimite = tarea?.fechaLimite;
    _prioridad = tarea?.prioridad ?? Prioridad.media;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaLimite ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    );
    if (fecha != null) {
      setState(() => _fechaLimite = fecha);
    }
  }

  void _guardar() {
    final formValido = _formKey.currentState?.validate() ?? false;
    if (!formValido || _fechaLimite == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El título y la fecha límite son obligatorios.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final tarea = Tarea(
      titulo: _tituloController.text.trim(),
      descripcion: _descripcionController.text.trim(),
      fechaLimite: _fechaLimite!,
      prioridad: _prioridad,
      completada: widget.tarea?.completada ?? false,
    );

    Navigator.pop(context, tarea);
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.tarea != null;

    return Scaffold(
      appBar: AppBar(title: Text(esEdicion ? 'Editar tarea' : 'Nueva tarea')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _descripcionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 14),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                _fechaLimite == null
                    ? 'Selecciona la fecha límite'
                    : 'Fecha límite: ${_fechaLimite!.day}/${_fechaLimite!.month}/${_fechaLimite!.year}',
              ),
              trailing: const Icon(Icons.calendar_month_outlined),
              onTap: _seleccionarFecha,
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<Prioridad>(
              initialValue: _prioridad,
              decoration: const InputDecoration(
                labelText: 'Prioridad',
                border: OutlineInputBorder(),
              ),
              items: Prioridad.values
                  .map((p) => DropdownMenuItem(
                        value: p,
                        child: Text(p.etiqueta),
                      ))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _prioridad = v);
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _guardar,
              child: Text(esEdicion ? 'Guardar cambios' : 'Agregar tarea'),
            ),
          ],
        ),
      ),
    );
  }
}
