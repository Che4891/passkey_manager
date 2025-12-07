// lib/features/passkeys/presentation/providers/passkey_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/passkey_repository.dart';
import '../../domain/models/passkey.dart';

final passkeyRepositoryProvider = Provider((ref) => PasskeyRepository());

final passkeysProvider = FutureProvider<List<Passkey>>((ref) async {
  final repository = ref.watch(passkeyRepositoryProvider);
  try {
    final passkeys = await repository.getAllPasskeys();
    print('Завантажено ${passkeys.length} passkeys');
    return passkeys;
  } catch (e) {
    print('Помилка в провайдері: $e');
    rethrow;
  }
});

// Правильний провайдер для додавання тестового passkey
final addTestPasskeyProvider = Provider<void Function()>((ref) {
  final repository = ref.read(passkeyRepositoryProvider);
  
  return () async {
    print('Додавання тестового passkey...');
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
    await repository.savePasskey(testPasskey);
    print('Тестовий passkey додано: ${testPasskey.id}');
  };
});