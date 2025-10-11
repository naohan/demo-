import 'package:flutter/material.dart';
import '../../../widgets/trainer_base_layout.dart';

class CommunityVitalInteractiveScreen extends StatefulWidget {
  static const route = '/community-vital-interactive';
  const CommunityVitalInteractiveScreen({super.key});

  @override
  State<CommunityVitalInteractiveScreen> createState() => _CommunityVitalInteractiveScreenState();
}

class _CommunityVitalInteractiveScreenState extends State<CommunityVitalInteractiveScreen>
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
    return TrainerBaseLayout(
      title: 'Comunidad Vital',
      hero: const Icon(Icons.fitness_center, size: 64),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFE8F5E8), // Verde muy claro
              const Color(0xFFC8E6C9), // Verde claro
              const Color(0xFFA5D6A7), // Verde medio claro
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Tab bar personalizado
            Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF4CAF50),
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                tabs: const [
                  Tab(text: 'Foros', icon: Icon(Icons.forum, size: 18)),
                  Tab(text: 'Grupos', icon: Icon(Icons.group, size: 18)),
                  Tab(text: 'Recursos', icon: Icon(Icons.library_books, size: 18)),
                  Tab(text: 'Eventos', icon: Icon(Icons.event, size: 18)),
                ],
              ),
            ),
            
            // Contenido de las pestañas
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildForumsTab(),
                  _buildTrainingGroupsTab(),
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
          ..._getFitnessPosts().map((post) => _buildForumPost(post)),
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
            'Comparte tu Rutina',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4CAF50),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _postController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: '¿Qué rutina hiciste hoy? Comparte tus consejos...',
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: const Color(0xFF4CAF50).withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF4CAF50)),
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
                  backgroundColor: const Color(0xFF4CAF50),
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

  Widget _buildForumPost(FitnessPost post) {
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
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF4CAF50).withOpacity(0.2),
                child: Text(
                  post.author.substring(0, 1),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                      ),
                    ),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  post.category,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post.content,
            style: const TextStyle(
              color: Color(0xFF424242),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _showComments(post);
                },
                icon: const Icon(Icons.comment, color: Color(0xFF4CAF50)),
              ),
              Text('${post.comments.length}'),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () {
                  setState(() {
                    post.isLiked = !post.isLiked;
                    post.likes += post.isLiked ? 1 : -1;
                  });
                },
                icon: Icon(
                  post.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: post.isLiked ? Colors.red : const Color(0xFF4CAF50),
                ),
              ),
              Text('${post.likes}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingGroupsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Crear nuevo grupo
          _buildCreateGroupCard(),
          const SizedBox(height: 20),
          
          // Lista de grupos
          ..._getTrainingGroups().map((group) => _buildTrainingGroupCard(group)),
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
            'Crear Grupo de Entrenamiento',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4CAF50),
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
              backgroundColor: const Color(0xFF2196F3),
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

  Widget _buildTrainingGroupCard(TrainingGroup group) {
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
                  color: const Color(0xFF2196F3).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  group.icon,
                  color: const Color(0xFF2196F3),
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
                        color: Color(0xFF2196F3),
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
                  backgroundColor: const Color(0xFF2196F3),
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
          // Recursos educativos
          ..._getFitnessResources().map((resource) => _buildResourceCard(resource)),
          
          const SizedBox(height: 20),
          
          // Recetas saludables
          Container(
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
                const Text(
                  'Recetas Saludables',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF9800),
                  ),
                ),
                const SizedBox(height: 15),
                ..._getHealthyRecipes().map((recipe) => _buildRecipeCard(recipe)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(FitnessResource resource) {
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

  Widget _buildRecipeCard(HealthyRecipe recipe) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFFF9800).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.restaurant, color: const Color(0xFFFF9800), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipe.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF9800),
                  ),
                ),
                Text(
                  recipe.description,
                  style: const TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Text(
                recipe.time,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
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
          ..._getFitnessEvents().map((event) => _buildEventCard(event)),
        ],
      ),
    );
  }

  Widget _buildEventCard(FitnessEvent event) {
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
                  color: const Color(0xFFFF5722).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  event.icon,
                  color: const Color(0xFFFF5722),
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
                        color: Color(0xFFFF5722),
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
                  backgroundColor: const Color(0xFFFF5722),
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
        content: Text('¡Tu rutina se ha compartido con la comunidad!'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _showComments(FitnessPost post) {
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
                  color: Color(0xFF4CAF50),
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
                    icon: const Icon(Icons.send, color: Color(0xFF4CAF50)),
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
            backgroundColor: const Color(0xFF4CAF50).withOpacity(0.2),
            child: Text(
              comment.author.substring(0, 1),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4CAF50),
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
                    color: Color(0xFF4CAF50),
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
        title: const Text('Crear Grupo de Entrenamiento'),
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

  void _showJoinGroupDialog(TrainingGroup group) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Unirse a ${group.name}'),
        content: Text('¿Te gustaría unirte a este grupo de entrenamiento?'),
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
                  backgroundColor: const Color(0xFF2196F3),
                ),
              );
            },
            child: const Text('Unirse'),
          ),
        ],
      ),
    );
  }

  void _showResourceDialog(FitnessResource resource) {
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

  void _showEventDetails(FitnessEvent event) {
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
                  backgroundColor: Color(0xFFFF5722),
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
  List<FitnessPost> _getFitnessPosts() {
    return [
      FitnessPost(
        author: 'María',
        content: 'Hoy completé mi rutina de cardio de 45 minutos! 💪 ¿Alguien más quiere compartir sus rutinas de cardio?',
        timeAgo: 'hace 2 horas',
        likes: 15,
        isLiked: false,
        category: 'Cardio',
        comments: [
          Comment(author: 'Carlos', content: '¡Excelente! Yo hice 30 min de HIIT.'),
          Comment(author: 'Ana', content: '¿Podrías compartir tu rutina?'),
        ],
      ),
      FitnessPost(
        author: 'Carlos',
        content: 'Comparto mi rutina de fuerza para principiantes. Empecé hace 3 meses y ya veo resultados!',
        timeAgo: 'hace 4 horas',
        likes: 22,
        isLiked: true,
        category: 'Fuerza',
        comments: [
          Comment(author: 'María', content: '¡Inspirador! Gracias por compartir.'),
        ],
      ),
    ];
  }

  List<TrainingGroup> _getTrainingGroups() {
    return [
      TrainingGroup(
        name: 'Principiantes en Fitness',
        description: 'Grupo para personas que están comenzando su journey fitness',
        members: 45,
        icon: Icons.fitness_center,
      ),
      TrainingGroup(
        name: 'Entrenamiento en Casa',
        description: 'Rutinas y ejercicios que puedes hacer desde casa',
        members: 32,
        icon: Icons.home,
      ),
      TrainingGroup(
        name: 'CrossFit Community',
        description: 'Apasionados del CrossFit compartiendo experiencias',
        members: 28,
        icon: Icons.sports_gymnastics,
      ),
    ];
  }

  List<FitnessResource> _getFitnessResources() {
    return [
      FitnessResource(
        title: 'Guía de Ejercicios Básicos',
        description: 'Aprende los ejercicios fundamentales para comenzar',
        duration: '20 min',
        rating: 4.8,
        icon: Icons.fitness_center,
      ),
      FitnessResource(
        title: 'Rutina de Cardio HIIT',
        description: 'Entrenamiento de alta intensidad para quemar grasa',
        duration: '25 min',
        rating: 4.9,
        icon: Icons.directions_run,
      ),
      FitnessResource(
        title: 'Flexibilidad y Estiramientos',
        description: 'Mejora tu flexibilidad con estos ejercicios',
        duration: '15 min',
        rating: 4.7,
        icon: Icons.accessibility_new,
      ),
    ];
  }

  List<HealthyRecipe> _getHealthyRecipes() {
    return [
      HealthyRecipe(
        name: 'Smoothie Verde Energético',
        description: 'Desayuno rico en vitaminas y minerales',
        time: '10 min',
      ),
      HealthyRecipe(
        name: 'Ensalada de Quinoa y Pollo',
        description: 'Almuerzo completo y nutritivo',
        time: '20 min',
      ),
      HealthyRecipe(
        name: 'Salmon a la Plancha',
        description: 'Cena rica en omega-3 y proteínas',
        time: '15 min',
      ),
    ];
  }

  List<FitnessEvent> _getFitnessEvents() {
    return [
      FitnessEvent(
        title: 'Clase de Yoga Grupal',
        description: 'Sesión de yoga para toda la comunidad',
        dateTime: 'Sábado 10:00',
        attendees: 35,
        isOnline: true,
        icon: Icons.self_improvement,
      ),
      FitnessEvent(
        title: 'Reto de 30 días',
        description: 'Desafío de fitness de 30 días para la comunidad',
        dateTime: 'Inicia Lunes',
        attendees: 150,
        isOnline: false,
        icon: Icons.emoji_events,
      ),
      FitnessEvent(
        title: 'Workshop de Nutrición',
        description: 'Aprende sobre alimentación saludable',
        dateTime: 'Domingo 15:00',
        attendees: 42,
        isOnline: true,
        icon: Icons.restaurant_menu,
      ),
    ];
  }
}

// Clases de modelo
class FitnessPost {
  final String author;
  final String content;
  final String timeAgo;
  int likes;
  bool isLiked;
  final String category;
  final List<Comment> comments;

  FitnessPost({
    required this.author,
    required this.content,
    required this.timeAgo,
    required this.likes,
    required this.isLiked,
    required this.category,
    required this.comments,
  });
}

class Comment {
  final String author;
  final String content;

  Comment({required this.author, required this.content});
}

class TrainingGroup {
  final String name;
  final String description;
  final int members;
  final IconData icon;

  TrainingGroup({
    required this.name,
    required this.description,
    required this.members,
    required this.icon,
  });
}

class FitnessResource {
  final String title;
  final String description;
  final String duration;
  final double rating;
  final IconData icon;

  FitnessResource({
    required this.title,
    required this.description,
    required this.duration,
    required this.rating,
    required this.icon,
  });
}

class HealthyRecipe {
  final String name;
  final String description;
  final String time;

  HealthyRecipe({
    required this.name,
    required this.description,
    required this.time,
  });
}

class FitnessEvent {
  final String title;
  final String description;
  final String dateTime;
  final int attendees;
  final bool isOnline;
  final IconData icon;

  FitnessEvent({
    required this.title,
    required this.description,
    required this.dateTime,
    required this.attendees,
    required this.isOnline,
    required this.icon,
  });
}
