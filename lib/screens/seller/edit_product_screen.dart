import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;

  EditProductScreen({required this.productId});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Функция для загрузки данных о товаре
  Future<void> _loadProductData() async {
    try {
      final productDoc =
          await FirebaseFirestore.instance
              .collection('products')
              .doc(widget.productId)
              .get();

      // Если документ существует
      if (productDoc.exists) {
        final productData = productDoc.data() as Map<String, dynamic>;

        _nameController.text =
            productData['name'] ?? ''; // Если данных нет, пустое значение
        _priceController.text =
            productData['price']?.toString() ?? ''; // Преобразуем цену в строку
        _descriptionController.text =
            productData['description'] ??
            ''; // Если данных нет, пустое значение
      } else {
        // Если документ не найден
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Продукт не найден!')));
      }
    } catch (e) {
      // Обработка ошибок
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка при загрузке данных: $e')));
    }
  }

  // Функция для сохранения данных о товаре
  Future<void> _saveProductData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('products')
            .doc(widget.productId)
            .update({
              'name': _nameController.text,
              'price': int.parse(
                _priceController.text,
              ), // Убедитесь, что цена - это целое число
              'description': _descriptionController.text,
            });

        Navigator.pop(context); // Закрытие экрана после успешного сохранения
      } catch (e) {
        // Обработка ошибок при сохранении
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при сохранении данных: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProductData(); // Загрузка данных при инициализации экрана
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать товар'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Поле для ввода названия товара
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Название товара'),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Поле не должно быть пустым' : null,
              ),
              // Поле для ввода цены
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Поле не должно быть пустым' : null,
              ),
              // Поле для ввода описания товара
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Описание'),
                maxLines: 3,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Поле не должно быть пустым' : null,
              ),
              SizedBox(height: 20),
              // Кнопка для сохранения изменений
              ElevatedButton(
                onPressed: _saveProductData,
                child: Text('Сохранить изменения'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
