// lib/screens/auth/register_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String role = 'Покупатель';

  // Модифицируем структуру данных для сохранения роли
  final Map<String, Map<String, String>> _users = {
    "buyer@example.com": {"password": "password123", "role": "Покупатель"},
    "seller@example.com": {"password": "password123", "role": "Продавец"},
  };

  void _register() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Проверка на существование пользователя
    if (_users.containsKey(email)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Пользователь уже существует")));
    } else {
      // Регистрация нового пользователя с ролью
      setState(() {
        _users[email] = {"password": password, "role": role};
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Регистрация")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Пароль',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: role,
              decoration: InputDecoration(
                labelText: 'Роль',
                border: OutlineInputBorder(),
              ),
              items:
                  ['Покупатель', 'Продавец']
                      .map(
                        (role) =>
                            DropdownMenuItem(value: role, child: Text(role)),
                      )
                      .toList(),
              onChanged: (value) {
                if (value != null) setState(() => role = value);
              },
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: _register,
              child: Text('Зарегистрироваться'),
            ),
          ],
        ),
      ),
    );
  }
}
