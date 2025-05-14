import 'package:flutter/material.dart';
import 'product_details_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomePageContent(),
    CartScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text("ФермаМаркет", style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            "Категории",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryCard(
                  "Овощи",
                  "assets/images/vegetables.jpg",
                  () {},
                ),
                _buildCategoryCard("Фрукты", "assets/images/fruits.jpg", () {}),
                _buildCategoryCard(
                  "Молочные продукты",
                  "assets/images/milk.jpg",
                  () {},
                ),
                _buildCategoryCard(
                  "Ремесленные товары",
                  "assets/images/handmade.jpg",
                  () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Фермерские товары",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildProductCard(
            "Мёд натуральный",
            "1 кг",
            "₽500",
            "Натуральный мёд с пасеки.",
            "assets/images/honey.jpg",
            context,
          ),
          _buildProductCard(
            "Яблоки свежие",
            "5 кг",
            "₽600",
            "Свежие яблоки с фермы.",
            "assets/images/apples.jpg",
            context,
          ),
          const SizedBox(height: 24),
          const Text(
            "Ремесленные товары",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildProductCard(
            "Глиняная кружка",
            "1 шт",
            "₽300",
            "Ручная работа, глиняная кружка.",
            "assets/images/clay_mug.jpg",
            context,
          ),
          _buildProductCard(
            "Вязаные носки",
            "1 пара",
            "₽150",
            "Теплые вязаные носки для зимы.",
            "assets/images/knitted_socks.jpg",
            context,
          ),
        ],
      ),
    );
  }

  static Widget _buildCategoryCard(
    String title,
    String imagePath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  static Widget _buildProductCard(
    String title,
    String subtitle,
    String price,
    String description,
    String imagePath,
    BuildContext context,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(
          price,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => ProductDetailsScreen(
                    title: title,
                    description: description,
                    price: price,
                  ),
            ),
          );
        },
      ),
    );
  }
}
