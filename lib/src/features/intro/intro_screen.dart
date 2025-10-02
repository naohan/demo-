import 'package:flutter/material.dart';
import '../home/home_screen.dart';

class IntroScreen extends StatefulWidget {
  static const route = '/intro';
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final Map<String, bool> _conditions = {
    'Arritmia cardíaca': false,
    'Hipertensión arterial severa': false,
    'Insuficiencia cardíaca': false,
    'Asma grave': false,
    'EPOC (Enfermedad Pulmonar Obstructiva Crónica)': false,
    'Epilepsia no controlada': false,
    'Embarazo de alto riesgo': false,
    'Ninguna de las anteriores': false,
  };

  String? _medicalAdvice; // Sí / No / No estoy seguro
  int _goalIndex = 1; // 0 cuerpo, 1 mente, 2 ambos

  void _continue() {
    Navigator.pushReplacementNamed(context, HomeScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    final hasCondition = _conditions.values.any((v) => v);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido a Serenity'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.health_and_safety, 
                              color: Colors.blue, size: 24),
                          SizedBox(width: 8),
                          Text(
                            'Paso 1 – Salud inicial',
                            style: TextStyle(
                              fontSize: 20, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const Text(
                        '¿Cuentas con alguna de estas enfermedades?',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      ..._conditions.keys.map((k) => CheckboxListTile(
                        title: Text(k),
                        value: _conditions[k]!,
                        onChanged: (v) => setState(() => _conditions[k] = v ?? false),
                        activeColor: Theme.of(context).primaryColor,
                      )),
                    ],
                  ),
                ),
              ),
              if (hasCondition) ...[
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '¿Tu médico te ha dado instrucciones específicas?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          items: const [
                            DropdownMenuItem(value: 'Sí', child: Text('Sí')),
                            DropdownMenuItem(value: 'No', child: Text('No')),
                            DropdownMenuItem(
                              value: 'No estoy seguro', 
                              child: Text('No estoy seguro')
                            ),
                          ],
                          onChanged: (v) => setState(() => _medicalAdvice = v),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.track_changes, 
                              color: Colors.green, size: 24),
                          SizedBox(width: 8),
                          Text(
                            'Paso 2 – Objetivo inicial',
                            style: TextStyle(
                              fontSize: 20, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 12),
                      Center(
                        child: ToggleButtons(
                          isSelected: [
                            _goalIndex == 0,
                            _goalIndex == 1,
                            _goalIndex == 2,
                          ],
                          onPressed: (i) => setState(() => _goalIndex = i),
                          borderRadius: BorderRadius.circular(10),
                          selectedColor: Colors.white,
                          fillColor: Theme.of(context).primaryColor,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('💪 Cuerpo'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('🌿 Mente'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('⚖️ Ambos'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _continue,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Continuar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}