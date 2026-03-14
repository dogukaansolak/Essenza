import 'package:flutter/material.dart';
import '../data/cart_manager.dart';
import '../models/perfume.dart';
import '../widgets/empty_cart_view.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartManager cartManager = CartManager.instance;

  @override
  void initState() {
    super.initState();
    cartManager.addListener(_refresh);
  }

  @override
  void dispose() {
    cartManager.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Perfume> cartItems = cartManager.items;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5F2),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? const EmptyCartView()
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final perfume = cartItems[index];

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset(
                                perfume.image,
                                width: 72,
                                height: 72,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 72,
                                    height: 72,
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.image_not_supported),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    perfume.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    perfume.brand,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "\$${perfume.price.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cartManager.removeFromCart(perfume);
                              },
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "\$${cartManager.totalPrice.toStringAsFixed(0)}",
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8E6E53),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                 MaterialPageRoute(
                                    builder: (_) => const CheckoutScreen(),
                               ),
                              );
                              },
                            child: const Text(
                              'Proceed to Checkout',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}