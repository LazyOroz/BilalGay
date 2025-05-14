// lib/screens/buyer/order_details_screen.dart
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String title;
  final String price;

  const OrderDetailsScreen({
    super.key,
    required this.title,
    required this.price,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int quantity = 1;
  String address = '';
  DateTime deliveryDate = DateTime.now().add(Duration(days: 2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Детали заказа"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Название товара
              Text(
                widget.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              // Цена товара
              Text(
                "Цена: ${widget.price}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 24),

              // Количество товара
              Row(
                children: [
                  Text("Количество: ", style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                  ),
                  Text("$quantity", style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Адрес доставки
              TextField(
                decoration: InputDecoration(
                  labelText: 'Адрес доставки',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              SizedBox(height: 12),

              // Дата доставки
              ListTile(
                title: Text(
                  "Дата доставки: ${deliveryDate.toLocal()}".split(' ')[0],
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: deliveryDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2025),
                  );
                  if (selectedDate != null && selectedDate != deliveryDate) {
                    setState(() {
                      deliveryDate = selectedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 24),

              // Кнопка оформления заказа
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  // Логика оформления заказа
                  // Например, покажем сообщение о подтверждении заказа
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: Text("Заказ подтвержден"),
                          content: Text(
                            "Вы успешно оформили заказ! \n\nТовар: ${widget.title} \nКоличество: $quantity \nАдрес доставки: $address \nДата доставки: ${deliveryDate.toLocal()}"
                                .split(' ')[0],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(
                                  context,
                                ); // Возвращаемся на главную страницу покупателя
                              },
                              child: Text("Ок"),
                            ),
                          ],
                        ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Оформить заказ', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
