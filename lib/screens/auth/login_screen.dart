// lib/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../buyer/home_screen.dart';
import '../seller/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final Map<String, Map<String, String>> _users = {
    "buyer@gmail.com": {"password": "password123", "role": "Покупатель"},
    "seller@gmail.com": {"password": "password123", "role": "Продавец"},
  };
  String _errorMessage = "";

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Проверка логина и пароля
    if (_users.containsKey(email) && _users[email]!["password"] == password) {
      // Переход в зависимости от роли
      String role = _users[email]!["role"]!;
      if (role == "Покупатель") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const BuyerHomeScreen()),
        );
      } else if (role == "Продавец") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SellerHomeScreen()),
        );
      }
    } else {
      setState(() {
        _errorMessage = "Неверный логин или пароль";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Добро пожаловать 👋",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    errorText: _errorMessage.isEmpty ? null : _errorMessage,
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
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: _login,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Войти', style: TextStyle(fontSize: 16)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: Text("Нет аккаунта? Зарегистрироваться"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
