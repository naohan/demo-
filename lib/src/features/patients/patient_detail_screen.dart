import 'package:flutter/material.dart';
import '../../widgets/psychologist_base_layout.dart';

class PatientData {
  final String name;
  final String avatar;
  final int age;
  final String lastSession;
  final String diagnosis;
  final Map<String, double> moodMetrics;
  final String insights;
  final String warnings;
  final List<CalendarDay> calendarDays;
  final List<RecentReport> recentReports;

  PatientData({
    required this.name,
    required this.avatar,
    required this.age,
    required this.lastSession,
    required this.diagnosis,
    required this.moodMetrics,
    required this.insights,
    required this.warnings,
    required this.calendarDays,
    required this.recentReports,
  });
}

class CalendarDay {
  final int day;
  final String emoji;
  final bool isToday;
  final String? note;

  CalendarDay({
    required this.day,
    required this.emoji,
    this.isToday = false,
    this.note,
  });
}

class RecentReport {
  final String title;
  final String patientName;
  final String diagnosis;
  final String recommendations;

  RecentReport({
    required this.title,
    required this.patientName,
    required this.diagnosis,
    required this.recommendations,
  });
}

class PatientDetailScreen extends StatefulWidget {
  static const route = '/patient-detail';

  final PatientData? patient;
  final String? patientName;

  const PatientDetailScreen({super.key, this.patient, this.patientName});

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  PatientData? currentPatient;

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

    currentPatient =
        widget.patient ?? _getPatientData(widget.patientName ?? 'Juan Torres');
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  PatientData _getPatientData(String name) {
    return PatientData(
      name: name,
      avatar:
          'https://ui-avatars.com/api/?name=${name.replaceAll(' ', '+')}&background=6366f1&color=ffffff&size=128',
      age: 28,
      lastSession: '10/10/2024',
      diagnosis: 'Ansiedad leve',
      moodMetrics: {'Happy': 60.0, 'Calm': 20.0, 'Sad': 10.0, 'Anxious': 10.0},
      insights: 'Mejora en calidad de sueño',
      warnings: 'Picos de estrés los lunes',
      calendarDays: [
        CalendarDay(day: 1, emoji: '😊'),
        CalendarDay(day: 3, emoji: '😊'),
        CalendarDay(day: 4, emoji: '😐'),
        CalendarDay(day: 7, emoji: '😊'),
        CalendarDay(day: 9, emoji: '😊'),
        CalendarDay(day: 11, emoji: '😔'),
        CalendarDay(day: 15, emoji: '😊'),
        CalendarDay(
          day: 17,
          emoji: '😔',
          isToday: true,
          note:
              'Hoy me sentí bastante frustrado por la tarea de la tarea no puede terminar.',
        ),
        CalendarDay(day: 19, emoji: '😐'),
        CalendarDay(day: 29, emoji: '😊'),
      ],
      recentReports: [
        RecentReport(
          title: 'Paciente: Juan Torres',
          patientName: 'Juan Torres',
          diagnosis: 'Ansiedad leve, estrés laboral',
          recommendations: 'Terapia conductual, ejercicios de respiración',
        ),
        RecentReport(
          title: 'Sepurtation',
          patientName: 'Juan Torres',
          diagnosis: 'Ansiedad leve, estrés laboral',
          recommendations: 'Terapia conductual, ejercicios de respiración',
        ),
        RecentReport(
          title: 'Padeentacion',
          patientName: 'Juan Torres',
          diagnosis: 'Ansiedad leve, estrés laboral',
          recommendations: 'Terapia conductual, ejercicios de respiración',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PsychologistBaseLayout(
      title: '',
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPatientHeader(),
              const SizedBox(height: 24),
              _buildDynamicMetrics(),
              const SizedBox(height: 24),
              _buildCalendarSection(),
              const SizedBox(height: 24),
              _buildRecentReports(),
              const SizedBox(height: 24),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
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
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF6366F1), width: 3),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                currentPatient!.avatar,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: const Color(0xFF6366F1),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentPatient!.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Edad: ${currentPatient!.age}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Última sesión: ${currentPatient!.lastSession}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Diagnóstico: ${currentPatient!.diagnosis}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicMetrics() {
    return Container(
      padding: const EdgeInsets.all(24),
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
            'Métricas Dinámicas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 20),
          // Gráfico de barras con porcentajes
          _buildMoodChart(),
          const SizedBox(height: 20),
          // Insights y advertencias
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Insights:',
                  currentPatient!.insights,
                  Icons.lightbulb_outline,
                  const Color(0xFF10B981),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  'Advertencias:',
                  currentPatient!.warnings,
                  Icons.warning_amber_outlined,
                  const Color(0xFFF59E0B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMoodChart() {
    return Column(
      children:
          currentPatient!.moodMetrics.entries.map((entry) {
            final percentage = entry.value;
            final color = _getMoodColor(entry.key);

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF374151),
                        ),
                      ),
                      Text(
                        '${percentage.toInt()}%',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: percentage / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case 'Happy':
        return const Color(0xFF10B981);
      case 'Calm':
        return const Color(0xFF3B82F6);
      case 'Sad':
        return const Color(0xFFEF4444);
      case 'Anxious':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6B7280);
    }
  }

  Widget _buildMetricCard(
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      padding: const EdgeInsets.all(24),
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
            'Calendario',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 20),
          _buildCalendarGrid(),
          const SizedBox(height: 16),
          // Nota del día seleccionado
          _buildSelectedDayNote(),
          const SizedBox(height: 16),
          GestureDetector(
            onTap:
                () => Navigator.pushNamed(
                  context,
                  '/patient-calendar',
                  arguments: currentPatient!.name,
                ),
            child: const Text(
              'Ver historial completo',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6366F1),
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 35, // 5 semanas
      itemBuilder: (context, index) {
        final day = index + 1;
        final calendarDay = currentPatient!.calendarDays.firstWhere(
          (d) => d.day == day,
          orElse: () => CalendarDay(day: day, emoji: ''),
        );

        return Container(
          decoration: BoxDecoration(
            color:
                calendarDay.isToday
                    ? const Color(0xFF6366F1).withOpacity(0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border:
                calendarDay.isToday
                    ? Border.all(color: const Color(0xFF6366F1), width: 2)
                    : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                day.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color:
                      calendarDay.isToday
                          ? const Color(0xFF6366F1)
                          : const Color(0xFF6B7280),
                ),
              ),
              if (calendarDay.emoji.isNotEmpty)
                Text(calendarDay.emoji, style: const TextStyle(fontSize: 16)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelectedDayNote() {
    final todayNote = currentPatient!.calendarDays.firstWhere(
      (day) => day.isToday,
      orElse: () => CalendarDay(day: 17, emoji: '😔'),
    );

    if (todayNote.note == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF6366F1).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.today, color: Color(0xFF6366F1), size: 16),
              const SizedBox(width: 8),
              Text(
                'Jueves, 17 Oct',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6366F1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Nota: ${todayNote.note}',
            style: const TextStyle(fontSize: 14, color: Color(0xFF475569)),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentReports() {
    return Container(
      padding: const EdgeInsets.all(24),
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
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: currentPatient!.recentReports.length,
            itemBuilder: (context, index) {
              final report = currentPatient!.recentReports[index];
              return _buildReportCard(report);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReportCard(RecentReport report) {
    return Container(
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
                  color: const Color(0xFF6366F1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  color: Color(0xFF6366F1),
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  report.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Diagnóstico:',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          Text(
            report.diagnosis,
            style: const TextStyle(fontSize: 12, color: Color(0xFF374151)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            'Recomendación:',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6B7280),
            ),
          ),
          Text(
            report.recommendations,
            style: const TextStyle(fontSize: 12, color: Color(0xFF374151)),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'Diario',
                Icons.book_outlined,
                const Color(0xFF6366F1),
                () => Navigator.pushNamed(
                  context,
                  '/patient-calendar',
                  arguments: currentPatient!.name,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionButton(
                'Chat',
                Icons.chat_bubble_outline,
                const Color(0xFF10B981),
                () => Navigator.pushNamed(
                  context,
                  '/patient-chat',
                  arguments: currentPatient!.name,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                'Mensajes',
                Icons.send_outlined,
                const Color(0xFF6366F1),
                () => Navigator.pushNamed(
                  context,
                  '/patient-messages',
                  arguments: currentPatient!.name,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionButton(
                'Recomendar',
                Icons.recommend_outlined,
                const Color(0xFFEC4899),
                () => Navigator.pushNamed(
                  context,
                  '/patient-recommendations',
                  arguments: currentPatient!.name,
                ),
              ),
            ),
          ],
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
