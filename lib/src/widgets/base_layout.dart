import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? hero;
  final List<Widget>? actions;

  const BaseLayout({
    super.key,
    required this.title,
    required this.child,
    this.hero,
    this.actions,
  });

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo/logo_S.png',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 8),
            Text('Serenity'),
          ],
        ),
        actions: [
          ...?actions,
          
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 900),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF5), // Sección central blanca
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (hero != null) ...[
                  Center(child: hero!),
                  const SizedBox(height: 12),
                ],
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _BottomNav(),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    int currentIndex = 0;
    switch (currentRoute) {
      case '/wellbeing-physical':
        currentIndex = 1;
        break;
      case '/wellbeing-mental':
        currentIndex = 2;
        break;
      case '/profile':
        currentIndex = 3;
        break;
      default:
        currentIndex = 0;
    }

    void onTap(int index) {
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/wellbeing-physical');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/wellbeing-mental');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/profile');
          break;
      }
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fitness_center),
          label: 'Bienestar físico',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.psychology),
          label: 'Bienestar mental',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }
}