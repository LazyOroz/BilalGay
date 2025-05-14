import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Корзина пока пуста 🛒", style: TextStyle(fontSize: 18)),
    );
  }
}
