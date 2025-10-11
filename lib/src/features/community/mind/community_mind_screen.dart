import 'package:flutter/material.dart';
import '../../../widgets/user_base_layout.dart';

class CommunityMindScreen extends StatefulWidget {
  static const route = '/community-mind';
  const CommunityMindScreen({super.key});

  @override
  State<CommunityMindScreen> createState() => _CommunityMindScreenState();
}

class _CommunityMindScreenState extends State<CommunityMindScreen> {
  @override
  Widget build(BuildContext context) {
    return UserBaseLayout(
      title: 'Comunidad de Mente Plena',
      hero: Container(
        height: 160,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF1565C0).withOpacity(0.08)),
          image: const DecorationImage(
            image: AssetImage('assets/banner/banner-comunity.png'),
            fit: BoxFit.cover, // ocupa todo el rectángulo
            alignment: Alignment.center,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFE3F2FD), // Azul muy claro
              const Color(0xFFBBDEFB), // Azul claro
              const Color(0xFF90CAF9), // Azul medio claro
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
                'Comunidad de Mente Plena',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1565C0),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // Descripción
              Text(
                'Un espacio seguro para compartir experiencias, obtener apoyo y conectar con otros en tu journey de bienestar mental.',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF424242),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Tarjetas de características
              _buildFeatureCard(
                context,
                icon: Icons.forum,
                title: 'Foros de Discusión',
                subtitle:
                    'Participa en conversaciones sobre temas de salud mental',
              ),
              const SizedBox(height: 15),
              _buildFeatureCard(
                context,
                icon: Icons.group,
                title: 'Grupos de Apoyo',
                subtitle:
                    'Conecta con personas que comparten experiencias similares',
              ),
              const SizedBox(height: 15),
              _buildFeatureCard(
                context,
                icon: Icons.local_library,
                title: 'Recursos Educativos',
                subtitle:
                    'Accede a artículos y material educativo especializado',
              ),
              const SizedBox(height: 20),

              // Sección de eventos
              _buildSectionCard(
                context,
                title: 'Próximos Eventos',
                children: [
                  _buildEventCard(
                    'Meditación Grupal',
                    'Sábado 15:00',
                    Icons.self_improvement,
                  ),
                  _buildEventCard(
                    'Taller de Ansiedad',
                    'Domingo 10:00',
                    Icons.psychology,
                  ),
                  _buildEventCard(
                    'Grupo de Apoyo',
                    'Lunes 19:00',
                    Icons.support,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Sección de recursos
              _buildSectionCard(
                context,
                title: 'Recursos Destacados',
                children: [
                  _buildResourceCard(
                    'Guía de Mindfulness',
                    'Aprende técnicas de atención plena',
                    Icons.book,
                  ),
                  _buildResourceCard(
                    'Ejercicios de Respiración',
                    'Técnicas para reducir el estrés',
                    Icons.air,
                  ),
                  _buildResourceCard(
                    'Diario de Emociones',
                    'Registra y analiza tus emociones',
                    Icons.edit,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Sección de testimonios
              _buildSectionCard(
                context,
                title: 'Testimonios de la Comunidad',
                children: [
                  _buildTestimonialCard(
                    'María',
                    'Esta comunidad me ha ayudado mucho en mi proceso de sanación. Gracias por el apoyo.',
                  ),
                  _buildTestimonialCard(
                    'Carlos',
                    'Los recursos educativos son excelentes. He aprendido técnicas muy útiles.',
                  ),
                  _buildTestimonialCard(
                    'Ana',
                    'El grupo de apoyo me ha dado la fuerza para seguir adelante.',
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Botón para ingresar a la comunidad
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1565C0).withOpacity(0.3),
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
                      Navigator.pushNamed(
                        context,
                        '/community-mind-interactive',
                      );
                    },
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.group_add, color: Colors.white, size: 24),
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
          color: const Color(0xFF1565C0).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1565C0).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF1565C0), size: 24),
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
                    color: Color(0xFF1565C0),
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

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
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
          color: const Color(0xFF1565C0).withOpacity(0.2),
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
              color: Color(0xFF1565C0),
            ),
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _buildEventCard(String title, String time, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF1565C0).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1565C0), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
                Text(
                  time,
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

  Widget _buildResourceCard(String title, String description, IconData icon) {
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
          Icon(icon, color: const Color(0xFF4CAF50), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                Text(
                  description,
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
