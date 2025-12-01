import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart'; // Додаємо імпорт файлу з роутером

class PasskeyManagerApp extends StatelessWidget {
  const PasskeyManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router, // Використовуємо router з імпортованого файлу
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
    );
  }
}