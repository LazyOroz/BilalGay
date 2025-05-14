import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  File? _imageFile;
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  String name = 'Фермер Алексей';
  String email = 'alexey@farm.ru';
  String phone = '+7 901 123-45-67';
  String address = 'Краснодарский край, Россия';
  String description = 'Выращиваю экологически чистые продукты.';

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Профиль обновлён')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль продавца'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      _imageFile != null ? FileImage(_imageFile!) : null,
                  child:
                      _imageFile == null
                          ? Icon(Icons.camera_alt, size: 40, color: Colors.grey)
                          : null,
                ),
              ),
              SizedBox(height: 20),
              _buildTextField('Имя', name, (val) => name = val),
              _buildTextField('Email', email, (val) => email = val),
              _buildTextField('Телефон', phone, (val) => phone = val),
              _buildTextField('Адрес', address, (val) => address = val),
              _buildTextField(
                'Описание',
                description,
                (val) => description = val,
                maxLines: 3,
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _saveForm,
                icon: Icon(Icons.save),
                label: Text('Сохранить'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Переход к добавлению товаров
                },
                icon: Icon(Icons.add_box),
                label: Text('Добавить товар'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    String initialValue,
    Function(String) onSaved, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: initialValue,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator:
            (value) => value!.isEmpty ? 'Поле не должно быть пустым' : null,
        onSaved: (value) => onSaved(value!),
      ),
    );
  }
}
