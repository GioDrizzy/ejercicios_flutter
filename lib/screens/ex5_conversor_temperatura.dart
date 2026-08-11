import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum _TipoConversion { celsiusAFahrenheit, fahrenheitACelsius }

class ConversorTemperaturaScreen extends StatefulWidget {
  const ConversorTemperaturaScreen({super.key});

  @override
  State<ConversorTemperaturaScreen> createState() =>
      _ConversorTemperaturaScreenState();
}

class _ConversorTemperaturaScreenState
    extends State<ConversorTemperaturaScreen> {
  final _temperaturaController = TextEditingController();
  _TipoConversion _tipo = _TipoConversion.celsiusAFahrenheit;

  double? _resultado;
  String? _error;

  @override
  void dispose() {
    _temperaturaController.dispose();
    super.dispose();
  }

  void _cambiarTipo(_TipoConversion? nuevo) {
    if (nuevo == null) return;
    setState(() {
      _tipo = nuevo;
      _resultado = null;
      _error = null;
    });
  }

  void _convertir() {
    final valor = double.tryParse(_temperaturaController.text.trim());
    if (valor == null) {
      setState(() {
        _error = 'Introduce un número válido.';
        _resultado = null;
      });
      return;
    }

    double resultado;
    if (_tipo == _TipoConversion.celsiusAFahrenheit) {
      resultado = (valor * 9 / 5) + 32;
    } else {
      resultado = (valor - 32) * 5 / 9;
    }

    setState(() {
      _error = null;
      _resultado = resultado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemedScreen(
      seedColor: AppPalette.conversorTemperatura,
      builder: (context) => _buildContenido(context),
    );
  }

  Widget _buildContenido(BuildContext context) {
    final unidadResultado =
        _tipo == _TipoConversion.celsiusAFahrenheit ? '°F' : '°C';
    final colorPrimario = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Conversor de temperatura')),
      body: ResponsiveFormBody(
        child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _temperaturaController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Temperatura',
                prefixIcon: Icon(Icons.thermostat_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            RadioListTile<_TipoConversion>(
              title: const Text('Celsius a Fahrenheit'),
              value: _TipoConversion.celsiusAFahrenheit,
              groupValue: _tipo,
              onChanged: _cambiarTipo,
            ),
            RadioListTile<_TipoConversion>(
              title: const Text('Fahrenheit a Celsius'),
              value: _TipoConversion.fahrenheitACelsius,
              groupValue: _tipo,
              onChanged: _cambiarTipo,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _convertir,
              child: const Text('Convertir'),
            ),
            const SizedBox(height: 24),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            if (_resultado != null)
              Center(
                child: Text(
                  '${_resultado!.toStringAsFixed(2)} $unidadResultado',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: colorPrimario,
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
