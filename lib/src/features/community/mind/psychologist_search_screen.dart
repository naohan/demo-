import 'package:flutter/material.dart';
import 'psychologist_profile_screen.dart';

class PsychologistSearchScreen extends StatefulWidget {
  static const route = '/psychologist-search';
  const PsychologistSearchScreen({super.key});

  @override
  State<PsychologistSearchScreen> createState() =>
      _PsychologistSearchScreenState();
}

class _PsychologistSearchScreenState extends State<PsychologistSearchScreen> {
  final _searchController = TextEditingController();
  String _selectedLocation = 'Todos';
  String _selectedSpecialty = 'Todas';

  final List<String> _locations = ['Todos', 'Lima', 'Arequipa', 'Trujillo'];
  final List<String> _specialties = [
    'Todas',
    'Terapia Cognitivo-Conductual',
    'Psicología Clínica',
    'Terapia de Pareja',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Quitar botón de regreso automático
        title: const Text('Buscar Psicólogo'),
      ),
      body: Column(
        children: [
          // Buscador
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por nombre...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // Filtros
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedLocation,
                    decoration: const InputDecoration(
                      labelText: 'Ubicación',
                      border: OutlineInputBorder(),
                    ),
                    items:
                        _locations
                            .map(
                              (loc) => DropdownMenuItem(
                                value: loc,
                                child: Text(loc),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() => _selectedLocation = value!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedSpecialty,
                    decoration: const InputDecoration(
                      labelText: 'Especialidad',
                      border: OutlineInputBorder(),
                    ),
                    items:
                        _specialties
                            .map(
                              (spec) => DropdownMenuItem(
                                value: spec,
                                child: Text(spec),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() => _selectedSpecialty = value!),
                  ),
                ),
              ],
            ),
          ),

          // Lista de psicólogos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 10,
              itemBuilder:
                  (context, index) => Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/${index % 2 == 0 ? "women" : "men"}/${index + 1}.jpg',
                        ),
                      ),
                      title: Text(
                        'Dr. ${index % 2 == 0 ? "María" : "Juan"} ${index + 1}',
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${_locations[index % _locations.length]}'),
                          Text('${_specialties[index % _specialties.length]}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('4.${5 + index % 5}'),
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                        ],
                      ),
                      onTap:
                          () => Navigator.pushNamed(
                            context,
                            PsychologistProfileScreen.route,
                          ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
