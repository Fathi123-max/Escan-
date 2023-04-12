class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final List<String> roles;
  final DateTime? lastLogin;
  final bool isEmailVerified;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.roles,
    this.lastLogin,
    this.isEmailVerified = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      roles: List<String>.from(json['roles']),
      lastLogin:
          json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
      isEmailVerified: json['isEmailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'roles': roles,
        'lastLogin': lastLogin?.toString(),
        'isEmailVerified': isEmailVerified,
      };

  String get fullName => '$firstName $lastName';

  bool hasRole(String role) => roles.contains(role);

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    List<String>? roles,
    DateTime? lastLogin,
    bool? isEmailVerified,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      roles: roles ?? this.roles,
      lastLogin: lastLogin ?? this.lastLogin,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }
}
