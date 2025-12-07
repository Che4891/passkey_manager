// lib/app/app.dart
import 'package:flutter/material.dart';
import 'package:passkey_manager/features/passkeys/presentation/screens/passkey_list_screen.dart';
import 'package:passkey_manager/features/testing/presentation/screens/simple_test_screen.dart';

class PasskeyManagerApp extends StatelessWidget {
  const PasskeyManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passkey Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      // Змініть на SimpleTestScreen для тесту
      home: const SimpleTestScreen(),
      // home: const PasskeyListScreen(), // Початковий варіант
    );
  }
}