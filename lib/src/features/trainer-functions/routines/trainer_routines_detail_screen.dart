import 'package:flutter/material.dart';
import '../../../widgets/trainer_base_layout.dart';
import 'create_edit_routine_screen.dart'; // <-- 1. Importa la futura pantalla de creación/edición

class TrainerRoutineDetailScreen extends StatelessWidget {
  static const route = '/trainer-routine-detail';
  const TrainerRoutineDetailScreen({super.key});

  // <-- 2. CREAMOS UNA FUNCIÓN PARA NAVEGAR Y EDITAR
  void _navigateToEdit(BuildContext context, Map<String, dynamic> routine) async {
    final result = await Navigator.pushNamed(
      context,
      CreateEditRoutineScreen.route,
      arguments: routine, // Le pasamos la rutina actual para que el formulario se llene
    );

    if (result != null && result is Map<String, dynamic>) {
      // Si la edición fue exitosa, cerramos la pantalla de detalle
      // y devolvemos la rutina actualizada a la pantalla de la lista.
      Navigator.pop(context, result);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Recibimos el Map<String, dynamic> que pasamos como argumento
    final routine = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    
    // Extraemos la lista de ejercicios del Map
    final exercises = routine['exercises'] as List;

    final bool isCustomRoutine = routine['isPredefined'] == false;

    return TrainerBaseLayout(
      title: 'Detalle de Rutina',
      hero: null,
      // <--- 2. AÑADIMOS EL FLOATINGACTIONBUTTON EN SU LUGAR
      floatingActionButton: isCustomRoutine ? FloatingActionButton(
        onPressed: () => _navigateToEdit(context, routine),
        backgroundColor: const Color(0xFFFF6B6B), // Mismo color que el de crear
        child: const Icon(Icons.edit), // Icono de editar
      ) : null, // Si no es personalizada, no mostramos ningún botón
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de cabecera
            Text(
              routine['name'],
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C3E50),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              routine['description'],
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.grey[700]),
            ),
            const Divider(height: 40, thickness: 1),

            // Sección de la lista de ejercicios
            Text(
              'Ejercicios de la Rutina',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            
            // 2. Construimos la lista de ejercicios dinámicamente desde la lista de Maps
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: exercises.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final exercise = exercises[index] as Map<String, dynamic>;
                return _buildExerciseListItem(context, exercise, index + 1);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget para mostrar cada ejercicio de la lista
  Widget _buildExerciseListItem(BuildContext context, Map<String, dynamic> exercise, int number) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: const Color(0xFF4ECDC4).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFF4ECDC4),
            foregroundColor: Colors.white,
            child: Text(number.toString()),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise['name'],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${exercise['sets']} series x ${exercise['reps']} repeticiones',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              const Icon(Icons.timer_outlined, color: Colors.grey),
              Text(
                exercise['restTime'],
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}