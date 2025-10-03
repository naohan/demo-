import 'package:flutter/material.dart';
import '../../widgets/psychologist_base_layout.dart';

enum MoodLevel { veryHappy, happy, neutral, sad, verySad }

class DailyMood {
  final DateTime date;
  final MoodLevel mood;
  final String? note;

  DailyMood({required this.date, required this.mood, this.note});
}

class PatientMood {
  final String name;
  final String avatar;
  final List<DailyMood> moodHistory;

  PatientMood({
    required this.name,
    required this.avatar,
    required this.moodHistory,
  });
}

class PatientCalendarScreen extends StatefulWidget {
  static const route = '/patient-calendar';

  final String? patientName;

  const PatientCalendarScreen({super.key, this.patientName});

  @override
  State<PatientCalendarScreen> createState() => _PatientCalendarScreenState();
}

class _PatientCalendarScreenState extends State<PatientCalendarScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  PatientMood? currentPatient;
  DateTime selectedDate = DateTime.now();
  DateTime displayedMonth = DateTime.now();

  // Lista de pacientes simulada
  final List<PatientMood> patients = [];

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

    _initializePatients();
    currentPatient = _getPatientData(widget.patientName ?? 'Ana');
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _initializePatients() {
    // Crear datos simulados para Ana
    List<DailyMood> anaMoods = [];
    DateTime now = DateTime.now();

    // Últimos 30 días con estados de ánimo aleatorios
    for (int i = 0; i < 30; i++) {
      DateTime date = now.subtract(Duration(days: i));
      MoodLevel mood;

      // Simular patrones basados en la imagen
      if (date.weekday == DateTime.monday ||
          date.weekday == DateTime.thursday) {
        mood = MoodLevel.sad; // Mayor ansiedad L/J
      } else if (date.weekday == DateTime.friday ||
          date.weekday == DateTime.saturday) {
        mood = MoodLevel.happy;
      } else {
        mood = MoodLevel.neutral;
      }

      anaMoods.add(
        DailyMood(
          date: date,
          mood: mood,
          note:
              date.weekday == DateTime.monday
                  ? 'Me sentí ansioso, evité salir.'
                  : null,
        ),
      );
    }

    // Crear pacientes
    patients.addAll([
      PatientMood(
        name: 'Ana',
        avatar:
            'https://ui-avatars.com/api/?name=Ana&background=3b82f6&color=ffffff&size=128',
        moodHistory: anaMoods,
      ),
      PatientMood(
        name: 'Luis',
        avatar:
            'https://ui-avatars.com/api/?name=Luis&background=3b82f6&color=ffffff&size=128',
        moodHistory: _generateRandomMoods(),
      ),
    ]);
  }

  List<DailyMood> _generateRandomMoods() {
    List<DailyMood> moods = [];
    DateTime now = DateTime.now();
    List<MoodLevel> moodLevels = [
      MoodLevel.happy,
      MoodLevel.neutral,
      MoodLevel.sad,
    ];

    for (int i = 0; i < 30; i++) {
      moods.add(
        DailyMood(
          date: now.subtract(Duration(days: i)),
          mood: moodLevels[i % 3],
        ),
      );
    }
    return moods;
  }

  PatientMood _getPatientData(String name) {
    return patients.firstWhere(
      (patient) => patient.name == name,
      orElse: () => patients.first,
    );
  }

  String _getMoodEmoji(MoodLevel mood) {
    switch (mood) {
      case MoodLevel.veryHappy:
        return '😄';
      case MoodLevel.happy:
        return '😊';
      case MoodLevel.neutral:
        return '😐';
      case MoodLevel.sad:
        return '☹️';
      case MoodLevel.verySad:
        return '😢';
    }
  }

  Color _getMoodColor(MoodLevel mood) {
    switch (mood) {
      case MoodLevel.veryHappy:
        return const Color(0xFF10B981);
      case MoodLevel.happy:
        return const Color(0xFF84CC16);
      case MoodLevel.neutral:
        return const Color(0xFFF59E0B);
      case MoodLevel.sad:
        return const Color(0xFFEF4444);
      case MoodLevel.verySad:
        return const Color(0xFFDC2626);
    }
  }

  DailyMood? _getMoodForDate(DateTime date) {
    return currentPatient?.moodHistory.firstWhere(
      (mood) =>
          mood.date.year == date.year &&
          mood.date.month == date.month &&
          mood.date.day == date.day,
      orElse: () => DailyMood(date: date, mood: MoodLevel.neutral),
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
              _buildHeader(),
              const SizedBox(height: 24),
              _buildCalendar(),
              const SizedBox(height: 24),
              _buildPatientsList(),
              if (_getMoodForDate(selectedDate)?.note != null) ...[
                const SizedBox(height: 24),
                _buildNoteSection(),
              ],
            ],
          ),
        ),
      ),
    );
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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Calendario • Ana',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCalendarHeader(),
          const SizedBox(height: 20),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              displayedMonth = DateTime(
                displayedMonth.year,
                displayedMonth.month - 1,
              );
            });
          },
          icon: const Icon(Icons.chevron_left, color: Color(0xFF3B82F6)),
        ),
        Text(
          _getMonthName(displayedMonth.month),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              displayedMonth = DateTime(
                displayedMonth.year,
                displayedMonth.month + 1,
              );
            });
          },
          icon: const Icon(Icons.chevron_right, color: Color(0xFF3B82F6)),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    return Column(
      children: [
        // Días de la semana
        Row(
          children:
              ['D', 'L', 'M', 'X', 'J', 'V', 'S']
                  .map(
                    (day) => Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          day,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 8),
        // Días del mes
        ..._buildCalendarWeeks(),
      ],
    );
  }

  List<Widget> _buildCalendarWeeks() {
    List<Widget> weeks = [];
    DateTime firstDay = DateTime(displayedMonth.year, displayedMonth.month, 1);
    DateTime lastDay = DateTime(
      displayedMonth.year,
      displayedMonth.month + 1,
      0,
    );

    int startWeekday = firstDay.weekday % 7;
    DateTime startDate = firstDay.subtract(Duration(days: startWeekday));

    for (int week = 0; week < 6; week++) {
      List<Widget> days = [];

      for (int day = 0; day < 7; day++) {
        DateTime currentDate = startDate.add(Duration(days: week * 7 + day));
        bool isCurrentMonth = currentDate.month == displayedMonth.month;
        bool isToday = _isSameDay(currentDate, DateTime.now());
        bool isSelected = _isSameDay(currentDate, selectedDate);

        DailyMood? mood = _getMoodForDate(currentDate);

        days.add(
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedDate = currentDate;
                });
              },
              child: Container(
                height: 48,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? const Color(0xFF3B82F6)
                          : isToday
                          ? const Color(0xFF3B82F6).withOpacity(0.1)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentDate.day.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected
                                ? Colors.white
                                : isCurrentMonth
                                ? const Color(0xFF1F2937)
                                : const Color(0xFFD1D5DB),
                      ),
                    ),
                    if (mood != null && isCurrentMonth)
                      Text(
                        _getMoodEmoji(mood.mood),
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      weeks.add(Row(children: days));

      // Parar si ya pasamos el último día del mes
      if (startDate.add(Duration(days: (week + 1) * 7)).month !=
              displayedMonth.month &&
          week > 3) {
        break;
      }
    }

    return weeks;
  }

  Widget _buildPatientsList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Datos generales',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          ...patients.map((patient) => _buildPatientRow(patient)),
        ],
      ),
    );
  }

  Widget _buildPatientRow(PatientMood patient) {
    // Obtener últimos 3 estados de ánimo
    List<DailyMood> recentMoods =
        patient.moodHistory
            .where(
              (mood) => mood.date.isAfter(
                DateTime.now().subtract(const Duration(days: 3)),
              ),
            )
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date));

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF3B82F6), width: 2),
            ),
            child: ClipOval(
              child: Image.network(
                patient.avatar,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: const Color(0xFF3B82F6),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              patient.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          Row(
            children:
                recentMoods
                    .take(3)
                    .map(
                      (mood) => Container(
                        margin: const EdgeInsets.only(left: 4),
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          _getMoodEmoji(mood.mood),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteSection() {
    DailyMood? mood = _getMoodForDate(selectedDate);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.note_outlined,
                color: const Color(0xFF3B82F6),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Nota (${selectedDate.day}/${selectedDate.month.toString().padLeft(2, '0')})',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Text(
              mood?.note ?? 'Sin notas para este día',
              style: const TextStyle(fontSize: 14, color: Color(0xFF475569)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.keyboard_arrow_down, color: const Color(0xFF6B7280)),
              const SizedBox(width: 8),
              Text(
                'Desliza para ver más detalles',
                style: TextStyle(fontSize: 12, color: const Color(0xFF6B7280)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];
    return months[month];
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
