// lib/features/passkeys/domain/models/passkey.dart
class Passkey {
  final String id;
  final String rpId;
  final String rpName;
  final String userId;
  final String userName;
  final String userDisplayName;
  final List<int> credentialId;
  final DateTime createdAt;
  final DateTime lastUsedAt;

  Passkey({
    required this.id,
    required this.rpId,
    required this.rpName,
    required this.userId,
    required this.userName,
    required this.userDisplayName,
    required this.credentialId,
    required this.createdAt,
    required this.lastUsedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rpId': rpId,
      'rpName': rpName,
      'userId': userId,
      'userName': userName,
      'userDisplayName': userDisplayName,
      'credentialId': credentialId,
      'createdAt': createdAt.toIso8601String(),
      'lastUsedAt': lastUsedAt.toIso8601String(),
    };
  }

  factory Passkey.fromJson(Map<String, dynamic> json) {
    return Passkey(
      id: json['id'] as String,
      rpId: json['rpId'] as String,
      rpName: json['rpName'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userDisplayName: json['userDisplayName'] as String,
      credentialId: List<int>.from(json['credentialId'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUsedAt: DateTime.parse(json['lastUsedAt'] as String),
    );
  }
}