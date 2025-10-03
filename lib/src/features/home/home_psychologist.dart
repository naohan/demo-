import 'package:flutter/material.dart';
import '../../widgets/psychologist_base_layout.dart';

enum PatientMood { happy, neutral, sad }

class Patient {
  final String name;
  final String lastName;
  final String avatar;
  final PatientMood mood;

  Patient({
    required this.name,
    required this.lastName,
    required this.avatar,
    required this.mood,
  });
}

class Session {
  final String time;
  final String patientName;
  final String patientAvatar;

  Session({
    required this.time,
    required this.patientName,
    required this.patientAvatar,
  });
}

class HomePsychologistScreen extends StatefulWidget {
  static const route = '/home-psychologist';
  const HomePsychologistScreen({super.key});

  @override
  State<HomePsychologistScreen> createState() => _HomePsychologistScreenState();
}

class _HomePsychologistScreenState extends State<HomePsychologistScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Patient> _activePatients = [
    Patient(
      name: 'María',
      lastName: 'González',
      avatar: 'https://randomuser.me/api/portraits/women/1.jpg',
      mood: PatientMood.happy,
    ),
    Patient(
      name: 'Carlos',
      lastName: 'Mendoza',
      avatar: 'https://randomuser.me/api/portraits/men/1.jpg',
      mood: PatientMood.neutral,
    ),
    Patient(
      name: 'Ana',
      lastName: 'Rodríguez',
      avatar: 'https://randomuser.me/api/portraits/women/2.jpg',
      mood: PatientMood.sad,
    ),
  ];

  final List<Session> _upcomingSessions = [
    Session(
      time: '2:00 PM',
      patientName: 'María González',
      patientAvatar: 'https://randomuser.me/api/portraits/women/1.jpg',
    ),
    Session(
      time: '4:30 PM',
      patientName: 'Juan Pérez',
      patientAvatar: 'https://randomuser.me/api/portraits/men/2.jpg',
    ),
    Session(
      time: '6:00 PM',
      patientName: 'Carla',
      patientAvatar: 'https://randomuser.me/api/portraits/women/3.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PsychologistBaseLayout(
      title: 'Dashboard',
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Saludo personalizado
                _buildWelcomeSection(),
                const SizedBox(height: 24),

                // Pacientes activos
                _buildActivePatientsSection(),
                const SizedBox(height: 24),

                // Próximas sesiones
                _buildUpcomingSessionsSection(),
                const SizedBox(height: 24),

                // Botones de acción
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6B73FF).withOpacity(0.1),
            const Color(0xFF9DD5EA).withOpacity(0.1),
          ],
        ),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hola, Dra. Andrea',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2C3E50),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Que tengas un día lleno de paz y sanación 🌿',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivePatientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pacientes activos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(_activePatients.length, (index) {
          final patient = _activePatients[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: _buildPatientCard(patient, index),
          );
        }),
      ],
    );
  }

  Widget _buildPatientCard(Patient patient, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 600 + (index * 100)),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
      ),
      child: Row(
        children: [
          // Avatar del paciente
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(patient.avatar),
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(width: 16),

          // Información del paciente
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                Text(
                  patient.lastName,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Indicador de estado de ánimo
          _buildMoodIndicator(patient.mood),
        ],
      ),
    );
  }

  Widget _buildMoodIndicator(PatientMood mood) {
    IconData icon;
    Color color;

    switch (mood) {
      case PatientMood.happy:
        icon = Icons.sentiment_very_satisfied;
        color = const Color(0xFF2ECC71);
        break;
      case PatientMood.neutral:
        icon = Icons.sentiment_neutral;
        color = const Color(0xFFF39C12);
        break;
      case PatientMood.sad:
        icon = Icons.sentiment_dissatisfied;
        color = const Color(0xFF95A5A6);
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Widget _buildUpcomingSessionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Próximas sesiones',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(_upcomingSessions.length, (index) {
          final session = _upcomingSessions[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: _buildSessionCard(session, index),
          );
        }),
      ],
    );
  }

  Widget _buildSessionCard(Session session, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800 + (index * 100)),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF6B73FF).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar del paciente
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(session.patientAvatar),
            backgroundColor: Colors.grey[200],
          ),
          const SizedBox(width: 16),

          // Información de la sesión
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.time,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B73FF),
                  ),
                ),
                Text(
                  session.patientName,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Flecha indicadora
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF6B73FF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF6B73FF),
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.edit_note,
            label: 'Nueva nota',
            color: const Color(0xFF6B73FF),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Función de notas en desarrollo')),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            icon: Icons.lightbulb_outline,
            label: 'Recomendación',
            color: const Color(0xFF2ECC71),
            onTap: () {
              Navigator.pushNamed(context, '/community-mind');
            },
          ),
        ),
      ],
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
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
