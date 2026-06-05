import 'package:firebase_core/firebase_core.dart';

enum FirebaseAvailability { configured, unavailable }

class FirebaseStatus {
  const FirebaseStatus.configured()
    : availability = FirebaseAvailability.configured,
      message = 'Firebase conectado';

  const FirebaseStatus.unavailable(this.message)
    : availability = FirebaseAvailability.unavailable;

  final FirebaseAvailability availability;
  final String message;

  bool get isConfigured => availability == FirebaseAvailability.configured;
}

class FirebaseService {
  const FirebaseService._();

  static Future<FirebaseStatus> initialize() async {
    try {
      await Firebase.initializeApp();
      return const FirebaseStatus.configured();
    } on FirebaseException catch (error) {
      return FirebaseStatus.unavailable(
        'Firebase aguardando configuração: ${error.code}',
      );
    } catch (error) {
      return FirebaseStatus.unavailable(
        'Firebase aguardando configuração local',
      );
    }
  }
}
