import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Импорт Firestore
import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/buyer/home_screen.dart';
import 'screens/seller/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Инициализация Firebase
  runApp(FarmMarketApp());
}

class FarmMarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ФермаМаркет',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Проверяем, вошел ли пользователь в систему
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Если пользователь не авторизован, показываем экран входа
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Ошибка авторизации'));
        }

        // Если пользователь авторизован, проверяем его роль
        if (snapshot.hasData) {
          final user = snapshot.data!;
          // Если пользователь - продавец, показываем экран продавца
          return FutureBuilder<DocumentSnapshot>(
            future:
                FirebaseFirestore.instance
                    .collection('sellers')
                    .doc(user.uid)
                    .get(),
            builder: (context, sellerSnapshot) {
              if (sellerSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (sellerSnapshot.hasError) {
                return Center(child: Text('Ошибка получения данных продавца'));
              }

              // Если продавец найден, показываем экран продавца
              if (sellerSnapshot.hasData && sellerSnapshot.data!.exists) {
                return const SellerHomeScreen();
              }

              // Иначе, показываем экран покупателя
              return const BuyerHomeScreen();
            },
          );
        }

        // Если пользователь не авторизован, показываем экран входа
        return const LoginScreen();
      },
    );
  }
}
