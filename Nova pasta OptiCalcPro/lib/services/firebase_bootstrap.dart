import 'package:firebase_core/firebase_core.dart';

enum FirebaseBootstrapState { configured, skipped, failed }

class FirebaseBootstrapResult {
  const FirebaseBootstrapResult({required this.state, required this.message});

  final FirebaseBootstrapState state;
  final String message;

  bool get isConfigured => state == FirebaseBootstrapState.configured;
}

class FirebaseBootstrap {
  static const String _apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const String _appId = String.fromEnvironment('FIREBASE_APP_ID');
  static const String _messagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
  );
  static const String _projectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
  );
  static const String _authDomain = String.fromEnvironment(
    'FIREBASE_AUTH_DOMAIN',
  );
  static const String _storageBucket = String.fromEnvironment(
    'FIREBASE_STORAGE_BUCKET',
  );

  static Future<FirebaseBootstrapResult> initialize() async {
    if (!_hasRequiredOptions) {
      return const FirebaseBootstrapResult(
        state: FirebaseBootstrapState.skipped,
        message:
            'Firebase aguardando FIREBASE_API_KEY, FIREBASE_APP_ID, '
            'FIREBASE_MESSAGING_SENDER_ID e FIREBASE_PROJECT_ID.',
      );
    }

    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(options: _options);
      }

      return const FirebaseBootstrapResult(
        state: FirebaseBootstrapState.configured,
        message: 'Firebase inicializado com as opcoes fornecidas.',
      );
    } on FirebaseException catch (error) {
      return FirebaseBootstrapResult(
        state: FirebaseBootstrapState.failed,
        message: 'Falha ao inicializar Firebase: ${error.message}',
      );
    } on Object catch (error) {
      return FirebaseBootstrapResult(
        state: FirebaseBootstrapState.failed,
        message: 'Falha inesperada no Firebase: $error',
      );
    }
  }

  static bool get _hasRequiredOptions =>
      _apiKey.isNotEmpty &&
      _appId.isNotEmpty &&
      _messagingSenderId.isNotEmpty &&
      _projectId.isNotEmpty;

  static FirebaseOptions get _options => FirebaseOptions(
    apiKey: _apiKey,
    appId: _appId,
    messagingSenderId: _messagingSenderId,
    projectId: _projectId,
    authDomain: _authDomain.isEmpty ? null : _authDomain,
    storageBucket: _storageBucket.isEmpty ? null : _storageBucket,
  );
}
