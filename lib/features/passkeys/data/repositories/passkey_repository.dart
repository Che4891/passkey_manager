import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/models/passkey.dart';

class PasskeyRepository {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  Future<void> savePasskey(Passkey passkey) async {
    try {
      final key = 'passkey_${passkey.id}';
      final json = passkey.toJson();
      await _storage.write(key: key, value: jsonEncode(json));
      print('Passkey збережено: $key');
    } catch (e) {
      print('Помилка збереження passkey: $e');
      rethrow;
    }
  }
  
  Future<List<Passkey>> getAllPasskeys() async {
    try {
      final allKeys = await _storage.readAll();
      print('Знайдено ключів у сховищі: ${allKeys.length}');
      
      final passkeys = allKeys.entries
          .where((entry) => entry.key.startsWith('passkey_'))
          .map((entry) {
            try {
              return Passkey.fromJson(jsonDecode(entry.value));
            } catch (e) {
              print('Помилка декодування ${entry.key}: $e');
              return null;
            }
          })
          .where((passkey) => passkey != null)
          .cast<Passkey>()
          .toList();
      
      print('Завантажено passkeys: ${passkeys.length}');
      return passkeys;
    } catch (e) {
      print('Помилка завантаження passkeys: $e');
      rethrow;
    }
  }
  
  Future<void> deletePasskey(String id) async {
    await _storage.delete(key: 'passkey_$id');
    print('Passkey видалено: $id');
  }
}