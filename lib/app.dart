import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'db/db.dart';
import 'widgets/account_picker.dart';

class EnvelopeApp extends HookConsumerWidget {
  const EnvelopeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = getService<DBService>();

    final accounts = useFuture(useMemoized(() => db.getAccounts()));

    return YaruTheme(builder: (context, yaru, child) {
      return MaterialApp(
          title: 'Flutter Demo',
          theme: yaru.theme,
          darkTheme: yaru.darkTheme,
          home: Scaffold(
              body: YaruMasterDetailPage(
            length: 10,
            appBar: YaruWindowTitleBar(
                heroTag: null,
                title: const Text("Folders"),
                actions: [
                  Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: AccountPicker(setAccount: (account) {}))
                ]),
            tileBuilder: (context, index, selected, availableWidth) {
              return YaruMasterTile(title: Text("Folder $index"));
            },
            pageBuilder: (context, index) {
              final navigator = Navigator.of(context);
              return YaruMasterDetailPage(
                  length: 35,
                  appBar: YaruWindowTitleBar(
                      heroTag: null,
                      leading: navigator.canPop()
                          ? YaruBackButton(onPressed: navigator.pop)
                          : const Icon(YaruIcons.folder),
                      title: Text("Folder $index")),
                  tileBuilder: (context, index, selected, availableWidth) {
                    return YaruMasterTile(
                        title: Text("Message $index"),
                        subtitle: const Text("sender@example.com"),
                        leading: const Icon(YaruIcons.mail));
                  },
                  pageBuilder: (context, index) {
                    final navigator = Navigator.of(context);
                    return Scaffold(
                        appBar: YaruWindowTitleBar(
                            heroTag: null,
                            leading: navigator.canPop()
                                ? YaruBackButton(onPressed: navigator.pop)
                                : const Icon(YaruIcons.mail),
                            title: Text("Message $index")),
                        body: Center(child: Text("Message content $index")));
                  });
            },
          )));
    });
  }
}
