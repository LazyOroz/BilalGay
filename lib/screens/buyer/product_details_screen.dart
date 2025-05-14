// lib/screens/buyer/product_details_screen.dart
import 'package:flutter/material.dart';
import 'order_details_screen.dart'; // Импортируем экран деталей заказа

class ProductDetailsScreen extends StatelessWidget {
  final String title;
  final String description;
  final String price;

  const ProductDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение товара
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.green[100],
              child: Center(
                child: Icon(Icons.shopping_bag, size: 80, color: Colors.green),
              ),
            ),
            SizedBox(height: 20),
            // Название товара
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            // Описание товара
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 12),
            // Цена товара
            Text(
              "Цена: $price",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 24),
            // Кнопка "Заказать"
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => OrderDetailsScreen(title: title, price: price),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Заказать', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
