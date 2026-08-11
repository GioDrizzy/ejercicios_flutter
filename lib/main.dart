import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/ex1_tarjeta_presentacion.dart';
import 'screens/ex2_contador_personas.dart';
import 'screens/ex3_calculadora_edad.dart';
import 'screens/ex4_calculadora_propinas.dart';
import 'screens/ex5_conversor_temperatura.dart';
import 'screens/ex6_semaforo.dart';
import 'screens/ex7_formulario_estudiante.dart';
import 'screens/ex8_lista_compras.dart';
import 'screens/ex9_catalogo_productos.dart';
import 'screens/ex10_tareas_pendientes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleModoOscuro(bool activarOscuro) {
    setState(() {
      _themeMode = activarOscuro ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicios Flutter',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(Brightness.light),
      darkTheme: buildAppTheme(Brightness.dark),
      themeMode: _themeMode,
      home: MenuScreen(
        modoOscuroActivo: _themeMode == ThemeMode.dark,
        onCambiarModoOscuro: _toggleModoOscuro,
      ),
    );
  }
}

class _Ejercicio {
  final String titulo;
  final String subtitulo;
  final IconData icono;
  final Color color;
  final WidgetBuilder builder;

  const _Ejercicio({
    required this.titulo,
    required this.subtitulo,
    required this.icono,
    required this.color,
    required this.builder,
  });
}

class MenuScreen extends StatelessWidget {
  final bool modoOscuroActivo;
  final ValueChanged<bool> onCambiarModoOscuro;

  const MenuScreen({
    super.key,
    required this.modoOscuroActivo,
    required this.onCambiarModoOscuro,
  });

  @override
  Widget build(BuildContext context) {
    final ejercicios = <_Ejercicio>[
      _Ejercicio(
        titulo: '1. Tarjeta de presentación',
        subtitulo: 'Perfil personal con foto y contacto',
        icono: Icons.badge_outlined,
        color: AppPalette.tarjetaPresentacion,
        builder: (_) => const TarjetaPresentacionScreen(),
      ),
      _Ejercicio(
        titulo: '2. Contador de personas',
        subtitulo: 'Conteo de entradas y salidas',
        icono: Icons.people_outline,
        color: AppPalette.contadorPersonas,
        builder: (_) => const ContadorPersonasScreen(),
      ),
      _Ejercicio(
        titulo: '3. Calculadora de edad',
        subtitulo: 'Edad aproximada por año de nacimiento',
        icono: Icons.cake_outlined,
        color: AppPalette.calculadoraEdad,
        builder: (_) => const CalculadoraEdadScreen(),
      ),
      _Ejercicio(
        titulo: '4. Calculadora de propinas',
        subtitulo: 'Propina y total de la cuenta',
        icono: Icons.receipt_long_outlined,
        color: AppPalette.calculadoraPropinas,
        builder: (_) => const CalculadoraPropinasScreen(),
      ),
      _Ejercicio(
        titulo: '5. Conversor de temperatura',
        subtitulo: 'Celsius ↔ Fahrenheit',
        icono: Icons.thermostat_outlined,
        color: AppPalette.conversorTemperatura,
        builder: (_) => const ConversorTemperaturaScreen(),
      ),
      _Ejercicio(
        titulo: '6. Semáforo interactivo',
        subtitulo: 'Simulación de luces de tránsito',
        icono: Icons.traffic_outlined,
        color: AppPalette.semaforo,
        builder: (_) => const SemaforoScreen(),
      ),
      _Ejercicio(
        titulo: '7. Registro de estudiante',
        subtitulo: 'Formulario con validaciones',
        icono: Icons.school_outlined,
        color: AppPalette.formularioEstudiante,
        builder: (_) => const FormularioEstudianteScreen(),
      ),
      _Ejercicio(
        titulo: '8. Lista de compras',
        subtitulo: 'Productos pendientes y comprados',
        icono: Icons.shopping_cart_outlined,
        color: AppPalette.listaCompras,
        builder: (_) => const ListaComprasScreen(),
      ),
      _Ejercicio(
        titulo: '9. Catálogo de productos',
        subtitulo: 'Tarjetas con detalle de producto',
        icono: Icons.storefront_outlined,
        color: AppPalette.catalogoProductos,
        builder: (_) => const CatalogoProductosScreen(),
      ),
      _Ejercicio(
        titulo: '10. Tareas pendientes',
        subtitulo: 'Gestión de tareas con prioridad',
        icono: Icons.checklist_outlined,
        color: AppPalette.tareasPendientes,
        builder: (_) => const TareasPendientesScreen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicios Flutter'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(
                  modoOscuroActivo
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  size: 20,
                ),
                Switch(
                  value: modoOscuroActivo,
                  onChanged: onCambiarModoOscuro,
                ),
              ],
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columnas = responsiveGridColumns(constraints.maxWidth);
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola 👋',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Elige un ejercicio para practicar',
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columnas,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: 0.92,
                        ),
                        itemCount: ejercicios.length,
                        itemBuilder: (context, index) {
                          return _EjercicioCard(ejercicio: ejercicios[index]);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EjercicioCard extends StatelessWidget {
  final _Ejercicio ejercicio;

  const _EjercicioCard({required this.ejercicio});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fondoIcono = ejercicio.color.withValues(alpha: isDark ? 0.28 : 0.12);

    return Material(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: ejercicio.builder),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: fondoIcono,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(ejercicio.icono, color: ejercicio.color, size: 24),
              ),
              const Spacer(),
              Text(
                ejercicio.titulo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                ejercicio.subtitulo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
