import 'package:flutter/material.dart';
import '../data/cart_manager.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartManager = CartManager.instance;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5F2),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [

                  Row(
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 18),
                      ),
                      const Spacer(),
                      Text(
                        "\$${cartManager.totalPrice.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  const Divider(),

                  const SizedBox(height: 18),

                  const Row(
                    children: [
                      Icon(Icons.credit_card),
                      SizedBox(width: 10),
                      Text(
                        "Credit Card",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const Row(
                    children: [
                      Icon(Icons.local_shipping),
                      SizedBox(width: 10),
                      Text(
                        "Standard Delivery",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E6E53),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {

                  cartManager.clearCart();

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Order Complete"),
                      content: const Text("Your order has been placed successfully."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        )
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}