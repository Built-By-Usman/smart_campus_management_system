class UserModel {
  final String name;
  final String email;
  final int id;
  final String role;
  final bool isAuthenticated;
  final bool isActive;
  final bool isVerifiedEmail;
  final DateTime createdAt;

  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.role,
    required this.isAuthenticated,
    required this.isActive,
    required this.isVerifiedEmail,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      isActive: json['is_active'] ?? false,
      isAuthenticated: json['is_authenticated'] ?? false,
      isVerifiedEmail: json['is_verified_email'] ?? false,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'id': id,
      'role': role,
      'is_active': isActive,
      'is_authenticated': isAuthenticated,
      'is_verified_email': isVerifiedEmail,
      'created_at': createdAt.toIso8601String(),
    };
  }
  UserModel copyWith({
    String? name,
    String? email,
    String? role,
    bool? isAuthenticated,
    bool? isActive,
    bool? isVerifiedEmail,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id, // ID same rahega
      role: role ?? this.role,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isActive: isActive ?? this.isActive,
      isVerifiedEmail: isVerifiedEmail ?? this.isVerifiedEmail,
      createdAt: createdAt, // createdAt change nahi hota
    );
  }
}

