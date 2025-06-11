import 'package:elderly_care/presentation/screens/landing_page.dart';
import 'package:elderly_care/presentation/screens/login_screen.dart';
import 'package:elderly_care/presentation/screens/signup_screen.dart';
import 'package:elderly_care/presentation/screens/care_schedule_screen.dart';
import 'package:elderly_care/presentation/screens/nurse_main_tabs.dart';
import 'package:elderly_care/presentation/screens/user_main_tabs.dart';
import 'package:elderly_care/presentation/screens/view_detail_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LandingPage(
        onGetStarted: () => context.go('/login'),
      ),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignUpScreen(
        onLoginClick: () => context.go('/login'),
      ),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(
        onSignUpClick: () => context.go('/signup'),
        onForgotPassword: () {},
        onLoginSuccess: (role) {
          if (role == 'USER') {
            context.go('/user/home');
          } else if (role == 'NURSE') {
            context.go('/nurse/home');
          }
        },
      ),
    ),
    GoRoute(
      path: '/user/home',
      builder: (context, state) => const UserMainTabs(),
    ),
    GoRoute(
      path: '/nurse/home',
      builder: (context, state) => const NurseMainTabs(),
    ),
    GoRoute(
      path: '/nurse/user/:id/:name/:email/details',
      builder: (context, state) {
        final elderId = state.pathParameters['id'] ?? '';
        final elderName = state.pathParameters['name'] ?? '';
        final elderEmail = state.pathParameters['email'] ?? '';
        return ViewDetailScreen(
          elderId: elderId,
          elderName: Uri.decodeComponent(elderName),
          elderEmail: Uri.decodeComponent(elderEmail),
        );
      },
    ),
    GoRoute(
      path: '/care-schedule',
      builder: (context, state) => CareScheduleScreen(
        onSubmitSuccess: () => context.go('/user/home'),
      ),
    ),
  ],
);