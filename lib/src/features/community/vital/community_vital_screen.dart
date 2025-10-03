import 'package:flutter/material.dart';
import '../../../widgets/user_base_layout.dart';

class CommunityVitalScreen extends StatefulWidget {
  static const route = '/community-vital';
  const CommunityVitalScreen({super.key});

  @override
  State<CommunityVitalScreen> createState() => _CommunityVitalScreenState();
}

class _CommunityVitalScreenState extends State<CommunityVitalScreen> {

  @override
  Widget build(BuildContext context) {
    return UserBaseLayout(
      title: 'Comunidad Vital',
      hero: const Icon(Icons.fitness_center, size: 64),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFE8F5E8), // Verde muy claro
              const Color(0xFFC8E6C9), // Verde claro
              const Color(0xFFA5D6A7), // Verde medio claro
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Título principal
              Text(
                'Comunidad de Vida Saludable',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // Descripción
              Text(
                'Conecta con personas que comparten tu pasión por el fitness, la nutrición y un estilo de vida saludable. Encuentra motivación, consejos y apoyo en tu journey hacia el bienestar físico.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF424242),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Tarjetas de características
              _buildFeatureCard(
                context,
                icon: Icons.fitness_center,
                title: 'Foros de Fitness',
                subtitle: 'Comparte rutinas, consejos y experiencias de entrenamiento',
              ),
              const SizedBox(height: 15),
              _buildFeatureCard(
                context,
                icon: Icons.restaurant_menu,
                title: 'Nutrición Saludable',
                subtitle: 'Recetas, planes alimenticios y consejos nutricionales',
              ),
              const SizedBox(height: 15),
              _buildFeatureCard(
                context,
                icon: Icons.group_work,
                title: 'Grupos de Entrenamiento',
                subtitle: 'Únete a grupos de personas con objetivos similares',
              ),
              const SizedBox(height: 15),
              _buildFeatureCard(
                context,
                icon: Icons.local_library,
                title: 'Recursos de Entrenamiento',
                subtitle: 'Guías, tutoriales y material educativo especializado',
              ),
              const SizedBox(height: 20),
              
              // Sección de entrenadores
              _buildSectionCard(
                context,
                title: 'Entrenadores Certificados',
                children: [
                  _buildTrainerCard('Carlos Mendoza', 'Entrenamiento Funcional', '5 años exp.', Icons.person),
                  _buildTrainerCard('Ana Rodríguez', 'CrossFit', '7 años exp.', Icons.person),
                  _buildTrainerCard('Miguel Torres', 'Musculación', '4 años exp.', Icons.person),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Sección de planes de entrenamiento
              _buildSectionCard(
                context,
                title: 'Planes de Entrenamiento',
                children: [
                  _buildPlanCard('Plan para Principiantes', 'Rutina básica de 4 semanas', 'Gratis', Icons.play_circle),
                  _buildPlanCard('Plan de Fuerza', 'Desarrollo muscular avanzado', 'Premium', Icons.fitness_center),
                  _buildPlanCard('Plan de Cardio', 'Mejora tu resistencia cardiovascular', 'Gratis', Icons.directions_run),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Sección de nutrición
              _buildSectionCard(
                context,
                title: 'Recetas Saludables',
                children: [
                  _buildRecipeCard('Smoothie Verde', 'Desayuno energético', '15 min', Icons.local_dining),
                  _buildRecipeCard('Ensalada de Quinoa', 'Almuerzo nutritivo', '20 min', Icons.restaurant),
                  _buildRecipeCard('Pollo a la Plancha', 'Cena proteica', '25 min', Icons.restaurant_menu),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Sección de testimonios
              _buildSectionCard(
                context,
                title: 'Testimonios de la Comunidad',
                children: [
                  _buildTestimonialCard('María', 'Gracias a esta comunidad logré mis objetivos de fitness. El apoyo es increíble!'),
                  _buildTestimonialCard('Carlos', 'Los planes de entrenamiento son excelentes. He mejorado mucho mi condición física.'),
                  _buildTestimonialCard('Ana', 'Las recetas saludables me ayudaron a cambiar mi alimentación completamente.'),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // Botón para ingresar a la comunidad
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4CAF50).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.pushNamed(context, '/community-vital-interactive');
                    },
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.group_add,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Ingresar a la Comunidad',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF4CAF50).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF4CAF50), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF424242),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, {required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF4CAF50).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4CAF50),
            ),
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTrainerCard(String name, String specialty, String experience, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF4CAF50).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF4CAF50), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                Text(
                  specialty,
                  style: const TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 13,
                  ),
                ),
                Text(
                  experience,
                  style: const TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(String title, String description, String price, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF2196F3).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF2196F3), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2196F3),
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF2196F3).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              price,
              style: const TextStyle(
                color: Color(0xFF2196F3),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(String title, String description, String time, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFFF9800).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFF9800), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF9800),
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 14,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(String name, String testimonial) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF9C27B0).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"$testimonial"',
            style: const TextStyle(
              color: Color(0xFF424242),
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '- $name',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF9C27B0),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
