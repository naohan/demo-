import 'package:flutter/material.dart';
import '../../widgets/psychologist_base_layout.dart';

class RecommendationCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<RecommendationItem> items;

  RecommendationCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class RecommendationItem {
  final String title;
  final String description;
  final String duration;
  final bool isAssigned;

  RecommendationItem({
    required this.title,
    required this.description,
    required this.duration,
    this.isAssigned = false,
  });
}

class PatientRecommendationScreen extends StatefulWidget {
  static const route = '/patient-recommendations';

  final String? patientName;

  const PatientRecommendationScreen({super.key, this.patientName});

  @override
  State<PatientRecommendationScreen> createState() =>
      _PatientRecommendationScreenState();
}

class _PatientRecommendationScreenState
    extends State<PatientRecommendationScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  List<RecommendationCategory> categories = [];
  Set<String> assignedRecommendations = {};

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

    _loadRecommendations();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _loadRecommendations() {
    categories = [
      RecommendationCategory(
        title: 'Ejercicios de Respiración',
        icon: Icons.air,
        color: const Color(0xFF3B82F6),
        items: [
          RecommendationItem(
            title: 'Respiración 4-7-8',
            description:
                'Inhala 4 segundos, mantén 7 segundos, exhala 8 segundos. Ideal para reducir ansiedad.',
            duration: '5 min',
          ),
          RecommendationItem(
            title: 'Respiración Diafragmática',
            description:
                'Respira profundamente usando el diafragma para relajar el cuerpo.',
            duration: '10 min',
          ),
          RecommendationItem(
            title: 'Respiración Cuadrada',
            description:
                'Inhala 4s, retiene 4s, exhala 4s, pausa 4s. Mejora concentración.',
            duration: '7 min',
          ),
        ],
      ),
      RecommendationCategory(
        title: 'Técnicas de Mindfulness',
        icon: Icons.self_improvement,
        color: const Color(0xFF10B981),
        items: [
          RecommendationItem(
            title: 'Escaneo Corporal',
            description:
                'Recorre mentalmente tu cuerpo identificando tensiones y relajándolas.',
            duration: '15 min',
          ),
          RecommendationItem(
            title: 'Meditación Guiada',
            description:
                'Sigue una narración para enfocar tu mente y reducir estrés.',
            duration: '20 min',
          ),
          RecommendationItem(
            title: 'Atención Plena en la Respiración',
            description:
                'Centra tu atención únicamente en tu respiración natural.',
            duration: '10 min',
          ),
        ],
      ),
      RecommendationCategory(
        title: 'Actividades Físicas',
        icon: Icons.fitness_center,
        color: const Color(0xFFEC4899),
        items: [
          RecommendationItem(
            title: 'Caminata al Aire Libre',
            description:
                'Caminar en la naturaleza reduce cortisol y mejora el estado de ánimo.',
            duration: '30 min',
          ),
          RecommendationItem(
            title: 'Yoga Suave',
            description:
                'Posturas de yoga para relajar cuerpo y mente, mejora flexibilidad.',
            duration: '25 min',
          ),
          RecommendationItem(
            title: 'Estiramientos Matutinos',
            description:
                'Rutina de estiramientos para empezar el día con energía.',
            duration: '10 min',
          ),
        ],
      ),
      RecommendationCategory(
        title: 'Recursos de Lectura',
        icon: Icons.menu_book,
        color: const Color(0xFFF59E0B),
        items: [
          RecommendationItem(
            title: 'Artículo: Manejo de Ansiedad',
            description:
                'Guía completa sobre técnicas cognitivo-conductuales para la ansiedad.',
            duration: '15 min lectura',
          ),
          RecommendationItem(
            title: 'Libro: El Poder del Ahora',
            description:
                'Eckhart Tolle - Vivir en el presente para reducir preocupaciones.',
            duration: 'Lectura recomendada',
          ),
          RecommendationItem(
            title: 'Artículo: Higiene del Sueño',
            description:
                'Estrategias basadas en evidencia para mejorar la calidad del sueño.',
            duration: '10 min lectura',
          ),
        ],
      ),
      RecommendationCategory(
        title: 'Ejercicios Cognitivos',
        icon: Icons.psychology,
        color: const Color(0xFF8B5CF6),
        items: [
          RecommendationItem(
            title: 'Registro de Pensamientos',
            description:
                'Identifica y cuestiona pensamientos automáticos negativos.',
            duration: 'Diario',
          ),
          RecommendationItem(
            title: 'Reestructuración Cognitiva',
            description:
                'Transforma pensamientos distorsionados en pensamientos equilibrados.',
            duration: '15 min',
          ),
          RecommendationItem(
            title: 'Diario de Gratitud',
            description:
                'Escribe 3 cosas por las que estás agradecido cada día.',
            duration: '5 min diarios',
          ),
        ],
      ),
    ];
  }

  void _toggleRecommendation(String title) {
    setState(() {
      if (assignedRecommendations.contains(title)) {
        assignedRecommendations.remove(title);
      } else {
        assignedRecommendations.add(title);
      }
    });
  }

  void _saveRecommendations() {
    if (assignedRecommendations.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona al menos una recomendación'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${assignedRecommendations.length} recomendación(es) asignada(s) a ${widget.patientName ?? "paciente"}',
        ),
        backgroundColor: const Color(0xFF10B981),
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PsychologistBaseLayout(
      title: 'Recomendaciones',
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 24),
                    _buildAssignedCounter(),
                    const SizedBox(height: 24),
                    ...categories.map(
                      (category) => Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: _buildCategorySection(category),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
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
            child: const Icon(Icons.recommend, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.patientName ?? 'Paciente',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Selecciona recomendaciones personalizadas',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignedCounter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF10B981),
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            '${assignedRecommendations.length} recomendación(es) seleccionada(s)',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF10B981),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(RecommendationCategory category) {
    return Container(
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
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(category.icon, color: category.color, size: 28),
                const SizedBox(width: 12),
                Text(
                  category.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: category.color,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children:
                  category.items
                      .map(
                        (item) =>
                            _buildRecommendationCard(item, category.color),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(RecommendationItem item, Color accentColor) {
    final isAssigned = assignedRecommendations.contains(item.title);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color:
            isAssigned
                ? accentColor.withOpacity(0.05)
                : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isAssigned ? accentColor : const Color(0xFFE2E8F0),
          width: isAssigned ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _toggleRecommendation(item.title),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  child: Icon(
                    isAssigned
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: isAssigned ? accentColor : const Color(0xFF9CA3AF),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:
                              isAssigned
                                  ? accentColor
                                  : const Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: accentColor.withOpacity(0.7),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.duration,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: accentColor.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF6366F1), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6366F1),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _saveRecommendations,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF6366F1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.send, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Asignar (${assignedRecommendations.length})',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
