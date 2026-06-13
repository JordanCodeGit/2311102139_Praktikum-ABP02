// lib/cubit/cart_state.dart

import 'package:equatable/equatable.dart';
import '../models/product.dart';

class CartState extends Equatable {
  final Map<Product, int> items; // Product -> quantity

  const CartState({required this.items});

  // State awal: keranjang kosong
  factory CartState.initial() => const CartState(items: {});

  // Total jumlah item (sum of all quantities)
  int get totalItems => items.values.fold(0, (sum, qty) => sum + qty);

  // Total harga semua item
  double get totalPrice => items.entries.fold(
        0,
        (sum, entry) => sum + (entry.key.price * entry.value),
      );

  // Cek apakah produk sudah ada di keranjang
  bool containsProduct(Product product) => items.containsKey(product);

  // Ambil quantity produk tertentu
  int quantityOf(Product product) => items[product] ?? 0;

  // Buat salinan state baru dengan items yang diperbarui
  CartState copyWith({Map<Product, int>? items}) {
    return CartState(items: items ?? this.items);
  }

  @override
  List<Object?> get props => [items];
}