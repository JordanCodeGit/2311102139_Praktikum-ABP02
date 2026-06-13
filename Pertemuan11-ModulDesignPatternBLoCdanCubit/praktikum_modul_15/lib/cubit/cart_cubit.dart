// lib/cubit/cart_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  // Tambah produk ke keranjang (increment quantity jika sudah ada)
  void addProduct(Product product) {
    final updatedItems = Map<Product, int>.from(state.items);
    updatedItems[product] = (updatedItems[product] ?? 0) + 1;
    emit(state.copyWith(items: updatedItems));
  }

  // Kurangi quantity, hapus jika quantity menjadi 0
  void removeProduct(Product product) {
    final updatedItems = Map<Product, int>.from(state.items);
    if (!updatedItems.containsKey(product)) return;

    if (updatedItems[product]! <= 1) {
      updatedItems.remove(product);
    } else {
      updatedItems[product] = updatedItems[product]! - 1;
    }

    emit(state.copyWith(items: updatedItems));
  }

  // Hapus produk sepenuhnya dari keranjang
  void deleteProduct(Product product) {
    final updatedItems = Map<Product, int>.from(state.items);
    updatedItems.remove(product);
    emit(state.copyWith(items: updatedItems));
  }

  // Kosongkan seluruh keranjang
  void clearCart() {
    emit(CartState.initial());
  }
}