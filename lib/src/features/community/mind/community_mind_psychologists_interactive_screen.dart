import 'package:flutter/material.dart';
import '../../../widgets/psychologist_base_layout.dart';

class CommunityMindPsychologistsInteractiveScreen extends StatefulWidget {
  static const route = '/community-mind-psychologists-interactive';
  const CommunityMindPsychologistsInteractiveScreen({super.key});

  @override
  State<CommunityMindPsychologistsInteractiveScreen> createState() =>
      _CommunityMindPsychologistsInteractiveScreenState();
}

class _CommunityMindPsychologistsInteractiveScreenState
    extends State<CommunityMindPsychologistsInteractiveScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _postController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _postController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PsychologistBaseLayout(
      title: 'Comunidad Profesional',
      hero: const Icon(Icons.forum, size: 64),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFF5F7FF),
              const Color(0xFFEEF6FF),
              const Color(0xFFEEF8FF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Tab bar like the user one but using psychologist colors
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFF6B73FF).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6B73FF), Color(0xFF3FB0D8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6B73FF).withOpacity(0.28),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF1F2A44),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                tabs: const [
                  Tab(
                    height: 64,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.forum, size: 24),
                          SizedBox(height: 6),
<<<<<<< HEAD
                          Text(
                            'Foros',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
=======
                          Text('Foros', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
>>>>>>> origin/Bryan
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    height: 64,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.group, size: 24),
                          SizedBox(height: 6),
<<<<<<< HEAD
                          Text(
                            'Grupos',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
=======
                          Text('Grupos', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
>>>>>>> origin/Bryan
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    height: 64,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.library_books, size: 24),
                          SizedBox(height: 6),
<<<<<<< HEAD
                          Text(
                            'Recursos',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
=======
                          Text('Recursos', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
>>>>>>> origin/Bryan
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    height: 64,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.event, size: 24),
                          SizedBox(height: 6),
<<<<<<< HEAD
                          Text(
                            'Eventos',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
=======
                          Text('Eventos', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
>>>>>>> origin/Bryan
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Contenido
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildForumsTab(),
                  _buildSupportGroupsTab(),
                  _buildResourcesTab(),
                  _buildEventsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForumsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCreatePostCard(),
          const SizedBox(height: 20),
          ..._getForumPosts().map((post) => _buildForumPost(post)),
        ],
      ),
    );
  }

  Widget _buildCreatePostCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Compartir en la Comunidad Profesional',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B73FF),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _postController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  'Comparte un caso clínico (anónimo), pregunta de supervisión o recurso...',
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: const Color(0xFF6B73FF).withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF6B73FF)),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _postController.clear();
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  if (_postController.text.isNotEmpty) {
                    _showPostCreated();
                    _postController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B73FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Publicar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForumPost(ForumPost post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF6B73FF).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6B73FF).withOpacity(0.1),
                  const Color(0xFF9DD5EA).withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6B73FF), Color(0xFF9DD5EA)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B73FF).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      post.author.substring(0, 1),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B73FF),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        post.timeAgo,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B73FF).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Profesionales',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B73FF),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.content,
<<<<<<< HEAD
                  style: const TextStyle(
                    color: Color(0xFF212121),
                    height: 1.6,
                    fontSize: 15,
                  ),
=======
                    style: const TextStyle(
                      color: Color(0xFF212121),
                      height: 1.6,
                      fontSize: 15,
                    ),
>>>>>>> origin/Bryan
                ),
                const SizedBox(height: 15),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: Icons.comment_outlined,
                        label: '${post.comments.length}',
                        color: const Color(0xFF6B73FF),
                        onTap: () => _showComments(post),
                      ),
                      Container(height: 20, width: 1, color: Colors.grey[300]),
                      _buildActionButton(
                        icon: Icons.thumb_up_off_alt,
                        label: '${post.likes}',
                        color: const Color(0xFF6B73FF),
                        onTap: () {},
                      ),
                      Container(height: 20, width: 1, color: Colors.grey[300]),
                      _buildActionButton(
                        icon: Icons.share_outlined,
                        label: 'Compartir',
                        color: const Color(0xFF6B73FF),
                        onTap: () {},
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

  // --- Psychologist-specific tabs: Support Groups, Resources, Events ---
  Widget _buildSupportGroupsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Crear nuevo grupo
          _buildCreateGroupCard(),
          const SizedBox(height: 20),

          // Lista de grupos
          ..._getSupportGroups().map((group) => _buildSupportGroupCard(group)),
        ],
      ),
    );
  }

  Widget _buildCreateGroupCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Crear Grupo de Apoyo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6B73FF),
            ),
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: () {
              _showCreateGroupDialog();
            },
            icon: const Icon(Icons.add),
            label: const Text('Crear Nuevo Grupo'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6B73FF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportGroupCard(SupportGroup group) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B73FF).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(group.icon, color: const Color(0xFF6B73FF)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6B73FF),
                      ),
                    ),
                    Text(
                      '${group.members} miembros',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showJoinGroupDialog(group);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B73FF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Unirse'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            group.description,
            style: const TextStyle(color: Color(0xFF212121), fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ..._getEducationalResources().map(
            (resource) => _buildResourceCard(resource),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(EducationalResource resource) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF9DD5EA).withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              resource.icon,
              color: const Color(0xFF6B73FF),
              size: 24,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resource.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B73FF),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  resource.description,
                  style: const TextStyle(
                    color: Color(0xFF212121),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 5),
                    Text(
                      resource.duration,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    const Spacer(),
                    Icon(Icons.star, size: 14, color: Colors.amber[600]),
                    const SizedBox(width: 5),
                    Text(
                      resource.rating.toString(),
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showResourceDialog(resource);
            },
            icon: const Icon(Icons.play_circle_fill, color: Color(0xFF6B73FF)),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ..._getCommunityEvents().map((event) => _buildEventCard(event)),
        ],
      ),
    );
  }

  Widget _buildEventCard(CommunityEvent event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF9DD5EA).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(event.icon, color: const Color(0xFF6B73FF)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6B73FF),
                      ),
                    ),
                    Text(
                      event.dateTime,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showEventDetails(event);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B73FF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Ver'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            event.description,
            style: const TextStyle(color: Color(0xFF212121), fontSize: 14),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.people, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 5),
              Text(
                '${event.attendees} participantes',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              const Spacer(),
              if (event.isOnline)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6B73FF).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'En línea',
                    style: TextStyle(
                      color: Color(0xFF6B73FF),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  void _showPostCreated() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Publicación creada')));
  }

  void _showComments(ForumPost post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (_) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comentarios (${post.comments.length})',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      ...post.comments
                          .map(
                            (c) => ListTile(
                              title: Text(c.author),
                              subtitle: Text(c.content),
                            ),
                          )
                          .toList(),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: 'Escribe un comentario profesional...',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cerrar'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Enviar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  // Mock data below: kept same as original
  List<ForumPost> _getForumPosts() {
    return [
      ForumPost(
        author: 'Ana (Supervisora)',
        timeAgo: '2h',
        content:
            'Apliqué la técnica X en una sesión con dificultades en regulación afectiva; observé mejoría en la tolerancia a la angustia. ¿Cómo la adaptarían en pacientes con comorbilidad?',
        likes: 12,
        comments: [
          ForumComment(
            author: 'Luis',
            content:
                'Interesante — yo uso una adaptación breve enfocada en exposición interoceptiva.',
          ),
        ],
      ),
      ForumPost(
        author: 'Carlos',
        timeAgo: '6h',
        content:
            'Comparto un recurso sobre abordaje faseado del trauma complejo, útil para trabajo faseado y estabilización.',
        likes: 8,
        comments: [
          ForumComment(
            author: 'María',
            content: 'Excelente recurso, gracias por compartir',
          ),
        ],
      ),
    ];
  }

  List<SupportGroup> _getSupportGroups() {
    return [
      SupportGroup(
        name: 'Supervisión Clínica',
        description: 'Espacio para supervisión entre colegas.',
        members: 24,
        icon: Icons.psychology,
      ),
      SupportGroup(
        name: 'Terapias Breves',
        description: 'Intercambio sobre intervenciones de corta duración.',
        members: 12,
        icon: Icons.self_improvement,
      ),
    ];
  }

  List<EducationalResource> _getEducationalResources() {
    return [
      EducationalResource(
        title: 'Guía de Entrevista Clínica',
        description: 'Documento con pautas y preguntas clave.',
        duration: '12 min',
        rating: 4.7,
        icon: Icons.menu_book,
      ),
      EducationalResource(
        title: 'Manejo de Crisis',
        description: 'Protocolo para atención en crisis.',
        duration: '25 min',
        rating: 4.9,
        icon: Icons.local_hospital,
      ),
    ];
  }

  List<CommunityEvent> _getCommunityEvents() {
    return [
      CommunityEvent(
        title: 'Taller: Trauma complejo',
        description: 'Sesión sobre abordaje del trauma complejo.',
        dateTime: 'Sáb 10:00',
        attendees: 40,
        isOnline: true,
        icon: Icons.event,
      ),
      CommunityEvent(
        title: 'Supervisión en grupo',
        description: 'Casos y discusión clínica.',
        dateTime: 'Mar 18:00',
        attendees: 18,
        isOnline: false,
        icon: Icons.group,
      ),
    ];
  }

  void _showCreateGroupDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Crear Grupo'),
            content: const Text(
              'Funcionalidad de creación de grupos próximamente.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }

  void _showJoinGroupDialog(SupportGroup group) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Unirse a ${group.name}'),
            content: Text('Solicitar unirse al grupo "${group.name}".'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Solicitud enviada')),
                  );
                },
                child: const Text('Solicitar'),
              ),
            ],
          ),
    );
  }

  void _showResourceDialog(EducationalResource resource) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(resource.title),
            content: Text('Reproducción de recurso: ${resource.description}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }

  void _showEventDetails(CommunityEvent event) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(event.title),
            content: Text('${event.description}\n${event.dateTime}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
    );
  }
}

class ForumPost {
  final String author;
  final String timeAgo;
  final String content;
  final int likes;
  final List<ForumComment> comments;

  ForumPost({
    required this.author,
    required this.timeAgo,
    required this.content,
    this.likes = 0,
    this.comments = const [],
  });
}

class ForumComment {
  final String author;
  final String content;
  ForumComment({required this.author, required this.content});
}

class SupportGroup {
  final String name;
  final String description;
  final int members;
  final IconData icon;

  SupportGroup({
    required this.name,
    required this.description,
    required this.members,
    required this.icon,
  });
}

class EducationalResource {
  final String title;
  final String description;
  final String duration;
  final double rating;
  final IconData icon;

  EducationalResource({
    required this.title,
    required this.description,
    required this.duration,
    required this.rating,
    required this.icon,
  });
}

class CommunityEvent {
  final String title;
  final String description;
  final String dateTime;
  final int attendees;
  final bool isOnline;
  final IconData icon;

  CommunityEvent({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.attendees,
    required this.isOnline,
    required this.icon,
  });
}
