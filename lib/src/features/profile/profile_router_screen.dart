import 'package:flutter/material.dart';
import '../../core/user_session.dart';
import 'profile_screen.dart';
import '../profiles/psychologist_profile_screen.dart';
import '../profiles/trainer_profile_screen.dart';

/// Pantalla que redirecciona al perfil correcto según el rol del usuario
class ProfileRouterScreen extends StatelessWidget {
  static const route = '/profile-router';

  const ProfileRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userSession = UserSession();

    // Redireccionar según el rol del usuario
    switch (userSession.currentRole) {
      case UserRole.usuario:
        return const ProfileScreen();
      case UserRole.psicologo:
        return const PsychologistProfileScreen();
      case UserRole.entrenador:
        return const TrainerProfileScreen();
    }
  }
}
