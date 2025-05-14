import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;

  String name = 'Иван Иванов';
  String email = 'ivan@example.com';
  String phone = '+7 999 123 4567';
  String address = 'г. Москва, ул. Примерная, д. 1';
  String bio = 'Фермер из Подмосковья';

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  void _saveProfile() {
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
        title: Text(
          "Профиль пользователя",
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child:
                        _image == null
                            ? Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.green,
                            )
                            : null,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField(
                  label: 'Имя',
                  initialValue: name,
                  onSaved: (val) => name = val!,
                ),
                _buildTextField(
                  label: 'Email',
                  initialValue: email,
                  onSaved: (val) => email = val!,
                  keyboardType: TextInputType.emailAddress,
                ),
                _buildTextField(
                  label: 'Телефон',
                  initialValue: phone,
                  onSaved: (val) => phone = val!,
                  keyboardType: TextInputType.phone,
                ),
                _buildTextField(
                  label: 'Адрес',
                  initialValue: address,
                  onSaved: (val) => address = val!,
                ),
                _buildTextField(
                  label: 'О себе',
                  initialValue: bio,
                  onSaved: (val) => bio = val!,
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                    child: Text('Сохранить', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required FormFieldSetter<String> onSaved,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator:
            (value) => value == null || value.isEmpty ? 'Заполните поле' : null,
        onSaved: onSaved,
      ),
    );
  }
}
