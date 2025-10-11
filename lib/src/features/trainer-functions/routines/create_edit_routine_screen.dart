import 'package:flutter/material.dart';
import 'dart:math'; // Para generar IDs aleatorios
import '../../../widgets/trainer_base_layout.dart';

class CreateEditRoutineScreen extends StatefulWidget {
  static const route = '/create-edit-routine';
  const CreateEditRoutineScreen({super.key});

  @override
  State<CreateEditRoutineScreen> createState() => _CreateEditRoutineScreenState();
}

class _CreateEditRoutineScreenState extends State<CreateEditRoutineScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditMode = false;
  
  // Controladores para los campos de texto
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  
  // Lista para gestionar los ejercicios
  List<Map<String, dynamic>> _exercises = [];
  Map<String, dynamic>? _originalRoutine;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();

    // Retrasamos la lectura de argumentos para asegurar que el contexto esté disponible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final routine = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (routine != null) {
        setState(() {
          _isEditMode = true;
          _originalRoutine = routine;
          _nameController.text = routine['name'];
          _descriptionController.text = routine['description'];
          // Creamos una copia de la lista para poder editarla sin afectar la original
          _exercises = List<Map<String, dynamic>>.from(routine['exercises']);
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newRoutine = {
        'id': _isEditMode ? _originalRoutine!['id'] : 'custom_${Random().nextInt(1000)}',
        'name': _nameController.text,
        'description': _descriptionController.text,
        'isPredefined': false,
        'exercises': _exercises,
      };
      // Devolvemos la rutina creada/editada a la pantalla anterior
      Navigator.pop(context, newRoutine);
    }
  }

  // Muestra un diálogo para añadir o editar un ejercicio
  void _showExerciseDialog({Map<String, dynamic>? exercise, int? index}) {
    final isEditingExercise = exercise != null;
    final nameController = TextEditingController(text: isEditingExercise ? exercise['name'] : '');
    final setsController = TextEditingController(text: isEditingExercise ? exercise['sets'].toString() : '');
    final repsController = TextEditingController(text: isEditingExercise ? exercise['reps'].toString() : '');
    final restController = TextEditingController(text: isEditingExercise ? exercise['restTime'] : '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditingExercise ? 'Editar Ejercicio' : 'Añadir Ejercicio'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nombre del Ejercicio')),
                TextField(controller: setsController, decoration: const InputDecoration(labelText: 'Series'), keyboardType: TextInputType.number),
                TextField(controller: repsController, decoration: const InputDecoration(labelText: 'Repeticiones'), keyboardType: TextInputType.number),
                TextField(controller: restController, decoration: const InputDecoration(labelText: 'Tiempo de Descanso (ej. 60s)')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () {
                final newExercise = {
                  'name': nameController.text,
                  'sets': int.tryParse(setsController.text) ?? 0,
                  'reps': int.tryParse(repsController.text) ?? 0,
                  'restTime': restController.text,
                };
                setState(() {
                  if (isEditingExercise) {
                    _exercises[index!] = newExercise;
                  } else {
                    _exercises.add(newExercise);
                  }
                });
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TrainerBaseLayout(
      title: _isEditMode ? 'Editar Rutina' : 'Crear Rutina',
      hero: null,
      // <--- 2. AÑADIMOS EL FLOATINGACTIONBUTTON EN SU LUGAR
      floatingActionButton: FloatingActionButton(
        onPressed: _saveForm,
        backgroundColor: const Color(0xFF4ECDC4), // Un color diferente para "Guardar"
        child: const Icon(Icons.save),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre de la Rutina'),
                validator: (value) => value!.isEmpty ? 'Por favor, introduce un nombre' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Por favor, introduce una descripción' : null,
              ),
              const Divider(height: 40),
              Text(
                'Ejercicios',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _exercises.length,
                itemBuilder: (context, index) {
                  final exercise = _exercises[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(exercise['name']),
                      subtitle: Text('${exercise['sets']}x${exercise['reps']} | Descanso: ${exercise['restTime']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showExerciseDialog(exercise: exercise, index: index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _exercises.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Añadir Ejercicio'),
                  onPressed: () => _showExerciseDialog(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}