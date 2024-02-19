import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'app.dart';
import 'db/db.dart';
import 'services/accounts_service.dart';

final helloWorldProvider = Provider<String>((ref) => "Hello World");

Future<void> main() async {
  registerService(DBService.new);
  registerService(AccountsService.new);

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await YaruWindowTitleBar.ensureInitialized();
  } catch (e) {
    print("Yaru title bar failed to initialize");
  }
  runApp(const ProviderScope(child: EnvelopeApp()));
}
