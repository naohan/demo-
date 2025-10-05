import 'package:flutter/material.dart';
import '../../widgets/trainer_base_layout.dart';

class TrainerProfileScreen extends StatefulWidget {
  static const route = '/profile-trainer';
  const TrainerProfileScreen({super.key});

  @override
  State<TrainerProfileScreen> createState() => _TrainerProfileScreenState();
}

class _TrainerProfileScreenState extends State<TrainerProfileScreen> {
  bool _isEditing = false;

  // Datos del perfil del entrenador
  final Map<String, dynamic> _profileData = {
    'name': 'Luis Rodríguez',
    'specialty': 'Entrenamiento Funcional y CrossFit',
    'experience': '8 años',
    'certificationNumber': 'CF-L2-7845',
    'email': 'luis.rodriguez@serenity.com',
    'phone': '+1 (555) 987-6543',
    'education':
        'Licenciatura en Ciencias del Deporte - Universidad del Deporte',
    'description':
        'Especialista en entrenamiento funcional, CrossFit y rehabilitación deportiva. Enfoque personalizado para alcanzar objetivos de salud y rendimiento.',
    'socialMedia': '@luistrainer_fit',
    'sessionRate': '45€/sesión',
    'languages': ['Español', 'Inglés'],
    'rating': 4.8,
    'clientsCount': 47,
  };

  final List<Map<String, String>> _certifications = [
    {
      'title': 'CrossFit Level 2',
      'institution': 'CrossFit Inc.',
      'year': '2022',
      'status': 'Vigente',
    },
    {
      'title': 'Entrenamiento Funcional',
      'institution': 'NSCA',
      'year': '2020',
      'status': 'Vigente',
    },
    {
      'title': 'Nutrición Deportiva',
      'institution': 'ISSN',
      'year': '2021',
      'status': 'Vigente',
    },
    {
      'title': 'Primeros Auxilios',
      'institution': 'Cruz Roja',
      'year': '2023',
      'status': 'Vigente',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return TrainerBaseLayout(
      title: 'Mi Perfil',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 12),
            _buildPersonalInfo(),
            const SizedBox(height: 12),
            _buildCertifications(),
            const SizedBox(height: 12),
            _buildTrainingTools(),
            const SizedBox(height: 12),
            _buildClientAccess(),
            const SizedBox(height: 12),
            _buildSettings(),
            const SizedBox(height: 16), // Espacio adicional al final
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFF6B6B).withOpacity(0.1),
            const Color(0xFF4ECDC4).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFFFF6B6B).withOpacity(0.2),
                child: const Icon(
                  Icons.fitness_center,
                  size: 24,
                  color: Color(0xFFFF6B6B),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2ECC71),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _profileData['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _profileData['specialty'],
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.star, size: 10, color: Colors.amber),
                    const SizedBox(width: 3),
                    Text(
                      '${_profileData['rating']} • ${_profileData['clientsCount']} clientes',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _isEditing = !_isEditing),
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
              color: const Color(0xFFFF6B6B),
              size: 16,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalInfo() {
    return _buildSection(
      title: 'Información Personal',
      icon: Icons.person,
      child: Column(
        children: [
          _buildInfoTile(
            'Certificación',
            _profileData['certificationNumber'],
            Icons.badge,
          ),
          _buildInfoTile('Email', _profileData['email'], Icons.email),
          _buildInfoTile('Teléfono', _profileData['phone'], Icons.phone),
          _buildInfoTile('Formación', _profileData['education'], Icons.school),
          _buildInfoTile(
            'Tarifa sesión',
            _profileData['sessionRate'],
            Icons.attach_money,
          ),
          _buildInfoTile(
            'Experiencia',
            _profileData['experience'],
            Icons.timeline,
          ),
          _buildLanguages(),
        ],
      ),
    );
  }

  Widget _buildCertifications() {
    return _buildSection(
      title: 'Certificaciones y Especialidades',
      icon: Icons.workspace_premium,
      child: Column(
        children:
            _certifications
                .map((cert) => _buildCertificationCard(cert))
                .toList(),
      ),
    );
  }

  Widget _buildCertificationCard(Map<String, String> cert) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFF2ECC71).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified,
              color: Color(0xFF2ECC71),
              size: 12,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cert['title']!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${cert['institution']} • ${cert['year']}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF2ECC71),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              cert['status']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingTools() {
    return _buildSection(
      title: 'Herramientas de Entrenamiento',
      icon: Icons.fitness_center,
      child: Column(
        children: [
          _buildToolCard(
            'Planes de Entrenamiento',
            'Rutinas personalizadas y seguimiento',
            Icons.assignment,
          ),
          _buildToolCard(
            'Seguimiento de Progreso',
            'Métricas y evolución física',
            Icons.trending_up,
          ),
          _buildToolCard(
            'Biblioteca de Ejercicios',
            'Videos y guías técnicas',
            Icons.video_library,
          ),
          _buildToolCard(
            'Gestión de Clientes',
            'Horarios y notas de entrenamiento',
            Icons.people,
          ),
          _buildToolCard(
            'Análisis Nutricional',
            'Planes alimentarios básicos',
            Icons.restaurant,
          ),
        ],
      ),
    );
  }

  Widget _buildClientAccess() {
    return _buildSection(
      title: 'Acceso a Datos del Cliente',
      icon: Icons.folder_shared,
      child: Column(
        children: [
          _buildAccessItem(
            'Progreso Físico',
            'Medidas, peso y composición corporal',
            true,
          ),
          _buildAccessItem(
            'Rutinas Realizadas',
            'Historial de entrenamientos completados',
            true,
          ),
          _buildAccessItem(
            'Métricas de Rendimiento',
            'RM, velocidad, resistencia',
            true,
          ),
          _buildAccessItem(
            'Fotos de Progreso',
            'Registro visual de cambios',
            true,
          ),
          _buildAccessItem(
            'Datos de Smartwatch',
            'Frecuencia cardíaca y calorías (Plan Laboral)',
            false,
          ),
          _buildAccessItem(
            'Análisis Biomecánico',
            'Evaluación de movimiento (Plan Premium)',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return _buildSection(
      title: 'Configuración',
      icon: Icons.settings,
      child: Column(
        children: [
          _buildSettingTile(
            'Notificaciones',
            'Gestionar alertas de entrenamientos',
            Icons.notifications,
          ),
          _buildSettingTile(
            'Horarios',
            'Configurar disponibilidad',
            Icons.schedule,
          ),
          _buildSettingTile(
            'Facturación',
            'Gestionar pagos y tarifas',
            Icons.receipt,
          ),
          _buildSettingTile('Soporte Técnico', 'Ayuda y contacto', Icons.help),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFFF6B6B), size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 12, color: Colors.grey[600]),
          const SizedBox(width: 6),
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF2C3E50),
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguages() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(Icons.language, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            'Idiomas:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Wrap(
              spacing: 6,
              children:
                  (_profileData['languages'] as List<String>)
                      .map(
                        (language) => Chip(
                          label: Text(
                            language,
                            style: const TextStyle(fontSize: 12),
                          ),
                          backgroundColor: const Color(
                            0xFFFF6B6B,
                          ).withOpacity(0.1),
                          side: BorderSide.none,
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFF6B6B), size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccessItem(String title, String description, bool hasAccess) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: hasAccess ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
              hasAccess
                  ? Colors.green.withOpacity(0.3)
                  : Colors.orange.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            hasAccess ? Icons.check_circle : Icons.lock,
            color: hasAccess ? Colors.green : Colors.orange,
            size: 14,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(String title, String description, IconData icon) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Abriendo configuración de $title')),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFFF6B6B), size: 14),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
