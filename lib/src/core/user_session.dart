import 'package:flutter/foundation.dart';

/// Enum para los tipos de roles en la aplicación
enum UserRole {
  usuario(0, 'Usuario'),
  psicologo(1, 'Psicólogo'),
  entrenador(2, 'Entrenador');

  const UserRole(this.roleIndex, this.name);
  final int roleIndex;
  final String name;

  /// Convierte un índice entero a UserRole
  static UserRole fromIndex(int index) {
    switch (index) {
      case 0:
        return UserRole.usuario;
      case 1:
        return UserRole.psicologo;
      case 2:
        return UserRole.entrenador;
      default:
        return UserRole.usuario;
    }
  }

  /// Obtiene la ruta del "home" correspondiente a cada rol
  String get homeRoute {
    switch (this) {
      case UserRole.usuario:
        return '/home';
      case UserRole.psicologo:
        return '/home-psychologist';
      case UserRole.entrenador:
        return '/home-trainer';
    }
  }
}

/// Singleton para manejar la sesión del usuario
class UserSession extends ChangeNotifier {
  static final UserSession _instance = UserSession._internal();
  factory UserSession() => _instance;
  UserSession._internal();

  UserRole _currentRole = UserRole.usuario;
  String? _userName;
  String? _userEmail;

  /// Obtiene el rol actual del usuario
  UserRole get currentRole => _currentRole;

  /// Obtiene el nombre del usuario
  String? get userName => _userName;

  /// Obtiene el email del usuario
  String? get userEmail => _userEmail;

  /// Obtiene la ruta del home según el rol actual
  String get homeRoute => _currentRole.homeRoute;

  /// Establece la sesión del usuario con toda su información
  void setUserSession({required UserRole role, String? name, String? email}) {
    _currentRole = role;
    _userName = name;
    _userEmail = email;
    notifyListeners();
  }

  /// Establece solo el rol del usuario (para compatibilidad con código existente)
  void setUserRole(int roleIndex) {
    _currentRole = UserRole.fromIndex(roleIndex);
    notifyListeners();
  }

  /// Cierra la sesión del usuario
  void logout() {
    _currentRole = UserRole.usuario;
    _userName = null;
    _userEmail = null;
    notifyListeners();
  }

  /// Verifica si el usuario está logueado
  bool get isLoggedIn => _userName != null && _userEmail != null;
}
