import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'app.dart';
import 'db/db.dart';
import 'services/accounts_service.dart';

final helloWorldProvider = Provider<String>((ref) => "Hello World");

Future<void> main() async {
  registerService(Logger.new);
  registerService(DBService.new);
  registerService(AccountsService.new);

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await YaruWindowTitleBar.ensureInitialized();
  } catch (e) {
    getService<Logger>().e("Yaru title bar failed to initialize: $e");
  }
  try {
    runApp(const ProviderScope(child: EnvelopeApp()));
  } on MissingPluginException catch (e) {
    getService<Logger>().e(
        "FFI exception, probably trying to run on a platform that doesn't support Yaru title bars (e.g. mobile): $e");
  }
}
