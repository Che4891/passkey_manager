// lib/features/passkeys/presentation/screens/passkey_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/passkey_provider.dart';
import '../widgets/passkey_list_item.dart';

class PasskeyListScreen extends ConsumerWidget {
  const PasskeyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passkeysAsync = ref.watch(passkeysProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мої Passkeys'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              final addTestPasskey = ref.read(addTestPasskeyProvider);
              addTestPasskey();
              // Оновлюємо список
              ref.refresh(passkeysProvider);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final addTestPasskey = ref.read(addTestPasskeyProvider);
          addTestPasskey();
          ref.refresh(passkeysProvider);
        },
        child: const Icon(Icons.add),
      ),
      body: passkeysAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          print('Помилка: $error');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Помилка: $error'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => ref.refresh(passkeysProvider),
                  child: const Text('Спробувати знову'),
                ),
              ],
            ),
          );
        },
        data: (passkeys) {
          print('Отримано passkeys: ${passkeys.length}');
          if (passkeys.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Немає збережених passkeys',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final addTestPasskey = ref.read(addTestPasskeyProvider);
                      addTestPasskey();
                      ref.refresh(passkeysProvider);
                    },
                    child: const Text('Додати тестовий passkey'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: passkeys.length,
            itemBuilder: (context, index) => PasskeyListItem(passkey: passkeys[index]),
          );
        },
      ),
    );
  }
}