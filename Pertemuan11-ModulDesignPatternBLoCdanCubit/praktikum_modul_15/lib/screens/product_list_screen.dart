// lib/screens/product_list_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cart_cubit.dart';
import '../cubit/cart_state.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String _selectedCategory = 'Semua';

  List<String> get _categories => [
        'Semua',
        ...dummyProducts.map((p) => p.category).toSet().toList()..sort(),
      ];

  List<Product> get _filteredProducts {
    if (_selectedCategory == 'Semua') return dummyProducts;
    return dummyProducts
        .where((p) => p.category == _selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('JordanShop 🛍️',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Pick your choice with our referral code 2311102139 ✨', style: TextStyle(fontSize: 11)),
          ],
        ),
        actions: [
          // ===================================================
          // BlocBuilder: Menampilkan jumlah item keranjang
          // secara real-time setiap kali state berubah
          // ===================================================
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const CartScreen()),
                  ),
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.shopping_cart_outlined, size: 28),
                      if (state.totalItems > 0)
                        Positioned(
                          top: -6,
                          right: -6,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.elasticOut,
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                state.totalItems > 99
                                    ? '99+'
                                    : '${state.totalItems}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ===================================================
          // Panel info state keranjang (real-time)
          // ===================================================
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: state.items.isEmpty ? 0 : 56,
                child: state.items.isEmpty
                    ? const SizedBox()
                    : _CartInfoStrip(state: state),
              );
            },
          ),

          // Filter kategori
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _categories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final selected = cat == _selectedCategory;
                return FilterChip(
                  label: Text(cat),
                  selected: selected,
                  onSelected: (_) => setState(() => _selectedCategory = cat),
                  showCheckmark: false,
                );
              },
            ),
          ),

          // Daftar produk
          Expanded(
            child: _filteredProducts.isEmpty
                ? const Center(
                    child: Text('Tidak ada produk dalam kategori ini'))
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) => ProductCard(
                      product: _filteredProducts[index],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// Strip info ringkasan keranjang di atas daftar produk
class _CartInfoStrip extends StatelessWidget {
  final CartState state;
  const _CartInfoStrip({required this.state});

  String _formatPrice(double price) {
    final formatted = price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]}.',
        );
    return 'Rp $formatted';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.shopping_bag_outlined, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '${state.totalItems} item dipilih · ${_formatPrice(state.totalPrice)}',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            ),
            child: const Text('Lihat Keranjang →'),
          ),
        ],
      ),
    );
  }
}