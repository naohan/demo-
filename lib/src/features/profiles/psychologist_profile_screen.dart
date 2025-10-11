import 'package:flutter/material.dart';
import '../../widgets/psychologist_base_layout.dart';

class PsychologistProfileScreen extends StatefulWidget {
  static const route = '/profile-psychologist';
  const PsychologistProfileScreen({super.key});

  @override
  State<PsychologistProfileScreen> createState() =>
      _PsychologistProfileScreenState();
}

class _PsychologistProfileScreenState extends State<PsychologistProfileScreen> {
  bool _isEditing = false;

  // Datos del perfil (normalmente vendrían de una base de datos)
  final Map<String, dynamic> _profileData = {
    'name': 'Dra. Andrea Martínez',
    'specialty': 'Terapia Cognitivo-Conductual',
    'experience': '12 años',
    'collegeNumber': 'COL-PSI-15847',
    'email': 'dra.martinez@serenity.com',
    'phone': '+1 (555) 123-4567',
    'education': 'Maestría en Psicología Clínica - Universidad Nacional',
    'description':
        'Especialista en trastornos de ansiedad, depresión y terapia familiar. Enfoque humanista con técnicas basadas en evidencia.',
    'socialMedia': '@dra.martinez.psi',
    'consultationRate': '80€/sesión',
    'languages': ['Español', 'Inglés', 'Francés'],
  };

  final List<Map<String, String>> _certifications = [
    {
      'title': 'Certificación en TCC',
      'institution': 'Instituto Beck',
      'year': '2018',
      'status': 'Vigente',
    },
    {
      'title': 'Especialización en Trauma',
      'institution': 'EMDR International',
      'year': '2020',
      'status': 'Vigente',
    },
    {
      'title': 'Terapia Familiar Sistémica',
      'institution': 'Instituto Ackerman',
      'year': '2019',
      'status': 'Vigente',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return PsychologistBaseLayout(
      title: 'Mi Perfil Profesional',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _buildPersonalInfo(),
            const SizedBox(height: 24),
            _buildCertifications(),
            const SizedBox(height: 24),
            _buildProfessionalTools(),
            const SizedBox(height: 24),
            _buildPatientAccess(),
            const SizedBox(height: 24),
            _buildSettings(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6B73FF).withOpacity(0.1),
            const Color(0xFF9DD5EA).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xFF6B73FF).withOpacity(0.2),
                backgroundImage: const AssetImage('assets/foto/perfil7.jpg'),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2ECC71),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _profileData['name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _profileData['specialty'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.school, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '${_profileData['experience']} de experiencia',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
              color: const Color(0xFF6B73FF),
            ),
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
            'Colegiatura',
            _profileData['collegeNumber'],
            Icons.badge,
          ),
          _buildInfoTile('Email', _profileData['email'], Icons.email),
          _buildInfoTile('Teléfono', _profileData['phone'], Icons.phone),
          _buildInfoTile('Formación', _profileData['education'], Icons.school),
          _buildInfoTile(
            'Tarifa consulta',
            _profileData['consultationRate'],
            Icons.attach_money,
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2ECC71).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified,
              color: Color(0xFF2ECC71),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cert['title']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                Text(
                  '${cert['institution']} • ${cert['year']}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF2ECC71),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              cert['status']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalTools() {
    return _buildSection(
      title: 'Herramientas Profesionales',
      icon: Icons.psychology,
      child: Column(
        children: [
          _buildToolCard(
            'Evaluaciones Psicológicas',
            'Tests y cuestionarios validados',
            Icons.quiz,
          ),
          _buildToolCard(
            'Seguimiento de Progreso',
            'Gráficas y análisis de evolución',
            Icons.trending_up,
          ),
          _buildToolCard(
            'Técnicas Terapéuticas',
            'Biblioteca de intervenciones',
            Icons.auto_stories,
          ),
          _buildToolCard(
            'Gestión de Sesiones',
            'Planificación y notas clínicas',
            Icons.event_note,
          ),
        ],
      ),
    );
  }

  Widget _buildPatientAccess() {
    return _buildSection(
      title: 'Acceso a Datos del Paciente',
      icon: Icons.folder_shared,
      child: Column(
        children: [
          _buildAccessItem(
            'Diario Emocional',
            'Registro diario de estados de ánimo',
            true,
          ),
          _buildAccessItem(
            'Calendario de Emociones',
            'Patrones temporales de bienestar',
            true,
          ),
          _buildAccessItem(
            'Técnicas Realizadas',
            'Historial de ejercicios completados',
            true,
          ),
          _buildAccessItem(
            'Métricas de Progreso',
            'Gráficas de evolución',
            true,
          ),
          _buildAccessItem(
            'Datos de Smartwatch',
            'Métricas biométricas (Plan Laboral)',
            false,
          ),
          _buildAccessItem(
            'Análisis de Estrés',
            'Situacional vs. crónico (Plan Laboral)',
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
            'Gestionar alertas y recordatorios',
            Icons.notifications,
          ),
          _buildSettingTile(
            'Privacidad',
            'Configurar acceso a datos',
            Icons.privacy_tip,
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF6B73FF), size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2C3E50),
                fontWeight: FontWeight.w500,
              ),
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
                            0xFF6B73FF,
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6B73FF), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: hasAccess ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(12),
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
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF6B73FF), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
