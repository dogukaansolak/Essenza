import 'package:flutter/material.dart';
import '../data/favorites_manager.dart';
import '../models/perfume.dart';
import 'image_placeholder.dart';

class PerfumeCard extends StatefulWidget {
  final Perfume perfume;
  final VoidCallback? onTap;

  const PerfumeCard({super.key, required this.perfume, this.onTap});

  @override
  State<PerfumeCard> createState() => _PerfumeCardState();
}

class _PerfumeCardState extends State<PerfumeCard> {
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
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = favoritesManager.isFavorite(widget.perfume);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag:
                        'perfume-image-${widget.perfume.name}-${widget.perfume.brand}',
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(22),
                      ),
                      child: Image.asset(
                        widget.perfume.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const ImagePlaceholder(borderRadius: 0);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        favoritesManager.toggleFavorite(widget.perfume);
                      },
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          size: 18,
                          color: isFavorite ? Colors.redAccent : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8E6E53),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.perfume.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.perfume.brand,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.perfume.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "\$${widget.perfume.price.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8E6E53),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3ECE6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_rounded,
                          size: 16,
                          color: Color(0xFF6B4F3A),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
