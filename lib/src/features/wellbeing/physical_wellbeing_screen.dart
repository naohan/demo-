import 'package:flutter/material.dart';
import 'dart:async';
import '../../widgets/user_base_layout.dart';

class PhysicalWellbeingScreen extends StatefulWidget {
  static const route = '/wellbeing-physical';
  const PhysicalWellbeingScreen({super.key});

  @override
  State<PhysicalWellbeingScreen> createState() => _PhysicalWellbeingScreenState();
}

class _PhysicalWellbeingScreenState extends State<PhysicalWellbeingScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  // Timer controllers for each sport
  Map<String, TimerController> _sportTimers = {};
  
  // Exercise history and challenges
  List<ExerciseRecord> _exerciseHistory = [];
  List<DailyChallenge> _dailyChallenges = [];
  Map<String, Duration> _challengeProgress = {};
  
  // Weight tracking
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    
    // Initialize timer controllers for each sport
    final sports = ['Carreras', 'Correr', 'Fútbol', 'Natación'];
    for (String sport in sports) {
      _sportTimers[sport] = TimerController();
    }
    
    // Initialize daily challenges
    _initializeDailyChallenges();
    
    // Initialize sample exercise history
    _initializeSampleHistory();
  }

  @override
  void dispose() {
    _animationController.dispose();
    // Dispose all timer controllers
    for (TimerController timer in _sportTimers.values) {
      timer.dispose();
    }
    // Dispose weight controllers
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UserBaseLayout(
      title: 'Bienestar Físico',
      hero: const Icon(Icons.fitness_center, size: 64),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF27AE60), Color(0xFF2ECC71)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF27AE60).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            onPressed: _showSharePopup,
            icon: const Icon(Icons.share, color: Colors.white, size: 22),
            tooltip: 'Compartir información',
            padding: const EdgeInsets.all(8),
          ),
        ),
      ],
      child: FadeTransition(
        opacity: _fadeAnimation,
      child: ListView(
        padding: const EdgeInsets.all(16),
          children: [
            // Dashboard principal con métricas
            _buildDashboardHeader(),
            const SizedBox(height: 20),
            
            // Arcos de progreso circulares
            _buildProgressArcs(),
            const SizedBox(height: 20),
            
            // Métricas principales
            _buildMetricsCards(),
            const SizedBox(height: 20),
            
            // Resumen del día
            _buildDailySummary(),
            const SizedBox(height: 20),
            
            // Motivación y recomendaciones
            _buildMotivationSection(),
            const SizedBox(height: 20),
            
            // Seguimiento de sueño
            _buildSleepTrackingCard(),
            const SizedBox(height: 20),
            
            // Sección de deportes
            _buildSportsSection(),
            const SizedBox(height: 20),
            
            // Botón de peso
            _buildWeightButton(),
            const SizedBox(height: 20),
            
            // Retos diarios
            _buildDailyChallengesSection(),
            const SizedBox(height: 20),
            
            // Historial de ejercicios
            _buildExerciseHistorySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF667eea).withOpacity(0.1),
            const Color(0xFF764ba2).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF667eea).withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF667eea).withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Gráfico de barras optimizado para móvil
          Container(
            width: 70,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF667eea).withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Barra Calorías (naranja) - optimizada para móvil
                  Container(
                    width: 12,
                    height: 30,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF6B35), Color(0xFFFF8E53)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  // Barra Pasos (amarillo) - optimizada para móvil
                  Container(
                    width: 12,
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF7931E), Color(0xFFFFB347)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  // Barra Movimiento (azul) - optimizada para móvil
                  Container(
                    width: 12,
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4A90E2), Color(0xFF7BB3F0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard de Bienestar',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A1A),
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Mantén tu cuerpo activo y saludable',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF424242),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                // Indicador de progreso del día
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFF27AE60),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Día activo',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF27AE60),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressArcs() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF3498DB).withOpacity(0.08),
            const Color(0xFF5DADE2).withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF3498DB).withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3498DB).withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Arcos de progreso optimizados para móvil
          Expanded(
            flex: 2,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Stack(
                    children: [
                      // Arco exterior (Pasos)
                      CustomPaint(
                        size: const Size(100, 100),
                        painter: ArcPainter(
                          progress: 0.17, // 1000/6000
                          color: Colors.orange,
                          strokeWidth: 6,
                          startAngle: 180,
                          endAngle: 0,
                        ),
                      ),
                      // Arco medio (Calorías)
                      CustomPaint(
                        size: const Size(100, 100),
                        painter: ArcPainter(
                          progress: 0.25, // 100/400
                          color: Colors.amber,
                          strokeWidth: 5,
                          startAngle: 180,
                          endAngle: 0,
                        ),
                      ),
                      // Arco interior (Movimiento)
                      CustomPaint(
                        size: const Size(100, 100),
                        painter: ArcPainter(
                          progress: 0.8, // 4h/5h (asumiendo 5h como máximo)
                          color: Colors.blue,
                          strokeWidth: 4,
                          startAngle: 180,
                          endAngle: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Texto detallado del progreso
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildProgressLabel('Pasos', '17%', Colors.orange),
                        _buildProgressLabel('Calorías', '25%', Colors.amber),
                        _buildProgressLabel('Movimiento', '80%', Colors.blue),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Icono de recompensa optimizado
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2C3E50), Color(0xFF34495E)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    color: Colors.amber,
                    size: 22,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'x0',
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Logros',
                  style: TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 10,
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

  Widget _buildMetricsCards() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8E44AD).withOpacity(0.08),
            const Color(0xFF9B59B6).withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF8E44AD).withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8E44AD).withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Calorías
          _buildMetricCard(
            icon: Icons.local_fire_department,
            iconColor: Colors.orange,
            label: 'Calorías',
            value: '100',
            goal: '/400 kcal',
          ),
          const SizedBox(height: 12),
          // Pasos
          _buildMetricCard(
            icon: Icons.directions_walk,
            iconColor: Colors.yellow,
            label: 'Pasos',
            value: '1000',
            goal: '/6000 pasos',
          ),
          const SizedBox(height: 12),
          // Movimiento
          _buildMetricCard(
            icon: Icons.access_time,
            iconColor: Colors.blue,
            label: 'Movimiento',
            value: '4h',
            goal: '/30 min',
          ),
        ],
      ),
    );
  }

  Widget _buildProgressLabel(String label, String percentage, Color color) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        Text(
          percentage,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required String goal,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF424242),
                  size: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1A1A1A),
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            goal,
            style: const TextStyle(
              color: Color(0xFF424242),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailySummary() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF27AE60).withOpacity(0.1),
            const Color(0xFF2ECC71).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF27AE60).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF27AE60).withOpacity(0.2),
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
              gradient: const LinearGradient(
                colors: [Color(0xFF27AE60), Color(0xFF2ECC71)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF27AE60).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.today,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resumen del Día',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Hoy caminaste 4,000 pasos y registraste 2 emociones positivas',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMotivationSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF9B59B6).withOpacity(0.1),
            const Color(0xFFBB8FCE).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF9B59B6).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9B59B6).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9B59B6), Color(0xFFBB8FCE)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9B59B6).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.psychology,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Motivación & Consejos',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '¡Sigue avanzando, cuerpo y mente en equilibrio!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF9B59B6).withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.nightlight_round, color: Color(0xFF9B59B6), size: 20),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Hoy yoga suave porque dormiste poco 😴',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSleepTrackingCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF9B59B6).withOpacity(0.1),
            const Color(0xFFBB8FCE).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF9B59B6).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9B59B6).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9B59B6), Color(0xFFBB8FCE)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF9B59B6).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.bedtime,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sueño',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1 h 52 min',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '3 de octubre | Pobre',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Barra de progreso de calidad del sueño
          Column(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF6A1B9A),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF8E24AA),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFAB47BC),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFBB8FCE),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  // Indicador triangular
                  Container(
                    width: 0,
                    height: 0,
                    decoration: const BoxDecoration(),
                    child: CustomPaint(
                      size: const Size(12, 8),
                      painter: TrianglePainter(),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Pobre',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    'Excelente',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSportsSection() {
    final sports = [
      {
        'name': 'Carreras',
        'image': 'assets/bienestar_fisico/carreras.png',
        'color': const Color(0xFFE74C3C),
      },
      {
        'name': 'Correr',
        'image': 'assets/bienestar_fisico/correr.png',
        'color': const Color(0xFF3498DB),
      },
      {
        'name': 'Fútbol',
        'image': 'assets/bienestar_fisico/futbol.png',
        'color': const Color(0xFF27AE60),
      },
      {
        'name': 'Natación',
        'image': 'assets/bienestar_fisico/natacion.png',
        'color': const Color(0xFF9B59B6),
      },
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2C3E50).withOpacity(0.1),
            const Color(0xFF34495E).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2C3E50).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C3E50).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2C3E50), Color(0xFF34495E)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2C3E50).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.sports,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deportes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ejercicios y actividades físicas',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: sports.length,
            itemBuilder: (context, index) {
              final sport = sports[index];
              return _buildSportCard(
                name: sport['name'] as String,
                imagePath: sport['image'] as String,
                color: sport['color'] as Color,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSportCard({
    required String name,
    required String imagePath,
    required Color color,
  }) {
    final timerController = _sportTimers[name]!;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.15),
            color.withOpacity(0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del deporte
          Container(
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Nombre del deporte
          Text(
            name,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          // Timer y controles
          StreamBuilder<Duration>(
              stream: timerController.durationStream,
              builder: (context, snapshot) {
                final duration = snapshot.data ?? Duration.zero;
                final isRunning = timerController.isRunning;
                final totalDuration = timerController.totalDuration;
                
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tiempo actual
                    Text(
                      _formatDurationWithSeconds(duration),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Controles de reproducción
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Botón de play/pause
                        GestureDetector(
                          onTap: () {
                            if (isRunning) {
                              timerController.pauseAndRecord(name, _recordExercise);
                            } else {
                              timerController.start();
                            }
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color, color.withOpacity(0.8)],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: color.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              isRunning ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Botón de reset
                        GestureDetector(
                          onTap: () {
                            timerController.reset();
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: color.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.stop,
                              color: color,
                              size: 12,
                            ),
                          ),
                        ),
                        // Icono de completado
                        if (totalDuration.inMinutes >= 5) ...[
                          const SizedBox(width: 6),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.green.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
  
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    
    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }
  
  String _formatDurationWithSeconds(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    
    if (duration.inHours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }
  
  void _initializeDailyChallenges() {
    _dailyChallenges = [
      DailyChallenge(
        id: 'run_5min',
        title: 'Correr 5 minutos',
        description: 'Mantén tu ritmo cardíaco activo',
        targetDuration: const Duration(minutes: 5),
        icon: Icons.directions_run,
        color: const Color(0xFFE74C3C),
        reward: '🏃‍♂️',
      ),
      DailyChallenge(
        id: 'run_10min',
        title: 'Correr 10 minutos',
        description: 'Desafío de resistencia diaria',
        targetDuration: const Duration(minutes: 10),
        icon: Icons.timer,
        color: const Color(0xFF3498DB),
        reward: '💪',
      ),
      DailyChallenge(
        id: 'sports_15min',
        title: '15 min de deporte',
        description: 'Cualquier actividad física cuenta',
        targetDuration: const Duration(minutes: 15),
        icon: Icons.sports,
        color: const Color(0xFF27AE60),
        reward: '🏆',
      ),
    ];
    
    // Initialize progress
    for (var challenge in _dailyChallenges) {
      _challengeProgress[challenge.id] = Duration.zero;
    }
  }
  
  void _initializeSampleHistory() {
    final now = DateTime.now();
    _exerciseHistory = [
      ExerciseRecord(
        sportName: 'Correr',
        duration: const Duration(minutes: 12, seconds: 30),
        date: now.subtract(const Duration(days: 1)),
        calories: 120,
      ),
      ExerciseRecord(
        sportName: 'Natación',
        duration: const Duration(minutes: 25),
        date: now.subtract(const Duration(days: 2)),
        calories: 250,
      ),
      ExerciseRecord(
        sportName: 'Fútbol',
        duration: const Duration(minutes: 45),
        date: now.subtract(const Duration(days: 3)),
        calories: 400,
      ),
      ExerciseRecord(
        sportName: 'Carreras',
        duration: const Duration(minutes: 8, seconds: 45),
        date: now.subtract(const Duration(days: 4)),
        calories: 85,
      ),
    ];
  }
  
  void _recordExercise(String sportName, Duration duration) {
    setState(() {
      _exerciseHistory.insert(0, ExerciseRecord(
        sportName: sportName,
        duration: duration,
        date: DateTime.now(),
        calories: _calculateCalories(sportName, duration),
      ));
      
      // Update challenge progress
      _updateChallengeProgress(sportName, duration);
    });
  }
  
  int _calculateCalories(String sportName, Duration duration) {
    // Simplified calorie calculation based on sport and duration
    final minutes = duration.inMinutes;
    switch (sportName) {
      case 'Correr':
        return (minutes * 8).round();
      case 'Natación':
        return (minutes * 10).round();
      case 'Fútbol':
        return (minutes * 9).round();
      case 'Carreras':
        return (minutes * 7).round();
      default:
        return (minutes * 6).round();
    }
  }
  
  void _updateChallengeProgress(String sportName, Duration duration) {
    // Update running challenges
    if (sportName == 'Correr' || sportName == 'Carreras') {
      _challengeProgress['run_5min'] = 
          (_challengeProgress['run_5min'] ?? Duration.zero) + duration;
      _challengeProgress['run_10min'] = 
          (_challengeProgress['run_10min'] ?? Duration.zero) + duration;
    }
    
    // Update general sports challenge
    _challengeProgress['sports_15min'] = 
        (_challengeProgress['sports_15min'] ?? Duration.zero) + duration;
  }
  
  void _showWeightPopup() {
    showDialog(
      context: context,
      builder: (context) => _WeightTrackingPopup(
        ageController: _ageController,
        weightController: _weightController,
        heightController: _heightController,
      ),
    );
  }
  
  void _showSharePopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.black.withOpacity(0.5),
        child: _TrainerSearchPopup(),
      ),
    );
  }
  
  Widget _buildWeightButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE67E22), Color(0xFFF39C12)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE67E22).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _showWeightPopup,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.monitor_weight,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Registro de Peso',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildDailyChallengesSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFE67E22).withOpacity(0.1),
            const Color(0xFFF39C12).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE67E22).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE67E22).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE67E22), Color(0xFFF39C12)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE67E22).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Retos Diarios',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Completa desafíos y gana recompensas',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...(_dailyChallenges.map((challenge) => _buildChallengeCard(challenge))),
        ],
      ),
    );
  }
  
  Widget _buildChallengeCard(DailyChallenge challenge) {
    final progress = _challengeProgress[challenge.id] ?? Duration.zero;
    final progressPercent = (progress.inMinutes / challenge.targetDuration.inMinutes).clamp(0.0, 1.0);
    final isCompleted = progress >= challenge.targetDuration;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: challenge.color.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: challenge.color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: challenge.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              challenge.icon,
              color: challenge.color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challenge.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: challenge.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  challenge.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                // Progress bar
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progressPercent,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: challenge.color,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_formatDuration(progress)} / ${_formatDuration(challenge.targetDuration)}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: challenge.color,
                      ),
                    ),
                    if (isCompleted)
                      Text(
                        challenge.reward,
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildExerciseHistorySection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8E44AD).withOpacity(0.1),
            const Color(0xFF9B59B6).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF8E44AD).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8E44AD).withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8E44AD), Color(0xFF9B59B6)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8E44AD).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.history,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Historial de Ejercicios',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tus actividades físicas recientes',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (_exerciseHistory.isEmpty)
            Container(
              padding: const EdgeInsets.all(32),
              child: const Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.fitness_center,
                      size: 48,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No hay ejercicios registrados aún',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '¡Comienza tu primera sesión!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...(_exerciseHistory.take(5).map((record) => _buildHistoryItem(record))),
        ],
      ),
    );
  }
  
  Widget _buildHistoryItem(ExerciseRecord record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _getSportColor(record.sportName).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getSportIcon(record.sportName),
              color: _getSportColor(record.sportName),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.sportName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(record.date),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatDuration(record.duration),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _getSportColor(record.sportName),
                ),
              ),
              Text(
                '${record.calories} cal',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Color _getSportColor(String sportName) {
    switch (sportName) {
      case 'Carreras':
        return const Color(0xFFE74C3C);
      case 'Correr':
        return const Color(0xFF3498DB);
      case 'Fútbol':
        return const Color(0xFF27AE60);
      case 'Natación':
        return const Color(0xFF9B59B6);
      default:
        return const Color(0xFF2C3E50);
    }
  }
  
  IconData _getSportIcon(String sportName) {
    switch (sportName) {
      case 'Carreras':
        return Icons.directions_run;
      case 'Correr':
        return Icons.directions_walk;
      case 'Fútbol':
        return Icons.sports_soccer;
      case 'Natación':
        return Icons.pool;
      default:
        return Icons.fitness_center;
    }
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return 'Hace ${difference.inDays} día${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return 'Hace ${difference.inHours} hora${difference.inHours > 1 ? 's' : ''}';
    } else if (difference.inMinutes > 0) {
      return 'Hace ${difference.inMinutes} min';
    } else {
      return 'Ahora';
    }
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, size.height);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ArcPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final double startAngle;
  final double endAngle;

  ArcPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    required this.startAngle,
    required this.endAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = (endAngle - startAngle) * progress * (3.14159 / 180);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle * (3.14159 / 180),
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TimerController {
  Timer? _timer;
  Duration _duration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isRunning = false;
  final StreamController<Duration> _durationController = StreamController<Duration>.broadcast();

  Stream<Duration> get durationStream => _durationController.stream;
  Duration get totalDuration => _totalDuration;
  bool get isRunning => _isRunning;

  void start() {
    if (_isRunning) return;
    
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _duration += const Duration(seconds: 1);
      _durationController.add(_duration);
    });
  }

  void pause() {
    if (!_isRunning) return;
    
    _isRunning = false;
    _timer?.cancel();
    _totalDuration += _duration;
    _duration = Duration.zero;
  }
  
  void pauseAndRecord(String sportName, Function(String, Duration) onRecord) {
    if (!_isRunning) return;
    
    _isRunning = false;
    _timer?.cancel();
    _totalDuration += _duration;
    
    // Record exercise if duration > 0
    if (_duration > Duration.zero) {
      onRecord(sportName, _duration);
    }
    
    _duration = Duration.zero;
  }

  void reset() {
    _isRunning = false;
    _timer?.cancel();
    _duration = Duration.zero;
    _totalDuration = Duration.zero;
    _durationController.add(_duration);
  }

  void dispose() {
    _timer?.cancel();
    _durationController.close();
  }
}

class _WeightTrackingPopup extends StatelessWidget {
  final TextEditingController ageController;
  final TextEditingController weightController;
  final TextEditingController heightController;

  const _WeightTrackingPopup({
    required this.ageController,
    required this.weightController,
    required this.heightController,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFE67E22).withOpacity(0.1),
              const Color(0xFFF39C12).withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE67E22).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE67E22).withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE67E22), Color(0xFFF39C12)],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  const Expanded(
                    child: Text(
                      'Registro de Peso',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance for close button
                ],
              ),
            ),
            
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Información Personal',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Completa tus datos para un mejor seguimiento',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Age field
                    _buildInputField(
                      controller: ageController,
                      label: 'Edad',
                      hint: 'Ingresa tu edad en años',
                      icon: Icons.cake,
                      keyboardType: TextInputType.number,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Weight field
                    _buildInputField(
                      controller: weightController,
                      label: 'Peso',
                      hint: 'Ingresa tu peso en kg',
                      icon: Icons.monitor_weight,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Height field
                    _buildInputField(
                      controller: heightController,
                      label: 'Altura',
                      hint: 'Ingresa tu altura en cm',
                      icon: Icons.height,
                      keyboardType: TextInputType.number,
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Save button
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE67E22), Color(0xFFF39C12)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFE67E22).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (ageController.text.isNotEmpty || 
                                weightController.text.isNotEmpty || 
                                heightController.text.isNotEmpty) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Datos de peso guardados exitosamente'),
                                  backgroundColor: Color(0xFFE67E22),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              'Guardar Datos',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
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
  
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE67E22).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: const Color(0xFFE67E22),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.05),
                contentPadding: const EdgeInsets.all(16),
              ),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class DailyChallenge {
  final String id;
  final String title;
  final String description;
  final Duration targetDuration;
  final IconData icon;
  final Color color;
  final String reward;

  DailyChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.targetDuration,
    required this.icon,
    required this.color,
    required this.reward,
  });
}

class ExerciseRecord {
  final String sportName;
  final Duration duration;
  final DateTime date;
  final int calories;

  ExerciseRecord({
    required this.sportName,
    required this.duration,
    required this.date,
    required this.calories,
  });
}

class _TrainerSearchPopup extends StatefulWidget {
  @override
  _TrainerSearchPopupState createState() => _TrainerSearchPopupState();
}

class _TrainerSearchPopupState extends State<_TrainerSearchPopup> {
  final TextEditingController _searchController = TextEditingController();
  List<Trainer> _filteredTrainers = [];
  final List<Trainer> _allTrainers = [
    Trainer(
      name: 'Carlos Mendoza',
      specialty: 'Entrenamiento Funcional',
      rating: 4.8,
      photo: 'assets/foto/perfi1.jpg',
    ),
    Trainer(
      name: 'Ana Rodríguez',
      specialty: 'CrossFit',
      rating: 4.9,
      photo: 'assets/foto/perfi2.jpg',
    ),
    Trainer(
      name: 'Miguel Torres',
      specialty: 'Musculación',
      rating: 4.7,
      photo: 'assets/foto/perfil3.jpg',
    ),
    Trainer(
      name: 'Sofia García',
      specialty: 'Yoga',
      rating: 4.9,
      photo: 'assets/foto/perfil4.jpeg',
    ),
    Trainer(
      name: 'David López',
      specialty: 'Running',
      rating: 4.6,
      photo: 'assets/foto/perfil5.jpeg',
    ),
    Trainer(
      name: 'Laura Martínez',
      specialty: 'Pilates',
      rating: 4.8,
      photo: 'assets/foto/perfil6.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _filteredTrainers = _allTrainers;
    _searchController.addListener(_filterTrainers);
  }

  void _filterTrainers() {
    setState(() {
      _filteredTrainers = _allTrainers
          .where((trainer) =>
              trainer.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
              trainer.specialty.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF27AE60).withOpacity(0.1),
              const Color(0xFF2ECC71).withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF27AE60).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF27AE60).withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF27AE60), Color(0xFF2ECC71)],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  const Expanded(
                    child: Text(
                      'Buscar Entrenador',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance for close button
                ],
              ),
            ),
            
            // Content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF27AE60).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Buscar por nombre o especialidad...',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          prefixIcon: Icon(Icons.search, color: const Color(0xFF27AE60)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Trainers list
                    Text(
                      'Entrenadores Disponibles',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // List of trainers
                    ..._filteredTrainers.map((trainer) => _buildTrainerCard(trainer)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainerCard(Trainer trainer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF27AE60).withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(trainer.photo),
        ),
        title: Text(
          trainer.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trainer.specialty,
              style: const TextStyle(
                color: Color(0xFF424242),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  trainer.rating.toString(),
                  style: const TextStyle(
                    color: Color(0xFF424242),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF27AE60), Color(0xFF2ECC71)],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Contactar',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
                 onTap: () {
                   _showConsentDialog(trainer);
                 },
      ),
    );
  }

  void _showConsentDialog(Trainer trainer) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.black.withOpacity(0.5),
        child: _ConsentDialog(trainer: trainer),
      ),
    );
  }
}

class _ConsentDialog extends StatefulWidget {
  final Trainer trainer;

  const _ConsentDialog({required this.trainer});

  @override
  _ConsentDialogState createState() => _ConsentDialogState();
}

class _ConsentDialogState extends State<_ConsentDialog> {
  bool _hasConsented = false;
  bool _hasSigned = false;
  final GlobalKey<SignatureState> _signatureKey = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF27AE60).withOpacity(0.1),
            const Color(0xFF2ECC71).withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF27AE60).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF27AE60).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF27AE60), Color(0xFF2ECC71)],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
                const Expanded(
                  child: Text(
                    'Compartir Información',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 48), // Balance for close button
              ],
            ),
          ),
          
          // Content
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trainer info
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF27AE60).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(widget.trainer.photo),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.trainer.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFF27AE60),
                                ),
                              ),
                              Text(
                                widget.trainer.specialty,
                                style: const TextStyle(
                                  color: Color(0xFF424242),
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    widget.trainer.rating.toString(),
                                    style: const TextStyle(
                                      color: Color(0xFF424242),
                                      fontWeight: FontWeight.w600,
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
                  
                  const SizedBox(height: 20),
                  
                  // Consent section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF27AE60).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Consentimiento para Compartir Datos',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF27AE60),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Al contactar con ${widget.trainer.name}, autorizo el compartir la siguiente información:',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF424242),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          '• Datos de actividad física y ejercicio\n'
                          '• Historial de entrenamientos\n'
                          '• Objetivos y metas de fitness\n'
                          '• Información de contacto para seguimiento',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF424242),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Checkbox(
                              value: _hasConsented,
                              onChanged: (value) {
                                setState(() {
                                  _hasConsented = value ?? false;
                                });
                              },
                              activeColor: const Color(0xFF27AE60),
                            ),
                            const Expanded(
                              child: Text(
                                'Acepto compartir mis datos con el entrenador',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF424242),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Signature section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF27AE60).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Firma Digital',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF27AE60),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Por favor, firma en el área de abajo:',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF424242),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                          ),
                          child: Signature(
                            key: _signatureKey,
                            backgroundColor: Colors.white,
                            penColor: const Color(0xFF27AE60),
                            strokeWidth: 2,
                            onSign: () {
                              setState(() {
                                _hasSigned = true;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                _signatureKey.currentState?.clear();
                                setState(() {
                                  _hasSigned = false;
                                });
                              },
                              child: const Text(
                                'Limpiar',
                                style: TextStyle(color: Color(0xFF27AE60)),
                              ),
                            ),
                            Text(
                              _hasSigned ? 'Firma completada ✓' : 'Firme aquí',
                              style: TextStyle(
                                fontSize: 12,
                                color: _hasSigned ? Colors.green : Colors.grey[600],
                                fontWeight: _hasSigned ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[400],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (_hasConsented && _hasSigned)
                              ? () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop(); // Close both dialogs
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Datos compartidos con ${widget.trainer.name}'),
                                      backgroundColor: const Color(0xFF27AE60),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF27AE60),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Compartir Datos'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Signature extends StatefulWidget {
  final GlobalKey<SignatureState>? key;
  final Color backgroundColor;
  final Color penColor;
  final double strokeWidth;
  final VoidCallback? onSign;

  const Signature({
    this.key,
    this.backgroundColor = Colors.white,
    this.penColor = Colors.black,
    this.strokeWidth = 2.0,
    this.onSign,
  }) : super(key: key);

  @override
  SignatureState createState() => SignatureState();
}

class SignatureState extends State<Signature> {
  List<Offset> _points = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          _points.add(renderBox.globalToLocal(details.globalPosition));
        });
      },
      onPanEnd: (details) {
        setState(() {
          _points.add(Offset.infinite);
        });
        widget.onSign?.call();
      },
      child: Container(
        color: widget.backgroundColor,
        child: CustomPaint(
          painter: SignaturePainter(_points, widget.penColor, widget.strokeWidth),
        ),
      ),
    );
  }

  void clear() {
    setState(() {
      _points.clear();
    });
  }
}

class SignaturePainter extends CustomPainter {
  final List<Offset> points;
  final Color penColor;
  final double strokeWidth;

  SignaturePainter(this.points, this.penColor, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = penColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.infinite && points[i + 1] != Offset.infinite) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => oldDelegate.points != points;
}

class Trainer {
  final String name;
  final String specialty;
  final double rating;
  final String photo;

  Trainer({
    required this.name,
    required this.specialty,
    required this.rating,
    required this.photo,
  });
}