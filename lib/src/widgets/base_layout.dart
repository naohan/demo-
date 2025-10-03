import 'package:flutter/material.dart';
import '../core/user_session.dart';

class BaseLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? hero;
  final List<Widget>? actions;

  const BaseLayout({
    super.key,
    required this.title,
    required this.child,
    this.hero,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Quitar botón de regreso automático
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        title: Row(
          children: [
            Image.asset('assets/logo/logo_S.png', width: 24, height: 24),
            const SizedBox(width: 8),
            Text('Serenity'),
          ],
        ),
        actions: [
          ...?actions,

          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      drawer: _RoleBasedDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF5), // Sección central blanca
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (hero != null) ...[
                  Center(child: hero!),
                  const SizedBox(height: 12),
                ],
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _BottomNav(),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    int currentIndex = 0;

    // Determinar el índice actual basado en la ruta
    switch (currentRoute) {
      case '/home':
      case '/community-mind':
      case '/community-vital':
        // Todas estas rutas son consideradas "home" según el rol
        currentIndex = 0;
        break;
      case '/wellbeing-physical':
        currentIndex = 1;
        break;
      case '/wellbeing-mental':
        currentIndex = 2;
        break;
      case '/profile-router':
        currentIndex = 3;
        break;
      default:
        currentIndex = 0;
    }

    void onTap(int index) {
      switch (index) {
        case 0:
          // Navegar al home según el rol del usuario
          final userSession = UserSession();
          Navigator.pushReplacementNamed(context, userSession.homeRoute);
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/wellbeing-physical');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/wellbeing-mental');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/profile-router');
          break;
      }
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Bienestar físico',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.psychology),
          label: 'Bienestar mental',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }
}

// Drawer con opciones específicas según el rol
class _RoleBasedDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userSession = UserSession();

    return Drawer(
      child: Container(
        color: const Color(0xFFFFFDF5),
        child: Column(
          children: [
            // Header del drawer (mismo diseño que home de usuarios)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF4A90A4), const Color(0xFF7BB3C7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Icon(
                        _getRoleIcon(userSession.currentRole),
                        size: 60,
                        color: const Color(0xFF4A90A4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userSession.userName ?? 'Usuario',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userSession.currentRole.name,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Contenido del menú
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                children: [
                  // Mensaje personalizado según el rol
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Text(
                      _getRoleMessage(userSession.currentRole),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF4A90A4).withOpacity(0.1),
                          const Color(0xFF7BB3C7).withOpacity(0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF4A90A4).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A90A4),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getRoleIcon(userSession.currentRole),
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            _getRoleQuote(userSession.currentRole),
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2C3E50),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 8),

                  // Opciones del menú según el rol
                  ..._buildMenuItems(context, userSession.currentRole),
                ],
              ),
            ),

            // Botón de cerrar sesión (mismo diseño que home de usuarios)
            Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar Sesión'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.usuario:
        return Icons.person;
      case UserRole.psicologo:
        return Icons.psychology;
      case UserRole.entrenador:
        return Icons.fitness_center;
    }
  }

  String _getRoleMessage(UserRole role) {
    switch (role) {
      case UserRole.usuario:
        return 'MENSAJE DEL DÍA';
      case UserRole.psicologo:
        return 'PANEL PROFESIONAL';
      case UserRole.entrenador:
        return 'CENTRO DE ENTRENAMIENTO';
    }
  }

  String _getRoleQuote(UserRole role) {
    switch (role) {
      case UserRole.usuario:
        return 'Cada día es una nueva oportunidad para cuidar tu bienestar mental y físico.';
      case UserRole.psicologo:
        return 'Tu dedicación y profesionalismo ayudan a transformar vidas cada día.';
      case UserRole.entrenador:
        return 'Inspiras a otros a superar sus límites y alcanzar sus metas fitness.';
    }
  }

  List<Widget> _buildMenuItems(BuildContext context, UserRole role) {
    switch (role) {
      case UserRole.usuario:
        return [
          _buildDrawerItem(
            context,
            icon: Icons.home_outlined,
            title: 'Inicio',
            route: '/home',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.psychology,
            title: 'Bienestar Mental',
            route: '/wellbeing-mental',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.fitness_center,
            title: 'Bienestar Físico',
            route: '/wellbeing-physical',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.search,
            title: 'Buscar Psicólogos',
            route: '/psychologist-search',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.sports,
            title: 'Buscar Entrenadores',
            route: '/trainers',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person_outline,
            title: 'Perfil',
            route: '/profile-router',
          ),
          const Divider(height: 32),
          _buildDrawerItem(
            context,
            icon: Icons.settings_outlined,
            title: 'Configuración',
            onTap: () => _showComingSoon(context, 'Configuración'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.help_outline,
            title: 'Ayuda',
            onTap: () => _showComingSoon(context, 'Centro de Ayuda'),
          ),
        ];

      case UserRole.psicologo:
        return [
          _buildDrawerItem(
            context,
            icon: Icons.home_outlined,
            title: 'Home Profesional',
            route: '/community-mind',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.people,
            title: 'Mis Pacientes',
            onTap: () => _showComingSoon(context, 'Gestión de Pacientes'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.calendar_today,
            title: 'Mi Agenda',
            onTap: () => _showComingSoon(context, 'Gestión de Agenda'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.analytics,
            title: 'Estadísticas',
            onTap: () => _showComingSoon(context, 'Reportes y Estadísticas'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.forum,
            title: 'Comunidad Mental',
            route: '/community-mind',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.search,
            title: 'Buscar Colegas',
            route: '/psychologist-search',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person_outline,
            title: 'Mi Perfil',
            route: '/profile-router',
          ),
          const Divider(height: 32),
          _buildDrawerItem(
            context,
            icon: Icons.school,
            title: 'Recursos Profesionales',
            onTap: () => _showComingSoon(context, 'Biblioteca de Recursos'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.help_outline,
            title: 'Soporte Técnico',
            onTap: () => _showComingSoon(context, 'Soporte para Profesionales'),
          ),
        ];

      case UserRole.entrenador:
        return [
          _buildDrawerItem(
            context,
            icon: Icons.home_outlined,
            title: 'Home Entrenador',
            route: '/community-vital',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.groups,
            title: 'Mis Clientes',
            onTap: () => _showComingSoon(context, 'Gestión de Clientes'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.fitness_center,
            title: 'Rutinas',
            onTap: () => _showComingSoon(context, 'Editor de Rutinas'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.trending_up,
            title: 'Progreso',
            onTap: () => _showComingSoon(context, 'Análisis de Progreso'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.forum,
            title: 'Comunidad Vital',
            route: '/community-vital',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.search,
            title: 'Red de Entrenadores',
            route: '/trainers',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person_outline,
            title: 'Mi Perfil',
            route: '/profile-router',
          ),
          const Divider(height: 32),
          _buildDrawerItem(
            context,
            icon: Icons.library_books,
            title: 'Planes de Entrenamiento',
            onTap: () => _showComingSoon(context, 'Biblioteca de Planes'),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.help_outline,
            title: 'Soporte Técnico',
            onTap: () => _showComingSoon(context, 'Soporte para Entrenadores'),
          ),
        ];
    }
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? route,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4A90A4)),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context); // Cerrar drawer
        if (route != null) {
          Navigator.pushReplacementNamed(context, route);
        } else if (onTap != null) {
          onTap();
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Próximamente: $feature'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Cerrar Sesión'),
            content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  UserSession().logout();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('Cerrar Sesión'),
              ),
            ],
          ),
    );
  }
}
