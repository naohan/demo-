import 'package:flutter/material.dart';
import '../../widgets/base_layout.dart';

class GoalsConfigScreen extends StatefulWidget {
  static const route = '/goals-config';
  const GoalsConfigScreen({super.key});

  @override
  State<GoalsConfigScreen> createState() => _GoalsConfigScreenState();
}

class _GoalsConfigScreenState extends State<GoalsConfigScreen> {
  int stepsGoal = 8000;
  double weightGoal = 70; // kg
  int routineDays = 4; // por semana

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      title: 'Metas',
      hero: const Icon(Icons.settings, size: 64),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pasos diarios', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: stepsGoal.toDouble(),
                          min: 2000,
                          max: 20000,
                          divisions: 18,
                          label: '$stepsGoal',
                          onChanged: (v) => setState(() => stepsGoal = v.round()),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text('$stepsGoal'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Peso objetivo (kg)', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: weightGoal,
                          min: 45,
                          max: 120,
                          divisions: 75,
                          label: '${weightGoal.toStringAsFixed(1)}',
                          onChanged: (v) => setState(() => weightGoal = v),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text('${weightGoal.toStringAsFixed(1)}'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Rutinas por semana', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: routineDays.toDouble(),
                          min: 1,
                          max: 7,
                          divisions: 6,
                          label: '$routineDays',
                          onChanged: (v) => setState(() => routineDays = v.round()),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text('$routineDays días'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Metas guardadas'))),
            child: const Text('Guardar Metas'),
          ),
        ],
      ),
    );
  }
}