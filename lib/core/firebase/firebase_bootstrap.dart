import 'package:firebase_core/firebase_core.dart';

import 'default_firebase_options.dart';

class FirebaseBootstrapResult {
  const FirebaseBootstrapResult._({
    required this.isInitialized,
    this.projectId,
    this.error,
    this.stackTrace,
  });

  const FirebaseBootstrapResult.initialized(String projectId)
      : this._(
          isInitialized: true,
          projectId: projectId,
        );

  const FirebaseBootstrapResult.failed(Object error, StackTrace stackTrace)
      : this._(
          isInitialized: false,
          error: error,
          stackTrace: stackTrace,
        );

  final bool isInitialized;
  final String? projectId;
  final Object? error;
  final StackTrace? stackTrace;
}

abstract final class FirebaseBootstrap {
  static Future<FirebaseBootstrapResult> initialize() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }

      return FirebaseBootstrapResult.initialized(Firebase.app().options.projectId);
    } on Object catch (error, stackTrace) {
      return FirebaseBootstrapResult.failed(error, stackTrace);
    }
  }
}
