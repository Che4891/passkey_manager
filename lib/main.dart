// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passkey_manager/app/app.dart';

void main() {
  // Додайте цей код для відладки
  WidgetsFlutterBinding.ensureInitialized();
  
  // Додаткові налаштування для відладки
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message != null) {
      print('[DEBUG] $message');
    }
  };
  
  runApp(const ProviderScope(child: PasskeyManagerApp()));
}