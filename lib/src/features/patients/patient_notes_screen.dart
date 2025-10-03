import 'package:flutter/material.dart';
import '../../widgets/psychologist_base_layout.dart';

enum MoodState { happy, neutral, sad }

class PatientNote {
  final DateTime date;
  final String content;
  final MoodState mood;
  final String? aiDiagnosis;
  final List<String> suggestions;
  final bool needsFollowUp;

  PatientNote({
    required this.date,
    required this.content,
    required this.mood,
    this.aiDiagnosis,
    this.suggestions = const [],
    this.needsFollowUp = false,
  });
}

class PatientNotesScreen extends StatefulWidget {
  static const route = '/patient-notes';

  final String? patientName;

  const PatientNotesScreen({super.key, this.patientName});

  @override
  State<PatientNotesScreen> createState() => _PatientNotesScreenState();
}

class _PatientNotesScreenState extends State<PatientNotesScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _noteController = TextEditingController();
  MoodState selectedMood = MoodState.sad;

  // Nota actual basada en la imagen
  final PatientNote currentNote = PatientNote(
    date: DateTime(2024, 9, 16),
    content: 'Hoy me sentí deprimido y sin ganas de levantarme.',
    mood: MoodState.sad,
    aiDiagnosis:
        'Análisis IA detecta: Posible episodio depresivo leve. Recomienda seguimiento.',
    suggestions: [
      'Técnicas de respiración profunda',
      'Actividades de activación conductual',
      'Revisar patrones de sueño',
      'Considerar apoyo social',
    ],
    needsFollowUp: true,
  );

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
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

    // Cargar la nota actual
    _noteController.text = currentNote.content;
    selectedMood = currentNote.mood;

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  String _getMoodEmoji(MoodState mood) {
    switch (mood) {
      case MoodState.happy:
        return '😊';
      case MoodState.neutral:
        return '😐';
      case MoodState.sad:
        return '😔';
    }
  }

  Color _getMoodColor(MoodState mood) {
    switch (mood) {
      case MoodState.happy:
        return const Color(0xFF10B981);
      case MoodState.neutral:
        return const Color(0xFFF59E0B);
      case MoodState.sad:
        return const Color(0xFFEF4444);
    }
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
                _buildHeader(),
                const SizedBox(height: 24),
                _buildMoodSelector(),
                const SizedBox(height: 24),
                _buildNoteInput(),
                const SizedBox(height: 24),
                _buildAIDiagnosis(),
                const SizedBox(height: 24),
                _buildSuggestions(),
                const SizedBox(height: 24),
                _buildActionButtons(),
                const SizedBox(height: 24),
                _buildFinishButton(),
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
          Expanded(
            child: Text(
              'Notas • ${currentNote.date.day.toString().padLeft(2, '0')}/${currentNote.date.month.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodSelector() {
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
            'Estado de ánimo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getMoodColor(selectedMood).withOpacity(0.1),
                border: Border.all(
                  color: _getMoodColor(selectedMood),
                  width: 3,
                ),
              ),
              child: Center(
                child: Text(
                  _getMoodEmoji(selectedMood),
                  style: const TextStyle(fontSize: 64),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                MoodState.values
                    .map(
                      (mood) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMood = mood;
                          });
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                selectedMood == mood
                                    ? _getMoodColor(mood).withOpacity(0.2)
                                    : Colors.grey.withOpacity(0.1),
                            border: Border.all(
                              color:
                                  selectedMood == mood
                                      ? _getMoodColor(mood)
                                      : Colors.grey.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _getMoodEmoji(mood),
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteInput() {
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
            'Nota del día',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Escribe cómo te sientes hoy...',
                hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 16),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
              style: const TextStyle(fontSize: 16, color: Color(0xFF374151)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIDiagnosis() {
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
        border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.2)),
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
                  Icons.psychology_outlined,
                  color: Color(0xFF8B5CF6),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Diagnóstico IA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B5CF6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              currentNote.aiDiagnosis ?? 'Analizando...',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF475569),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
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
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lightbulb_outlined,
                  color: Color(0xFF10B981),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Sugerencias',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF10B981),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...currentNote.suggestions
              .map(
                (suggestion) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF10B981).withOpacity(0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: const Color(0xFF10B981),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          suggestion,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildActionButton(
          'Recetar',
          Icons.medication_outlined,
          const Color(0xFF8B5CF6),
          () {
            // Acción de recetar
            _showActionDialog('Recetar medicación');
          },
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          'Citar',
          Icons.calendar_today_outlined,
          const Color(0xFF3B82F6),
          () {
            // Acción de citar
            _showActionDialog('Programar cita');
          },
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
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  color: color,
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

  Widget _buildFinishButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // Guardar nota y terminar
          Navigator.pop(context);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3B82F6).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Text(
            'Terminar',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showActionDialog(String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(action),
          content: Text(
            '¿Deseas $action para ${widget.patientName ?? 'este paciente'}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$action programado exitosamente'),
                    backgroundColor: const Color(0xFF10B981),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Confirmar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
