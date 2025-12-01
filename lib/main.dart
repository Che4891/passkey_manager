// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:passkey_manager/app/app.dart';

void main() {
  runApp(const ProviderScope(child: PasskeyManagerApp()));
}