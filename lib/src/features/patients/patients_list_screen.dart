import 'package:flutter/material.dart';
import '../../widgets/psychologist_base_layout.dart';

class Patient {
  final String name;
  final String avatar;
  final String status;

  Patient({required this.name, required this.avatar, required this.status});
}

class PatientsListScreen extends StatefulWidget {
  static const route = '/patients-list';
  const PatientsListScreen({super.key});

  @override
  State<PatientsListScreen> createState() => _PatientsListScreenState();
}

class _PatientsListScreenState extends State<PatientsListScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Patient> _allPatients = [
    Patient(
      name: 'Ana',
      avatar:
          'https://ui-avatars.com/api/?name=Ana&background=3b82f6&color=ffffff&size=128',
      status: 'Activo',
    ),
    Patient(
      name: 'Luis',
      avatar:
          'https://ui-avatars.com/api/?name=Luis&background=3b82f6&color=ffffff&size=128',
      status: 'Activo',
    ),
    Patient(
      name: 'María',
      avatar:
          'https://ui-avatars.com/api/?name=Maria&background=3b82f6&color=ffffff&size=128',
      status: 'Activo',
    ),
    Patient(
      name: 'Osmar',
      avatar:
          'https://ui-avatars.com/api/?name=Osmar&background=3b82f6&color=ffffff&size=128',
      status: 'Activo',
    ),
    Patient(
      name: 'Brayan',
      avatar:
          'https://ui-avatars.com/api/?name=Brayan&background=3b82f6&color=ffffff&size=128',
      status: 'Activo',
    ),
    Patient(
      name: 'Carlos',
      avatar:
          'https://ui-avatars.com/api/?name=Carlos&background=3b82f6&color=ffffff&size=128',
      status: 'Activo',
    ),
  ];

  List<Patient> _filteredPatients = [];

  @override
  void initState() {
    super.initState();
    _filteredPatients = _allPatients;
    _searchController.addListener(_filterPatients);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPatients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPatients =
          _allPatients
              .where((patient) => patient.name.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PsychologistBaseLayout(
      title: '',
      child: Column(
        children: [
          // Header personalizado
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF3B82F6),
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Pacientes',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Barra de búsqueda
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Buscar...',
                      hintStyle: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(Icons.search, color: Color(0xFF9CA3AF)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Lista de pacientes
          Expanded(
            child: Container(
              color: const Color(0xFFF9FAFB),
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _filteredPatients.length,
                itemBuilder: (context, index) {
                  final patient = _filteredPatients[index];
                  return _buildPatientCard(patient);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientCard(Patient patient) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF3B82F6).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Avatar del paciente
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF3B82F6), width: 3),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(patient.avatar),
              backgroundColor: const Color(0xFF3B82F6),
              child: const Icon(Icons.person, color: Colors.white, size: 35),
            ),
          ),
          const SizedBox(height: 16),

          // Nombre del paciente
          Text(
            patient.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 16),

          // Botón Ver
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/patient-detail',
                  arguments: patient.name,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                'Ver',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
