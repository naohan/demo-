import 'package:flutter/material.dart';
import '../../../widgets/trainer_base_layout.dart';
import 'trainers_screen.dart';

class CommunityVitalScreen extends StatefulWidget {
  static const route = '/community-vital';
  const CommunityVitalScreen({super.key});

  @override
  State<CommunityVitalScreen> createState() => _CommunityVitalScreenState();
}

class _CommunityVitalScreenState extends State<CommunityVitalScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Datos del foro
  final List<ForumPost> _forumPosts = [
    ForumPost(
      id: 1,
      title: "¿Cómo empezar con el cardio?",
      author: "María González",
      authorAvatar: "https://randomuser.me/api/portraits/women/1.jpg",
      content:
          "Hola comunidad! Soy nueva en esto del ejercicio y quiero empezar con cardio. ¿Algún consejo para principiantes?",
      likes: 12,
      comments: 8,
      timeAgo: "2 horas",
      category: "Cardio",
      isLiked: false,
    ),
    ForumPost(
      id: 2,
      title: "Rutina de fuerza para casa",
      author: "Carlos Ruiz",
      authorAvatar: "https://randomuser.me/api/portraits/men/2.jpg",
      content:
          "Comparto mi rutina de fuerza que hago en casa. Solo necesitas unas pesas básicas y mucha motivación! 💪",
      likes: 24,
      comments: 15,
      timeAgo: "4 horas",
      category: "Fuerza",
      isLiked: true,
    ),
    ForumPost(
      id: 3,
      title: "Recuperación después del ejercicio",
      author: "Ana Martínez",
      authorAvatar: "https://randomuser.me/api/portraits/women/3.jpg",
      content:
          "La recuperación es tan importante como el ejercicio. ¿Qué hacen ustedes para recuperarse mejor?",
      likes: 18,
      comments: 12,
      timeAgo: "6 horas",
      category: "Recuperación",
      isLiked: false,
    ),
    ForumPost(
      id: 4,
      title: "Motivación para seguir entrenando",
      author: "Pedro López",
      authorAvatar: "https://randomuser.me/api/portraits/men/4.jpg",
      content:
          "A veces es difícil mantener la motivación. ¿Cuáles son sus tips para no rendirse?",
      likes: 31,
      comments: 22,
      timeAgo: "1 día",
      category: "Motivación",
      isLiked: true,
    ),
    ForumPost(
      id: 5,
      title: "Alimentación pre y post entrenamiento",
      author: "Laura Sánchez",
      authorAvatar: "https://randomuser.me/api/portraits/women/5.jpg",
      content:
          "¿Qué comen antes y después de entrenar? Busco ideas saludables y fáciles de preparar.",
      likes: 15,
      comments: 9,
      timeAgo: "1 día",
      category: "Nutrición",
      isLiked: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TrainerBaseLayout(
      title: 'Comunidad Zona Vital',
      hero: AnimatedBuilder(
        animation: _fadeAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 0.9 + (_fadeAnimation.value * 0.1),
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Container(
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
            ),
          );
        },
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              // Botón de encontrar entrenador
              _buildFindTrainerSection(),
              const SizedBox(height: 20),

              // Header del foro
              _buildForumHeader(),
              const SizedBox(height: 16),

              // Lista del foro
              Expanded(child: _buildForumList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFindTrainerSection() {
    return Container(
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF3498DB).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF3498DB),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_search,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '¿Necesitas un entrenador?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    Text(
                      'Encuentra el entrenador perfecto para tus objetivos',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed:
                  () => Navigator.pushNamed(context, TrainersScreen.route),
              icon: const Icon(Icons.search),
              label: const Text('Encuentra a tu Entrenador'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3498DB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForumHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2ECC71).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.forum, color: Color(0xFF2ECC71), size: 24),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Foro de la Comunidad',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _showCreatePostDialog,
            icon: const Icon(Icons.add),
            label: const Text('Nuevo Post'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2ECC71),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForumList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _forumPosts.length,
        separatorBuilder: (context, index) => const Divider(height: 24),
        itemBuilder: (context, index) {
          final post = _forumPosts[index];
          return _buildForumPost(post);
        },
      ),
    );
  }

  Widget _buildForumPost(ForumPost post) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF2ECC71).withOpacity(0.05), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF2ECC71).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header del post
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(post.authorAvatar),
                onBackgroundImageError: (exception, stackTrace) {},
                child: const Icon(Icons.person),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    Text(
                      post.timeAgo,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF3498DB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  post.category,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3498DB),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Título del post
          Text(
            post.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 8),

          // Contenido del post
          Text(
            post.content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),

          // Acciones del post
          Row(
            children: [
              InkWell(
                onTap: () => _toggleLike(post),
                child: Row(
                  children: [
                    Icon(
                      post.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: post.isLiked ? Colors.red : Colors.grey[600],
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post.likes}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              InkWell(
                onTap: () => _showPostComments(post),
                child: Row(
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      color: Colors.grey[600],
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post.comments}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => _showPostComments(post),
                child: const Text(
                  'Ver más',
                  style: TextStyle(fontSize: 12, color: Color(0xFF3498DB)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleLike(ForumPost post) {
    setState(() {
      final index = _forumPosts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        _forumPosts[index] = ForumPost(
          id: post.id,
          title: post.title,
          author: post.author,
          authorAvatar: post.authorAvatar,
          content: post.content,
          likes: post.isLiked ? post.likes - 1 : post.likes + 1,
          comments: post.comments,
          timeAgo: post.timeAgo,
          category: post.category,
          isLiked: !post.isLiked,
        );
      }
    });
  }

  void _showCreatePostDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('Crear Nuevo Post'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Contenido',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Post creado exitosamente!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2ECC71),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Publicar'),
              ),
            ],
          ),
    );
  }

  void _showPostComments(ForumPost post) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(post.title),
            content: SizedBox(
              width: double.maxFinite,
              height: 400,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: List.generate(
                        post.comments,
                        (index) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundImage: NetworkImage(
                                      'https://randomuser.me/api/portraits/${index % 2 == 0 ? 'men' : 'women'}/${index + 1}.jpg',
                                    ),
                                    child: const Icon(Icons.person, size: 16),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Usuario ${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Este es un comentario de ejemplo sobre el post. Muy útil! 👍',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Escribe tu comentario...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
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
}

class ForumPost {
  final int id;
  final String title;
  final String author;
  final String authorAvatar;
  final String content;
  final int likes;
  final int comments;
  final String timeAgo;
  final String category;
  final bool isLiked;

  ForumPost({
    required this.id,
    required this.title,
    required this.author,
    required this.authorAvatar,
    required this.content,
    required this.likes,
    required this.comments,
    required this.timeAgo,
    required this.category,
    required this.isLiked,
  });
}
