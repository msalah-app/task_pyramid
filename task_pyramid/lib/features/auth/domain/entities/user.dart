import 'dart:convert';

class LoginResponse {
  final int storeId;
  final String storeName;
  final int storeTypeId;
  final bool activation;
  final String token;
  LoginResponse({
    required this.storeId,
    required this.storeName,
    required this.storeTypeId,
    required this.activation,
    required this.token,
  });

  LoginResponse copyWith({
    int? storeId,
    String? storeName,
    int? storeTypeId,
    bool? activation,
    String? token,
  }) {
    return LoginResponse(
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      storeTypeId: storeTypeId ?? this.storeTypeId,
      activation: activation ?? this.activation,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'store_id': storeId,
      'store_name': storeName,
      'store_type_id': storeTypeId,
      'activation': activation,
      'token': token,
    };
  }
  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      storeId: map['store_id']?.toInt() ?? 0,
      storeName: map['store_name'] ?? '',
      storeTypeId: map['store_type_id']?.toInt() ?? 0,
      activation: map['activation'] ?? false,
      token: map['token'] ?? '',
    );
  }
  String toJson() => json.encode(toMap());
  factory LoginResponse.fromJson(String source) =>
      LoginResponse.fromMap(json.decode(source));
  @override
  String toString() {
    return 'UserLoginResponse(storeId: $storeId, storeName: $storeName, storeTypeId: $storeTypeId, activation: $activation, token: $token)';
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginResponse &&
        other.storeId == storeId &&
        other.storeName == storeName &&
        other.storeTypeId == storeTypeId &&
        other.activation == activation &&
        other.token == token;
  }
  @override
  int get hashCode {
    return storeId.hashCode ^
        storeName.hashCode ^
        storeTypeId.hashCode ^
        activation.hashCode ^
        token.hashCode;
  }
}
