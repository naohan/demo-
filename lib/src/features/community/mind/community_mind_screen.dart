import 'package:flutter/material.dart';
import '../../../widgets/base_layout.dart';

class CommunityMindScreen extends StatefulWidget {
  static const route = '/community-mind';
  const CommunityMindScreen({super.key});

  @override
  State<CommunityMindScreen> createState() => _CommunityMindScreenState();
}

class _CommunityMindScreenState extends State<CommunityMindScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseLayout(
      title: 'Comunidad Zona Mental',
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono principal
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.primaryColor.withOpacity(0.1),
                    theme.primaryColor.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.primaryColor.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.psychology,
                size: 80,
                color: theme.primaryColor,
              ),
            ),

            const SizedBox(height: 30),

            // Título principal
            Text(
              'Comunidad de Salud Mental',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Descripción
            Text(
              'Un espacio seguro para compartir experiencias, obtener apoyo y conectar con otros en tu journey de bienestar mental.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Tarjetas de características
            Column(
              children: [
                _buildFeatureCard(
                  context,
                  icon: Icons.forum,
                  title: 'Foros de Discusión',
                  subtitle:
                      'Participa en conversaciones sobre temas de salud mental',
                ),
                const SizedBox(height: 15),
                _buildFeatureCard(
                  context,
                  icon: Icons.group,
                  title: 'Grupos de Apoyo',
                  subtitle:
                      'Conecta con personas que comparten experiencias similares',
                ),
                const SizedBox(height: 15),
                _buildFeatureCard(
                  context,
                  icon: Icons.local_library,
                  title: 'Recursos Educativos',
                  subtitle:
                      'Accede a artículos y material educativo especializado',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: theme.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: theme.primaryColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
