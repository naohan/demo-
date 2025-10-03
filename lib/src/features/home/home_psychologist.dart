import 'package:flutter/material.dart';
import '../../widgets/base_layout.dart';
import '../community/mind/psychologist_search_screen.dart';

class HomePsychologistScreen extends StatefulWidget {
  static const route = '/home-psychologist';
  const HomePsychologistScreen({super.key});

  @override
  State<HomePsychologistScreen> createState() => _HomePsychologistScreenState();
}

class _HomePsychologistScreenState extends State<HomePsychologistScreen>
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

    return BaseLayout(
      title: 'Home Psicólogo',
      hero: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: Icon(_isIncognito ? Icons.masks : Icons.face),
            onPressed: () => setState(() => _isIncognito = !_isIncognito),
            tooltip: _isIncognito ? 'Modo incógnito activo' : 'Modo normal',
          ),
        ],
      ),
      child: Column(
        children: [
          // Sección de búsqueda de psicólogos
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
