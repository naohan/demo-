import 'package:flutter/material.dart';
import '../../../widgets/trainer_base_layout.dart';
import 'create_edit_routine_screen.dart'; // <-- 1. Importa la futura pantalla de creación/edición
import 'trainer_routines_detail_screen.dart'; // <-- 1. Importa la futura pantalla de detalle

class TrainerRoutinesScreen extends StatefulWidget {
  static const route = '/trainer-routines';
  const TrainerRoutinesScreen({super.key});

  @override
  State<TrainerRoutinesScreen> createState() => _TrainerRoutinesScreenState();
}

class _TrainerRoutinesScreenState extends State<TrainerRoutinesScreen> {
  // 2. Ampliamos los datos de ejemplo para incluir la lista de ejercicios
  final List<Map<String, dynamic>> _routines = [
    {
      'id': 'predef_1',
      'name': 'Calentamiento Esencial',
      'description': 'Rutina de baja intensidad para empezar el día con energía.',
      'isPredefined': true,
      'exercises': [
        {'name': 'Estiramiento de brazos', 'sets': 1, 'reps': 10, 'restTime': '15s'},
        {'name': 'Rotación de tobillos', 'sets': 1, 'reps': 15, 'restTime': '15s'},
        {'name': 'Jumping Jacks (lento)', 'sets': 2, 'reps': 20, 'restTime': '30s'},
      ],
    },
    {
      'id': 'predef_2',
      'name': 'Fuerza Total',
      'description': 'Rutina de alta intensidad para desarrollo muscular completo.',
      'isPredefined': true,
      'exercises': [
        {'name': 'Sentadillas con barra', 'sets': 4, 'reps': 12, 'restTime': '90s'},
        {'name': 'Press de banca', 'sets': 4, 'reps': 10, 'restTime': '90s'},
        {'name': 'Dominadas', 'sets': 3, 'reps': 8, 'restTime': '2m'},
        {'name': 'Peso muerto', 'sets': 3, 'reps': 8, 'restTime': '2m'},
      ],
    },
    {
      'id': 'custom_1',
      'name': 'Mi Rutina de Tren Superior',
      'description': 'Ejercicios personalizados para pecho, espalda y hombros.',
      'isPredefined': false,
      'exercises': [
        {'name': 'Flexiones', 'sets': 3, 'reps': 15, 'restTime': '60s'},
        {'name': 'Remo con mancuerna', 'sets': 3, 'reps': 12, 'restTime': '60s'},
        {'name': 'Elevaciones laterales', 'sets': 3, 'reps': 15, 'restTime': '45s'},
      ],
    },
  ];

    // <-- 2. FUNCIÓN PARA NAVEGAR Y ESPERAR EL RESULTADO
  void _navigateToCreateRoutine() async {
    final result = await Navigator.pushNamed(context, CreateEditRoutineScreen.route);

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _routines.add(result);
      });
    }
  }
  
  // <-- FUNCIÓN PARA MANEJAR LA NAVEGACIÓN A DETALLE Y LA ACTUALIZACIÓN
  void _navigateToDetailAndUpdate(Map<String, dynamic> routine) async {
    final result = await Navigator.pushNamed(
      context, 
      TrainerRoutineDetailScreen.route, 
      arguments: routine
    );
    
    // Si la pantalla de detalle nos devuelve una rutina actualizada, la procesamos
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        final index = _routines.indexWhere((r) => r['id'] == result['id']);
        if (index != -1) {
          _routines[index] = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TrainerBaseLayout(
      title: 'Gestión de Rutinas',
      hero: null,
      // <-- 3. AÑADIMOS EL BOTÓN FLOTANTE
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreateRoutine,
        backgroundColor: const Color(0xFFFF6B6B),
        child: const Icon(Icons.add),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mis Rutinas',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E50),
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Aquí puedes ver, crear y editar tus planes de entrenamiento.',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _routines.length,
              itemBuilder: (context, index) {
                final routine = _routines[index];
                return _buildRoutineCard(context, routine);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineCard(BuildContext context, Map<String, dynamic> routine) {
    final bool isPredefined = routine['isPredefined'];

    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isPredefined
              ? const Color(0xFF4ECDC4).withOpacity(0.5)
              : const Color(0xFFFF6B6B).withOpacity(0.5),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                (isPredefined ? const Color(0xFF4ECDC4) : const Color(0xFFFF6B6B))
                    .withOpacity(0.1),
          ),
          child: Icon(
            isPredefined ? Icons.verified : Icons.edit_note,
            color: isPredefined
                ? const Color(0xFF4ECDC4)
                : const Color(0xFFFF6B6B),
          ),
        ),
        title: Text(routine['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(routine['description']),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // Usar la función que espera el resultado y actualiza la lista
          _navigateToDetailAndUpdate(routine);
        },
      ),
    );
  }
}