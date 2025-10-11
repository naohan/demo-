import 'package:flutter/material.dart';
// 1. IMPORTAMOS LA PANTALLA DE RUTINAS PARA USAR SU RUTA ESTÁTICA
import '../trainer-functions/routines/trainer_routines_screen.dart'; 
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
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.08)),
          image: const DecorationImage(
            image: AssetImage('assets/banner/banner-trainer.png'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
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
                      const Color(0xFF66BB6A).withOpacity(0.08),
                      const Color(0xFF4CAF50).withOpacity(0.06),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF4CAF50).withOpacity(0.18),
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
                      color: const Color(0xFF4CAF50),
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
                childAspectRatio: 1.1,
                children: [
                  _buildQuickAccessCard(
                    context,
                    title: 'Mis Clientes',
                    subtitle: 'Gestionar entrenamientos',
                    icon: Icons.group,
                    color: const Color(0xFF4CAF50),
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
                    color: const Color(0xFF4CAF50),
                    // 2. RUTA ACTUALIZADA
                    onTap: () {
                      Navigator.pushNamed(context, TrainerRoutinesScreen.route);
                    },
                  ),
                  _buildQuickAccessCard(
                    context,
                    title: 'Calendario',
                    subtitle: 'Horarios y citas',
                    icon: Icons.calendar_today,
                    color: const Color(0xFF4CAF50),
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
                    color: const Color(0xFF4CAF50),
                    onTap: () {
                      Navigator.pushNamed(context, '/community-vital');
                    },
                  ),
                  _buildQuickAccessCard(
                    context,
                    title: 'Estadísticas',
                    subtitle: 'Progreso de clientes',
                    icon: Icons.analytics,
                    color: const Color(0xFF4CAF50),
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
                    color: const Color(0xFF4CAF50),
                    // 3. RUTA CORREGIDA (según tu estructura de archivos)
                    onTap: () {
                      Navigator.pushNamed(context, '/profile-trainer');
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
    // Este widget no necesita cambios, se mantiene tu nueva versión
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
        child: SingleChildScrollView( // <-- Mantenemos la corrección del overflow
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
      ),
    );
  }
}