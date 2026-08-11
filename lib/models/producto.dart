import 'package:flutter/material.dart';

class Producto {
  final String nombre;
  final double precio;
  final String descripcion;
  final IconData icono;
  final String categoria;
  final String imagenUrl;

  const Producto({
    required this.nombre,
    required this.precio,
    required this.descripcion,
    required this.icono,
    required this.categoria,
    required this.imagenUrl,
  });
}

final List<Producto> productosDemo = [
  const Producto(
    nombre: 'Computadora portátil',
    precio: 45999.00,
    descripcion:
        'Laptop de 15" con procesador de última generación, ideal para '
        'trabajo y estudio.',
    icono: Icons.laptop_mac,
    categoria: 'Computadoras',
    imagenUrl:
        'https://images.unsplash.com/photo-1676272682018-b1435bad1cf0?fm=jpg&q=80&w=600&auto=format&fit=crop',
  ),
  const Producto(
    nombre: 'Teléfono móvil',
    precio: 22999.00,
    descripcion:
        'Smartphone con pantalla AMOLED, cámara triple y batería de larga '
        'duración.',
    icono: Icons.smartphone,
    categoria: 'Móviles',
    imagenUrl:
        'https://images.unsplash.com/photo-1601784551446-20c9e07cdbdb?fm=jpg&q=80&w=600&auto=format&fit=crop',
  ),
  const Producto(
    nombre: 'Audífonos',
    precio: 3499.00,
    descripcion:
        'Audífonos inalámbricos con cancelación de ruido activa y estuche '
        'de carga.',
    icono: Icons.headphones,
    categoria: 'Accesorios',
    imagenUrl:
        'https://images.unsplash.com/photo-1599669454699-248893623440?fm=jpg&q=80&w=600&auto=format&fit=crop',
  ),
  const Producto(
    nombre: 'Teclado mecánico',
    precio: 2799.00,
    descripcion: 'Teclado mecánico retroiluminado, ideal para gaming y trabajo.',
    icono: Icons.keyboard,
    categoria: 'Accesorios',
    imagenUrl:
        'https://images.unsplash.com/photo-1566748861876-c7e74c17eb5a?fm=jpg&q=80&w=600&auto=format&fit=crop',
  ),
  const Producto(
    nombre: 'Reloj inteligente',
    precio: 8999.00,
    descripcion:
        'Smartwatch con monitor de ritmo cardíaco, GPS y resistencia al agua.',
    icono: Icons.watch,
    categoria: 'Wearables',
    imagenUrl:
        'https://images.unsplash.com/photo-1777496410128-926b2d0083f9?fm=jpg&q=80&w=600&auto=format&fit=crop',
  ),
];
