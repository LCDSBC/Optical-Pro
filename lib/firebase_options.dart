import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Firebase can be enabled with dart defines without committing secret files.
///
/// Example:
/// flutter run --dart-define=OPTICALC_FIREBASE_CONFIGURED=true \
///   --dart-define=FIREBASE_API_KEY=... \
///   --dart-define=FIREBASE_APP_ID=... \
///   --dart-define=FIREBASE_MESSAGING_SENDER_ID=... \
///   --dart-define=FIREBASE_PROJECT_ID=...
class DefaultFirebaseOptions {
  static const bool isConfigured = bool.fromEnvironment(
    'OPTICALC_FIREBASE_CONFIGURED',
  );

  static FirebaseOptions get currentPlatform {
    if (!isConfigured) {
      throw StateError('Firebase nao configurado.');
    }

    final options = FirebaseOptions(
      apiKey: _required('FIREBASE_API_KEY'),
      appId: _required('FIREBASE_APP_ID'),
      messagingSenderId: _required('FIREBASE_MESSAGING_SENDER_ID'),
      projectId: _required('FIREBASE_PROJECT_ID'),
      authDomain: const String.fromEnvironment('FIREBASE_AUTH_DOMAIN'),
      storageBucket: const String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
      iosBundleId: defaultTargetPlatform == TargetPlatform.iOS
          ? const String.fromEnvironment('FIREBASE_IOS_BUNDLE_ID')
          : null,
    );

    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return options;
    }

    return options;
  }

  static String _required(String key) {
    final value = String.fromEnvironment(key);
    if (value.isEmpty) {
      throw StateError('Defina $key para inicializar o Firebase.');
    }
    return value;
  }
}
