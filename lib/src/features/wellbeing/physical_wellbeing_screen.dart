import 'package:flutter/material.dart';
import '../../widgets/base_layout.dart';

class PhysicalWellbeingScreen extends StatelessWidget {
  static const route = '/wellbeing-physical';
  const PhysicalWellbeingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Bienestar Físico',
      hero: const Icon(Icons.fitness_center, size: 64),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Smartwatch (si está conectado)'),
                  SizedBox(height: 8),
                  Text('Pasos diarios: 4,000'),
                  Text('Racha: meta 10,000 pasos'),
                  Text('Sueño: 6.5 horas (calidad media)'),
                  Text('Ejercicios realizados: 2 (manual)'),
                  Text('Peso/medidas: opcional'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Balance del día'),
                  SizedBox(height: 8),
                  Text('Hoy caminaste 4,000 pasos 🏃‍♂️ y registraste 2 emociones positivas 🌞'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Motivación personalizada'),
                  SizedBox(height: 8),
                  Text('¡Sigue avanzando, cuerpo y mente en equilibrio!'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Recomendaciones dinámicas'),
                  SizedBox(height: 8),
                  Text('Hoy yoga suave porque dormiste poco 😴'),
                  SizedBox(height: 8),
                  Text('Recomendaciones del entrenador: tips de 5–10 min'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}