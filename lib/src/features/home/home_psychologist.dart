import 'package:flutter/material.dart';
import '../../widgets/psychologist_base_layout.dart';

enum AnxietyLevel { leve, moderado, severo }

class PatientReport {
  final String name;
  final String avatar;
  final String diagnosis;
  final AnxietyLevel level;
  final String recommendations;

  PatientReport({
    required this.name,
    required this.avatar,
    required this.diagnosis,
    required this.level,
    required this.recommendations,
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

  // Puntuación semanal del psicólogo
  final int weeklyScore = 78;
  final double weeklyProgress = 0.78; // 78%

  // Informes recientes de pacientes
  final List<PatientReport> _recentReports = [
    PatientReport(
      name: 'Ana García',
      avatar:
          'https://ui-avatars.com/api/?name=Ana+Garcia&background=3b82f6&color=ffffff&size=128',
      diagnosis: 'Ansiedad',
      level: AnxietyLevel.leve,
      recommendations: 'Respiración 4-7, exposición',
    ),
    PatientReport(
      name: 'Luis Pérez',
      avatar:
          'https://ui-avatars.com/api/?name=Luis+Perez&background=3b82f6&color=ffffff&size=128',
      diagnosis: 'Ansiedad',
      level: AnxietyLevel.moderado,
      recommendations: 'Respiración 4-7, exposición',
    ),
    PatientReport(
      name: 'Carla Ruiz',
      avatar:
          'https://ui-avatars.com/api/?name=Carla+Ruiz&background=3b82f6&color=ffffff&size=128',
      diagnosis: 'Ansiedad',
      level: AnxietyLevel.leve,
      recommendations: 'Respiración 4-7, exposición',
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
      title: '',
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header personalizado
                _buildHeader(),
                const SizedBox(height: 24),

                // Puntuación semanal
                _buildWeeklyScore(),
                const SizedBox(height: 24),

                // Botones de acción rápida
                _buildQuickActions(),
                const SizedBox(height: 24),

                // Informes recientes
                _buildRecentReports(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method para obtener el texto del nivel de ansiedad
  String _getAnxietyLevelText(AnxietyLevel level) {
    switch (level) {
      case AnxietyLevel.leve:
        return 'leve';
      case AnxietyLevel.moderado:
        return 'moderado';
      case AnxietyLevel.severo:
        return 'severo';
    }
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.psychology, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hola, Dra. Andrea',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tienes ${_recentReports.length} pacientes activos hoy',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyScore() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF3B82F6).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.trending_up,
                  color: Color(0xFF3B82F6),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Puntuación semanal',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                weeklyScore.toString(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B82F6),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      color: Color(0xFF10B981),
                      size: 16,
                    ),
                    SizedBox(width: 2),
                    Text(
                      '+12%',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: const Color(0xFFE5E7EB),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: weeklyProgress,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Excelente progreso esta semana',
            style: TextStyle(fontSize: 12, color: const Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Acciones rápidas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.people_outline,
                title: 'Pacientes',
                subtitle: '${_recentReports.length} activos',
                color: const Color(0xFF3B82F6),
                onTap: () => _navigateToPatients(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                icon: Icons.calendar_today_outlined,
                title: 'Agenda',
                subtitle: '3 citas hoy',
                color: const Color(0xFF10B981),
                onTap: () => _showSnackBar('Agenda próximamente'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.assessment_outlined,
                title: 'Reportes',
                subtitle: 'Ver estadísticas',
                color: const Color(0xFF8B5CF6),
                onTap: () => _showSnackBar('Reportes próximamente'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                icon: Icons.note_add_outlined,
                title: 'Nueva Nota',
                subtitle: 'Agregar registro',
                color: const Color(0xFFF59E0B),
                onTap: () => _showSnackBar('Nueva nota próximamente'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.1), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPatients() {
    Navigator.pushNamed(context, '/patients-list');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF3B82F6),
      ),
    );
  }

  Widget _buildRecentReports() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informes recientes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(_recentReports.length, (index) {
          final report = _recentReports[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: _buildReportCard(report),
          );
        }),
      ],
    );
  }

  Widget _buildReportCard(PatientReport report) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF3B82F6).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Avatar del paciente con indicador de estado
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF3B82F6), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(report.avatar),
                  backgroundColor: const Color(0xFF3B82F6),
                  onBackgroundImageError: (exception, stackTrace) {
                    // En caso de error, se mostrará el backgroundColor
                  },
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: _getStatusColor(report.level),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Información del reporte
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      report.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(report.level).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getAnxietyLevelText(report.level).toUpperCase(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(report.level),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Dx: ${report.diagnosis}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Recs: ${report.recommendations}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),

          // Botón Ver detalle mejorado
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                // Acción para ver detalles
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ver detalles de ${report.name}'),
                    backgroundColor: const Color(0xFF3B82F6),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Ver detalle',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios, size: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(AnxietyLevel level) {
    switch (level) {
      case AnxietyLevel.leve:
        return const Color(0xFF10B981);
      case AnxietyLevel.moderado:
        return const Color(0xFFF59E0B);
      case AnxietyLevel.severo:
        return const Color(0xFFEF4444);
    }
  }
}
