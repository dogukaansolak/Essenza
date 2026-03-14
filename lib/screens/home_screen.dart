import 'package:flutter/material.dart';
import '../models/perfume.dart';
import '../services/perfume_service.dart';
import '../widgets/perfume_card.dart';
import '../widgets/app_search_bar.dart';
import 'perfume_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Perfume>> futurePerfumes;
  List<Perfume> allPerfumes = [];
  List<Perfume> filteredPerfumes = [];

  String searchQuery = '';
  String selectedCategory = 'All';

  final List<String> categories = ['All', 'Men', 'Women', 'Unisex'];

  @override
  void initState() {
    super.initState();
    futurePerfumes = PerfumeService.loadPerfumes();
    _loadPerfumes();
  }

  Future<void> _loadPerfumes() async {
    final perfumes = await PerfumeService.loadPerfumes();
    setState(() {
      allPerfumes = perfumes;
      filteredPerfumes = perfumes;
    });
  }

  void _applyFilters() {
    setState(() {
      filteredPerfumes = allPerfumes.where((perfume) {
        final query = searchQuery.toLowerCase();

        final matchesSearch =
            perfume.name.toLowerCase().contains(query) ||
            perfume.brand.toLowerCase().contains(query) ||
            perfume.category.toLowerCase().contains(query);

        final matchesCategory = selectedCategory == 'All'
            ? true
            : perfume.category.toLowerCase() == selectedCategory.toLowerCase();

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _filterPerfumes(String query) {
    searchQuery = query;
    _applyFilters();
  }

  void _selectCategory(String category) {
    selectedCategory = category;
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFF8F5F2),
        title: const Text(
          'Essenza',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
      ),
      body: FutureBuilder<List<Perfume>>(
        future: futurePerfumes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              allPerfumes.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError && allPerfumes.isEmpty) {
            return Center(
              child: Text('Bir hata oluştu: ${snapshot.error}'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF8E6E53),
                        Color(0xFFB89574),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discover Luxury Fragrances',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Find your perfect scent from our elegant perfume collection.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AppSearchBar(
                  onChanged: _filterPerfumes,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      final isSelected = selectedCategory == category;

                      return GestureDetector(
                        onTap: () => _selectCategory(category),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF8E6E53)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF8E6E53)
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Featured Fragrances',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '${filteredPerfumes.length} items',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: filteredPerfumes.isEmpty
                      ? SizedBox(
                          key: const ValueKey('empty-state'),
                          height: 300,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off_rounded,
                                  size: 52,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Aradığın kriterde parfüm bulunamadı.',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      : GridView.builder(
                          key: ValueKey(
                            '${filteredPerfumes.length}-$selectedCategory-$searchQuery',
                          ),
                          itemCount: filteredPerfumes.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 0.68,
                          ),
                          itemBuilder: (context, index) {
                            final perfume = filteredPerfumes[index];

                            return PerfumeCard(
                              perfume: perfume,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PerfumeDetailScreen(
                                      perfume: perfume,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}