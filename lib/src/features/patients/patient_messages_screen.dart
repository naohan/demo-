import 'package:flutter/material.dart';
import '../../widgets/psychologist_base_layout.dart';

class RecentReport {
  final String title;
  final String diagnosis;
  final String recommendations;

  RecentReport({
    required this.title,
    required this.diagnosis,
    required this.recommendations,
  });
}

class PatientMessagesScreen extends StatefulWidget {
  static const route = '/patient-messages';

  final String? patientName;

  const PatientMessagesScreen({super.key, this.patientName});

  @override
  State<PatientMessagesScreen> createState() => _PatientMessagesScreenState();
}

class _PatientMessagesScreenState extends State<PatientMessagesScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<RecentReport> recentReports = [
    RecentReport(
      title: 'Paciente: Juan...',
      diagnosis: 'Ansiedad leve, estrés laboral',
      recommendations: 'Terapia conductual, ejercicios de respiración',
    ),
    RecentReport(
      title: 'Sepurtation',
      diagnosis: 'Ansiedad leve, estrés laboral',
      recommendations: 'Terapia conductual, ejercicios de respiración',
    ),
    RecentReport(
      title: 'Padeentacion',
      diagnosis: 'Ansiedad leve, estrés laboral',
      recommendations: 'Terapia conductual, ejercicios de respiración',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PsychologistBaseLayout(
      title: '',
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFDDD6FE), Color(0xFFC7D2FE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildDateNote(),
                const SizedBox(height: 24),
                _buildRecentReports(),
                const SizedBox(height: 24),
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.menu, color: Color(0xFF8B5CF6), size: 24),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Row(
              children: [
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: Color(0xFF8B5CF6),
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'Serenity Pro',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'DÉBIL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateNote() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFF8B5CF6),
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Jueves, 17 Oct',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B5CF6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Nota: Hoy me sentí bastante frustrado por la tarea de la tarea no puede terminar.',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF374151),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap:
                () => Navigator.pushNamed(
                  context,
                  '/patient-calendar',
                  arguments: widget.patientName,
                ),
            child: const Text(
              'Ver historial completo',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF8B5CF6),
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReports() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informes Recientes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 20),
          Column(
            children:
                recentReports
                    .map((report) => _buildReportCard(report))
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(RecentReport report) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: Color(0xFF8B5CF6),
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  report.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Diagnóstico:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          Text(
            report.diagnosis,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF374151),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Recomendación:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          Text(
            report.recommendations,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF374151),
              height: 1.4,
            ),
          ),
          // Indicador de overflow como en la imagen
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 20,
            decoration: BoxDecoration(
              color: Colors.yellow.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Center(
              child: Text(
                'BOTTOM OVERFLOWED BY 38 PIXELS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
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
            'Diario',
            Icons.book_outlined,
            const Color(0xFF8B5CF6),
            () => Navigator.pushNamed(
              context,
              '/patient-calendar',
              arguments: widget.patientName,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            'Mensajes',
            Icons.send_outlined,
            const Color(0xFF8B5CF6),
            () => Navigator.pushNamed(
              context,
              '/patient-chat',
              arguments: widget.patientName,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 12,
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
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
