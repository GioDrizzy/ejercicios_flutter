import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CalculadoraPropinasScreen extends StatefulWidget {
  const CalculadoraPropinasScreen({super.key});

  @override
  State<CalculadoraPropinasScreen> createState() =>
      _CalculadoraPropinasScreenState();
}

class _CalculadoraPropinasScreenState
    extends State<CalculadoraPropinasScreen> {
  final _montoController = TextEditingController();
  int _porcentajeSeleccionado = 10;

  double? _valorPropina;
  double? _total;
  String? _error;

  final List<int> _porcentajes = const [5, 10, 15, 20];

  @override
  void dispose() {
    _montoController.dispose();
    super.dispose();
  }

  void _calcular() {
    final monto = double.tryParse(_montoController.text.trim());

    if (monto == null || monto <= 0) {
      setState(() {
        _error = 'El monto de la cuenta debe ser mayor que cero.';
        _valorPropina = null;
        _total = null;
      });
      return;
    }

    final propina = monto * (_porcentajeSeleccionado / 100);
    setState(() {
      _error = null;
      _valorPropina = propina;
      _total = monto + propina;
    });
  }

  void _reiniciar() {
    _montoController.clear();
    setState(() {
      _porcentajeSeleccionado = 10;
      _valorPropina = null;
      _total = null;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScreen(
      seedColor: AppPalette.calculadoraPropinas,
      builder: (context) => _buildContenido(context),
    );
  }

  Widget _buildContenido(BuildContext context) {
    final colorPrimario = Theme.of(context).colorScheme.primary;
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de propinas')),
      body: ResponsiveFormBody(
        child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _montoController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Monto de la cuenta (RD\$)',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Porcentaje de propina',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              initialValue: _porcentajeSeleccionado,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: _porcentajes
                  .map((p) => DropdownMenuItem(value: p, child: Text('$p %')))
                  .toList(),
              onChanged: (valor) {
                if (valor != null) {
                  setState(() => _porcentajeSeleccionado = valor);
                }
              },
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calcular,
                    child: const Text('Calcular'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _reiniciar,
                    child: const Text('Reiniciar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            if (_valorPropina != null && _total != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _FilaResultado(
                        titulo: 'Valor de la propina',
                        valor: 'RD\$${_valorPropina!.toStringAsFixed(2)}',
                      ),
                      const Divider(),
                      _FilaResultado(
                        titulo: 'Total a pagar',
                        valor: 'RD\$${_total!.toStringAsFixed(2)}',
                        destacado: true,
                        colorDestacado: colorPrimario,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        ),
      ),
    );
  }
}

class _FilaResultado extends StatelessWidget {
  final String titulo;
  final String valor;
  final bool destacado;
  final Color? colorDestacado;

  const _FilaResultado({
    required this.titulo,
    required this.valor,
    this.destacado = false,
    this.colorDestacado,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titulo, style: const TextStyle(fontSize: 16)),
        Text(
          valor,
          style: TextStyle(
            fontSize: destacado ? 22 : 18,
            fontWeight: FontWeight.bold,
            color: destacado ? colorDestacado : Colors.black87,
          ),
        ),
      ],
    );
  }
}
