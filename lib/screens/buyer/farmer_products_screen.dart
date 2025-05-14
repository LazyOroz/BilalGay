// lib/screens/buyer/farmer_products_screen.dart
import 'package:flutter/material.dart';

class FarmerProductsScreen extends StatelessWidget {
  const FarmerProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Фермерские товары")),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildProductCard("Мёд натуральный", "1 кг", "₽500"),
          _buildProductCard("Яблоки свежие", "5 кг", "₽600"),
          // Добавить больше товаров
        ],
      ),
    );
  }

  Widget _buildProductCard(String title, String subtitle, String price) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.shopping_bag, color: Colors.green),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(
          price,
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
