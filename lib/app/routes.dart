import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Змінюємо з приватної змінної (_router) на публічну (router)
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Головна сторінка'),
        ),
      ),
    ),
  ],
);