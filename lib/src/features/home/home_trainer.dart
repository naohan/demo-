import 'package:flutter/material.dart';
import '../../widgets/trainer_base_layout.dart';

class HomeTrainerScreen extends StatefulWidget {
  static const route = '/home-trainer';
  const HomeTrainerScreen({super.key});

  @override
  State<HomeTrainerScreen> createState() => _HomeTrainerScreenState();
}

class _HomeTrainerScreenState extends State<HomeTrainerScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TrainerBaseLayout(
      title: 'Home Entrenador',
      hero: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF3498DB).withOpacity(0.1),
              const Color(0xFF2ECC71).withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.fitness_center,
          size: 64,
          color: Color(0xFF3498DB),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saludo personalizado
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3498DB).withOpacity(0.1),
                    const Color(0xFF2ECC71).withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF3498DB).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Bienvenido, Coach!',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3498DB),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Inspira y transforma vidas a través del fitness',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tarjetas de acceso rápido
            Text(
              'Acceso Rápido',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: [
                  _buildQuickAccessCard(
                    context,
                    title: 'Mis Clientes',
                    subtitle: 'Gestionar entrenamientos',
                    icon: Icons.group,
                    color: const Color(0xFF3498DB),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Función en desarrollo')),
                      );
                    },
                  ),
                  _buildQuickAccessCard(
                    context,
                    title: 'Rutinas',
                    subtitle: 'Crear y editar',
                    icon: Icons.fitness_center,
                    color: const Color(0xFF2ECC71),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Función en desarrollo')),
                      );
                    },
                  ),
                  _buildQuickAccessCard(
                    context,
                    title: 'Calendario',
                    subtitle: 'Horarios y citas',
                    icon: Icons.calendar_today,
                    color: const Color(0xFFE74C3C),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Función en desarrollo')),
                      );
                    },
                  ),
                  _buildQuickAccessCard(
                    context,
                    title: 'Comunidad',
                    subtitle: 'Interactuar y compartir',
                    icon: Icons.forum,
                    color: const Color(0xFF9B59B6),
                    onTap: () {
                      Navigator.pushNamed(context, '/community-vital');
                    },
                  ),
                  _buildQuickAccessCard(
                    context,
                    title: 'Estadísticas',
                    subtitle: 'Progreso de clientes',
                    icon: Icons.analytics,
                    color: const Color(0xFFF39C12),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Función en desarrollo')),
                      );
                    },
                  ),
                  _buildQuickAccessCard(
                    context,
                    title: 'Perfil',
                    subtitle: 'Mi información',
                    icon: Icons.person,
                    color: const Color(0xFF34495E),
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.1), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2C3E50),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
