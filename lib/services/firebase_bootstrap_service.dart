import 'package:firebase_core/firebase_core.dart';

import '../firebase_options.dart';

class FirebaseStatus {
  const FirebaseStatus({
    required this.isConfigured,
    required this.isOnline,
    required this.message,
  });

  const FirebaseStatus.offline(String message)
    : this(isConfigured: false, isOnline: false, message: message);

  const FirebaseStatus.online()
    : this(isConfigured: true, isOnline: true, message: 'Firebase conectado');

  final bool isConfigured;
  final bool isOnline;
  final String message;
}

class FirebaseBootstrapService {
  Future<FirebaseStatus> initialize() async {
    if (!DefaultFirebaseOptions.isConfigured) {
      return const FirebaseStatus.offline(
        'Firebase nao configurado; usando modo local.',
      );
    }

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      return const FirebaseStatus.online();
    } on Object catch (error) {
      return FirebaseStatus.offline(
        'Firebase indisponivel; usando modo local. Detalhe: $error',
      );
    }
  }
}
