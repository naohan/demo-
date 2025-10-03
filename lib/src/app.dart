import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'features/splash/splash_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/intro/intro_screen.dart';
import 'features/home/home_screen.dart';
import 'features/home/home_psychologist.dart';
import 'features/home/home_trainer.dart';
import 'features/community/mind/community_mind_screen.dart';
import 'features/community/mind/community_mind_interactive_screen.dart';
import 'features/community/vital/community_vital_screen.dart';
import 'features/community/vital/community_vital_interactive_screen.dart';
import 'features/community/vital/trainers_screen.dart';
import 'features/wellbeing/physical_wellbeing_screen.dart';
import 'features/wellbeing/mental_wellbeing_screen.dart';
import 'features/wellbeing/goals_config_screen.dart';
import 'features/wellbeing/activity_stats_screen.dart';
import 'features/wellbeing/trainer_recommendations_screen.dart';
import 'features/profiles/psychologist_profile_screen.dart';
import 'features/profiles/trainer_profile_screen.dart';
import 'features/auth/register_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/profile/profile_router_screen.dart';
import 'features/patients/patients_list_screen.dart';
import 'features/patients/patient_detail_screen.dart';
import 'features/patients/patient_calendar_screen.dart';
import 'features/patients/patient_notes_screen.dart';
import 'features/patients/patient_chat_screen.dart';
import 'features/patients/patient_messages_screen.dart';

class CalmmindApp extends StatelessWidget {
  const CalmmindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serenity',
      theme: buildCalmmindTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (_) => const SplashScreen(),
        LoginScreen.route: (_) => const LoginScreen(),
        RegisterScreen.route: (_) => const RegisterScreen(),
        OnboardingScreen.route: (_) => const OnboardingScreen(),
        IntroScreen.route: (_) => const IntroScreen(),
        HomeScreen.route: (_) => const HomeScreen(),
        HomePsychologistScreen.route: (_) => const HomePsychologistScreen(),
        HomeTrainerScreen.route: (_) => const HomeTrainerScreen(),
        CommunityMindScreen.route: (_) => const CommunityMindScreen(),
        CommunityMindInteractiveScreen.route: (_) => const CommunityMindInteractiveScreen(),
        CommunityVitalScreen.route: (_) => const CommunityVitalScreen(),
        CommunityVitalInteractiveScreen.route: (_) => const CommunityVitalInteractiveScreen(),
        TrainersScreen.route: (_) => const TrainersScreen(),
        PhysicalWellbeingScreen.route: (_) => const PhysicalWellbeingScreen(),
        MentalWellbeingScreen.route: (_) => const MentalWellbeingScreen(),
        GoalsConfigScreen.route: (_) => const GoalsConfigScreen(),
        ActivityStatsScreen.route: (_) => const ActivityStatsScreen(),
        TrainerRecommendationsScreen.route:
            (_) => const TrainerRecommendationsScreen(),
        PsychologistProfileScreen.route:
            (_) => const PsychologistProfileScreen(),
        TrainerProfileScreen.route: (_) => const TrainerProfileScreen(),
        ProfileScreen.route: (_) => const ProfileScreen(),
        ProfileRouterScreen.route: (_) => const ProfileRouterScreen(),
        PatientsListScreen.route: (_) => const PatientsListScreen(),
        PatientDetailScreen.route: (context) {
          final patientName =
              ModalRoute.of(context)?.settings.arguments as String?;
          return PatientDetailScreen(patientName: patientName);
        },
        PatientCalendarScreen.route: (context) {
          final patientName =
              ModalRoute.of(context)?.settings.arguments as String?;
          return PatientCalendarScreen(patientName: patientName);
        },
        PatientNotesScreen.route: (context) {
          final patientName =
              ModalRoute.of(context)?.settings.arguments as String?;
          return PatientNotesScreen(patientName: patientName);
        },
        PatientChatScreen.route: (context) {
          final patientName =
              ModalRoute.of(context)?.settings.arguments as String?;
          return PatientChatScreen(patientName: patientName);
        },
        PatientMessagesScreen.route: (context) {
          final patientName =
              ModalRoute.of(context)?.settings.arguments as String?;
          return PatientMessagesScreen(patientName: patientName);
        },
      },
    );
  }
}
