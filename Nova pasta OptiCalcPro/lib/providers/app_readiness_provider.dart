import 'package:flutter/material.dart';

import '../models/readiness_item.dart';
import '../services/firebase_bootstrap.dart';

class AppReadinessProvider extends ChangeNotifier {
  AppReadinessProvider(this.firebase);

  final FirebaseBootstrapResult firebase;

  List<ReadinessItem> get checks => [
    const ReadinessItem(
      title: 'Dependencias',
      description:
          'Provider e SDKs Firebase instalados via pubspec.yaml e pub get.',
      status: ReadinessStatus.ready,
      icon: Icons.inventory_2_outlined,
    ),
    ReadinessItem(
      title: 'Firebase',
      description: firebase.message,
      status: switch (firebase.state) {
        FirebaseBootstrapState.configured => ReadinessStatus.ready,
        FirebaseBootstrapState.skipped => ReadinessStatus.warning,
        FirebaseBootstrapState.failed => ReadinessStatus.blocked,
      },
      icon: Icons.cloud_done_outlined,
    ),
    const ReadinessItem(
      title: 'Android',
      description:
          'Namespace, applicationId, minSdk 23 e targetSdk do Flutter '
          'configurados para execucao.',
      status: ReadinessStatus.ready,
      icon: Icons.android_outlined,
    ),
    const ReadinessItem(
      title: 'Permissoes',
      description:
          'INTERNET e ACCESS_NETWORK_STATE declaradas para Firebase e servicos '
          'online.',
      status: ReadinessStatus.ready,
      icon: Icons.verified_user_outlined,
    ),
  ];

  int get readyCount =>
      checks.where((item) => item.status == ReadinessStatus.ready).length;

  int get totalCount => checks.length;
}
