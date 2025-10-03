import 'package:flutter/material.dart';
import '../../../widgets/base_layout.dart';
import 'psychologist_profile_screen.dart';
import 'psychologist_search_screen.dart';
import '../../../core/user_session.dart';

class CommunityMindScreen extends StatefulWidget {
  static const route = '/community-mind';
  const CommunityMindScreen({super.key});

  @override
  State<CommunityMindScreen> createState() => _CommunityMindScreenState();
}

class _CommunityMindScreenState extends State<CommunityMindScreen>
    with SingleTickerProviderStateMixin {
  bool _isIncognito = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userSession = UserSession();

    return BaseLayout(
      title: 'Home - ${userSession.userName ?? "Psicólogo"}',
      hero: Row(
        children: [
          // Saludo personalizado
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¡Hola, Dr./Dra. ${userSession.userName?.split(' ').first ?? "Psicólogo"}!',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                Text(
                  'Gestiona tu práctica profesional',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(_isIncognito ? Icons.masks : Icons.face),
            onPressed: () => setState(() => _isIncognito = !_isIncognito),
            tooltip: _isIncognito ? 'Modo incógnito activo' : 'Modo normal',
          ),
        ],
      ),
      child: Column(
        children: [
          // Sección de accesos rápidos para psicólogos
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Accesos Rápidos',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _QuickAccessCard(
                          icon: Icons.people,
                          title: 'Mis Pacientes',
                          subtitle: 'Gestionar citas',
                          onTap: () {
                            // TODO: Navegar a lista de pacientes
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Próximamente: Gestión de pacientes',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _QuickAccessCard(
                          icon: Icons.calendar_today,
                          title: 'Agenda',
                          subtitle: 'Ver horarios',
                          onTap: () {
                            // TODO: Navegar a agenda
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Próximamente: Gestión de agenda',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _QuickAccessCard(
                          icon: Icons.analytics,
                          title: 'Estadísticas',
                          subtitle: 'Ver reportes',
                          onTap: () {
                            // TODO: Navegar a estadísticas
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Próximamente: Reportes y estadísticas',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Sección de búsqueda de psicólogos (para colaboración)
          Card(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.psychology),
                  title: const Text('Encuentra a tu psicólogo'),
                  subtitle: const Text('Busca por ubicación y especialidad'),
                  trailing: ElevatedButton.icon(
                    onPressed:
                        () => Navigator.pushNamed(
                          context,
                          PsychologistSearchScreen.route,
                        ),
                    icon: const Icon(Icons.search),
                    label: const Text('Buscar'),
                  ),
                ),
              ],
            ),
          ),

          // Sección de contenido multimedia
          Expanded(
            child: Column(
              children: [
                Container(
                  color: theme.primaryColor.withOpacity(0.1),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: theme.primaryColor,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(icon: Icon(Icons.forum), text: 'Foro'),
                      Tab(icon: Icon(Icons.video_library), text: 'Videos'),
                      Tab(icon: Icon(Icons.photo_library), text: 'Fotos'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Foro
                      Card(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('Foro de salud mental'),
                              trailing: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Crear nueva publicación'),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 10,
                                itemBuilder:
                                    (context, index) => InkWell(
                                      onTap: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Ver detalles'),
                                          ),
                                        );
                                      },
                                      child: ListTile(
                                        leading: Icon(
                                          _isIncognito
                                              ? Icons.masks_outlined
                                              : Icons.person_outline,
                                        ),
                                        title: Text('Experiencia ${index + 1}'),
                                        subtitle: Text(
                                          _isIncognito
                                              ? 'Anónimo'
                                              : 'Usuario ${index + 1}',
                                        ),
                                        trailing: Chip(
                                          label: Text(
                                            '${index + 2} respuestas',
                                          ),
                                          backgroundColor: theme.primaryColor
                                              .withOpacity(0.1),
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Videos
                      GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 16 / 9,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                        itemCount: 6,
                        itemBuilder:
                            (context, index) => Card(
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    'https://picsum.photos/seed/$index/300/200',
                                    fit: BoxFit.cover,
                                  ),
                                  const Center(
                                    child: Icon(
                                      Icons.play_circle,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ),

                      // Fotos
                      GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                        itemCount: 9,
                        itemBuilder:
                            (context, index) => Card(
                              child: Image.network(
                                'https://picsum.photos/seed/${index + 10}/200',
                                fit: BoxFit.cover,
                              ),
                            ),
                      ),
                    ],
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

// Widget para los accesos rápidos
class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: theme.primaryColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
