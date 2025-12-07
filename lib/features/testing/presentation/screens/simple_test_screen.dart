// lib/features/testing/presentation/screens/simple_test_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../passkeys/data/repositories/passkey_repository.dart';
import '../../../passkeys/domain/models/passkey.dart';

class SimpleTestScreen extends StatefulWidget {
  const SimpleTestScreen({super.key});

  @override
  State<SimpleTestScreen> createState() => _SimpleTestScreenState();
}

class _SimpleTestScreenState extends State<SimpleTestScreen> {
  final PasskeyRepository _repository = PasskeyRepository();
  List<Passkey> _passkeys = [];
  bool _isLoading = false;
  String _status = '';

  Future<void> _addTestPasskey() async {
    setState(() {
      _isLoading = true;
      _status = 'Додаємо тестовий passkey...';
    });

    try {
      final testPasskey = Passkey(
        id: 'test_${DateTime.now().millisecondsSinceEpoch}',
        rpId: 'example.com',
        rpName: 'Example Website',
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
        userName: 'user@example.com',
        userDisplayName: 'Test User',
        credentialId: [1, 2, 3, 4, 5],
        createdAt: DateTime.now(),
        lastUsedAt: DateTime.now(),
      );
      
      await _repository.savePasskey(testPasskey);
      setState(() {
        _status = 'Тестовий passkey додано успішно!';
      });
      
      await _loadPasskeys();
    } catch (e) {
      setState(() {
        _status = 'Помилка: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadPasskeys() async {
    setState(() {
      _isLoading = true;
      _status = 'Завантаження...';
    });

    try {
      final passkeys = await _repository.getAllPasskeys();
      setState(() {
        _passkeys = passkeys;
        _status = 'Завантажено ${passkeys.length} passkeys';
      });
    } catch (e) {
      setState(() {
        _status = 'Помилка завантаження: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPasskeys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тест Passkeys'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Статус
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      _status,
                      style: const TextStyle(fontSize: 16),
                    ),
                    if (_isLoading) const LinearProgressIndicator(),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Кнопки
            ElevatedButton(
              onPressed: _isLoading ? null : _addTestPasskey,
              child: const Text('Додати тестовий passkey'),
            ),
            
            ElevatedButton(
              onPressed: _isLoading ? null : _loadPasskeys,
              child: const Text('Оновити список'),
            ),
            
            const SizedBox(height: 20),
            const Divider(),
            const Text(
              'Список passkeys:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            
            // Список
            Expanded(
              child: _passkeys.isEmpty
                  ? const Center(
                      child: Text('Немає passkeys'),
                    )
                  : ListView.builder(
                      itemCount: _passkeys.length,
                      itemBuilder: (context, index) {
                        final passkey = _passkeys[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: const Icon(Icons.security),
                            title: Text(passkey.rpName),
                            subtitle: Text(passkey.userName),
                            trailing: Text(passkey.id.substring(0, 8)),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}