import 'package:envelope/db/db.dart';
import 'package:envelope/db/models/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:yaru_icons/yaru_icons.dart';

class AccountPicker extends HookWidget {
  final int initialAccount = 0;
  final void Function(Account) setAccount;

  const AccountPicker({super.key, required this.setAccount});

  @override
  Widget build(BuildContext context) {
    final db = getService<DBService>();
    final logger = getService<Logger>();

    final accounts = useFuture(useMemoized(() => db.getAccounts()));
    final accountId = useState(initialAccount);
    final account = useMemoized(
        () => accounts.data
            ?.firstWhere((element) => element.id == accountId.value),
        [accountId]);
    useEffect(() {
      if (account != null) {
        setAccount(account);
      }
      return null;
    }, [account]);

    final image = account?.profileImage != null
        ? Image.network(account!.profileImage!)
        : const Icon(YaruIcons.user);

    return PopupMenuButton(
        icon: account?.profileImage != null ? ClipOval(child: image) : image,
        itemBuilder: (context) {
          return [
            ...(accounts.data
                    ?.map((account) => PopupMenuItem(
                        value: account.id,
                        child: ListTile(
                            leading: ClipOval(
                                child:
                                    Image.network(account.profileImage ?? "")),
                            title: Text(account.name ?? account.email),
                            subtitle: account.name != null
                                ? Text(account.email)
                                : null)))
                    .toList() ??
                []),
            const PopupMenuItem(
              value: -1,
              child: Text("Add Account"),
            )
          ];
        },
        onSelected: (value) {
          if (value is! int) {
            logger.e(
                "Selected account ID is not an int, this is an error - got $value");
            return;
          }

          if (value == -1) {
            logger.i("Adding a new account");
          } else {
            logger.i("Switching to account $value");
            accountId.value = value;
          }
        });
  }
}
