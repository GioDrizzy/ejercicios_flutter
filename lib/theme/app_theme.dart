import 'package:flutter/material.dart';

/// Color base de la app: "Índigo nocturno".
class AppPalette {
  AppPalette._();

  static const Color base = Color(0xFF3F4B8C);

  // Variaciones sutiles del índigo base para cada ejercicio.
  // Mismo tono general, pequeños corrimientos de matiz para que cada
  // pantalla se sienta ligeramente distinta sin ser llamativo.
  static const Color tarjetaPresentacion = Color(0xFF3F4B8C);
  static const Color contadorPersonas = Color(0xFF46508C);
  static const Color calculadoraEdad = Color(0xFF3F5789);
  static const Color calculadoraPropinas = Color(0xFF4A4A8C);
  static const Color conversorTemperatura = Color(0xFF3F4B99);
  static const Color semaforo = Color(0xFF4C4B7E);
  static const Color formularioEstudiante = Color(0xFF3F5C8C);
  static const Color listaCompras = Color(0xFF504A8C);
  static const Color catalogoProductos = Color(0xFF3F4B7A);
  static const Color tareasPendientes = Color(0xFF45508F);
}

ThemeData buildAppTheme(Brightness brightness, [Color seed = AppPalette.base]) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seed,
    brightness: brightness,
  );
  return ThemeData(
    colorScheme: colorScheme,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
  );
}

/// Ancho máximo que puede ocupar el contenido en pantallas grandes
/// (tablet/escritorio), para que no se estire de borde a borde.
const double kMaxContentWidth = 1100;

/// Cantidad de columnas de grilla según el ancho disponible, siguiendo
/// puntos de quiebre similares a los de Material Design:
/// teléfono (<600), tablet vertical (600-900), tablet horizontal /
/// escritorio pequeño (900-1200) y escritorio grande (>=1200).
int responsiveGridColumns(
  double width, {
  int telefono = 2,
  int tabletVertical = 3,
  int tabletHorizontal = 4,
  int escritorio = 5,
}) {
  if (width >= 1200) return escritorio;
  if (width >= 900) return tabletHorizontal;
  if (width >= 600) return tabletVertical;
  return telefono;
}

/// Envuelve una pantalla de ejercicio con su propia variante de color,
/// respetando el modo claro/oscuro activo globalmente en la app.
class ThemedScreen extends StatelessWidget {
  final Color seedColor;
  final WidgetBuilder builder;

  const ThemedScreen({
    super.key,
    required this.seedColor,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Theme(
      data: buildAppTheme(brightness, seedColor),
      child: Builder(builder: builder),
    );
  }
}

/// Centra el contenido de un formulario y le pone un ancho máximo, para
/// que en tablet/escritorio no se estire de borde a borde de la pantalla.
class ResponsiveFormBody extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveFormBody({
    super.key,
    required this.child,
    this.maxWidth = 520,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
