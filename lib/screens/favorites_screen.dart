import 'package:flutter/material.dart';
import '../data/favorites_manager.dart';
import '../models/perfume.dart';
import '../widgets/perfume_card.dart';
import 'perfume_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Perfume> favorites = favoritesManager.items;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5F2),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border_rounded,
                      size: 72,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'No favorites yet',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Save the fragrances you love and find them here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                itemCount: favorites.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) {
                  final perfume = favorites[index];

                  return PerfumeCard(
                    perfume: perfume,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PerfumeDetailScreen(perfume: perfume),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}