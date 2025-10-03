import 'package:flutter/material.dart';
import '../../../widgets/trainer_base_layout.dart';

class TrainersScreen extends StatefulWidget {
  static const route = '/trainers';
  const TrainersScreen({super.key});

  @override
  State<TrainersScreen> createState() => _TrainersScreenState();
}

class _TrainersScreenState extends State<TrainersScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _searchController = TextEditingController();
  String _selectedCity = 'Todas las ciudades';

  // Lista de entrenadores
  final List<Trainer> _trainers = [
    Trainer(
      id: 1,
      name: 'Carlos Mendoza',
      specialty: 'Fuerza y Acondicionamiento',
      city: 'Lima',
      rating: 4.9,
      reviews: 127,
      experience: '8 años',
      price: 50,
      avatar: 'https://randomuser.me/api/portraits/men/1.jpg',
      description:
          'Especialista en entrenamiento de fuerza y acondicionamiento físico. Certificado en NSCA.',
      specialties: ['Fuerza', 'Acondicionamiento', 'Perder peso'],
      availability: 'Lun-Vie: 6:00-20:00',
    ),
    Trainer(
      id: 2,
      name: 'María González',
      specialty: 'Yoga y Pilates',
      city: 'Arequipa',
      rating: 4.8,
      reviews: 89,
      experience: '6 años',
      price: 40,
      avatar: 'https://randomuser.me/api/portraits/women/2.jpg',
      description:
          'Instructora certificada de Yoga y Pilates. Enfoque en bienestar integral.',
      specialties: ['Yoga', 'Pilates', 'Flexibilidad'],
      availability: 'Lun-Sáb: 7:00-19:00',
    ),
    Trainer(
      id: 3,
      name: 'Pedro Ramírez',
      specialty: 'CrossFit',
      city: 'Lima',
      rating: 4.7,
      reviews: 156,
      experience: '5 años',
      price: 45,
      avatar: 'https://randomuser.me/api/portraits/men/3.jpg',
      description:
          'Entrenador certificado de CrossFit con experiencia en competiciones.',
      specialties: ['CrossFit', 'HIIT', 'Competencia'],
      availability: 'Lun-Vie: 5:00-21:00',
    ),
    Trainer(
      id: 4,
      name: 'Ana Silva',
      specialty: 'Running y Cardio',
      city: 'Trujillo',
      rating: 4.9,
      reviews: 73,
      experience: '7 años',
      price: 35,
      avatar: 'https://randomuser.me/api/portraits/women/4.jpg',
      description:
          'Maratonista profesional y entrenadora de running. Especializada en resistencia.',
      specialties: ['Running', 'Cardio', 'Maratones'],
      availability: 'Lun-Dom: 6:00-18:00',
    ),
    Trainer(
      id: 5,
      name: 'Luis Torres',
      specialty: 'Culturismo',
      city: 'Lima',
      rating: 4.6,
      reviews: 98,
      experience: '10 años',
      price: 60,
      avatar: 'https://randomuser.me/api/portraits/men/5.jpg',
      description:
          'Culturista profesional con amplia experiencia en entrenamiento de hipertrofia.',
      specialties: ['Culturismo', 'Hipertrofia', 'Nutrición'],
      availability: 'Lun-Sáb: 6:00-22:00',
    ),
    Trainer(
      id: 6,
      name: 'Carmen Vega',
      specialty: 'Fitness Funcional',
      city: 'Cusco',
      rating: 4.8,
      reviews: 64,
      experience: '4 años',
      price: 42,
      avatar: 'https://randomuser.me/api/portraits/women/6.jpg',
      description:
          'Especialista en fitness funcional y entrenamiento personalizado.',
      specialties: ['Funcional', 'Personalizado', 'Rehabilitación'],
      availability: 'Lun-Vie: 7:00-20:00',
    ),
  ];

  List<Trainer> get _filteredTrainers {
    var filtered =
        _trainers.where((trainer) {
          final nameMatch = trainer.name.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
          final cityMatch =
              _selectedCity == 'Todas las ciudades' ||
              trainer.city == _selectedCity;
          return nameMatch && cityMatch;
        }).toList();

    // Ordenar por rating
    filtered.sort((a, b) => b.rating.compareTo(a.rating));
    return filtered;
  }

  List<String> get _cities {
    final cities = _trainers.map((trainer) => trainer.city).toSet().toList();
    cities.sort();
    return ['Todas las ciudades', ...cities];
  }

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
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TrainerBaseLayout(
      title: 'Entrenadores',
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
                  Icons.person_search,
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
              // Barra de búsqueda
              _buildSearchSection(),
              const SizedBox(height: 20),

              // Lista de entrenadores
              Expanded(child: _buildTrainersList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
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
      child: Column(
        children: [
          // Búsqueda por nombre
          TextField(
            controller: _searchController,
            onChanged: (value) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Buscar por nombre...',
              prefixIcon: const Icon(Icons.search, color: Color(0xFF3498DB)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF3498DB)),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Filtro por ciudad
          Row(
            children: [
              const Icon(Icons.location_on, color: Color(0xFF2ECC71), size: 20),
              const SizedBox(width: 8),
              const Text(
                'Ciudad:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButton<String>(
                  value: _selectedCity,
                  isExpanded: true,
                  underline: Container(),
                  items:
                      _cities.map((city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(
                            city,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCity = value!;
                    });
                  },
                ),
              ),
            ],
          ),

          // Contador de resultados
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF3498DB).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '${_filteredTrainers.length} entrenadores encontrados',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF3498DB),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainersList() {
    if (_filteredTrainers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No se encontraron entrenadores',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Intenta con otros criterios de búsqueda',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredTrainers.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final trainer = _filteredTrainers[index];
        return _buildTrainerCard(trainer);
      },
    );
  }

  Widget _buildTrainerCard(Trainer trainer) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, const Color(0xFF3498DB).withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF3498DB).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header del entrenador
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(trainer.avatar),
                onBackgroundImageError: (exception, stackTrace) {},
                child: const Icon(Icons.person, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trainer.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      trainer.specialty,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          trainer.city,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2ECC71),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          trainer.rating.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${trainer.reviews} reseñas',
                    style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Descripción
          Text(
            trainer.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),

          // Especialidades
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children:
                trainer.specialties.map((specialty) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3498DB).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      specialty,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3498DB),
                      ),
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 16),

          // Información adicional y botón
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          trainer.availability,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.work, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${trainer.experience} de experiencia',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'S/\$ ${trainer.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2ECC71),
                    ),
                  ),
                  const Text(
                    'por sesión',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Botón de contacto
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _contactTrainer(trainer),
              icon: const Icon(Icons.message),
              label: const Text('Contactar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3498DB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _contactTrainer(Trainer trainer) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text('Contactar a ${trainer.name}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(trainer.avatar),
                  child: const Icon(Icons.person, size: 40),
                ),
                const SizedBox(height: 16),
                Text(
                  '¿Cómo te gustaría contactar a ${trainer.name}?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Mensaje enviado a ${trainer.name}'),
                    ),
                  );
                },
                icon: const Icon(Icons.message),
                label: const Text('Enviar Mensaje'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3498DB),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
    );
  }
}

class Trainer {
  final int id;
  final String name;
  final String specialty;
  final String city;
  final double rating;
  final int reviews;
  final String experience;
  final double price;
  final String avatar;
  final String description;
  final List<String> specialties;
  final String availability;

  Trainer({
    required this.id,
    required this.name,
    required this.specialty,
    required this.city,
    required this.rating,
    required this.reviews,
    required this.experience,
    required this.price,
    required this.avatar,
    required this.description,
    required this.specialties,
    required this.availability,
  });
}
