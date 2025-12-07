// lib/features/passkeys/presentation/widgets/passkey_list_item.dart
import 'package:flutter/material.dart';
import '../../domain/models/passkey.dart';

class PasskeyListItem extends StatelessWidget {
  final Passkey passkey;
  
  const PasskeyListItem({
    super.key,
    required this.passkey,
  });
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.security),
      title: Text(passkey.rpName),
      subtitle: Text(passkey.userName),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Навігація до деталей буде пізніше
      },
    );
  }
}