import 'package:flutter/material.dart';

class PsychologistProfileScreen extends StatelessWidget {
  static const route = '/profile-psychologist';
  const PsychologistProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Quitar botón de regreso automático
        title: const Text('Perfil del Psicólogo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.psychology)),
            title: Text('Nombre: Dra. María López'),
            subtitle: Text(
              'Especialidad: TCC • Experiencia: 10 años • Colegiatura: 12345',
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Descripción breve del enfoque.'),
            ),
          ),
          ListTile(
            title: Text('Redes sociales'),
            subtitle: Text('@dramarialopez'),
          ),
          Divider(),
          ListTile(title: Text('Acceso al paciente (con firma digital):')),
          ListTile(title: Text('• Preguntas de estado de ánimo')),
          ListTile(title: Text('• Diario emocional')),
          ListTile(title: Text('• Calendario de emociones')),
          ListTile(title: Text('• Técnicas realizadas')),
          ListTile(title: Text('• Gráficas del usuario')),
          ListTile(title: Text('En laboral: datos del smartwatch')),
          Divider(),
          ListTile(title: Text('Herramientas extra (laboral):')),
          ListTile(title: Text('• Identificar estrés situacional vs. crónico')),
          ListTile(title: Text('• Historial de progreso')),
          ListTile(title: Text('• Recomendaciones personalizadas')),
        ],
      ),
    );
  }
}
