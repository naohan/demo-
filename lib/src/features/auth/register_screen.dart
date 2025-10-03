import 'package:flutter/material.dart';
import '../onboarding/onboarding_screen.dart';
import 'login_screen.dart';
import '../../core/user_session.dart';

class RegisterScreen extends StatefulWidget {
  static const route = '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _specializationController =
      TextEditingController(); // Para psicólogos/entrenadores

  // Campos específicos para psicólogos
  final _countryController = TextEditingController();
  final _locationController = TextEditingController();
  final _collegeNumberController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptProfessionalTerms = false; // Para el checkbox de psicólogos
  int _roleIndex = 0; // 0: usuario, 1: psicólogo, 2: entrenador

  // Sistema de fases
  int _currentPhase = 1; // 1: Datos básicos, 2: Datos del rol, 3: Compromiso
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Inicializar animaciones
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Iniciar la primera animación
    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtener el rol pasado desde LoginScreen
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is int) {
      _roleIndex = args;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _specializationController.dispose();
    _countryController.dispose();
    _locationController.dispose();
    _collegeNumberController.dispose();
    super.dispose();
  }

  // Métodos para navegación entre fases
  void _nextPhase() async {
    // Validar la fase actual antes de continuar
    if (!_validateCurrentPhase()) return;

    await _animationController.reverse();
    setState(() {
      _currentPhase++;
    });
    await _animationController.forward();
  }

  void _previousPhase() async {
    if (_currentPhase > 1) {
      await _animationController.reverse();
      setState(() {
        _currentPhase--;
      });
      await _animationController.forward();
    }
  }

  bool _validateCurrentPhase() {
    switch (_currentPhase) {
      case 1:
        // Validar nombre y email
        if (_nameController.text.trim().isEmpty) {
          _showError('Ingresa tu nombre completo');
          return false;
        }
        if (_emailController.text.trim().isEmpty ||
            !_emailController.text.contains('@')) {
          _showError('Ingresa un correo válido');
          return false;
        }
        return true;
      case 2:
        // Validar contraseñas y campos específicos del rol
        if (_passwordController.text.trim().isEmpty ||
            _passwordController.text.length < 6) {
          _showError('La contraseña debe tener al menos 6 caracteres');
          return false;
        }
        if (_passwordController.text != _confirmPasswordController.text) {
          _showError('Las contraseñas no coinciden');
          return false;
        }
        if (_roleIndex > 0 && _specializationController.text.trim().isEmpty) {
          _showError(
            _roleIndex == 1
                ? 'Ingresa tu especialización'
                : 'Ingresa tu certificación',
          );
          return false;
        }
        if (_roleIndex == 1) {
          if (_countryController.text.trim().isEmpty) {
            _showError('Ingresa tu país');
            return false;
          }
          if (_locationController.text.trim().isEmpty) {
            _showError('Ingresa tu ubicación');
            return false;
          }
          if (_collegeNumberController.text.trim().isEmpty) {
            _showError('Ingresa tu número de colegiatura');
            return false;
          }
        }
        return true;
      default:
        return true;
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[400],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  int _getTotalPhases() {
    return _roleIndex == 1 ? 3 : 2; // Psicólogos tienen 3 fases, otros 2
  }

  void _register() {
    // Validar todos los campos requeridos manualmente
    if (_nameController.text.trim().isEmpty) {
      _showError('Ingresa tu nombre completo');
      return;
    }

    if (_emailController.text.trim().isEmpty ||
        !_emailController.text.contains('@')) {
      _showError('Ingresa un correo válido');
      return;
    }

    if (_passwordController.text.trim().isEmpty ||
        _passwordController.text.length < 6) {
      _showError('La contraseña debe tener al menos 6 caracteres');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showError('Las contraseñas no coinciden');
      return;
    }

    // Validar campos específicos según el rol
    if (_roleIndex > 0 && _specializationController.text.trim().isEmpty) {
      _showError(
        _roleIndex == 1
            ? 'Ingresa tu especialización'
            : 'Ingresa tu certificación',
      );
      return;
    }

    if (_roleIndex == 1) {
      if (_countryController.text.trim().isEmpty) {
        _showError('Ingresa tu país');
        return;
      }
      if (_locationController.text.trim().isEmpty) {
        _showError('Ingresa tu ubicación');
        return;
      }
      if (_collegeNumberController.text.trim().isEmpty) {
        _showError('Ingresa tu número de colegiatura');
        return;
      }
      if (!_acceptProfessionalTerms) {
        _showError(
          'Debes aceptar tu responsabilidad profesional para continuar',
        );
        return;
      }
    }

    // Guardar la sesión del usuario
    final userSession = UserSession();
    userSession.setUserSession(
      role: UserRole.fromIndex(_roleIndex),
      name: _nameController.text,
      email: _emailController.text,
    );

    // Mostrar mensaje de éxito
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '¡Cuenta creada exitosamente! Bienvenido${_roleIndex == 1
              ? ' Dr./Dra.'
              : _roleIndex == 2
              ? ' Coach'
              : ''} ${_nameController.text.split(' ').first}',
        ),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    // Esperar un momento antes de navegar para que se vea el mensaje
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return; // Verificar que el widget sigue montado

      // Navegar según el tipo de cuenta registrada
      if (_roleIndex == 0) {
        // Usuario normal - va al onboarding
        Navigator.pushReplacementNamed(context, OnboardingScreen.route);
      } else if (_roleIndex == 1) {
        // Psicólogo - va directo a Home Psychologist
        Navigator.pushReplacementNamed(context, '/home-psychologist');
      } else {
        // Entrenador - va directo a Home Trainer
        Navigator.pushReplacementNamed(context, '/home-trainer');
      }
    });
  }

  String _getRoleTitle() {
    switch (_roleIndex) {
      case 1:
        return 'Registro de Psicólogo';
      case 2:
        return 'Registro de Entrenador';
      default:
        return 'Crear Cuenta';
    }
  }

  String _getRoleSubtitle() {
    switch (_roleIndex) {
      case 1:
        return 'Únete como profesional de la salud mental';
      case 2:
        return 'Únete como entrenador físico certificado';
      default:
        return 'Únete a Serenity hoy mismo';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(_getRoleTitle()),
        centerTitle: true,
        elevation: 0,
        leading:
            _currentPhase > 1
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _previousPhase,
                )
                : null,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF5),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Indicador de progreso
                    _buildProgressIndicator(),
                    const SizedBox(height: 24),

                    // Logo
                    Image.asset(
                      'assets/logo/logo_S.png',
                      height: 80,
                      width: 80,
                    ),
                    const SizedBox(height: 20),

                    // Contenido según la fase actual
                    _buildPhaseContent(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Métodos para construir las fases
  Widget _buildProgressIndicator() {
    int totalPhases = _getTotalPhases();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPhases, (index) {
        bool isActive = index + 1 <= _currentPhase;
        bool isCurrent = index + 1 == _currentPhase;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isCurrent ? 30 : 20,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue[600] : Colors.grey[300],
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  Widget _buildPhaseContent() {
    switch (_currentPhase) {
      case 1:
        return _buildPhase1();
      case 2:
        return _buildPhase2();
      case 3:
        return _buildPhase3();
      default:
        return _buildPhase1();
    }
  }

  Widget _buildPhase1() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Información básica',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Comenzemos con lo esencial',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Campo de nombre
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nombre completo',
              hintText: 'Juan Pérez',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // Campo de correo
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Correo electrónico',
              hintText: 'tu@email.com',
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 32),

          // Botón continuar
          ElevatedButton(
            onPressed: _nextPhase,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Continuar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhase2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          _roleIndex == 1 ? 'Datos profesionales' : 'Información del rol',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Completa tu perfil profesional',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        // Campos específicos según el rol
        if (_roleIndex > 0) ...[
          TextFormField(
            controller: _specializationController,
            decoration: InputDecoration(
              labelText: _roleIndex == 1 ? 'Especialización' : 'Certificación',
              hintText:
                  _roleIndex == 1
                      ? 'Ej: Psicología clínica, Terapia cognitiva...'
                      : 'Ej: Personal Trainer, Nutrición deportiva...',
              prefixIcon: Icon(
                _roleIndex == 1 ? Icons.psychology : Icons.fitness_center,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Campos específicos para psicólogos
        if (_roleIndex == 1) ...[
          TextFormField(
            controller: _countryController,
            decoration: InputDecoration(
              labelText: 'País/Nación',
              hintText: 'Ej: México, Colombia, España...',
              prefixIcon: const Icon(Icons.public),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _locationController,
            decoration: InputDecoration(
              labelText: 'Ubicación/Ciudad',
              hintText: 'Ej: Ciudad de México, Bogotá, Madrid...',
              prefixIcon: const Icon(Icons.location_city),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: _collegeNumberController,
            decoration: InputDecoration(
              labelText: 'Número de Colegiatura',
              hintText: 'Ingresa tu número de colegiatura profesional',
              prefixIcon: const Icon(Icons.card_membership),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Campos de contraseña
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            hintText: 'Mínimo 6 caracteres',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.white,
          ),
          obscureText: _obscurePassword,
        ),
        const SizedBox(height: 16),

        TextFormField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(
            labelText: 'Confirmar contraseña',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.white,
          ),
          obscureText: _obscureConfirmPassword,
        ),
        const SizedBox(height: 32),

        // Botón continuar
        ElevatedButton(
          onPressed: _roleIndex == 1 ? _nextPhase : _register,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Text(
            _roleIndex == 1 ? 'Continuar' : 'Crear Cuenta',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildPhase3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Compromiso Profesional',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue[700],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Un último paso importante',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.psychology, color: Colors.blue[600], size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tu Misión en Serenity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Como psicólogo(a), reconozco la importancia de mi carrera en salvar vidas y mejorar el bienestar mental de las personas.',
                style: TextStyle(fontSize: 15, height: 1.5),
              ),
              const SizedBox(height: 12),
              const Text(
                'El objetivo de Serenity es buscar el bienestar integral del usuario, y mi participación contribuye a este noble propósito.',
                style: TextStyle(fontSize: 15, height: 1.5),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: _acceptProfessionalTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptProfessionalTerms = value ?? false;
                      });
                    },
                    activeColor: Colors.blue[600],
                  ),
                  const Expanded(
                    child: Text(
                      'Acepto mi responsabilidad profesional y me comprometo con el bienestar de los usuarios',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // Botón finalizar
        ElevatedButton(
          onPressed: _register,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            backgroundColor: Colors.green[600],
          ),
          child: const Text(
            'Finalizar Registro',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
