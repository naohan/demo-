import 'package:flutter/material.dart';
import '../../widgets/base_layout.dart';

class MentalWellbeingScreen extends StatefulWidget {
  static const route = '/wellbeing-mental';
  const MentalWellbeingScreen({super.key});

  @override
  State<MentalWellbeingScreen> createState() => _MentalWellbeingScreenState();
}

class _MentalWellbeingScreenState extends State<MentalWellbeingScreen> {
  final _diaryController = TextEditingController();
  final List<String> _positives = [];
  double _stress = 3;
  double _energy = 3;
  double _motivation = 3;
  double _balance = 3;
  final Map<String, bool> _techniques = {
    'Meditación': false,
    'Respiración': false,
    'Journaling': false,
  };

  @override
  void dispose() {
    _diaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final riskAlert = _stress >= 4; // placeholder para >10 días
    return BaseLayout(
      title: 'Bienestar Mental',
      hero: const Icon(Icons.psychology, size: 64),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Tarea terapéutica:'),
                  const SizedBox(height: 8),
                  const Text('Escribe 3 cosas positivas de tu día'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () => setState(() => _positives.add('Positivo ${_positives.length + 1}')),
                        child: const Text('Añadir ejemplo'),
                      ),
                      ..._positives.map((p) => Chip(label: Text(p))),
                    ],
                  ),
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
                  Text('Calendario de emociones'),
                  SizedBox(height: 8),
                  Text('🙂🙂😐🙁🙂 😄'),
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
                children: [
                  const Text('Diario emocional'),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _diaryController,
                    decoration: const InputDecoration(
                      hintText: 'Notas rápidas del usuario',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
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
                  Text('Registro laboral breve'),
                  SizedBox(height: 8),
                  Text('¿Qué fue lo más estresante hoy?'),
                  Text('¿Qué fue lo mejor del día?'),
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
                children: [
                  const Text('Escalas rápidas'),
                  const SizedBox(height: 8),
                  _buildScale('Estrés laboral', _stress, (v) => setState(() => _stress = v)),
                  _buildScale('Energía', _energy, (v) => setState(() => _energy = v)),
                  _buildScale('Motivación', _motivation, (v) => setState(() => _motivation = v)),
                  _buildScale('Balance trabajo–vida', _balance, (v) => setState(() => _balance = v)),
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
                children: [
                  const Text('Técnicas registradas'),
                  ..._techniques.keys.map((t) => CheckboxListTile(
                        title: Text(t),
                        value: _techniques[t]!,
                        onChanged: (v) => setState(() => _techniques[t] = v ?? false),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          if (riskAlert)
            Card(
              color: Colors.red.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Alerta de riesgo: estrés alto detectado.'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildScale(String label, double value, ValueChanged<double> onChanged) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Expanded(
          flex: 3,
          child: Slider(
            min: 1,
            max: 5,
            divisions: 4,
            label: value.round().toString(),
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}