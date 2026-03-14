import 'package:flutter/material.dart';
import '../data/cart_manager.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';
import '../data/favorites_manager.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;
  final CartManager cartManager = CartManager.instance;
  final FavoritesManager favoritesManager = FavoritesManager.instance;
  final List<Widget> screens = const [
    HomeScreen(),
    FavoritesScreen(),
    CartScreen(),
    ProfilePlaceholderScreen(),
  ];

  @override
  void initState() {
    super.initState();
    cartManager.addListener(_refresh);
    favoritesManager.addListener(_refresh);
  }

  @override
  void dispose() {
  cartManager.removeListener(_refresh);
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
    final int cartCount = cartManager.itemCount;
    final int favoritesCount = favoritesManager.items.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      body: SafeArea(
        child: screens[currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        height: 74,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 6,
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: _FavoriteIconWithBadge(count: favoritesCount, isSelected: false),
            selectedIcon: _FavoriteIconWithBadge(count: favoritesCount, isSelected: true),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: _CartIconWithBadge(count: cartCount, isSelected: false),
            selectedIcon: _CartIconWithBadge(count: cartCount, isSelected: true),
            label: 'Cart',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _CartIconWithBadge extends StatelessWidget {
  final int count;
  final bool isSelected;

  const _CartIconWithBadge({
    required this.count,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          isSelected ? Icons.shopping_bag_rounded : Icons.shopping_bag_outlined,
        ),
        if (count > 0)
          Positioned(
            right: -8,
            top: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(999),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                count > 99 ? '99+' : '$count',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ProfilePlaceholderScreen extends StatelessWidget {
  const ProfilePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5F2),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline_rounded,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            const Text(
              'Profile screen coming soon',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _FavoriteIconWithBadge extends StatelessWidget {
  final int count;
  final bool isSelected;

  const _FavoriteIconWithBadge({
    required this.count,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          isSelected ? Icons.favorite_rounded : Icons.favorite_border_rounded,
        ),
        if (count > 0)
          Positioned(
            right: -8,
            top: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(999),
              ),
              constraints: const BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                count > 99 ? '99+' : '$count',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}