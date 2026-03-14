import 'package:flutter/material.dart';
import '../models/perfume.dart';
import '../data/cart_manager.dart';
import '../data/favorites_manager.dart';
import 'cart_screen.dart';
import '../widgets/image_placeholder.dart';

class PerfumeDetailScreen extends StatefulWidget {
  final Perfume perfume;

  const PerfumeDetailScreen({super.key, required this.perfume});

  @override
  State<PerfumeDetailScreen> createState() => _PerfumeDetailScreenState();
}

class _PerfumeDetailScreenState extends State<PerfumeDetailScreen> {
  final FavoritesManager favoritesManager = FavoritesManager.instance;

  @override
  void initState() {
    super.initState();
    favoritesManager.addListener(_refresh);
  }

  @override
  void dispose() {
    favoritesManager.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final perfume = widget.perfume;
    final isFavorite = favoritesManager.isFavorite(perfume);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 360,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(32),
                            ),
                          ),
                          child: Hero(
                            tag:
                                'perfume-image-${perfume.name}-${perfume.brand}',
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(32),
                              ),
                              child: Image.asset(
                                perfume.image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const ImagePlaceholder(
                                    borderRadius: 0,
                                    icon: Icons.local_mall_rounded,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.92,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.92,
                            ),
                            child: IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: isFavorite
                                    ? Colors.redAccent
                                    : Colors.black87,
                              ),
                              onPressed: () {
                                favoritesManager.toggleFavorite(perfume);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            perfume.brand,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            perfume.name,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              height: 1.15,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8E6E53),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  perfume.category,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "\$${perfume.price.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  perfume.description,
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 1.7,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 18),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fragrance Notes',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 14),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    _NoteChip(label: 'Bergamot'),
                                    _NoteChip(label: 'Vanilla'),
                                    _NoteChip(label: 'Amber'),
                                    _NoteChip(label: 'Woody'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8E6E53),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      CartManager.instance.addToCart(perfume);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${perfume.name} sepete eklendi'),
                          behavior: SnackBarBehavior.floating,
                          action: SnackBarAction(
                            label: 'Go to Cart',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CartScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteChip extends StatelessWidget {
  final String label;

  const _NoteChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF3ECE6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFF6B4F3A),
        ),
      ),
    );
  }
}
