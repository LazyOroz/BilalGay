import 'package:flutter/material.dart';
import 'add_product_screen.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({super.key});

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  List<Map<String, String>> products = [];

  void _addProduct(Map<String, String> product) {
    setState(() {
      products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Кабинет продавца", style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            products.isEmpty
                ? Center(child: Text("Нет добавленных товаров"))
                : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    final product = products[index];
                    return Card(
                      child: ListTile(
                        title: Text(product['name']!),
                        subtitle: Text(product['desc']!),
                        trailing: Text(product['price']!),
                      ),
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          final newProduct = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(builder: (_) => AddProductScreen()),
          );
          if (newProduct != null) {
            _addProduct(newProduct);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
