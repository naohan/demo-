import 'package:flutter/material.dart';
import '../../../widgets/user_base_layout.dart';

class CommunityMindInteractiveScreen extends StatefulWidget {
  static const route = '/community-mind-interactive';
  const CommunityMindInteractiveScreen({super.key});

  @override
  State<CommunityMindInteractiveScreen> createState() => _CommunityMindInteractiveScreenState();
}

class _CommunityMindInteractiveScreenState extends State<CommunityMindInteractiveScreen>
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
    return UserBaseLayout(
      title: 'Comunidad Interactiva',
      hero: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF1565C0).withOpacity(0.08)),
          image: const DecorationImage(
            image: AssetImage('assets/banner/banner-comunity.png'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFE3F2FD),
              const Color(0xFFBBDEFB),
              const Color(0xFF90CAF9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Tab bar personalizado mejorado
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFF1565C0).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1565C0).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF1565C0),
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
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.forum, size: 20),
                        SizedBox(height: 4),
                        Text('Foros', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                  Tab(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.group, size: 20),
                        SizedBox(height: 4),
                        Text('Grupos', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                  Tab(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.library_books, size: 20),
                        SizedBox(height: 4),
                        Text('Recursos', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                  Tab(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event, size: 20),
                        SizedBox(height: 4),
                        Text('Eventos', style: TextStyle(fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Contenido de las pestañas
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
          // Crear nuevo post
          _buildCreatePostCard(),
          const SizedBox(height: 20),
          
          // Lista de posts
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
            'Compartir en la Comunidad',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _postController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: '¿Cómo te sientes hoy? Comparte tu experiencia...',
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: const Color(0xFF1565C0).withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF1565C0)),
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
                child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
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
                  backgroundColor: const Color(0xFF1565C0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Publicar', style: TextStyle(color: Colors.white)),
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
          color: const Color(0xFF1565C0).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header del post con gradiente
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF1565C0).withOpacity(0.1),
                  const Color(0xFF1976D2).withOpacity(0.05),
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
                      colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1565C0).withOpacity(0.3),
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
                          color: Color(0xFF1565C0),
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1565C0).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Comunidad',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Contenido del post
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.content,
                  style: const TextStyle(
                    color: Color(0xFF424242),
                    height: 1.6,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 15),
                
                // Acciones del post mejoradas
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
                        color: const Color(0xFF1565C0),
                        onTap: () => _showComments(post),
                      ),
                      Container(
                        height: 20,
                        width: 1,
                        color: Colors.grey[300],
                      ),
                      _buildActionButton(
                        icon: post.isLiked ? Icons.favorite : Icons.favorite_border,
                        label: '${post.likes}',
                        color: post.isLiked ? Colors.red : const Color(0xFF1565C0),
                        onTap: () {
                          setState(() {
                            post.isLiked = !post.isLiked;
                            post.likes += post.isLiked ? 1 : -1;
                          });
                        },
                      ),
                      Container(
                        height: 20,
                        width: 1,
                        color: Colors.grey[300],
                      ),
                      _buildActionButton(
                        icon: Icons.share_outlined,
                        label: 'Compartir',
                        color: const Color(0xFF1565C0),
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

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              color: Color(0xFF1565C0),
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
              backgroundColor: const Color(0xFF4CAF50),
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
                  color: const Color(0xFF4CAF50).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  group.icon,
                  color: const Color(0xFF4CAF50),
                ),
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
                        color: Color(0xFF4CAF50),
                      ),
                    ),
                    Text(
                      '${group.members} miembros',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showJoinGroupDialog(group);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
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
            style: const TextStyle(
              color: Color(0xFF424242),
              fontSize: 14,
            ),
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
          ..._getEducationalResources().map((resource) => _buildResourceCard(resource)),
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
              color: const Color(0xFF9C27B0).withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              resource.icon,
              color: const Color(0xFF9C27B0),
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
                    color: Color(0xFF9C27B0),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  resource.description,
                  style: const TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 5),
                    Text(
                      resource.duration,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.amber[600],
                    ),
                    const SizedBox(width: 5),
                    Text(
                      resource.rating.toString(),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
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
            icon: const Icon(Icons.play_circle_fill, color: Color(0xFF9C27B0)),
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
                  color: const Color(0xFFFF9800).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  event.icon,
                  color: const Color(0xFFFF9800),
                ),
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
                        color: Color(0xFFFF9800),
                      ),
                    ),
                    Text(
                      event.dateTime,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _showEventDetails(event);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9800),
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
            style: const TextStyle(
              color: Color(0xFF424242),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Icon(
                Icons.people,
                size: 14,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 5),
              Text(
                '${event.attendees} participantes',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              if (event.isOnline)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'En línea',
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
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

  // Métodos para mostrar diálogos y funcionalidades
  void _showPostCreated() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Tu publicación se ha compartido con la comunidad!'),
        backgroundColor: Color(0xFF1565C0),
      ),
    );
  }

  void _showComments(ForumPost post) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Comentarios',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1565C0),
                ),
              ),
              const SizedBox(height: 15),
              ...post.comments.map((comment) => _buildCommentItem(comment)),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Escribe un comentario...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      if (_commentController.text.isNotEmpty) {
                        _commentController.clear();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Comentario agregado'),
                            backgroundColor: Color(0xFF4CAF50),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.send, color: Color(0xFF1565C0)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentItem(Comment comment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: const Color(0xFF1565C0).withOpacity(0.2),
            child: Text(
              comment.author.substring(0, 1),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.author,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFF1565C0),
                  ),
                ),
                Text(
                  comment.content,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF424242),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateGroupDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Crear Grupo de Apoyo'),
        content: const Text('Esta funcionalidad estará disponible pronto.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  void _showJoinGroupDialog(SupportGroup group) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Unirse a ${group.name}'),
        content: Text('¿Te gustaría unirte a este grupo de apoyo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Te has unido a ${group.name}'),
                  backgroundColor: const Color(0xFF4CAF50),
                ),
              );
            },
            child: const Text('Unirse'),
          ),
        ],
      ),
    );
  }

  void _showResourceDialog(EducationalResource resource) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(resource.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(resource.description),
            const SizedBox(height: 10),
            Text('Duración: ${resource.duration}'),
            Text('Rating: ${resource.rating}/5'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Recurso iniciado'),
                  backgroundColor: Color(0xFF9C27B0),
                ),
              );
            },
            child: const Text('Comenzar'),
          ),
        ],
      ),
    );
  }

  void _showEventDetails(CommunityEvent event) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(event.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.description),
            const SizedBox(height: 10),
            Text('Fecha: ${event.dateTime}'),
            Text('Participantes: ${event.attendees}'),
            Text('Tipo: ${event.isOnline ? "En línea" : "Presencial"}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Te has registrado al evento'),
                  backgroundColor: Color(0xFFFF9800),
                ),
              );
            },
            child: const Text('Registrarse'),
          ),
        ],
      ),
    );
  }

  // Datos de ejemplo
  List<ForumPost> _getForumPosts() {
    return [
      ForumPost(
        author: 'María',
        content: 'Hoy me siento más tranquila después de practicar mindfulness. ¿Alguien más ha probado esta técnica?',
        timeAgo: 'hace 2 horas',
        likes: 12,
        isLiked: false,
        comments: [
          Comment(author: 'Carlos', content: '¡Excelente! Yo también la practico diariamente.'),
          Comment(author: 'Ana', content: '¿Podrías compartir algunos consejos?'),
        ],
      ),
      ForumPost(
        author: 'Carlos',
        content: 'Comparto mi experiencia con la ansiedad y cómo he aprendido a manejarla mejor.',
        timeAgo: 'hace 5 horas',
        likes: 8,
        isLiked: true,
        comments: [
          Comment(author: 'María', content: 'Gracias por compartir, me ayuda mucho.'),
        ],
      ),
    ];
  }

  List<SupportGroup> _getSupportGroups() {
    return [
      SupportGroup(
        name: 'Manejo de Ansiedad',
        description: 'Grupo de apoyo para personas que enfrentan ansiedad',
        members: 24,
        icon: Icons.psychology,
      ),
      SupportGroup(
        name: 'Mindfulness y Meditación',
        description: 'Practicantes de mindfulness y meditación',
        members: 18,
        icon: Icons.self_improvement,
      ),
      SupportGroup(
        name: 'Apoyo Emocional',
        description: 'Espacio para compartir emociones y experiencias',
        members: 32,
        icon: Icons.favorite,
      ),
    ];
  }

  List<EducationalResource> _getEducationalResources() {
    return [
      EducationalResource(
        title: 'Técnicas de Respiración',
        description: 'Aprende diferentes técnicas de respiración para reducir el estrés',
        duration: '15 min',
        rating: 4.8,
        icon: Icons.air,
      ),
      EducationalResource(
        title: 'Guía de Mindfulness',
        description: 'Introducción completa al mindfulness y sus beneficios',
        duration: '30 min',
        rating: 4.9,
        icon: Icons.book,
      ),
      EducationalResource(
        title: 'Ejercicios de Relajación',
        description: 'Rutina de ejercicios para relajar cuerpo y mente',
        duration: '20 min',
        rating: 4.7,
        icon: Icons.spa,
      ),
    ];
  }

  List<CommunityEvent> _getCommunityEvents() {
    return [
      CommunityEvent(
        title: 'Meditación Grupal',
        description: 'Sesión de meditación guiada para toda la comunidad',
        dateTime: 'Sábado 15:00',
        attendees: 45,
        isOnline: true,
        icon: Icons.self_improvement,
      ),
      CommunityEvent(
        title: 'Taller de Ansiedad',
        description: 'Taller práctico sobre técnicas para manejar la ansiedad',
        dateTime: 'Domingo 10:00',
        attendees: 28,
        isOnline: false,
        icon: Icons.psychology,
      ),
      CommunityEvent(
        title: 'Grupo de Apoyo',
        description: 'Reunión semanal del grupo de apoyo emocional',
        dateTime: 'Lunes 19:00',
        attendees: 35,
        isOnline: true,
        icon: Icons.support,
      ),
    ];
  }
}

// Clases de modelo
class ForumPost {
  final String author;
  final String content;
  final String timeAgo;
  int likes;
  bool isLiked;
  final List<Comment> comments;

  ForumPost({
    required this.author,
    required this.content,
    required this.timeAgo,
    required this.likes,
    required this.isLiked,
    required this.comments,
  });
}

class Comment {
  final String author;
  final String content;

  Comment({required this.author, required this.content});
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
