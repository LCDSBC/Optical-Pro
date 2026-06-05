import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Placeholder Firebase options.
///
/// Replace these values by running FlutterFire CLI for each target platform:
/// `flutterfire configure --project=<firebase-project-id>`.
abstract final class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => ios,
      TargetPlatform.macOS => macos,
      _ => android,
    };
  }

  static const web = FirebaseOptions(
    apiKey: 'replace-with-web-api-key',
    appId: '1:000000000000:web:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'opticalc-pro',
    authDomain: 'opticalc-pro.firebaseapp.com',
    storageBucket: 'opticalc-pro.appspot.com',
  );

  static const android = FirebaseOptions(
    apiKey: 'replace-with-android-api-key',
    appId: '1:000000000000:android:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'opticalc-pro',
    storageBucket: 'opticalc-pro.appspot.com',
  );

  static const ios = FirebaseOptions(
    apiKey: 'replace-with-ios-api-key',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'opticalc-pro',
    storageBucket: 'opticalc-pro.appspot.com',
    iosBundleId: 'br.com.opticalc.pro',
  );

  static const macos = FirebaseOptions(
    apiKey: 'replace-with-macos-api-key',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'opticalc-pro',
    storageBucket: 'opticalc-pro.appspot.com',
    iosBundleId: 'br.com.opticalc.pro',
  );
}
