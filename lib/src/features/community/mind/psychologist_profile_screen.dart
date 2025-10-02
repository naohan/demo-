import 'package:flutter/material.dart';

class PsychologistProfileScreen extends StatelessWidget {
  static const route = '/psychologist-profile';
  const PsychologistProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://randomuser.me/api/portraits/women/1.jpg',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dra. María Sánchez',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.verified, color: Colors.blue[600]),
                          const Text(' Psicóloga Clínica Certificada'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(Icons.school, 'PhD. en Psicología Clínica'),
                      _buildInfoRow(
                        Icons.work_outline, 
                        '12 años de experiencia'
                      ),
                      _buildInfoRow(
                        Icons.location_on, 
                        'Lima, Perú - Consultas presenciales y online'
                      ),
                    ],
                  ),
                ),

                _buildSection(
                  'Especialidades',
                  [
                    'Terapia Cognitivo-Conductual',
                    'Manejo del Estrés y Ansiedad',
                    'Depresión',
                    'Terapia de Pareja',
                  ].map((esp) => ListTile(
                    leading: const Icon(Icons.check_circle),
                    title: Text(esp),
                  )).toList(),
                ),

                _buildSection(
                  'Horarios de Atención',
                  [
                    _buildTimeSlot('Lunes a Viernes', '9am - 6pm'),
                    _buildTimeSlot('Sábados', '9am - 1pm'),
                  ],
                ),

                _buildSection(
                  'Testimonios',
                  [
                    _buildReview(
                      'Carlos R.', 
                      'Excelente profesional, me ayudó mucho',
                      5
                    ),
                    _buildReview(
                      'Anónimo', 
                      'Gran experiencia en terapia online',
                      5
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Agendar Consulta'),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(String days, String hours) {
    return ListTile(
      leading: const Icon(Icons.access_time),
      title: Text(days),
      subtitle: Text(hours),
    );
  }

  Widget _buildReview(String name, String comment, int rating) {
    return ListTile(
      title: Row(
        children: [
          Text(name),
          const SizedBox(width: 8),
          ...List.generate(
            5,
            (i) => Icon(
              Icons.star,
              size: 16,
              color: i < rating ? Colors.amber : Colors.grey[300],
            ),
          ),
        ],
      ),
      subtitle: Text(comment),
    );
  }
}
