import 'package:finger_ai/presentation/screens/home/home_screen.dart';
import 'package:finger_ai/presentation/screens/identification/identification_screen.dart';
import 'package:finger_ai/presentation/screens/models/model_detail_screen.dart';
import 'package:finger_ai/presentation/screens/models/model_list_screen.dart';
import 'package:finger_ai/presentation/screens/training/new_training_job_screen.dart';
import 'package:finger_ai/presentation/screens/training/training_job_detail_screen.dart';
import 'package:finger_ai/presentation/screens/training/training_job_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // Home Screen
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),

      // Training Job Routes
      GoRoute(
        path: '/jobs',
        builder: (context, state) => const TrainingJobListScreen(),
      ),
      GoRoute(
        path: '/jobs/new',
        builder: (context, state) => const NewTrainingJobScreen(),
      ),
      GoRoute(
        path: '/jobs/:jobId',
        builder: (context, state) {
          final jobId = state.pathParameters['jobId']!;
          return TrainingJobDetailScreen(jobId: jobId);
        },
      ),

      // Model Routes
      GoRoute(
        path: '/models',
        builder: (context, state) => const ModelListScreen(),
      ),
      GoRoute(
        path: '/models/:modelId',
        builder: (context, state) {
          final modelId = state.pathParameters['modelId']!;
          return ModelDetailScreen(modelId: modelId);
        },
      ),

      // Identification Route
      GoRoute(
        path: '/identify',
        builder: (context, state) => const IdentificationScreen(),
      ),
    ],
    errorBuilder:
        (context, state) => Scaffold(
          appBar: AppBar(title: const Text('Page Not Found')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 80, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Page Not Found',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('The path ${state.uri.path} does not exist'),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => context.go('/'),
                  icon: const Icon(Icons.home),
                  label: const Text('Go Home'),
                ),
              ],
            ),
          ),
        ),
  );
}
