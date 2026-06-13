// lib/models/product.dart

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String emoji;
  final String category;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.emoji,
    required this.category,
  });

  @override
  List<Object?> get props => [id];
}

// Daftar produk statis (minimal 5 produk)
final List<Product> dummyProducts = [
  const Product(
    id: 'p1',
    name: 'Laptop Gaming',
    description: 'Laptop bertenaga tinggi untuk gaming dan kreasi konten',
    price: 15000000,
    emoji: '💻',
    category: 'Elektronik',
  ),
  const Product(
    id: 'p2',
    name: 'Mechanical Keyboard',
    description: 'Keyboard mekanikal RGB dengan switch tactile',
    price: 850000,
    emoji: '⌨️',
    category: 'Aksesori',
  ),
  const Product(
    id: 'p3',
    name: 'Monitor 27"',
    description: 'Monitor IPS 144Hz resolusi QHD untuk produktivitas',
    price: 4500000,
    emoji: '🖥️',
    category: 'Elektronik',
  ),
  const Product(
    id: 'p4',
    name: 'Wireless Mouse',
    description: 'Mouse nirkabel ergonomis dengan baterai tahan lama',
    price: 350000,
    emoji: '🖱️',
    category: 'Aksesori',
  ),
  const Product(
    id: 'p5',
    name: 'Headphone Studio',
    description: 'Headphone over-ear dengan noise cancelling aktif',
    price: 2200000,
    emoji: '🎧',
    category: 'Audio',
  ),
  const Product(
    id: 'p6',
    name: 'Webcam HD',
    description: 'Kamera web 1080p untuk meeting dan streaming',
    price: 650000,
    emoji: '📷',
    category: 'Elektronik',
  ),
  const Product(
    id: 'p7',
    name: 'SSD Eksternal',
    description: 'Penyimpanan portabel 1TB dengan transfer ultra-cepat',
    price: 1100000,
    emoji: '💾',
    category: 'Penyimpanan',
  ),
  const Product(
    id: 'p8',
    name: 'USB-C Hub',
    description: 'Hub 7-in-1 dengan HDMI, USB, dan card reader',
    price: 420000,
    emoji: '🔌',
    category: 'Aksesori',
  ),
];