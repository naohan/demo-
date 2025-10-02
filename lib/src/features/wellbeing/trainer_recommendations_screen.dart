import 'package:flutter/material.dart';
import '../../widgets/base_layout.dart';

class TrainerRecommendationsScreen extends StatelessWidget {
  static const route = '/trainer-recommendations';
  const TrainerRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recommendations = const [
      'Calentamiento de 5 min (movilidad de cadera y hombros)',
      'Caminata ligera 20 min (zona aeróbica baja)',
      'Estiramientos guiados 10 min (respiración 4-4)',
      'Hidratación: 2 vasos de agua antes de dormir',
    ];

    return BaseLayout(
      title: 'Recomendaciones del Entrenador',
      hero: const Icon(Icons.support_agent, size: 64),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Ana Pérez – Yoga & Mindfulness'),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Feedback disponible'),
                  const SizedBox(height: 8),
                  ...recommendations.map((r) => ListTile(
                        leading: const Icon(Icons.check_circle_outline, color: Colors.green),
                        title: Text(r),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}