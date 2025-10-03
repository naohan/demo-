import 'package:flutter/material.dart';

class TrainerProfileScreen extends StatelessWidget {
  static const route = '/profile-trainer';
  const TrainerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Quitar botón de regreso automático
        title: const Text('Perfil del Entrenador'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.fitness_center)),
            title: Text('Nombre: Luis Gómez'),
            subtitle: Text(
              'Especialidad: Funcional • Experiencia: 7 años • Certificaciones: CF-L1',
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Descripción corta del enfoque.'),
            ),
          ),
          ListTile(title: Text('Ranking ⭐ (versión personal): 4.5')),
          Divider(),
          ListTile(title: Text('Acceso al cliente (con firma digital):')),
          ListTile(title: Text('• Rutinas realizadas')),
          ListTile(title: Text('• Pasos y calorías')),
          ListTile(title: Text('• Sueño y energía (laboral)')),
          Divider(),
          ListTile(title: Text('Herramientas extra (laboral):')),
          ListTile(title: Text('• Pausas activas')),
          ListTile(
            title: Text('• Retos antiestrés (ej. 5,000 pasos en jornada)'),
          ),
          ListTile(title: Text('• Estadísticas de actividad física')),
        ],
      ),
    );
  }
}
